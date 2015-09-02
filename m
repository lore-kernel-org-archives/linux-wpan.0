Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35288 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbbIBMWO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:14 -0400
Received: by wicge5 with SMTP id ge5so38851305wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/16] ieee820154: 6lowpan: dispatch evaluation rework
Date: Wed,  2 Sep 2015 14:21:25 +0200
Message-Id: <1441196491-25013-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

This patch complete reworks the evaluation of 6lowpan dispatch value by
introducing a receive handler mechanism for each dispatch value.

A list of changes:

 - Doing uncompression on-the-fly when FRAG1 is received, this require
   some special handling for 802.15.4 lltype in generic 6lowpan branch
   for setting the payload length correct.
 - Fix dispatch mask for fragmentation.
 - Add IPv6 dispatch evaluation for FRAG1.
 - Add skb_unshare for dispatch which might manipulate the skb data
   buffer.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h               |  31 ++++--
 net/6lowpan/iphc.c                  |  13 ++-
 net/6lowpan/nhc_udp.c               |  13 ++-
 net/ieee802154/6lowpan/6lowpan_i.h  |  12 +++
 net/ieee802154/6lowpan/reassembly.c | 142 +++++++++++++++++++--------
 net/ieee802154/6lowpan/rx.c         | 188 ++++++++++++++++++++++++------------
 6 files changed, 288 insertions(+), 111 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index a2f59ec..3509841 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -126,13 +126,19 @@
 	 (((a)[6]) == 0xFF) &&	\
 	 (((a)[7]) == 0xFF))
 
-#define LOWPAN_DISPATCH_IPV6	0x41 /* 01000001 = 65 */
-#define LOWPAN_DISPATCH_HC1	0x42 /* 01000010 = 66 */
-#define LOWPAN_DISPATCH_IPHC	0x60 /* 011xxxxx = ... */
-#define LOWPAN_DISPATCH_FRAG1	0xc0 /* 11000xxx */
-#define LOWPAN_DISPATCH_FRAGN	0xe0 /* 11100xxx */
+#define LOWPAN_DISPATCH_IPV6		0x41 /* 01000001 = 65 */
+#define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
+#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
 
-#define LOWPAN_DISPATCH_MASK	0xf8 /* 11111000 */
+static inline bool lowpan_is_ipv6(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_IPV6;
+}
+
+static inline bool lowpan_is_iphc(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_IPHC_MASK) == LOWPAN_DISPATCH_IPHC;
+}
 
 #define LOWPAN_FRAG_TIMEOUT	(HZ * 60)	/* time-out 60 sec */
 
@@ -218,6 +224,19 @@ struct lowpan_priv *lowpan_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+struct lowpan_802154_cb {
+	u16 d_tag;
+	unsigned int d_size;
+	u8 d_offset;
+};
+
+static inline
+struct lowpan_802154_cb *lowpan_802154_cb(const struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct lowpan_802154_cb) > sizeof(skb->cb));
+	return (struct lowpan_802154_cb *)skb->cb;
+}
+
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 1e0071f..78c8a49 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -366,7 +366,18 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 			return err;
 	}
 
-	hdr.payload_len = htons(skb->len);
+	switch (lowpan_priv(dev)->lltype) {
+	case LOWPAN_LLTYPE_IEEE802154:
+		if (lowpan_802154_cb(skb)->d_size)
+			hdr.payload_len = htons(lowpan_802154_cb(skb)->d_size -
+						sizeof(struct ipv6hdr));
+		else
+			hdr.payload_len = htons(skb->len);
+		break;
+	default:
+		hdr.payload_len = htons(skb->len);
+		break;
+	}
 
 	pr_debug("skb headroom size = %d, data length = %d\n",
 		 skb_headroom(skb), skb->len);
diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
index c6bcaeb..72d0b57 100644
--- a/net/6lowpan/nhc_udp.c
+++ b/net/6lowpan/nhc_udp.c
@@ -71,7 +71,18 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
 	 * here, we obtain the hint from the remaining size of the
 	 * frame
 	 */
