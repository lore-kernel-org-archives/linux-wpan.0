Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38548 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbD3PqU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 11:46:20 -0400
Received: by wiun10 with SMTP id n10so22906072wiu.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Apr 2015 08:46:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/13] at86rf230: remove unnecessary tx state change
Date: Thu, 30 Apr 2015 17:45:01 +0200
Message-Id: <1430408704-21815-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
References: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

All supported transceivers can do a valid state change from TRX_OFF to
AACK_ON. This patch removes the state change chain from TRX_OFF ->
TX_ON -> AACK_ON instead we doing a directly state change from TRX_OFF
to AACK_ON.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f99dce5..6285145 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -781,16 +781,6 @@ at86rf230_tx_on(void *context)
 }
 
 static void
-at86rf230_tx_trac_error(void *context)
-{
-	struct at86rf230_state_change *ctx = context;
-	struct at86rf230_local *lp = ctx->lp;
-
-	at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-				     at86rf230_tx_on, true);
-}
-
-static void
 at86rf230_tx_trac_check(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
@@ -799,12 +789,12 @@ at86rf230_tx_trac_check(void *context)
 	const u8 trac = (buf[1] & 0xe0) >> 5;
 
 	/* If trac status is different than zero we need to do a state change
-	 * to STATE_FORCE_TRX_OFF then STATE_TX_ON to recover the transceiver
-	 * state to TX_ON.
+	 * to STATE_FORCE_TRX_OFF then STATE_RX_AACK_ON to recover the
+	 * transceiver.
 	 */
 	if (trac)
 		at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
-					     at86rf230_tx_trac_error, true);
+					     at86rf230_tx_on, true);
 	else
 		at86rf230_tx_on(context);
 }
-- 
2.3.6

