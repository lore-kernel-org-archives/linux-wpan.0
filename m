Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49423 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919AbaJ2UgH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:07 -0400
Received: by mail-wg0-f44.google.com with SMTP id x12so2198218wgg.17
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/17] mac802154: rx: add error handling after skb_clone
Date: Wed, 29 Oct 2014 21:34:42 +0100
Message-Id: <1414614884-20243-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds error handling after skb_clone and deliver only if
skb_clone was successful.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 971a855..95961cc 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -240,12 +240,13 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 			continue;
 
 		skb2 = skb_clone(skb, GFP_ATOMIC);
-		skb2->dev = sdata->dev;
+		if (skb2) {
+			skb2->dev = sdata->dev;
+			ieee802154_deliver_skb(skb2);
 
-		ieee802154_deliver_skb(skb2);
-
-		sdata->dev->stats.rx_packets++;
-		sdata->dev->stats.rx_bytes += skb->len;
+			sdata->dev->stats.rx_packets++;
+			sdata->dev->stats.rx_bytes += skb->len;
+		}
 	}
 }
 
-- 
2.1.2

