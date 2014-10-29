Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37010 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2UgE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:04 -0400
Received: by mail-wi0-f177.google.com with SMTP id ex7so5667018wid.4
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/17] mac802154: rx: use netif_receive_skb
Date: Wed, 29 Oct 2014 21:34:39 +0100
Message-Id: <1414614884-20243-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes netif_rx_ni call. Instead we call netif_receive_skb,
we can do that since commit c5c47e67bcd24638a059b1b5e9ec18c95f8634ca
("mac802154: rx: use tasklet instead workqueue").

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index f15c50b..7669cdb 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -240,7 +240,7 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		skb2 = skb_clone(skb, GFP_ATOMIC);
 		skb2->dev = sdata->dev;
 
-		netif_rx_ni(skb2);
+		ieee802154_deliver_skb(skb2);
 	}
 }
 
-- 
2.1.2

