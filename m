Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35693 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbIRJa4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 05:30:56 -0400
Received: by wicge5 with SMTP id ge5so24500898wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 18 Sep 2015 02:30:55 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/5] ieee802154: introduce wpan_dev_header_ops
Date: Fri, 18 Sep 2015 11:30:42 +0200
Message-Id: <1442568644-2158-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
References: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The current header_ops callback structure of net device are used mostly
from 802.15.4 upper-layers. Because this callback structure is a very
generic one, which is also used by e.g. DGRAM AF_PACKET sockets, we
can't make this callback structure 802.15.4 specific which is currently
is.

I saw the smallest "constraint" for calling this callback with
dev_hard_header/dev_parse_header by AF_PACKET which assign a 8 byte
array for address void pointers. Currently 802.15.4 specific protocols
like af802154 and 6LoWPAN will assign the "struct ieee802154_addr" as
these parameters which is greater than 8 bytes. The current callback
implementation for header_ops.create assumes always a complete
"struct ieee802154_addr" which AF_PACKET can't never handled and is
greater than 8 bytes.

For that reason we introduce now a "generic" create/parse header_ops
callback which allows handling with intra-pan extended addresses only.
This allows a small use-case with AF_PACKET to send "somehow" a valid
dataframe over DGRAM.

To keeping the current dev_hard_header behaviour we introduce a similar
callback structure "wpan_dev_header_ops" which contains 802.15.4 specific
upper-layer header creation functionality, which can be called by
wpan_dev_hard_header.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h         | 33 +++++++++++++++
 include/net/ieee802154_netdev.h |  9 ----
 net/ieee802154/6lowpan/tx.c     |  8 ++--
 net/ieee802154/socket.c         |  4 +-
 net/mac802154/iface.c           | 91 +++++++++++++++++++++++++++++++++++------
 5 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 76b1ffa..242273c 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -167,6 +167,26 @@ struct wpan_phy {
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
+struct ieee802154_addr {
+	u8 mode;
+	__le16 pan_id;
+	union {
+		__le16 short_addr;
+		__le64 extended_addr;
+	};
+};
+
+struct wpan_dev_header_ops {
+	/* TODO create callback currently assumes ieee802154_mac_cb inside
+	 * skb->cb. This should be changed to give these information as
+	 * parameter.
+	 */
+	int	(*create)(struct sk_buff *skb, struct net_device *dev,
+			  const struct ieee802154_addr *daddr,
+			  const struct ieee802154_addr *saddr,
+			  unsigned int len);
+};
+
 struct wpan_dev {
 	struct wpan_phy *wpan_phy;
 	int iftype;
@@ -175,6 +195,8 @@ struct wpan_dev {
 	struct list_head list;
 	struct net_device *netdev;
 
+	const struct wpan_dev_header_ops *header_ops;
+
 	/* lowpan interface, set when the wpan_dev belongs to one lowpan_dev */
 	struct net_device *lowpan_dev;
 
@@ -205,6 +227,17 @@ struct wpan_dev {
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
 
+static inline int
+wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
+		     const struct ieee802154_addr *daddr,
+		     const struct ieee802154_addr *saddr,
+		     unsigned int len)
+{
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+
+	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+}
+
 struct wpan_phy *
 wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size);
 static inline void wpan_phy_set_dev(struct wpan_phy *phy, struct device *dev)
diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 95a71bc..aebb9d8 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -50,15 +50,6 @@ struct ieee802154_sechdr {
 	};
 };
 
-struct ieee802154_addr {
-	u8 mode;
-	__le16 pan_id;
-	union {
-		__le16 short_addr;
-		__le64 extended_addr;
-	};
-};
-
 struct ieee802154_hdr_fc {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	u16 type:3,
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 54939d0..6067e06 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -87,8 +87,8 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 		skb_reset_network_header(frag);
 		*mac_cb(frag) = *mac_cb(skb);
 
-		rc = dev_hard_header(frag, wdev, 0, &master_hdr->dest,
-				     &master_hdr->source, size);
+		rc = wpan_dev_hard_header(frag, wdev, &master_hdr->dest,
+					  &master_hdr->source, size);
 		if (rc < 0) {
 			kfree_skb(frag);
 			return ERR_PTR(rc);
@@ -228,8 +228,8 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 		cb->ackreq = wpan_dev->ackreq;
 	}
 
-	return dev_hard_header(skb, lowpan_dev_info(ldev)->wdev, ETH_P_IPV6,
-			       (void *)&da, (void *)&sa, 0);
+	return wpan_dev_hard_header(skb, lowpan_dev_info(ldev)->wdev, &da, &sa,
+				    0);
 }
 
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index b6eacf3..be77f21 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -676,8 +676,8 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	cb->seclevel = ro->seclevel;
 	cb->seclevel_override = ro->seclevel_override;
 
-	err = dev_hard_header(skb, dev, ETH_P_IEEE802154, &dst_addr,
-			      ro->bound ? &ro->src_addr : NULL, size);
+	err = wpan_dev_hard_header(skb, dev, &dst_addr,
+				   ro->bound ? &ro->src_addr : NULL, size);
 	if (err < 0)
 		goto out_skb;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ed26952..8afe26d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -367,12 +367,11 @@ static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 	return 0;
 }
 
