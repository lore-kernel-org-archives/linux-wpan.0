Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34221 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbbIBMWP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:15 -0400
Received: by wicfx3 with SMTP id fx3so15719751wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:14 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/16] ieee802154: 6lowpan: add generic lowpan header check
Date: Wed,  2 Sep 2015 14:21:26 +0200
Message-Id: <1441196491-25013-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce an earlier check if a 6LoWPAN frame can be valid.
This contains at first for checking if the header contains a dispatch
byte and isn't the nalp dispatch value, which means it isn't a 6LoWPAN
packet. Also we add a check if we can derference the dispatch value by
checking if skb->len is unequal zero.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index fded109..c46cab3 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -15,8 +15,11 @@
 
 #include "6lowpan_i.h"
 
+#define LOWPAN_DISPATCH_FIRST		0xc0
 #define LOWPAN_DISPATCH_FRAG_MASK	0xf8
 
+#define LOWPAN_DISPATCH_NALP		0x00
+
 static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
 	skb->protocol = htons(ETH_P_IPV6);
@@ -162,13 +165,36 @@ rxh_next:
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
+static inline bool lowpan_rx_h_check(struct sk_buff *skb)
+{
+	/* check if we can dereference the dispatch */
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
 	struct net_device *ldev;
 
 	if (wdev->type != ARPHRD_IEEE802154 ||
-	    skb->pkt_type == PACKET_OTHERHOST)
+	    skb->pkt_type == PACKET_OTHERHOST ||
+	    !lowpan_rx_h_check(skb))
 		return NET_RX_DROP;
 
 	ldev = wdev->ieee802154_ptr->lowpan_dev;
-- 
2.5.1

