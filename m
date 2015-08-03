Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38061 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbbHCGYC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:24:02 -0400
Received: by wibxm9 with SMTP id xm9so99676175wib.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:24:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 10/16] ieee802154: 6lowpan: add dispatch evalualtion helpers
Date: Mon,  3 Aug 2015 08:23:49 +0200
Message-Id: <1438583035-6287-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce some static inline function for checking the right
dispatch value. This also fixes an bug to detect the right fragmentation
dispatch value, we currently use "0xe0" as masking the fragmentation
dispatch. Correct is "0xf8" as mask.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h              | 18 +++++++++++++-----
 net/ieee802154/6lowpan/6lowpan_i.h |  3 +++
 net/ieee802154/6lowpan/rx.c        | 30 +++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index e16763f..073c791 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -126,11 +126,19 @@
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
 
 #define LOWPAN_DISPATCH_MASK	0xf8 /* 11111000 */
 
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index d62046e..e009a4a 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -7,6 +7,9 @@
 #include <net/inet_frag.h>
 #include <net/6lowpan.h>
 
+#define LOWPAN_DISPATCH_FRAG1		0xc0
+#define LOWPAN_DISPATCH_FRAGN		0xe0
+
 struct lowpan_create_arg {
 	u16 tag;
 	u16 d_size;
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index c7afd4a..b0066b7 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -21,6 +21,16 @@ typedef unsigned __bitwise__ lowpan_rx_result;
 #define RX_DROP			((__force lowpan_rx_result) 2u)
 #define RX_QUEUED		((__force lowpan_rx_result) 3u)
 
+#define LOWPAN_DISPATCH_FIRST		0xc0
+#define LOWPAN_DISPATCH_FRAG_MASK	0xf8
+#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
+
+#define LOWPAN_DISPATCH_NALP		0x00
+#define LOWPAN_DISPATCH_HC1		0x42
+#define LOWPAN_DISPATCH_BC0		0x50
+#define LOWPAN_DISPATCH_ESC		0x7f
+#define LOWPAN_DISPATCH_MESH		0x80
+
 static int
 lowpan_rx_handlers_result(struct sk_buff *skb, lowpan_rx_result res)
 {
@@ -86,7 +96,7 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 
 static lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
 {
-	if (skb->data[0] != LOWPAN_DISPATCH_IPV6)
+	if (!lowpan_is_ipv6(*skb_network_header(skb)))
 		return RX_CONTINUE;
 
 	/* Pull off the 1-byte of 6lowpan header. */
@@ -94,15 +104,25 @@ static lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
 	return lowpan_give_skb_to_device(skb);
 }
 
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
 static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
 {
 	int ret;
 
-	if ((skb->data[0] & 0xe0) != LOWPAN_DISPATCH_FRAG1 &&
-	    (skb->data[0] & 0xe0) != LOWPAN_DISPATCH_FRAGN)
+	if (!(lowpan_is_frag1(*skb_network_header(skb)) ||
+	      lowpan_is_fragn(*skb_network_header(skb))))
 		return RX_CONTINUE;
 
-	ret = lowpan_frag_rcv(skb, skb->data[0] & 0xe0);
+	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) & 0xe0);
 	if (ret == 1)
 		return RX_CONTINUE;
 
@@ -115,7 +135,7 @@ static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
 	int ret;
 	struct ieee802154_hdr hdr;
 
-	if ((skb->data[0] & 0xe0) != LOWPAN_DISPATCH_IPHC)
+	if (!lowpan_is_iphc(*skb_network_header(skb)))
 		return RX_CONTINUE;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-- 
2.5.0

