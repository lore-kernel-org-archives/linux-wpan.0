Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50209 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaJ2UoH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:44:07 -0400
Received: by mail-wg0-f50.google.com with SMTP id z12so4244662wgg.9
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:44:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/17] mac802154: rx: remove override pkt_type set to PACKET_HOST
Date: Wed, 29 Oct 2014 21:34:38 +0100
Message-Id: <1414614884-20243-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes pkt_type set to PACKET_HOST while monitor receiving.
This should be PACKET_OTHERHOST on monitor mode which already set
before.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index c9f1c72..f15c50b 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -239,7 +239,6 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 
 		skb2 = skb_clone(skb, GFP_ATOMIC);
 		skb2->dev = sdata->dev;
-		skb2->pkt_type = PACKET_HOST;
 
 		netif_rx_ni(skb2);
 	}
-- 
2.1.2

