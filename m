Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34986 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967893AbcA0UqZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 27 Jan 2016 15:46:25 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next] 6lowpan: move reciving handling to generic
Date: Wed, 27 Jan 2016 21:46:14 +0100
Message-Id: <1453927574-5074-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch moves 6lowpan receive handling into 6lowpan generic. I
introduced some callback ops to make some link-layer specific handling.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
Hi,

this patch is a draft to talking about to move the receive handling
and evaluation of 6LoWPAN dispatches into net/6lowpan instead that
every 6lowpan specific link-layer implementation will do that on his
own.

I added some callbacks for receive handling, other solutions would
be to add runtime decisions into net/6lowpan/rx.c by eval the
interface type.

Any comments are welcome. It's not perfect yet and it can be still
improved at some places, if we really like to go that way.

- Alex

 include/net/6lowpan.h               | 154 ++++++++++++++++++-----
 net/6lowpan/6lowpan_i.h             |  19 +++
 net/6lowpan/Makefile                |   2 +-
 net/6lowpan/iphc.c                  |   1 -
 net/6lowpan/rx.c                    | 159 +++++++++++++++++++++++
 net/bluetooth/6lowpan.c             | 163 +++++++-----------------
 net/ieee802154/6lowpan/6lowpan_i.h  |  12 +-
 net/ieee802154/6lowpan/core.c       |   4 +
 net/ieee802154/6lowpan/reassembly.c |  21 ++--
 net/ieee802154/6lowpan/rx.c         | 244 ++++++++----------------------------
 10 files changed, 413 insertions(+), 366 deletions(-)
 create mode 100644 net/6lowpan/rx.c

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index e1e2e61..4f04b81 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -60,6 +60,65 @@
 
 #define EUI64_ADDR_LEN		8
 
+#define LOWPAN_DISPATCH_FIRST		0xc0
+#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
+#define LOWPAN_DISPATCH_FRAG_MASK	0xf8
+
+#define LOWPAN_DISPATCH_IPV6		0x41
+#define LOWPAN_DISPATCH_IPHC		0x60
+#define LOWPAN_DISPATCH_FRAG1		0xc0
+#define LOWPAN_DISPATCH_FRAGN		0xe0
+#define LOWPAN_DISPATCH_ESC		0x40
+#define LOWPAN_DISPATCH_HC1		0x42
+#define LOWPAN_DISPATCH_DFF		0x43
+#define LOWPAN_DISPATCH_BC0		0x50
+#define LOWPAN_DISPATCH_MESH		0x80
+
+static inline bool lowpan_is_ipv6(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_IPV6;
+}
+
+static inline bool lowpan_is_iphc(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_IPHC_MASK) == LOWPAN_DISPATCH_IPHC;
+}
+
+static inline bool lowpan_is_frag1(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_FRAG_MASK) == LOWPAN_DISPATCH_FRAG1;
+}
+
+static inline bool lowpan_is_fragn(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_FRAG_MASK) == LOWPAN_DISPATCH_FRAGN;
+}
+
+static inline bool lowpan_is_esc(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_ESC;
+}
+
+static inline bool lowpan_is_hc1(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_HC1;
+}
+
+static inline bool lowpan_is_dff(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_DFF;
+}
+
+static inline bool lowpan_is_bc0(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_BC0;
+}
+
+static inline bool lowpan_is_mesh(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_MESH;
+}
+
 #define LOWPAN_NHC_MAX_ID_LEN	1
 /* Maximum next header compression length which we currently support inclusive
  * possible inline data.
@@ -78,20 +137,6 @@
 /* SCI/DCI is 4 bit width, so we have maximum 16 entries */
 #define LOWPAN_IPHC_CTX_TABLE_SIZE	(1 << 4)
 
-#define LOWPAN_DISPATCH_IPV6		0x41 /* 01000001 = 65 */
-#define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
-#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
-
-static inline bool lowpan_is_ipv6(u8 dispatch)
-{
-	return dispatch == LOWPAN_DISPATCH_IPV6;
-}
-
-static inline bool lowpan_is_iphc(u8 dispatch)
-{
-	return (dispatch & LOWPAN_DISPATCH_IPHC_MASK) == LOWPAN_DISPATCH_IPHC;
-}
-
 #define LOWPAN_PRIV_SIZE(llpriv_size)	\
 	(sizeof(struct lowpan_priv) + llpriv_size)
 
