Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:44554 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbaIXKWK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 06:22:10 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/4] ieee802154: 6lowpan: ensure header compression does not corrupt ipv6 header
Date: Wed, 24 Sep 2014 12:21:33 +0200
Message-Id: <1411554093-14976-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Simon Vincent <simon.vincent@xsilon.com>, Alexander Aring <alex.aring@gmail.com>

From: Simon Vincent <simon.vincent@xsilon.com>

The 6lowpan ipv6 header compression was causing problems for other interfaces
that expected a ipv6 header to still be in place, as we were replacing the
ipv6 header with a compressed version. This happened if you sent a packet to a
multicast address as the packet would be output on 802.15.4, ethernet, and also
be sent to the loopback interface. The skb data was shared between these
interfaces so all interfaces ended up with a compressed ipv6 header.
The solution is to ensure that before we do any header compression we are not
sharing the skb or skb data with any other interface. If we are then we must
take a copy of the skb and skb data before modifying the ipv6 header.
The only place we can copy the skb is inside the xmit function so we don't
leave dangling references to skb.
This patch moves all the header compression to inside the xmit function. Very
little code has been changed it has mostly been moved from lowpan_header_create
to lowpan_xmit. At the top of the xmit function we now check if the skb is
shared and if so copy it. In lowpan_header_create all we do now is store the
source and destination addresses for use later when we compress the header.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 125 ++++++++++++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 36 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 5e788cd..78cb206 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -71,20 +71,42 @@ struct lowpan_dev_record {
 	struct list_head list;
 };
 
+/* don't save pan id, it's intra pan */
+struct lowpan_addr {
+	u8 mode;
+	union lowpan_addr_u {
+		/* IPv6 needs big endian here */
+		__be64 extended_addr;
+		__be16 short_addr;
+	} u;
+};
+
+struct lowpan_addr_info {
+	struct lowpan_addr daddr;
+	struct lowpan_addr saddr;
+};
+
 static inline struct
 lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
 {
 	return netdev_priv(dev);
 }
 
+static inline struct
+lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
+{
+	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
+	return (struct lowpan_addr_info *)(skb->data -
+			sizeof(struct lowpan_addr_info));
+}
+
 static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 				unsigned short type, const void *_daddr,
 				const void *_saddr, unsigned int len)
 {
 	const u8 *saddr = _saddr;
 	const u8 *daddr = _daddr;
-	struct ieee802154_addr sa, da;
-	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
+	struct lowpan_addr_info *info;
 
 	/* TODO:
 	 * if this package isn't ipv6 one, where should it be routed?
@@ -98,41 +120,17 @@ static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
 	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
 
-	lowpan_header_compress(skb, dev, type, daddr, saddr, len);
-
-	/* NOTE1: I'm still unsure about the fact that compression and WPAN
-	 * header are created here and not later in the xmit. So wait for
-	 * an opinion of net maintainers.
-	 */
-	/* NOTE2: to be absolutely correct, we must derive PANid information
-	 * from MAC subif of the 'dev' and 'real_dev' network devices, but
-	 * this isn't implemented in mainline yet, so currently we assign 0xff
-	 */
-	cb->type = IEEE802154_FC_TYPE_DATA;
-
-	/* prepare wpan address data */
-	sa.mode = IEEE802154_ADDR_LONG;
-	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
-	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
-
-	/* intra-PAN communications */
-	da.pan_id = sa.pan_id;
-
-	/* if the destination address is the broadcast address, use the
-	 * corresponding short address
-	 */
-	if (lowpan_is_addr_broadcast(daddr)) {
-		da.mode = IEEE802154_ADDR_SHORT;
-		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
-	} else {
-		da.mode = IEEE802154_ADDR_LONG;
-		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
-	}
+	info = lowpan_skb_priv(skb);
 
-	cb->ackreq = !lowpan_is_addr_broadcast(daddr);
+	/* TODO: Currently we only support extended_addr */
+	info->daddr.mode = IEEE802154_ADDR_LONG;
+	memcpy(&info->daddr.u.extended_addr, daddr,
+	       sizeof(info->daddr.u.extended_addr));
+	info->saddr.mode = IEEE802154_ADDR_LONG;
+	memcpy(&info->saddr.u.extended_addr, saddr,
+	       sizeof(info->daddr.u.extended_addr));
 
-	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
-			type, (void *)&da, (void *)&sa, 0);
+	return 0;
 }
 
 static int lowpan_give_skb_to_devices(struct sk_buff *skb,
@@ -330,13 +328,68 @@ err:
 	return rc;
 }
 
+static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ieee802154_addr sa, da;
+	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
+	struct lowpan_addr_info info;
+	void *daddr, *saddr;
+
+	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
+
+	/* TODO: Currently we only support extended_addr */
+	daddr = &info.daddr.u.extended_addr;
+	saddr = &info.saddr.u.extended_addr;
+
+	lowpan_header_compress(skb, dev, ETH_P_IPV6, daddr, saddr, skb->len);
+
+	cb->type = IEEE802154_FC_TYPE_DATA;
+
+	/* prepare wpan address data */
+	sa.mode = IEEE802154_ADDR_LONG;
+	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
+
+	/* intra-PAN communications */
+	da.pan_id = sa.pan_id;
+
+	/* if the destination address is the broadcast address, use the
+	 * corresponding short address
+	 */
+	if (lowpan_is_addr_broadcast((const u8 *)daddr)) {
+		da.mode = IEEE802154_ADDR_SHORT;
+		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+		cb->ackreq = false;
+	} else {
+		da.mode = IEEE802154_ADDR_LONG;
+		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
+		cb->ackreq = true;
+	}
+
+	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
+			ETH_P_IPV6, (void *)&da, (void *)&sa, 0);
+}
+
 static netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_hdr wpan_hdr;
-	int max_single;
+	int max_single, ret;
 
 	pr_debug("package xmit\n");
 
+	/* We must take a copy of the skb before we modify/replace the ipv6
+	 * header as the header could be used elsewhere
+	 */
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_XMIT_DROP;
+
+	ret = lowpan_header(skb, dev);
+	if (ret < 0) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	if (ieee802154_hdr_peek(skb, &wpan_hdr) < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
-- 
2.1.0

