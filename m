Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:54334 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbaLSJhT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 04:37:19 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so802573wgg.11
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 01:37:18 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next RESEND] at86rf230: cleanup check on trac status
Date: Fri, 19 Dec 2014 10:36:50 +0100
Message-Id: <1418981810-17663-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 79fbf38..80632fc 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -749,13 +749,11 @@ at86rf230_tx_trac_check(void *context)
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
 
 static void
-- 
2.2.0