@@ -132,6 +177,7 @@ struct lowpan_priv {
 	enum lowpan_lltypes lltype;
 	struct dentry *iface_debugfs;
 	struct lowpan_iphc_ctx_table ctx;
+	const struct lowpan_rcv_ops *rcv_ops;
 
 	/* must be last */
 	u8 priv[0] __aligned(sizeof(void *));
@@ -143,6 +189,63 @@ struct lowpan_priv *lowpan_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+typedef unsigned __bitwise__ lowpan_rx_result;
+#define LOWPAN_RX_CONTINUE	((__force lowpan_rx_result) 0u)
+#define LOWPAN_RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
+#define LOWPAN_RX_DROP		((__force lowpan_rx_result) 2u)
+#define LOWPAN_RX_QUEUE		((__force lowpan_rx_result) 3u)
+
+struct lowpan_rcv_ops {
+	bool			(*is_invalid_dispatch)(u8 dispatch);
+	int			(*give_skb_to_device)(struct sk_buff *skb);
+	lowpan_rx_result	(*lowpan_rx_h_ll)(struct sk_buff *skb);
+	int			(*parse_mac_addr)(const struct sk_buff *skb,
+						  void *daddr, void *saddr);
+	bool			(*lowpan_unshare_skb)(u8 dispatch);
+};
+
+static inline bool lowpan_unshare_skb(const struct net_device *dev,
+				      u8 dispatch)
+{
+	if (!lowpan_priv(dev)->rcv_ops->lowpan_unshare_skb)
+		return false;
+
+	return lowpan_priv(dev)->rcv_ops->lowpan_unshare_skb(dispatch);
+}
+
+static inline bool lowpan_is_invalid_dispatch(const struct net_device *dev, u8 dispatch)
+{
+	if (!lowpan_priv(dev)->rcv_ops->is_invalid_dispatch)
+		return false;
+
+	return lowpan_priv(dev)->rcv_ops->is_invalid_dispatch(dispatch);
+}
+
+static inline int lowpan_give_skb_to_device(struct sk_buff *skb)
+{
+	if (!lowpan_priv(skb->dev)->rcv_ops->give_skb_to_device)
+		return -EOPNOTSUPP;
+
+	return lowpan_priv(skb->dev)->rcv_ops->give_skb_to_device(skb);
+}
+
+static inline int lowpan_rx_h_ll(struct sk_buff *skb)
+{
+	if (!lowpan_priv(skb->dev)->rcv_ops->lowpan_rx_h_ll)
+		return LOWPAN_RX_CONTINUE;
+
+	return lowpan_priv(skb->dev)->rcv_ops->lowpan_rx_h_ll(skb);
+}
+
+static inline int lowpan_parse_mac_addr(const struct sk_buff *skb, void *daddr,
+					void *saddr)
+{
+	if (!lowpan_priv(skb->dev)->rcv_ops->parse_mac_addr)
+		return -EOPNOTSUPP;
+
+	return lowpan_priv(skb->dev)->rcv_ops->parse_mac_addr(skb, daddr, saddr);
+}
+
 struct lowpan_802154_cb {
 	u16 d_tag;
 	unsigned int d_size;
@@ -227,25 +330,6 @@ void lowpan_unregister_netdevice(struct net_device *dev);
 void lowpan_unregister_netdev(struct net_device *dev);
 
 /**
- * lowpan_header_decompress - replace 6LoWPAN header with IPv6 header
- *
- * This function replaces the IPHC 6LoWPAN header which should be pointed at
- * skb->data and skb_network_header, with the IPv6 header.
- * It would be nice that the caller have the necessary headroom of IPv6 header
- * and greatest Transport layer header, this would reduce the overhead for
- * reallocate headroom.
- *
- * @skb: the buffer which should be manipulate.
- * @dev: the lowpan net device pointer.
- * @daddr: destination lladdr of mac header which is used for compression
- *	methods.
- * @saddr: source lladdr of mac header which is used for compression
- *	methods.
- */
-int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
-			     const void *daddr, const void *saddr);
-
-/**
  * lowpan_header_compress - replace IPv6 header with 6LoWPAN header
  *
  * This function replaces the IPv6 header which should be pointed at
@@ -264,4 +348,8 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 			   const void *daddr, const void *saddr);
 
+int lowpan_rcv(struct sk_buff *skb, struct net_device *dev);
+int lowpan_iphc_decompress(struct sk_buff *skb);
+lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb);
+
 #endif /* __6LOWPAN_H__ */
diff --git a/net/6lowpan/6lowpan_i.h b/net/6lowpan/6lowpan_i.h
index d16bb4b..9e8360f 100644
--- a/net/6lowpan/6lowpan_i.h
+++ b/net/6lowpan/6lowpan_i.h
@@ -25,4 +25,23 @@ static inline int __init lowpan_debugfs_init(void)
 static inline void lowpan_debugfs_exit(void) { }
 #endif /* CONFIG_6LOWPAN_DEBUGFS */
 
+/**
+ * lowpan_header_decompress - replace 6LoWPAN header with IPv6 header
+ *
+ * This function replaces the IPHC 6LoWPAN header which should be pointed at
+ * skb->data and skb_network_header, with the IPv6 header.
+ * It would be nice that the caller have the necessary headroom of IPv6 header
+ * and greatest Transport layer header, this would reduce the overhead for
+ * reallocate headroom.
+ *
+ * @skb: the buffer which should be manipulate.
+ * @dev: the lowpan net device pointer.
+ * @daddr: destination lladdr of mac header which is used for compression
+ *	methods.
+ * @saddr: source lladdr of mac header which is used for compression
+ *	methods.
+ */
+int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
+			     const void *daddr, const void *saddr);
+
 #endif /* __6LOWPAN_I_H */
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index e44f3bf..c7ddc82 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_6LOWPAN) += 6lowpan.o
 