-static int mac802154_header_create(struct sk_buff *skb,
-				   struct net_device *dev,
-				   unsigned short type,
-				   const void *daddr,
-				   const void *saddr,
-				   unsigned len)
+static int ieee802154_header_create(struct sk_buff *skb,
+				    struct net_device *dev,
+				    const struct ieee802154_addr *daddr,
+				    const struct ieee802154_addr *saddr,
+				    unsigned len)
 {
 	struct ieee802154_hdr hdr;
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
@@ -423,24 +422,91 @@ static int mac802154_header_create(struct sk_buff *skb,
 	return hlen;
 }
 
+static const struct wpan_dev_header_ops ieee802154_header_ops = {
+	.create		= ieee802154_header_create,
+};
+
+/* This header create functionality assumes a 8 byte array for
+ * source and destination pointer at maximum. To adapt this for
+ * the 802.15.4 dataframe header we use extended address handling
+ * here only and intra pan connection. fc fields are mostly fallback
+ * handling. For provide dev_hard_header for dgram sockets.
+ */
+static int mac802154_header_create(struct sk_buff *skb,
+				   struct net_device *dev,
+				   unsigned short type,
+				   const void *daddr,
+				   const void *saddr,
+				   unsigned len)
+{
+	struct ieee802154_hdr hdr;
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct ieee802154_mac_cb cb = { };
+	int hlen;
+
+	if (!daddr)
+		return -EINVAL;
+
+	memset(&hdr.fc, 0, sizeof(hdr.fc));
+	hdr.fc.type = IEEE802154_FC_TYPE_DATA;
+	hdr.fc.ack_request = wpan_dev->ackreq;
+	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
+
+	/* TODO currently a workaround to give zero cb block to set
+	 * security parameters defaults according MIB.
+	 */
+	if (mac802154_set_header_security(sdata, &hdr, &cb) < 0)
+		return -EINVAL;
+
+	hdr.dest.pan_id = wpan_dev->pan_id;
+	hdr.dest.mode = IEEE802154_ADDR_LONG;
+	memcpy(&hdr.dest.extended_addr, daddr, IEEE802154_EXTENDED_ADDR_LEN);
+
+	hdr.source.pan_id = hdr.dest.pan_id;
+	hdr.source.mode = IEEE802154_ADDR_LONG;
+
+	if (!saddr)
+		hdr.source.extended_addr = wpan_dev->extended_addr;
+	else
+		memcpy(&hdr.source.extended_addr, saddr,
+		       IEEE802154_EXTENDED_ADDR_LEN);
+
+	hlen = ieee802154_hdr_push(skb, &hdr);
+	if (hlen < 0)
+		return -EINVAL;
+
+	skb_reset_mac_header(skb);
+	skb->mac_len = hlen;
+
+	if (len > ieee802154_max_payload(&hdr))
+		return -EMSGSIZE;
+
+	return hlen;
+}
+
 static int
 mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 {
 	struct ieee802154_hdr hdr;
-	struct ieee802154_addr *addr = (struct ieee802154_addr *)haddr;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0) {
 		pr_debug("malformed packet\n");
 		return 0;
 	}
 
-	*addr = hdr.source;
-	return sizeof(*addr);
+	if (hdr.source.mode == IEEE802154_ADDR_LONG) {
+		memcpy(haddr, &hdr.source.extended_addr,
+		       IEEE802154_EXTENDED_ADDR_LEN);
+		return IEEE802154_EXTENDED_ADDR_LEN;
+	}
+
+	return 0;
 }
 
-static struct header_ops mac802154_header_ops = {
-	.create		= mac802154_header_create,
-	.parse		= mac802154_header_parse,
+static const struct header_ops mac802154_header_ops = {
+	.create         = mac802154_header_create,
+	.parse          = mac802154_header_parse,
 };
 
 static const struct net_device_ops mac802154_wpan_ops = {
@@ -513,6 +579,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
 		wpan_dev->promiscuous_mode = false;
+		wpan_dev->header_ops = &ieee802154_header_ops;
 
 		mutex_init(&sdata->sec_mtx);
 
-- 
2.5.2

