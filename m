Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:37256 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbCAUz4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:55:56 -0500
Received: by wghk14 with SMTP id k14so29896998wgh.4
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:55:55 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/6] at86rf230: cleanup and squash stack variable
Date: Sun,  1 Mar 2015 21:55:29 +0100
Message-Id: <1425243333-8344-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

I had this variable because I thought it would be protected by
disable/enable irq but this is not true. It's protected by stop/wake
netdev queue which is called by ieee802154_xmit_complete.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 503fabd..8501220 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -725,11 +725,10 @@ at86rf230_tx_complete(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	struct sk_buff *skb = lp->tx_skb;
 
 	enable_irq(lp->spi->irq);
 
-	ieee802154_xmit_complete(lp->hw, skb, !lp->tx_aret);
+	ieee802154_xmit_complete(lp->hw, lp->tx_skb, !lp->tx_aret);
 }
 
 static void
-- 
2.3.0

