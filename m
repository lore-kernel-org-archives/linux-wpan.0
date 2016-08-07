Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40675 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752034AbcHGOdE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:04 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 12/19] ieee802154: 6lowpan: move header create to 6lowpan
Date: Sun,  7 Aug 2016 16:30:49 +0200
Message-Id: <20160807143056.3116-13-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

The handling for the header_ops create callback should be on all 6LoWPAN
implementation the same. We move that now to generic 6LoWPAN.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h              | 12 +++++
 net/6lowpan/core.c                 | 35 ++++++++++++++
 net/ieee802154/6lowpan/6lowpan_i.h |  3 --
 net/ieee802154/6lowpan/core.c      |  5 --
 net/ieee802154/6lowpan/tx.c        | 93 +++++++++++++-------------------------
 5 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 90d9d08..9a6282b 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -133,6 +133,18 @@ lowpan_iphc_ctx_is_compression(const struct lowpan_iphc_ctx *ctx)
 	return test_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
 }
 
+struct lowpan_addr_info {
+	unsigned char daddr[EUI64_ADDR_LEN];
+	unsigned char saddr[EUI64_ADDR_LEN];
+};
+
+static inline struct
+lowpan_addr_info *lowpan_addr_info(const struct sk_buff *skb)
+{
+	return (struct lowpan_addr_info *)(skb->data -
+					   sizeof(struct lowpan_addr_info));
+}
+
 struct lowpan_dev {
 	enum lowpan_lltypes lltype;
 	struct dentry *iface_debugfs;
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 00ffab3..b01effd 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -18,6 +18,33 @@
 
 #include "6lowpan_i.h"
 
+/* TODO I think AF_PACKET DGRAM (sending/receiving) RAW (sending) makes no
+ * sense here. We should disable it, the right use-case would be AF_INET6
+ * RAW/DGRAM sockets.
+ */
+static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
+				unsigned short type, const void *daddr,
+				const void *saddr, unsigned int len)
+{
+	struct lowpan_addr_info *info = lowpan_addr_info(skb);
+
+	if (WARN_ON_ONCE(type != ETH_P_IPV6))
+		return -EINVAL;
+
+	memcpy(info->daddr, daddr, dev->addr_len);
+
+	if (saddr)
+		memcpy(info->saddr, saddr, dev->addr_len);
+	else
+		memcpy(info->saddr, dev->dev_addr, dev->addr_len);
+
+	return 0;
+}
+
+static struct header_ops header_ops = {
+	.create	= lowpan_header_create,
+};
+
 int lowpan_register_netdevice(struct net_device *dev,
 			      enum lowpan_lltypes lltype)
 {
@@ -28,6 +55,14 @@ int lowpan_register_netdevice(struct net_device *dev,
 	dev->mtu = IPV6_MIN_MTU;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
+	dev->header_ops = &header_ops;
+
+	/* We need at least headroom for lowpan_addr_info to get necessary
+	 * address information from header create to xmit callback.
+	 */
+	if (dev->needed_headroom < sizeof(struct lowpan_addr_info))
+		dev->needed_headroom += sizeof(struct lowpan_addr_info);
+
 	lowpan_dev(dev)->lltype = lltype;
 
 	spin_lock_init(&lowpan_dev(dev)->ctx.lock);
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index 39b739f..709c22c 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -48,9 +48,6 @@ int lowpan_net_frag_init(void);
 void lowpan_rx_init(void);
 void lowpan_rx_exit(void);
 
-int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
-			 unsigned short type, const void *_daddr,
-			 const void *_saddr, unsigned int len);
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev);
 
 int lowpan_iphc_decompress(struct sk_buff *skb);
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index f70edcc..096a194 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -54,10 +54,6 @@
 
 static int open_count;
 
-static struct header_ops lowpan_header_ops = {
-	.create	= lowpan_header_create,
-};
-
 static int lowpan_dev_init(struct net_device *ldev)
 {
 	netdev_lockdep_set_classes(ldev);
@@ -106,7 +102,6 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
-	ldev->header_ops	= &lowpan_header_ops;
 	ldev->destructor	= free_netdev;
 	ldev->features		|= NETIF_F_NETNS_LOCAL;
 }
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index a7a1b12..f56b9cd 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -18,48 +18,23 @@
 #define LOWPAN_FRAG1_HEAD_SIZE	0x4
 #define LOWPAN_FRAGN_HEAD_SIZE	0x5
 
