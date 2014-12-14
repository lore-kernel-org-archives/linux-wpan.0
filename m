Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:37569 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbaLNXUv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Dec 2014 18:20:51 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so13168627wgg.25
        for <linux-wpan@vger.kernel.org>; Sun, 14 Dec 2014 15:20:50 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/5] at86rf230: cleanup check on trac status
Date: Mon, 15 Dec 2014 00:20:31 +0100
Message-Id: <1418599232-6267-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 08b2f9f..7b0a17e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -750,13 +750,11 @@ at86rf230_tx_trac_check(void *context)
 	 * to STATE_FORCE_TRX_OFF then STATE_TX_ON to recover the transceiver
 	 * state to TX_ON.
 	 */
-	if (trac) {
+	if (trac)
 		at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
 					     at86rf230_tx_trac_error, true);
-		return;
-	}
-
-	at86rf230_tx_on(context);
+	else
+		at86rf230_tx_on(context);
 }
 
 
-- 
2.1.3