-	uh.len = htons(skb->len + sizeof(struct udphdr));
+	switch (lowpan_priv(skb->dev)->lltype) {
+	case LOWPAN_LLTYPE_IEEE802154:
+		if (lowpan_802154_cb(skb)->d_size)
+			uh.len = htons(lowpan_802154_cb(skb)->d_size -
+				       sizeof(struct ipv6hdr));
+		else
+			uh.len = htons(skb->len + sizeof(struct udphdr));
+		break;
+	default:
+		uh.len = htons(skb->len + sizeof(struct udphdr));
+		break;
+	}
 	pr_debug("uncompressed UDP length: src = %d", ntohs(uh.len));
 
 	/* replace the compressed UDP head by the uncompressed UDP
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index 9aa7b62..b4e17a7 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -7,6 +7,15 @@
 #include <net/inet_frag.h>
 #include <net/6lowpan.h>
 
+typedef unsigned __bitwise__ lowpan_rx_result;
+#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
+#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
+#define RX_DROP			((__force lowpan_rx_result) 2u)
+#define RX_QUEUED		((__force lowpan_rx_result) 3u)
+
+#define LOWPAN_DISPATCH_FRAG1           0xc0
+#define LOWPAN_DISPATCH_FRAGN           0xe0
+
 struct lowpan_create_arg {
 	u16 tag;
 	u16 d_size;
@@ -62,4 +71,7 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 			 const void *_saddr, unsigned int len);
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev);
 
+int lowpan_iphc_decompress(struct sk_buff *skb);
+lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb);
+
 #endif /* __IEEE802154_6LOWPAN_I_H__ */
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 0fc3350..12e8cf4 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -32,17 +32,6 @@
 
 static const char lowpan_frags_cache_name[] = "lowpan-frags";
 
-struct lowpan_frag_info {
-	u16 d_tag;
-	u16 d_size;
-	u8 d_offset;
-};
-
-static struct lowpan_frag_info *lowpan_cb(struct sk_buff *skb)
-{
-	return (struct lowpan_frag_info *)skb->cb;
-}
-
 static struct inet_frags lowpan_frags;
 
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
@@ -111,7 +100,7 @@ out:
 }
 
 static inline struct lowpan_frag_queue *