-6lowpan-y := core.o iphc.o nhc.o
+6lowpan-y := core.o iphc.o nhc.o rx.o
 6lowpan-$(CONFIG_6LOWPAN_DEBUGFS) += debugfs.o
 
 #rfc6282 nhcs
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index aad7d77..99d7074 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -766,7 +766,6 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
 static const u8 lowpan_iphc_dam_to_sam_value[] = {
 	[LOWPAN_IPHC_DAM_00] = LOWPAN_IPHC_SAM_00,
diff --git a/net/6lowpan/rx.c b/net/6lowpan/rx.c
new file mode 100644
index 0000000..bd7773e
--- /dev/null
+++ b/net/6lowpan/rx.c
@@ -0,0 +1,159 @@
+/* This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <net/6lowpan.h>
+
+#include "6lowpan_i.h"
+
+#define LOWPAN_DISPATCH_NALP		0x00
+
+static inline bool lowpan_is_nalp(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
+}
+
+static int lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
+{
+	switch (res) {
+	case LOWPAN_RX_CONTINUE:
+		/* nobody cared about this packet */
+		net_warn_ratelimited("%s: received unknown dispatch\n",
+				     __func__);
+
+		/* fall-through */
+	case LOWPAN_RX_DROP_UNUSABLE:
+		kfree_skb(skb);
+
+		/* fall-through */
+	case LOWPAN_RX_DROP:
+		return NET_RX_DROP;
+	case LOWPAN_RX_QUEUE:
+		return lowpan_give_skb_to_device(skb);
+	default:
+		break;
+	}
+
+	return NET_RX_DROP;
+}
+
+int lowpan_iphc_decompress(struct sk_buff *skb)
+{
+	unsigned char daddr[MAX_ADDR_LEN], saddr[MAX_ADDR_LEN];
+	int ret;
+
+	ret = lowpan_parse_mac_addr(skb, &daddr, &saddr);
+	if (ret < 0)
+		return ret;
+
+	return lowpan_header_decompress(skb, skb->dev, &daddr, &saddr);
+}
+EXPORT_SYMBOL(lowpan_iphc_decompress);
+
+static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
+{
+	int ret;
+
+	if (!lowpan_is_iphc(*skb_network_header(skb)))
+		return LOWPAN_RX_CONTINUE;
+
+	switch (lowpan_priv(skb->dev)->lltype) {
+	case LOWPAN_LLTYPE_IEEE802154:
+		/* Setting datagram_offset to zero indicates non frag handling
+		 * while doing lowpan_header_decompress.
+		 */
+		lowpan_802154_cb(skb)->d_size = 0;
+		break;
+	default:
+		break;
+	}
+
+	ret = lowpan_iphc_decompress(skb);
+	if (ret < 0)
+		return LOWPAN_RX_DROP_UNUSABLE;
+
+	return LOWPAN_RX_QUEUE;
+}
+
+lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
+{
+	if (!lowpan_is_ipv6(*skb_network_header(skb)))
+		return LOWPAN_RX_CONTINUE;
+
+	/* Pull off the 1-byte of 6lowpan header. */
+	skb_pull(skb, 1);
+	return LOWPAN_RX_QUEUE;
+}
+EXPORT_SYMBOL(lowpan_rx_h_ipv6);
+
+static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
+{
+	lowpan_rx_result res;
+
+#define CALL_RXH(rxh)				\
+	do {					\
+		res = rxh(skb);			\
+		if (res != LOWPAN_RX_CONTINUE)	\
+			goto rxh_next;		\
+	} while (0)
+
+	CALL_RXH(lowpan_rx_h_iphc);
+	CALL_RXH(lowpan_rx_h_ipv6);
+	/* linklayer specific handler */
+	CALL_RXH(lowpan_rx_h_ll);
+
+rxh_next:
+	return lowpan_rx_handlers_result(skb, res);
+#undef CALL_RXH
+}
+
+/* Lookup for reserved dispatch values at:
+ * https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
+ *
+ * Last Updated: 2015-01-22
+ */
+static inline bool lowpan_is_reserved(u8 dispatch)
+{
+	return ((dispatch >= 0x44 && dispatch <= 0x4F) ||
+		(dispatch >= 0x51 && dispatch <= 0x5F) ||
+		(dispatch >= 0xc8 && dispatch <= 0xdf) ||
+		(dispatch >= 0xe8 && dispatch <= 0xff));
+}
+
+int lowpan_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	if (!netif_running(dev))
+		goto drop;
+
+	if (!skb->len || lowpan_is_nalp(*skb_network_header(skb)) ||
+	    lowpan_is_reserved(*skb_network_header(skb)) ||
+	    lowpan_is_invalid_dispatch(dev, *skb_network_header(skb)))
+		goto drop;
+
+	/* Replacing skb->dev and followed rx handlers will manipulate skb. */
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+	skb->dev = dev;
+
+	if (lowpan_is_iphc(*skb_network_header(skb)) ||
+	    lowpan_unshare_skb(dev, *skb_network_header(skb))) {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			goto out;
+	}
+
+	return lowpan_invoke_rx_handlers(skb);
+
+drop:
+	kfree_skb(skb);
+out:
+	return NET_RX_DROP;
+}
+EXPORT_SYMBOL(lowpan_rcv);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 8a4cc2f..9821188 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -255,147 +255,70 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 	return dev;
 }
 
