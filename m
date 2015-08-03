Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33153 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbHCGX7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:59 -0400
Received: by wicmv11 with SMTP id mv11so121727425wic.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 08/16] ieee802154: 6lowpan: change frag return value handling
Date: Mon,  3 Aug 2015 08:23:47 +0200
Message-Id: <1438583035-6287-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The function lowpan_frag_rcv does return only:

 - "1": skb is reassmbled
 - "-1": skb is putted into the frag bucket or failure.

Other values can't happend. This patch will change that we return on "1"
the return value of netif_rx and "-1" to NET_RX_DROP, which means that
the packet doesn't reach the next layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 3871804a..bf6e857 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -94,11 +94,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 					goto drop_skb;
 
 				return lowpan_give_skb_to_device(skb);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
 			}
+
+			return NET_RX_DROP;
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
@@ -107,11 +105,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 					goto drop_skb;
 
 				return lowpan_give_skb_to_device(skb);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
 			}
+
+			return NET_RX_DROP;
 		default:
 			break;
 		}
-- 
2.5.0