-fq_find(struct net *net, const struct lowpan_frag_info *frag_info,
+fq_find(struct net *net, const struct lowpan_802154_cb *cb,
 	const struct ieee802154_addr *src,
 	const struct ieee802154_addr *dst)
 {
@@ -121,12 +110,12 @@ fq_find(struct net *net, const struct lowpan_frag_info *frag_info,
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
 
-	arg.tag = frag_info->d_tag;
-	arg.d_size = frag_info->d_size;
+	arg.tag = cb->d_tag;
+	arg.d_size = cb->d_size;
 	arg.src = src;
 	arg.dst = dst;
 
-	hash = lowpan_hash_frag(frag_info->d_tag, frag_info->d_size, src, dst);
+	hash = lowpan_hash_frag(cb->d_tag, cb->d_size, src, dst);
 
 	q = inet_frag_find(&ieee802154_lowpan->frags,
 			   &lowpan_frags, &arg, hash);
@@ -138,7 +127,7 @@ fq_find(struct net *net, const struct lowpan_frag_info *frag_info,
 }
 
 static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
-			     struct sk_buff *skb, const u8 frag_type)
+			     struct sk_buff *skb, u8 frag_type)
 {
 	struct sk_buff *prev, *next;
 	struct net_device *ldev;
@@ -147,8 +136,8 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 	if (fq->q.flags & INET_FRAG_COMPLETE)
 		goto err;
 
-	offset = lowpan_cb(skb)->d_offset << 3;
-	end = lowpan_cb(skb)->d_size;
+	offset = lowpan_802154_cb(skb)->d_offset << 3;
+	end = lowpan_802154_cb(skb)->d_size;
 
 	/* Is this the final fragment? */
 	if (offset + skb->len == end) {
@@ -174,13 +163,16 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 	 * this fragment, right?
 	 */
 	prev = fq->q.fragments_tail;
-	if (!prev || lowpan_cb(prev)->d_offset < lowpan_cb(skb)->d_offset) {
+	if (!prev ||
+	    lowpan_802154_cb(prev)->d_offset <
+	    lowpan_802154_cb(skb)->d_offset) {
 		next = NULL;
 		goto found;
 	}
 	prev = NULL;
 	for (next = fq->q.fragments; next != NULL; next = next->next) {
-		if (lowpan_cb(next)->d_offset >= lowpan_cb(skb)->d_offset)
+		if (lowpan_802154_cb(next)->d_offset >=
+		    lowpan_802154_cb(skb)->d_offset)
 			break;	/* bingo! */
 		prev = next;
 	}
@@ -200,13 +192,10 @@ found:
 		skb->dev = NULL;
 
 	fq->q.stamp = skb->tstamp;
-	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
-		/* Calculate uncomp. 6lowpan header to estimate full size */
-		fq->q.meat += lowpan_uncompress_size(skb, NULL);
+	if (frag_type == LOWPAN_DISPATCH_FRAG1)
 		fq->q.flags |= INET_FRAG_FIRST_IN;
-	} else {
-		fq->q.meat += skb->len;
-	}
+
+	fq->q.meat += skb->len;
 	add_frag_mem_limit(fq->q.net, skb->truesize);
 
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
@@ -325,24 +314,87 @@ out_oom:
 	return -1;
 }
 
-static int lowpan_get_frag_info(struct sk_buff *skb, const u8 frag_type,
-				struct lowpan_frag_info *frag_info)
+static int lowpan_frag_rx_handlers_result(struct sk_buff *skb,
+					  lowpan_rx_result res)
+{
+	switch (res) {
+	case RX_QUEUED:
+		return NET_RX_SUCCESS;
+	case RX_CONTINUE:
+		/* nobody cared about this packet */
+		net_warn_ratelimited("%s: received unknown dispatch\n",
+				     __func__);
+
+		/* fall-through */
+	default:
+		/* all others failure */
+		return NET_RX_DROP;
+	}
+}
+
+static lowpan_rx_result lowpan_frag_rx_h_iphc(struct sk_buff *skb)
+{
+	int ret;
+
+	if (!lowpan_is_iphc(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	ret = lowpan_iphc_decompress(skb);
+	if (ret < 0)
+		return RX_DROP;
+
+	return RX_QUEUED;
+}
+
+static int lowpan_invoke_frag_rx_handlers(struct sk_buff *skb)
+{
+	lowpan_rx_result res;
+
+#define CALL_RXH(rxh)			\
+	do {				\
+		res = rxh(skb);	\
+		if (res != RX_CONTINUE)	\
+			goto rxh_next;	\
+	} while (0)
+
+	/* likely at first */
+	CALL_RXH(lowpan_frag_rx_h_iphc);
+	CALL_RXH(lowpan_rx_h_ipv6);
+
+rxh_next:
+	return lowpan_frag_rx_handlers_result(skb, res);
+#undef CALL_RXH
+}
+
+#define LOWPAN_FRAG_DGRAM_SIZE_HIGH_MASK	0x07
+#define LOWPAN_FRAG_DGRAM_SIZE_HIGH_SHIFT	8
+
+static int lowpan_get_cb(struct sk_buff *skb, u8 frag_type,
+			 struct lowpan_802154_cb *cb)
 {
 	bool fail;
-	u8 pattern = 0, low = 0;
+	u8 high = 0, low = 0;
 	__be16 d_tag = 0;
 
-	fail = lowpan_fetch_skb(skb, &pattern, 1);
+	fail = lowpan_fetch_skb(skb, &high, 1);
 	fail |= lowpan_fetch_skb(skb, &low, 1);
-	frag_info->d_size = (pattern & 7) << 8 | low;
+	/* remove the dispatch value and use first three bits as high value
+	 * for the datagram size
+	 */
+	cb->d_size = (high & LOWPAN_FRAG_DGRAM_SIZE_HIGH_MASK) <<
+		LOWPAN_FRAG_DGRAM_SIZE_HIGH_SHIFT | low;
 	fail |= lowpan_fetch_skb(skb, &d_tag, 2);
-	frag_info->d_tag = ntohs(d_tag);
+	cb->d_tag = ntohs(d_tag);
 
 	if (frag_type == LOWPAN_DISPATCH_FRAGN) {
-		fail |= lowpan_fetch_skb(skb, &frag_info->d_offset, 1);
+		fail |= lowpan_fetch_skb(skb, &cb->d_offset, 1);
 	} else {
 		skb_reset_network_header(skb);
-		frag_info->d_offset = 0;
+		cb->d_offset = 0;
+		/* check if datagram_size has ipv6hdr on FRAG1 */
+		fail |= cb->d_size < sizeof(struct ipv6hdr);
+		/* check if we can dereference the dispatch value */
+		fail |= !skb->len;
 	}
 
 	if (unlikely(fail))
@@ -351,27 +403,33 @@ static int lowpan_get_frag_info(struct sk_buff *skb, const u8 frag_type,
 	return 0;
 }
 
-int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type)
+int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 {
 	struct lowpan_frag_queue *fq;
 	struct net *net = dev_net(skb->dev);
-	struct lowpan_frag_info *frag_info = lowpan_cb(skb);
-	struct ieee802154_addr source, dest;
+	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
+	struct ieee802154_hdr hdr;
 	int err;
 
-	source = mac_cb(skb)->source;
-	dest = mac_cb(skb)->dest;
+	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
+		goto err;
 
-	err = lowpan_get_frag_info(skb, frag_type, frag_info);
+	err = lowpan_get_cb(skb, frag_type, cb);
 	if (err < 0)
 		goto err;
 
-	if (frag_info->d_size > IPV6_MIN_MTU) {
+	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
+		err = lowpan_invoke_frag_rx_handlers(skb);
+		if (err == NET_RX_DROP)
+			goto err;
+	}
+
+	if (cb->d_size > IPV6_MIN_MTU) {
 		net_warn_ratelimited("lowpan_frag_rcv: datagram size exceeds MTU\n");
 		goto err;
 	}
 
-	fq = fq_find(net, frag_info, &source, &dest);
+	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
 	if (fq != NULL) {
 		int ret;
 
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index f9cb70b..fded109 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -15,8 +15,9 @@
 
 #include "6lowpan_i.h"
 
-static int lowpan_give_skb_to_device(struct sk_buff *skb,
-				     struct net_device *wdev)
+#define LOWPAN_DISPATCH_FRAG_MASK	0xf8
+
+static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->pkt_type = PACKET_HOST;
@@ -24,21 +25,77 @@ static int lowpan_give_skb_to_device(struct sk_buff *skb,
 	return netif_rx(skb);
 }
 
-static int
-iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+static int lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
+{
+	switch (res) {
+	case RX_CONTINUE:
+		/* nobody cared about this packet */
+		net_warn_ratelimited("%s: received unknown dispatch\n",
+				     __func__);
+
+		/* fall-through */
+	case RX_DROP_UNUSABLE:
+		kfree_skb(skb);
+
+		/* fall-through */
+	case RX_DROP:
+		return NET_RX_DROP;
+	case RX_QUEUED:
+		return lowpan_give_skb_to_device(skb);
+	default:
+		break;
+	}
+
+	return NET_RX_DROP;
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
+static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
+{
+	int ret;
+
+	if (!(lowpan_is_frag1(*skb_network_header(skb)) ||
+	      lowpan_is_fragn(*skb_network_header(skb))))
+		return RX_CONTINUE;
+
+	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) &
+			      LOWPAN_DISPATCH_FRAG_MASK);
+	if (ret == 1)
+		return RX_QUEUED;
+
+	/* Packet is freed by lowpan_frag_rcv on error or put into the frag
+	 * bucket.
+	 */
+	return RX_DROP;
+}
+
+int lowpan_iphc_decompress(struct sk_buff *skb)
 {
-	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
+	struct ieee802154_hdr hdr;
+	u8 iphc0, iphc1;
 	void *sap, *dap;
 
+	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
+		return -EINVAL;
+
 	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
 
 	if (lowpan_fetch_skb_u8(skb, &iphc0) ||
 	    lowpan_fetch_skb_u8(skb, &iphc1))
 		return -EINVAL;
 
-	ieee802154_addr_to_sa(&sa, &hdr->source);
-	ieee802154_addr_to_sa(&da, &hdr->dest);
+	ieee802154_addr_to_sa(&sa, &hdr.source);
+	ieee802154_addr_to_sa(&da, &hdr.dest);
 
 	if (sa.addr_type == IEEE802154_ADDR_SHORT)
 		sap = &sa.short_addr;
@@ -55,78 +112,87 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 					IEEE802154_ADDR_LEN, iphc0, iphc1);
 }
 
+static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
+{
+	int ret;
+
+	if (!lowpan_is_iphc(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	/* Setting datagram_offset to zero indicates non frag handling
+	 * while doing lowpan_header_decompress.
+	 */
+	lowpan_802154_cb(skb)->d_size = 0;
+
+	ret = lowpan_iphc_decompress(skb);
+	if (ret < 0)
+		return RX_DROP_UNUSABLE;
+
+	return RX_QUEUED;
+}
+
+lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
+{
+	if (!lowpan_is_ipv6(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	/* Pull off the 1-byte of 6lowpan header. */
+	skb_pull(skb, 1);
+	return RX_QUEUED;
+}
+
+static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
+{
+	lowpan_rx_result res;
+
+#define CALL_RXH(rxh)			\
+	do {				\
+		res = rxh(skb);	\
+		if (res != RX_CONTINUE)	\
+			goto rxh_next;	\
+	} while (0)
+
+	/* likely at first */
+	CALL_RXH(lowpan_rx_h_iphc);
+	CALL_RXH(lowpan_rx_h_frag);
+	CALL_RXH(lowpan_rx_h_ipv6);
+
+rxh_next:
+	return lowpan_rx_handlers_result(skb, res);
+#undef CALL_RXH
+}
+
 static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 		      struct packet_type *pt, struct net_device *orig_wdev)
 {
-	struct ieee802154_hdr hdr;
 	struct net_device *ldev;
-	int ret;
 
 	if (wdev->type != ARPHRD_IEEE802154 ||
 	    skb->pkt_type == PACKET_OTHERHOST)
-		goto drop;
+		return NET_RX_DROP;
 
 	ldev = wdev->ieee802154_ptr->lowpan_dev;
 	if (!ldev || !netif_running(ldev))
-		goto drop;
+		return NET_RX_DROP;
 
 	/* Replacing skb->dev and followed rx handlers will manipulate skb. */
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
-		goto drop;
+		return NET_RX_DROP;
 	skb->dev = ldev;
 
-	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-		goto drop_skb;
-
-	/* check that it's our buffer */
-	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
-		/* Pull off the 1-byte of 6lowpan header. */
-		skb_pull(skb, 1);
-		return lowpan_give_skb_to_device(skb, wdev);
-	} else {
-		switch (skb->data[0] & 0xe0) {
-		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = iphc_decompress(skb, &hdr);
-			if (ret < 0)
-				goto drop_skb;
-
-			return lowpan_give_skb_to_device(skb, wdev);
-		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
-			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
-				return lowpan_give_skb_to_device(skb, wdev);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
-			}
-		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
-			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
-				return lowpan_give_skb_to_device(skb, wdev);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
-			}
-		default:
-			break;
-		}
+	/* When receive frag1 it's likely that we manipulate the buffer.
+	 * When recevie iphc we manipulate the data buffer. So we need
+	 * to unshare the buffer.
+	 */
+	if (lowpan_is_frag1(*skb_network_header(skb)) ||
+	    lowpan_is_iphc(*skb_network_header(skb))) {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return RX_DROP;
 	}
 
-drop_skb:
-	kfree_skb(skb);
-drop:
-	return NET_RX_DROP;
+	return lowpan_invoke_rx_handlers(skb);
 }
 
 static struct packet_type lowpan_packet_type = {
-- 
2.5.1