-static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
-{
-	struct sk_buff *skb_cp;
-
-	skb_cp = skb_copy(skb, GFP_ATOMIC);
-	if (!skb_cp)
-		return NET_RX_DROP;
-
-	return netif_rx_ni(skb_cp);
-}
-
-static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
-			   struct l2cap_chan *chan)
+/* Packet from BT LE device */
+static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	const u8 *saddr, *daddr;
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
 
-	dev = lowpan_dev(netdev);
-
-	rcu_read_lock();
-	peer = __peer_lookup_chan(dev, chan);
-	rcu_read_unlock();
+	peer = lookup_peer(chan->conn);
 	if (!peer)
-		return -EINVAL;
+		return -ENOENT;
 
-	saddr = peer->eui64_addr;
-	daddr = dev->netdev->dev_addr;
+	dev = lookup_dev(chan->conn);
+	if (!dev || !dev->netdev)
+		return -ENOENT;
 
-	return lowpan_header_decompress(skb, netdev, daddr, saddr);
+	skb_reset_network_header(skb);
+	lowpan_cb(skb)->chan = chan;
+	return lowpan_rcv(skb, dev->netdev);
 }
 
-static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
-		    struct l2cap_chan *chan)
+static int lowpan_btle_give_skb_to_device(struct sk_buff *skb)
 {
-	struct sk_buff *local_skb;
-	int ret;
-
-	if (!netif_running(dev))
-		goto drop;
-
-	if (dev->type != ARPHRD_6LOWPAN || !skb->len)
-		goto drop;
-
-	skb_reset_network_header(skb);
-
-	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!skb)
-		goto drop;
-
-	/* check that it's our buffer */
-	if (lowpan_is_ipv6(*skb_network_header(skb))) {
-		/* Pull off the 1-byte of 6lowpan header. */
-		skb_pull(skb, 1);
-
-		/* Copy the packet so that the IPv6 header is
-		 * properly aligned.
-		 */
-		local_skb = skb_copy_expand(skb, NET_SKB_PAD - 1,
-					    skb_tailroom(skb), GFP_ATOMIC);
-		if (!local_skb)
-			goto drop;
-
-		local_skb->protocol = htons(ETH_P_IPV6);
-		local_skb->pkt_type = PACKET_HOST;
-		local_skb->dev = dev;
-
-		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
-
-		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
-			kfree_skb(local_skb);
-			goto drop;
-		}
-
-		dev->stats.rx_bytes += skb->len;
-		dev->stats.rx_packets++;
-
-		consume_skb(local_skb);
-		consume_skb(skb);
-	} else if (lowpan_is_iphc(*skb_network_header(skb))) {
-		local_skb = skb_clone(skb, GFP_ATOMIC);
-		if (!local_skb)
-			goto drop;
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+	skb->dev->stats.rx_packets++;
+	skb->dev->stats.rx_bytes += skb->len;
 
-		local_skb->dev = dev;
-
-		ret = iphc_decompress(local_skb, dev, chan);
-		if (ret < 0) {
-			kfree_skb(local_skb);
-			goto drop;
-		}
-
-		local_skb->protocol = htons(ETH_P_IPV6);
-		local_skb->pkt_type = PACKET_HOST;
-
-		if (give_skb_to_upper(local_skb, dev)
-				!= NET_RX_SUCCESS) {
-			kfree_skb(local_skb);
-			goto drop;
-		}
-
-		dev->stats.rx_bytes += skb->len;
-		dev->stats.rx_packets++;
-
-		consume_skb(local_skb);
-		consume_skb(skb);
-	} else {
-		goto drop;
-	}
-
-	return NET_RX_SUCCESS;
+	return netif_rx_ni(skb);
+}
 
