Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:57344 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaLOJ0a (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 04:26:30 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so13924209wgh.8
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 01:26:29 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/5] at86rf230: remove if branch
Date: Mon, 15 Dec 2014 10:25:53 +0100
Message-Id: <1418635557-6670-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
References: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes an unnecessary if branch inside the tx complete
handler.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1c01356..434efc5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -715,10 +715,7 @@ at86rf230_tx_complete(void *context)
 
 	enable_irq(lp->spi->irq);
 
-	if (lp->max_frame_retries <= 0)
-		ieee802154_xmit_complete(lp->hw, skb, true);
-	else
-		ieee802154_xmit_complete(lp->hw, skb, false);
+	ieee802154_xmit_complete(lp->hw, skb, !lp->tx_aret);
 }
 
 static void
-- 
2.1.3

