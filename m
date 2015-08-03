Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37595 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbHCGYB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:24:01 -0400
Received: by wibud3 with SMTP id ud3so99352130wib.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:24:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 09/16] ieee820154: 6lowpan: dispatch evaluation rework
Date: Mon,  3 Aug 2015 08:23:48 +0200
Message-Id: <1438583035-6287-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch complete reworks the evaluation of 6lowpan dispatch value by
introducing several different handlers for each dispatch value. This
patch also fixes a bug to re-evaluate the dispatch value after reassmble
while fragmentation. Currently we always assume that we have an IPHC
header there.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 155 +++++++++++++++++++++++++++++---------------
 1 file changed, 101 insertions(+), 54 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index bf6e857..c7afd4a 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -15,12 +15,42 @@
 
 #include "6lowpan_i.h"
 
+typedef unsigned __bitwise__ lowpan_rx_result;
+#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
+#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
+#define RX_DROP			((__force lowpan_rx_result) 2u)
+#define RX_QUEUED		((__force lowpan_rx_result) 3u)
+
+static int
+lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
+{
+	switch (res) {
+	/* nobody cared about this packet */
+	case RX_CONTINUE:
+	case RX_DROP_UNUSABLE:
+		kfree_skb(skb);
+	case RX_DROP:
+		return NET_RX_DROP;
+	default:
+		break;
+	}
+
+	return NET_RX_SUCCESS;
+}
+
 static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
+	int ret;
+
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->pkt_type = PACKET_HOST;
 
-	return netif_rx(skb);
+	ret = netif_rx(skb);
+	/* kfree_skb handled by netif_rx, so RX_DROP on failure */
+	if (ret == NET_RX_SUCCESS)
+		return RX_QUEUED;
+	else
+		return RX_DROP;
 }
 
 static int
@@ -54,69 +84,86 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 					IEEE802154_ADDR_LEN, iphc0, iphc1);
 }
 
-static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
-		      struct packet_type *pt, struct net_device *orig_wdev)
+static lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
+{
+	if (skb->data[0] != LOWPAN_DISPATCH_IPV6)
+		return RX_CONTINUE;
+
+	/* Pull off the 1-byte of 6lowpan header. */
+	skb_pull(skb, 1);
+	return lowpan_give_skb_to_device(skb);
+}
+
+static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
+{
+	int ret;
+
+	if ((skb->data[0] & 0xe0) != LOWPAN_DISPATCH_FRAG1 &&
+	    (skb->data[0] & 0xe0) != LOWPAN_DISPATCH_FRAGN)
+		return RX_CONTINUE;
+
+	ret = lowpan_frag_rcv(skb, skb->data[0] & 0xe0);
+	if (ret == 1)
+		return RX_CONTINUE;
+
+	/* packet is dropped and putted into the frag bucket only */
+	return RX_DROP;
+}
+
+static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
 {
-	struct ieee802154_hdr hdr;
 	int ret;
+	struct ieee802154_hdr hdr;
+
+	if ((skb->data[0] & 0xe0) != LOWPAN_DISPATCH_IPHC)
+		return RX_CONTINUE;
+
+	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
+		return RX_DROP_UNUSABLE;
+
+	ret = iphc_decompress(skb, &hdr);
+	if (ret < 0)
+		return RX_DROP_UNUSABLE;
+
+	return lowpan_give_skb_to_device(skb);
+}
+
+int lowpan_invoke_rx_handlers(struct sk_buff *skb)
+{
+	lowpan_rx_result res;
+
+#define CALL_RXH(rxh)			\
+	do {				\
+		res = rxh(skb);		\
+		if (res != RX_CONTINUE)	\
+			goto rxh_next;	\
+	} while (0)
+
+	/* frag at first, because it contains dispatch value again */
+	CALL_RXH(lowpan_rx_h_frag);
 
+	/* likely at first */
+	CALL_RXH(lowpan_rx_h_iphc);
+	CALL_RXH(lowpan_rx_h_ipv6);
+
+rxh_next:
+	return lowpan_rx_handlers_result(skb, res);
+#undef CALL_RXH
+}
+
+static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
+		      struct packet_type *pt, struct net_device *orig_wdev)
+{
 	if (skb->pkt_type == PACKET_OTHERHOST ||
 	    wdev->type != ARPHRD_IEEE802154)
-		goto drop;
+		return NET_RX_DROP;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
-		goto drop;
-
-	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-		goto drop_skb;
+		return NET_RX_DROP;
 
 	skb->dev = wdev->ieee802154_ptr->lowpan_dev;
-
-	/* check that it's our buffer */
-	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
-		/* Pull off the 1-byte of 6lowpan header. */
-		skb_pull(skb, 1);
-		return lowpan_give_skb_to_device(skb);
-	} else {
-		switch (skb->data[0] & 0xe0) {
-		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = iphc_decompress(skb, &hdr);
-			if (ret < 0)
-				goto drop_skb;
-
-			return lowpan_give_skb_to_device(skb);
-		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
-			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
-				return lowpan_give_skb_to_device(skb);
-			}
-
-			return NET_RX_DROP;
-		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
-			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
-				return lowpan_give_skb_to_device(skb);
-			}
-
-			return NET_RX_DROP;
-		default:
-			break;
-		}
-	}
-
-drop_skb:
-	kfree_skb(skb);
-drop:
-	return NET_RX_DROP;
+	return lowpan_invoke_rx_handlers(skb);
 }
 
 static struct packet_type lowpan_packet_type = {
-- 
2.5.0