-drop:
-	dev->stats.rx_dropped++;
-	return NET_RX_DROP;
+static inline bool lowpan_btle_is_invalid_dispatch(u8 dispatch)
+{
+	return lowpan_is_frag1(dispatch) || lowpan_is_fragn(dispatch) ||
+	       lowpan_is_esc(dispatch) || lowpan_is_hc1(dispatch) ||
+	       lowpan_is_dff(dispatch) || lowpan_is_bc0(dispatch) ||
+	       lowpan_is_mesh(dispatch);
 }
 
-/* Packet from BT LE device */
-static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
+static int lowpan_btle_parse_mac_addr(const struct sk_buff *skb,
+				      void *daddr, void *saddr)
 {
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
-	int err;
 
-	peer = lookup_peer(chan->conn);
-	if (!peer)
-		return -ENOENT;
+	dev = lowpan_dev(skb->dev);
 
-	dev = lookup_dev(chan->conn);
-	if (!dev || !dev->netdev)
-		return -ENOENT;
-
-	err = recv_pkt(skb, dev->netdev, chan);
-	if (err) {
-		BT_DBG("recv pkt %d", err);
-		err = -EAGAIN;
+	rcu_read_lock();
+	peer = __peer_lookup_chan(dev, lowpan_cb(skb)->chan);
+	if (!peer) {
+		rcu_read_unlock();
+		return -EINVAL;
 	}
+	memcpy(saddr, &peer->eui64_addr, EUI64_ADDR_LEN);
+	rcu_read_unlock();
 
-	return err;
+	memcpy(daddr, skb->dev->dev_addr, EUI64_ADDR_LEN);
+	return 0;
 }
 
+static const struct lowpan_rcv_ops lowpan_btle_rcv_ops = {
+	.is_invalid_dispatch = lowpan_btle_is_invalid_dispatch,
+	.give_skb_to_device = lowpan_btle_give_skb_to_device,
+	.parse_mac_addr = lowpan_btle_parse_mac_addr,
+};
+
 static u8 get_addr_type_from_eui64(u8 byte)
 {
 	/* Is universal(0) or local(1) bit */
@@ -656,6 +579,8 @@ static struct header_ops header_ops = {
 
 static void netdev_setup(struct net_device *dev)
 {
+	struct lowpan_priv *lpriv = lowpan_priv(dev);
+
 	dev->hard_header_len	= 0;
 	dev->needed_tailroom	= 0;
 	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
@@ -665,6 +590,8 @@ static void netdev_setup(struct net_device *dev)
 	dev->netdev_ops		= &netdev_ops;
 	dev->header_ops		= &header_ops;
 	dev->destructor		= free_netdev;
+
+	lpriv->rcv_ops		= &lowpan_btle_rcv_ops;
 }
 
 static struct device_type bt_type = {
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index b4e17a7..210c4d3 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -7,15 +7,6 @@
 #include <net/inet_frag.h>
 #include <net/6lowpan.h>
 
-typedef unsigned __bitwise__ lowpan_rx_result;
-#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
-#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
-#define RX_DROP			((__force lowpan_rx_result) 2u)
-#define RX_QUEUED		((__force lowpan_rx_result) 3u)
-
-#define LOWPAN_DISPATCH_FRAG1           0xc0
-#define LOWPAN_DISPATCH_FRAGN           0xe0
-
 struct lowpan_create_arg {
 	u16 tag;
 	u16 d_size;
@@ -71,7 +62,6 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 			 const void *_saddr, unsigned int len);
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev);
 
-int lowpan_iphc_decompress(struct sk_buff *skb);
-lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb);
+extern const struct lowpan_rcv_ops lowpan_802154_rcv_ops;
 
 #endif /* __IEEE802154_6LOWPAN_I_H__ */
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 0023c90..f52f7ad 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -101,6 +101,8 @@ static const struct net_device_ops lowpan_netdev_ops = {
 
 static void lowpan_setup(struct net_device *ldev)
 {
+	struct lowpan_priv *lpriv = lowpan_priv(ldev);
+
 	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
 	/* We need an ipv6hdr as minimum len when calling xmit */
 	ldev->hard_header_len	= sizeof(struct ipv6hdr);
@@ -110,6 +112,8 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->header_ops	= &lowpan_header_ops;
 	ldev->destructor	= free_netdev;
 	ldev->features		|= NETIF_F_NETNS_LOCAL;
+
+	lpriv->rcv_ops		= &lowpan_802154_rcv_ops;
 }
 
 static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 30d875d..36eb9ee 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -318,9 +318,9 @@ static int lowpan_frag_rx_handlers_result(struct sk_buff *skb,
 					  lowpan_rx_result res)
 {
 	switch (res) {
-	case RX_QUEUED:
+	case LOWPAN_RX_QUEUE:
 		return NET_RX_SUCCESS;
-	case RX_CONTINUE:
+	case LOWPAN_RX_CONTINUE:
 		/* nobody cared about this packet */
 		net_warn_ratelimited("%s: received unknown dispatch\n",
 				     __func__);
@@ -337,27 +337,26 @@ static lowpan_rx_result lowpan_frag_rx_h_iphc(struct sk_buff *skb)
 	int ret;
 
 	if (!lowpan_is_iphc(*skb_network_header(skb)))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	ret = lowpan_iphc_decompress(skb);
 	if (ret < 0)
-		return RX_DROP;
+		return LOWPAN_RX_DROP;
 
-	return RX_QUEUED;
+	return LOWPAN_RX_QUEUE;
 }
 
 static int lowpan_invoke_frag_rx_handlers(struct sk_buff *skb)
 {
 	lowpan_rx_result res;
 
-#define CALL_RXH(rxh)			\
-	do {				\
-		res = rxh(skb);	\
-		if (res != RX_CONTINUE)	\
-			goto rxh_next;	\
+#define CALL_RXH(rxh)				\
+	do {					\
+		res = rxh(skb);			\
+		if (res != LOWPAN_RX_CONTINUE)	\
+			goto rxh_next;		\
 	} while (0)
 
-	/* likely at first */
 	CALL_RXH(lowpan_frag_rx_h_iphc);
 	CALL_RXH(lowpan_rx_h_ipv6);
 
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index ef185dd..057c2ec 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -16,17 +16,7 @@
 
 #include "6lowpan_i.h"
 
-#define LOWPAN_DISPATCH_FIRST		0xc0
-#define LOWPAN_DISPATCH_FRAG_MASK	0xf8
-
-#define LOWPAN_DISPATCH_NALP		0x00
-#define LOWPAN_DISPATCH_ESC		0x40
-#define LOWPAN_DISPATCH_HC1		0x42
-#define LOWPAN_DISPATCH_DFF		0x43
-#define LOWPAN_DISPATCH_BC0		0x50
-#define LOWPAN_DISPATCH_MESH		0x80
-
-static int lowpan_give_skb_to_device(struct sk_buff *skb)
+static int lowpan_802154_give_skb_to_device(struct sk_buff *skb)
 {
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev->stats.rx_packets++;
@@ -35,193 +25,93 @@ static int lowpan_give_skb_to_device(struct sk_buff *skb)
 	return netif_rx(skb);
 }
 
-static int lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
-{
-	switch (res) {
-	case RX_CONTINUE:
-		/* nobody cared about this packet */
-		net_warn_ratelimited("%s: received unknown dispatch\n",
-				     __func__);
-
-		/* fall-through */
-	case RX_DROP_UNUSABLE:
-		kfree_skb(skb);
-
-		/* fall-through */
-	case RX_DROP:
-		return NET_RX_DROP;
-	case RX_QUEUED:
-		return lowpan_give_skb_to_device(skb);
-	default:
-		break;
-	}
-
-	return NET_RX_DROP;
-}
-
-static inline bool lowpan_is_frag1(u8 dispatch)
-{
-	return (dispatch & LOWPAN_DISPATCH_FRAG_MASK) == LOWPAN_DISPATCH_FRAG1;
-}
-
-static inline bool lowpan_is_fragn(u8 dispatch)
-{
-	return (dispatch & LOWPAN_DISPATCH_FRAG_MASK) == LOWPAN_DISPATCH_FRAGN;
-}
-
 static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
 {
 	int ret;
 
 	if (!(lowpan_is_frag1(*skb_network_header(skb)) ||
 	      lowpan_is_fragn(*skb_network_header(skb))))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) &
 			      LOWPAN_DISPATCH_FRAG_MASK);
 	if (ret == 1)
-		return RX_QUEUED;
+		return LOWPAN_RX_QUEUE;
 
 	/* Packet is freed by lowpan_frag_rcv on error or put into the frag
 	 * bucket.
 	 */
-	return RX_DROP;
-}
-
-int lowpan_iphc_decompress(struct sk_buff *skb)
-{
-	struct ieee802154_hdr hdr;
-
-	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-		return -EINVAL;
-
-	return lowpan_header_decompress(skb, skb->dev, &hdr.dest, &hdr.source);
-}
-
-static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
-{
-	int ret;
-
-	if (!lowpan_is_iphc(*skb_network_header(skb)))
-		return RX_CONTINUE;
-
-	/* Setting datagram_offset to zero indicates non frag handling
-	 * while doing lowpan_header_decompress.
-	 */
-	lowpan_802154_cb(skb)->d_size = 0;
-
-	ret = lowpan_iphc_decompress(skb);
-	if (ret < 0)
-		return RX_DROP_UNUSABLE;
-
-	return RX_QUEUED;
-}
-
-lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
-{
-	if (!lowpan_is_ipv6(*skb_network_header(skb)))
-		return RX_CONTINUE;
-
-	/* Pull off the 1-byte of 6lowpan header. */
-	skb_pull(skb, 1);
-	return RX_QUEUED;
-}
-
-static inline bool lowpan_is_esc(u8 dispatch)
-{
-	return dispatch == LOWPAN_DISPATCH_ESC;
+	return LOWPAN_RX_DROP;
 }
 
 static lowpan_rx_result lowpan_rx_h_esc(struct sk_buff *skb)
 {
 	if (!lowpan_is_esc(*skb_network_header(skb)))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	net_warn_ratelimited("%s: %s\n", skb->dev->name,
 			     "6LoWPAN ESC not supported\n");
 
-	return RX_DROP_UNUSABLE;
-}
-
-static inline bool lowpan_is_hc1(u8 dispatch)
-{
-	return dispatch == LOWPAN_DISPATCH_HC1;
+	return LOWPAN_RX_DROP_UNUSABLE;
 }
 
 static lowpan_rx_result lowpan_rx_h_hc1(struct sk_buff *skb)
 {
 	if (!lowpan_is_hc1(*skb_network_header(skb)))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	net_warn_ratelimited("%s: %s\n", skb->dev->name,
 			     "6LoWPAN HC1 not supported\n");
 
-	return RX_DROP_UNUSABLE;
-}
-
-static inline bool lowpan_is_dff(u8 dispatch)
-{
-	return dispatch == LOWPAN_DISPATCH_DFF;
+	return LOWPAN_RX_DROP_UNUSABLE;
 }
 
 static lowpan_rx_result lowpan_rx_h_dff(struct sk_buff *skb)
 {
 	if (!lowpan_is_dff(*skb_network_header(skb)))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	net_warn_ratelimited("%s: %s\n", skb->dev->name,
 			     "6LoWPAN DFF not supported\n");
 
-	return RX_DROP_UNUSABLE;
-}
-
-static inline bool lowpan_is_bc0(u8 dispatch)
-{
-	return dispatch == LOWPAN_DISPATCH_BC0;
+	return LOWPAN_RX_DROP_UNUSABLE;
 }
 
 static lowpan_rx_result lowpan_rx_h_bc0(struct sk_buff *skb)
 {
 	if (!lowpan_is_bc0(*skb_network_header(skb)))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	net_warn_ratelimited("%s: %s\n", skb->dev->name,
 			     "6LoWPAN BC0 not supported\n");
 
-	return RX_DROP_UNUSABLE;
-}
-
-static inline bool lowpan_is_mesh(u8 dispatch)
-{
-	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_MESH;
+	return LOWPAN_RX_DROP_UNUSABLE;
 }
 
 static lowpan_rx_result lowpan_rx_h_mesh(struct sk_buff *skb)
 {
 	if (!lowpan_is_mesh(*skb_network_header(skb)))
-		return RX_CONTINUE;
+		return LOWPAN_RX_CONTINUE;
 
 	net_warn_ratelimited("%s: %s\n", skb->dev->name,
 			     "6LoWPAN MESH not supported\n");
 
-	return RX_DROP_UNUSABLE;
+	return LOWPAN_RX_DROP_UNUSABLE;
 }
 
-static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
+static lowpan_rx_result lowpan_802154_invoke_rx_handlers(struct sk_buff *skb)
 {
 	lowpan_rx_result res;
 
-#define CALL_RXH(rxh)			\
-	do {				\
-		res = rxh(skb);	\
-		if (res != RX_CONTINUE)	\
-			goto rxh_next;	\
+#define CALL_RXH(rxh)				\
+	do {					\
+		res = rxh(skb);			\
+		if (res != LOWPAN_RX_CONTINUE)	\
+			goto rxh_next;		\
 	} while (0)
 
 	/* likely at first */
-	CALL_RXH(lowpan_rx_h_iphc);
 	CALL_RXH(lowpan_rx_h_frag);
-	CALL_RXH(lowpan_rx_h_ipv6);
 	CALL_RXH(lowpan_rx_h_esc);
 	CALL_RXH(lowpan_rx_h_hc1);
 	CALL_RXH(lowpan_rx_h_dff);
@@ -229,95 +119,67 @@ static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
 	CALL_RXH(lowpan_rx_h_mesh);
 
 rxh_next:
-	return lowpan_rx_handlers_result(skb, res);
+	return res;
 #undef CALL_RXH
 }
 
-static inline bool lowpan_is_nalp(u8 dispatch)
+static int lowpan_802154_parse_mac_addr(const struct sk_buff *skb,
+					void *daddr, void *saddr)
 {
-	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
-}
-
-/* Lookup for reserved dispatch values at:
- * https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
- *
- * Last Updated: 2015-01-22
- */
-static inline bool lowpan_is_reserved(u8 dispatch)
-{
-	return ((dispatch >= 0x44 && dispatch <= 0x4F) ||
-		(dispatch >= 0x51 && dispatch <= 0x5F) ||
-		(dispatch >= 0xc8 && dispatch <= 0xdf) ||
-		(dispatch >= 0xe8 && dispatch <= 0xff));
-}
-
-/* lowpan_rx_h_check checks on generic 6LoWPAN requirements
- * in MAC and 6LoWPAN header.
- *
- * Don't manipulate the skb here, it could be shared buffer.
- */
-static inline bool lowpan_rx_h_check(struct sk_buff *skb)
-{
-	__le16 fc = ieee802154_get_fc_from_skb(skb);
+	struct ieee802154_hdr hdr;
 
-	/* check on ieee802154 conform 6LoWPAN header */
-	if (!ieee802154_is_data(fc) ||
-	    !ieee802154_is_intra_pan(fc))
-		return false;
+	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
+		return -EINVAL;
 
-	/* check if we can dereference the dispatch */
-	if (unlikely(!skb->len))
-		return false;
+	memcpy(daddr, &hdr.dest, sizeof(hdr.dest));
+	memcpy(saddr, &hdr.source, sizeof(hdr.source));
 
-	if (lowpan_is_nalp(*skb_network_header(skb)) ||
-	    lowpan_is_reserved(*skb_network_header(skb)))
-		return false;
+	return 0;
+}
 
-	return true;
+static bool lowpan_802154_unshare_buffer(u8 dispatch)
+{
+	return lowpan_is_frag1(dispatch);
 }
 
-static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
-		      struct packet_type *pt, struct net_device *orig_wdev)
+const struct lowpan_rcv_ops lowpan_802154_rcv_ops = {
+	.give_skb_to_device = lowpan_802154_give_skb_to_device,
+	.lowpan_rx_h_ll = lowpan_802154_invoke_rx_handlers,
+	.parse_mac_addr = lowpan_802154_parse_mac_addr,
+	.lowpan_unshare_skb = lowpan_802154_unshare_buffer,
+};
+
+static int lowpan_802154_rcv(struct sk_buff *skb, struct net_device *wdev,
+			     struct packet_type *pt,
+			     struct net_device *orig_wdev)
 {
 	struct net_device *ldev;
+	__le16 fc;
 
 	if (wdev->type != ARPHRD_IEEE802154 ||
-	    skb->pkt_type == PACKET_OTHERHOST ||
-	    !lowpan_rx_h_check(skb))
+	    skb->pkt_type == PACKET_OTHERHOST)
 		goto drop;
 
 	ldev = wdev->ieee802154_ptr->lowpan_dev;
-	if (!ldev || !netif_running(ldev))
+	if (!ldev)
 		goto drop;
 
-	/* Replacing skb->dev and followed rx handlers will manipulate skb. */
-	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!skb)
-		goto out;
-	skb->dev = ldev;
-
-	/* When receive frag1 it's likely that we manipulate the buffer.
-	 * When recevie iphc we manipulate the data buffer. So we need
-	 * to unshare the buffer.
-	 */
-	if (lowpan_is_frag1(*skb_network_header(skb)) ||
-	    lowpan_is_iphc(*skb_network_header(skb))) {
-		skb = skb_unshare(skb, GFP_ATOMIC);
-		if (!skb)
-			goto out;
-	}
+	fc = ieee802154_get_fc_from_skb(skb);
+	/* check on ieee802154 conform 6LoWPAN header */
+	if (!ieee802154_is_data(fc) ||
+	    !ieee802154_is_intra_pan(fc))
+		goto drop;
 
-	return lowpan_invoke_rx_handlers(skb);
+	return lowpan_rcv(skb, ldev);
 
 drop:
 	kfree_skb(skb);
-out:
 	return NET_RX_DROP;
 }
 
 static struct packet_type lowpan_packet_type = {
 	.type = htons(ETH_P_IEEE802154),
-	.func = lowpan_rcv,
+	.func = lowpan_802154_rcv,
 };
 
 void lowpan_rx_init(void)
-- 
2.7.0