-struct lowpan_addr_info {
-	struct ieee802154_addr daddr;
-	struct ieee802154_addr saddr;
-};
-
-static inline struct
-lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
-{
-	return (struct lowpan_addr_info *)(skb->data -
-			sizeof(struct lowpan_addr_info));
-}
-
-/* This callback will be called from AF_PACKET and IPv6 stack, the AF_PACKET
- * sockets gives an 8 byte array for addresses only!
- *
- * TODO I think AF_PACKET DGRAM (sending/receiving) RAW (sending) makes no
- * sense here. We should disable it, the right use-case would be AF_INET6
- * RAW/DGRAM sockets.
- */
-int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
-			 unsigned short type, const void *daddr,
-			 const void *saddr, unsigned int len)
+static void lowpan_addr_lookup(struct net_device *ldev, struct sk_buff *skb,
+			       struct ieee802154_addr *daddr,
+			       struct ieee802154_addr *saddr)
 {
 	struct wpan_dev *wpan_dev = lowpan_802154_dev(ldev)->wdev->ieee802154_ptr;
-	struct lowpan_addr_info *info = lowpan_skb_priv(skb);
+	struct lowpan_addr_info *info = lowpan_addr_info(skb);
 	struct lowpan_802154_neigh *llneigh = NULL;
 	const struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct neighbour *n;
 
-	/* TODO:
-	 * if this package isn't ipv6 one, where should it be routed?
-	 */
-	if (type != ETH_P_IPV6)
-		return 0;
-
 	/* intra-pan communication */
-	info->saddr.pan_id = wpan_dev->pan_id;
-	info->daddr.pan_id = info->saddr.pan_id;
+	saddr->pan_id = wpan_dev->pan_id;
+	daddr->pan_id = saddr->pan_id;
 
-	if (!memcmp(daddr, ldev->broadcast, EUI64_ADDR_LEN)) {
-		info->daddr.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
-		info->daddr.mode = IEEE802154_ADDR_SHORT;
+	if (!memcmp(info->daddr, ldev->broadcast, EUI64_ADDR_LEN)) {
+		daddr->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+		daddr->mode = IEEE802154_ADDR_SHORT;
 	} else {
 		__le16 short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
 
@@ -73,32 +48,25 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 
 		if (llneigh &&
 		    lowpan_802154_is_valid_src_short_addr(short_addr)) {
-			info->daddr.short_addr = short_addr;
-			info->daddr.mode = IEEE802154_ADDR_SHORT;
+			daddr->short_addr = short_addr;
+			daddr->mode = IEEE802154_ADDR_SHORT;
 		} else {
-			info->daddr.mode = IEEE802154_ADDR_LONG;
-			ieee802154_be64_to_le64(&info->daddr.extended_addr,
-						daddr);
+			daddr->mode = IEEE802154_ADDR_LONG;
+			ieee802154_be64_to_le64(&daddr->extended_addr,
+						info->daddr);
 		}
 
 		if (n)
 			neigh_release(n);
 	}
 
-	if (!saddr) {
-		if (lowpan_802154_is_valid_src_short_addr(wpan_dev->short_addr)) {
-			info->saddr.mode = IEEE802154_ADDR_SHORT;
-			info->saddr.short_addr = wpan_dev->short_addr;
-		} else {
-			info->saddr.mode = IEEE802154_ADDR_LONG;
-			info->saddr.extended_addr = wpan_dev->extended_addr;
-		}
+	if (lowpan_802154_is_valid_src_short_addr(wpan_dev->short_addr)) {
+		saddr->mode = IEEE802154_ADDR_SHORT;
+		saddr->short_addr = wpan_dev->short_addr;
 	} else {
-		info->saddr.mode = IEEE802154_ADDR_LONG;
-		ieee802154_be64_to_le64(&info->saddr.extended_addr, saddr);
+		saddr->mode = IEEE802154_ADDR_LONG;
+		ieee802154_be64_to_le64(&saddr->extended_addr, info->saddr);
 	}
-
-	return 0;
 }
 
 static struct sk_buff*
@@ -227,33 +195,33 @@ err:
 }
 
 static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
-			 u16 *dgram_size, u16 *dgram_offset)
+			 u16 *dgram_size, u16 *dgram_offset,
+			 const struct ieee802154_addr *daddr,
+			 const struct ieee802154_addr *saddr)
 {
 	struct wpan_dev *wpan_dev = lowpan_802154_dev(ldev)->wdev->ieee802154_ptr;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
-	struct lowpan_addr_info info;
-
-	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
 
 	*dgram_size = skb->len;
-	lowpan_header_compress(skb, ldev, &info.daddr, &info.saddr);
+	lowpan_header_compress(skb, ldev, daddr, saddr);
 	/* dgram_offset = (saved bytes after compression) + lowpan header len */
 	*dgram_offset = (*dgram_size - skb->len) + skb_network_header_len(skb);
 
 	cb->type = IEEE802154_FC_TYPE_DATA;
 
-	if (info.daddr.mode == IEEE802154_ADDR_SHORT &&
-	    ieee802154_is_broadcast_short_addr(info.daddr.short_addr))
+	if (daddr->mode == IEEE802154_ADDR_SHORT &&
+	    ieee802154_is_broadcast_short_addr(daddr->short_addr))
 		cb->ackreq = false;
 	else
 		cb->ackreq = wpan_dev->ackreq;
 
-	return wpan_dev_hard_header(skb, lowpan_802154_dev(ldev)->wdev,
-				    &info.daddr, &info.saddr, 0);
+	return wpan_dev_hard_header(skb, lowpan_802154_dev(ldev)->wdev, daddr,
+				    saddr, 0);
 }
 
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 {
+	struct ieee802154_addr daddr, saddr;
 	struct ieee802154_hdr wpan_hdr;
 	int max_single, ret;
 	u16 dgram_size, dgram_offset;
@@ -262,6 +230,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 
 	WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
 
+	lowpan_addr_lookup(ldev, skb, &daddr, &saddr);
+
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
@@ -269,7 +239,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 	if (!skb)
 		return NET_XMIT_DROP;
 
-	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
+	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset, &daddr,
+			    &saddr);
 	if (ret < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
-- 
2.9.2

