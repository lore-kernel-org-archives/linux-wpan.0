Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34534 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbHCGYF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:24:05 -0400
Received: by wibud3 with SMTP id ud3so121972376wib.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:24:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 12/16] ieee802154: 6lowpan: add generic lowpan header check
Date: Mon,  3 Aug 2015 08:23:51 +0200
Message-Id: <1438583035-6287-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce an earlier check if a 6LoWPAN can be valid. This
contains at first for checking if the header contains a dispatch byte
and isn't the nalp dispatch value, which means it isn't a 6LoWPAN
packet.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 595830f..62d181a 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -172,11 +172,34 @@ rxh_next:
 #undef CALL_RXH
 }
 
+static inline bool lowpan_is_nalp(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
+}
+
+/* lowpan_rx_h_check checks on generic 6LoWPAN requirements
+ * in MAC and 6LoWPAN header.
+ *
+ * Don't manipulate the skb here, it could be shared buffer.
+ */
+static bool lowpan_rx_h_check(struct sk_buff *skb)
+{
+	/* check for if we can evaluate the dispatch */
+	if (unlikely(!skb->len))
+		return false;
+
+	if (lowpan_is_nalp(*skb_network_header(skb)))
+		return false;
+
+	return true;
+}
+
 static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 		      struct packet_type *pt, struct net_device *orig_wdev)
 {
 	if (skb->pkt_type == PACKET_OTHERHOST ||
-	    wdev->type != ARPHRD_IEEE802154)
+	    wdev->type != ARPHRD_IEEE802154 ||
+	    !lowpan_rx_h_check(skb))
 		return NET_RX_DROP;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
-- 
2.5.0

