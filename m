Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35834 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031314AbbD2HfU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 03:35:20 -0400
Received: by widdi4 with SMTP id di4so168635464wid.0
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 00:35:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 4/6] at86rf230: remove unnecessary tx state change
Date: Wed, 29 Apr 2015 09:34:51 +0200
Message-Id: <1430292893-5752-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430292893-5752-1-git-send-email-alex.aring@gmail.com>
References: <1430292893-5752-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

All supported transceivers can do a valid state change from TRX_OFF to
AACK_ON. This patach removes the state change chain from TRX_OFF ->
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

