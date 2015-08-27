Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33626 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbH0Tth (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 15:49:37 -0400
Received: by wicge2 with SMTP id ge2so3122681wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 12:49:36 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/4] at86rf230: interrupt tx with force trx_off
Date: Thu, 27 Aug 2015 21:49:18 +0200
Message-Id: <1440704960-10515-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
References: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

To abort a TX_ARET_BUSY state it's recommended to switch into TRX_OFF
state by doing STATE_TRX_FORCE_OFF. This patch will do always a TRX_OFF
state change when the transceiver stucks in any state. From TRX_OFF we
can switch to the states which are also possible by TX_ON state.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 39485d0..1e71a97 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -377,14 +377,6 @@ at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
 	}
 }
 
-static inline u8 at86rf230_state_to_force(u8 state)
-{
-	if (state == STATE_TX_ON)
-		return STATE_FORCE_TX_ON;
-	else
-		return STATE_FORCE_TRX_OFF;
-}
-
 static void
 at86rf230_async_state_assert(void *context)
 {
@@ -426,7 +418,7 @@ at86rf230_async_state_assert(void *context)
 				u8 state = ctx->to_state;
 
 				if (lp->tx_retry >= AT86RF2XX_MAX_TX_RETRIES)
-					state = at86rf230_state_to_force(state);
+					state = STATE_FORCE_TRX_OFF;
 				lp->tx_retry++;
 
 				at86rf230_async_state_change(lp, ctx, state,
-- 
2.5.0

