Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48127 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828AbaLWO3C (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:29:02 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so9242576wgg.33
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:29:00 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/7] ieee802154: 6lowpan: remove rx full-size calc workaround
Date: Tue, 23 Dec 2014 15:28:26 +0100
Message-Id: <1419344909-16007-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes a workaround to call lowpan_uncompress_size while
receiving first fragment. The lowpan_uncompress_size function is very
statically and should not be used. Instead we do a uncompression
on-the-fly while receiving first fragment.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/6lowpan_i.h  |  1 +
 net/ieee802154/6lowpan/reassembly.c | 25 +++++++++++++++++++++----
 net/ieee802154/6lowpan/rx.c         | 21 ++++++++-------------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index e50f69d..63a7ad7 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -60,6 +60,7 @@ extern struct list_head lowpan_devices;
 int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
 void lowpan_net_frag_exit(void);
 int lowpan_net_frag_init(void);
+int iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr);
 
 void lowpan_rx_init(void);
 void lowpan_rx_exit(void);
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index f46e4d1..c76c0cb 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -201,12 +201,29 @@ found:
 
 	fq->q.stamp = skb->tstamp;
 	if (frag_type == LOWPAN_DISPATCH_FRAG1) {
-		/* Calculate uncomp. 6lowpan header to estimate full size */
-		fq->q.meat += lowpan_uncompress_size(skb, NULL);
+		int ret;
+		struct ieee802154_hdr hdr;
+
+		ret = ieee802154_hdr_peek_addrs(skb, &hdr);
+		if (ret < 0)
+			goto err;
+
+		/* TODO use CALL_RXH when parsing rework is done. */
+		switch (*skb_network_header(skb) & 0xe0) {
+		case LOWPAN_DISPATCH_IPHC:
+			/* uncompress ipv6 header */
+			ret = iphc_decompress(skb, &hdr);
+			if (ret < 0)
+				goto err;
+			break;
+		default:
+			goto err;
+		}
+
 		fq->q.flags |= INET_FRAG_FIRST_IN;
-	} else {
-		fq->q.meat += skb->len;
 	}
+
+	fq->q.meat += skb->len;
 	add_frag_mem_limit(&fq->q, skb->truesize);
 
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index a7b9d39..158756f 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -47,8 +47,7 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
 	return stat;
 }
 
-static int
-iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+int iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 {
 	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
@@ -102,9 +101,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (dev->type != ARPHRD_IEEE802154)
 		goto drop_skb;
 
-	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-		goto drop_skb;
-
 	/* check that it's our buffer */
 	if (*skb_network_header(skb) == LOWPAN_DISPATCH_IPV6) {
 		/* Pull off the 1-byte of 6lowpan header. */
@@ -115,6 +111,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		switch (*skb_network_header(skb) & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
+			if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
+				goto drop_skb;
+
 			ret = iphc_decompress(skb, &hdr);
 			if (ret < 0)
 				goto drop_skb;
@@ -123,10 +122,8 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
+				ipv6_hdr(skb)->payload_len = htons(skb->len -
+								   sizeof(struct ipv6hdr));
 				return lowpan_give_skb_to_devices(skb, NULL);
 			} else if (ret == -1) {
 				return NET_RX_DROP;
@@ -136,10 +133,8 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
+				ipv6_hdr(skb)->payload_len = htons(skb->len -
+								   sizeof(struct ipv6hdr));
 				return lowpan_give_skb_to_devices(skb, NULL);
 			} else if (ret == -1) {
 				return NET_RX_DROP;
-- 
2.2.0

