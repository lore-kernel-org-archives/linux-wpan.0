Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33122 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbHCGX5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:57 -0400
Received: by wicmv11 with SMTP id mv11so121726662wic.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 07/16] ieee802154: 6lowpan: change skb->dev earlier
Date: Mon,  3 Aug 2015 08:23:46 +0200
Message-Id: <1438583035-6287-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We should change the skb->dev pointer earlier to the lowpan interface.
Sometimes we call iphc_decompress which also use some netdev printout
functionality. This patch will change that the correct interface will be
displayed in this case, which should be the lowpan interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 11a5629..3871804a 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -15,10 +15,8 @@
 
 #include "6lowpan_i.h"
 
-static int lowpan_give_skb_to_device(struct sk_buff *skb,
-				     struct net_device *wdev)
+static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
-	skb->dev = wdev->ieee802154_ptr->lowpan_dev;
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->pkt_type = PACKET_HOST;
 
@@ -73,11 +71,13 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		goto drop_skb;
 
+	skb->dev = wdev->ieee802154_ptr->lowpan_dev;
+
 	/* check that it's our buffer */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
-		return lowpan_give_skb_to_device(skb, wdev);
+		return lowpan_give_skb_to_device(skb);
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
@@ -85,7 +85,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 			if (ret < 0)
 				goto drop_skb;
 
-			return lowpan_give_skb_to_device(skb, wdev);
+			return lowpan_give_skb_to_device(skb);
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
@@ -93,7 +93,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 				if (ret < 0)
 					goto drop_skb;
 
-				return lowpan_give_skb_to_device(skb, wdev);
+				return lowpan_give_skb_to_device(skb);
 			} else if (ret == -1) {
 				return NET_RX_DROP;
 			} else {
@@ -106,7 +106,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 				if (ret < 0)
 					goto drop_skb;
 
-				return lowpan_give_skb_to_device(skb, wdev);
+				return lowpan_give_skb_to_device(skb);
 			} else if (ret == -1) {
 				return NET_RX_DROP;
 			} else {
-- 
2.5.0

