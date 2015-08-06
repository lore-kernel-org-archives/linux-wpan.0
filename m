Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35131 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbbHFPVg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Aug 2015 11:21:36 -0400
Received: by wibxm9 with SMTP id xm9so27165605wib.0
        for <linux-wpan@vger.kernel.org>; Thu, 06 Aug 2015 08:21:35 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 1/2] at86rf230: change trac status check behaviour
Date: Thu,  6 Aug 2015 17:21:40 +0200
Message-Id: <1438874501-19971-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
References: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

When transmit is done, indicated by trx_end irq, we do first a force
state change to TX_ON and then checking the trac status, if the trac
status is unequal zero we do a state change to TRX_OFF.

This patch changes to the following behaviour, we first check on trac
status after trx_end occurs and then doing a normal change to TX_ON
without do the state change to TRX_OFF when trac status is unequal zero.

The reasons are that the datasheet doesn't described when the trac
status register is cleared, we should doing to evaluate the trac status
at first. The reason to remove the TRX_OFF change if the trac status is
unequal to zero and it was force is the following paragraph inside The
at86rf2xx datasheets:

"Using FORCE_PLL_ON to interrupt an TX_ARET transaction, it is
 recommended to check register bits [7:5] of register address 0x32 for
 value 0. If this value is different, TRX_CMD sequence FORCE_TRX_OFF shall
 be used immediately followed by TRX_CMD sequence PLL_ON. This performs a
 state transition to PLL_ON."

The meaning is here "to interrupt an TX_ARET transaction" in case of
trx_end interrupt the "TX_ARET transaction" is already done and we don't
interrupt the "TX_ARET transaction" by doing the change to TX_ON (PLL_ON)
here. Additional I changed the force change to normal TX_ON which seems to
work here.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6422caa..39485d0 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -667,28 +667,9 @@ at86rf230_tx_trac_check(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	const u8 *buf = ctx->buf;
-	const u8 trac = (buf[1] & 0xe0) >> 5;
 
-	/* If trac status is different than zero we need to do a state change
-	 * to STATE_FORCE_TRX_OFF then STATE_RX_AACK_ON to recover the
-	 * transceiver.
-	 */
-	if (trac)
-		at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
-					     at86rf230_tx_on, true);
-	else
-		at86rf230_tx_on(context);
-}
-
-static void
-at86rf230_tx_trac_status(void *context)
-{
-	struct at86rf230_state_change *ctx = context;
-	struct at86rf230_local *lp = ctx->lp;
-
-	at86rf230_async_read_reg(lp, RG_TRX_STATE, ctx,
-				 at86rf230_tx_trac_check, true);
+	at86rf230_async_state_change(lp, &lp->irq, STATE_TX_ON,
+				     at86rf230_tx_on, true);
 }
 
 static void
@@ -758,10 +739,8 @@ at86rf230_irq_trx_end(struct at86rf230_local *lp)
 {
 	if (lp->is_tx) {
 		lp->is_tx = 0;
-		at86rf230_async_state_change(lp, &lp->irq,
-					     STATE_FORCE_TX_ON,
-					     at86rf230_tx_trac_status,
-					     true);
+		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
+					 at86rf230_tx_trac_check, true);
 	} else {
 		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
 					 at86rf230_rx_trac_check, true);
-- 
2.5.0

