Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:58485 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbaIJOGu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Sep 2014 10:06:50 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH][linux-bluetooth 3/3] 6lowpan: Refactored lowpan_rcv so it's RFC compliant
Date: Wed, 10 Sep 2014 15:06:08 +0100
Message-Id: <1410357968-27051-5-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, Martin Townsend <martin.townsend@xsilon.com>

Currently we support uncompressed IPv6 headers after performing fragmentation.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         | 17 ++++++++++++
 net/ieee802154/6lowpan_rtnl.c | 63 +++++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index d71c062..71b1bf0 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -126,11 +126,28 @@
 	 (((a)[6]) == 0xFF) &&	\
 	 (((a)[7]) == 0xFF))
 
+#define lowpan_dispatch_is_nalp(a)	\
+	(((a) & LOWPAN_DISPATCH_MAJOR) == 0x00)
+
+#define lowpan_dispatch_is_mesh(a)	\
+	(((a) & LOWPAN_DISPATCH_MAJOR) == 0x80)
+
+#define lowpan_dispatch_is_broadcast(a)	\
+	((a) == LOWPAN_DISPATCH_BCAST)
+
+#define lowpan_dispatch_is_frag(a)	\
+	(((a) & LOWPAN_DISPATCH_MASK) == LOWPAN_DISPATCH_FRAG1 || \
+	 ((a) & LOWPAN_DISPATCH_MASK) == LOWPAN_DISPATCH_FRAGN)
+
+#define LOWPAN_DISPATCH_MAJOR	0xc0
+#define LOWPAN_DISPATCH_MINOR	0x3f
+
 #define LOWPAN_DISPATCH_IPV6	0x41 /* 01000001 = 65 */
 #define LOWPAN_DISPATCH_HC1	0x42 /* 01000010 = 66 */
 #define LOWPAN_DISPATCH_IPHC	0x60 /* 011xxxxx = ... */
 #define LOWPAN_DISPATCH_FRAG1	0xc0 /* 11000xxx */
 #define LOWPAN_DISPATCH_FRAGN	0xe0 /* 11100xxx */
+#define LOWPAN_DISPATCH_BCAST	0x50 /* 01010000 */
 
 #define LOWPAN_DISPATCH_MASK	0xf8 /* 11111000 */
 
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 4f4b02d..1557ece 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -477,41 +477,46 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		goto drop_skb;
 
-	/* check that it's our buffer */
+	/* First off if frame is Not A LoWPAN Packet (NALP) then chuck away */
+	if (lowpan_dispatch_is_nalp(skb->data[0]))
+		goto drop_skb;
+
+	/* The 6LoWPAN header stack comprimises of the following (in order)
+	 *   Mesh
+	 *   Broadcast
+	 *   Fragmentation
+	 */
+	if (lowpan_dispatch_is_mesh(skb->data[0]))
+		/* Not supported */
+		goto drop_skb;
+
+	if (lowpan_dispatch_is_broadcast(skb->data[0]))
+		/* Not supported */
+		goto drop_skb;
+
+	if (lowpan_dispatch_is_frag(skb->data[0])) {
+		u8 frag_dispatch = skb->data[0] & 0xe0;
+
+		ret = lowpan_frag_rcv(skb, frag_dispatch);
+		if (ret != 1) {
+			/* more frags to process */
+			return NET_RX_SUCCESS;
+		}
+	}
+
+	/* We should now have an IPv6 Header (Compressed or Uncompressed) */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
-		/* Pull off the 1-byte of 6lowpan header. */
+		/* Uncompressed, Pull off the dispatch byte */
 		skb_pull(skb, 1);
-
-		ret = NET_RX_SUCCESS;
 	} else {
-		switch (skb->data[0] & 0xe0) {
-		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
+		if ((skb->data[0] & 0xe0) == LOWPAN_DISPATCH_IPHC) {
+			/* Compressed with IPHC - RFC 6282 */
 			ret = iphc_uncompress_hdr(&skb, &hdr);
 			if (ret < 0)
 				goto drop;
-			break;
-		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
-			if (ret == 1) {
-				ret = iphc_uncompress_hdr(&skb, &hdr);
-				if (ret < 0)
-					goto drop;
-			} else {
-				return NET_RX_SUCCESS;
-			}
-			break;
-		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
-			if (ret == 1) {
-				ret = iphc_uncompress_hdr(&skb, &hdr);
-				if (ret < 0)
-					goto drop;
-			} else {
-				return NET_RX_SUCCESS;
-			}
-			break;
-		default:
-			break;
+		} else {
+			/* TODO: other compression formats to follow */
+			goto drop_skb;
 		}
 	}
 
-- 
1.9.1

