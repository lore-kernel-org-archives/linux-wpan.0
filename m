Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48659 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaJGIjy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:54 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so8575021wgh.17
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:52 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 8/9] at86rf230: fix enable_irq handling on async spi
Date: Tue,  7 Oct 2014 10:38:32 +0200
Message-Id: <1412671113-26675-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Sometimes the async state function is call in an context where the spi
irq is diabled. This patch fix the handling to enable the irq when
spi_async failed in the async state change calling chain. We do this by
a context parameter irq_enable and evaluate this parameter when
spi_async failed instead of returning spi_async errno.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 157 ++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 5dbec64..7a1a8e3 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -74,6 +74,8 @@ struct at86rf230_state_change {
 	void (*complete)(void *context);
 	u8 from_state;
 	u8 to_state;
+
+	bool irq_enable;
 };
 
 struct at86rf230_local {
@@ -292,10 +294,11 @@ struct at86rf230_local {
 
 #define AT86RF2XX_NUMREGS 0x3F
 
-static int
+static void
 at86rf230_async_state_change(struct at86rf230_local *lp,
 			     struct at86rf230_state_change *ctx,
-			     const u8 state, void (*complete)(void *context));
+			     const u8 state, void (*complete)(void *context),
+			     const bool irq_enable);
 
 static inline int
 __at86rf230_write(struct at86rf230_local *lp,
@@ -452,7 +455,7 @@ at86rf230_async_error_recover(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL);
+	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL, false);
 }
 
 static void
@@ -462,21 +465,31 @@ at86rf230_async_error(struct at86rf230_local *lp,
 	dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
 
 	at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
-				     at86rf230_async_error_recover);
+				     at86rf230_async_error_recover, false);
 }
 
 /* Generic function to get some register value in async mode */
-static int
+static void
 at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
 			 struct at86rf230_state_change *ctx,
-			 void (*complete)(void *context))
+			 void (*complete)(void *context),
+			 const bool irq_enable)
 {
+	int rc;
+
 	u8 *tx_buf = ctx->buf;
 
 	tx_buf[0] = (reg & CMD_REG_MASK) | CMD_REG;
 	ctx->trx.len = 2;
 	ctx->msg.complete = complete;
-	return spi_async(lp->spi, &ctx->msg);
+	ctx->irq_enable = irq_enable;
+	rc = spi_async(lp->spi, &ctx->msg);
+	if (rc) {
+		if (irq_enable)
+			enable_irq(lp->spi->irq);
+
+		at86rf230_async_error(lp, ctx, rc);
+	}
 }
 
 static void
@@ -513,7 +526,8 @@ at86rf230_async_state_assert(void *context)
 			if (ctx->to_state == STATE_TX_ON) {
 				at86rf230_async_state_change(lp, ctx,
 							     STATE_FORCE_TX_ON,
-							     ctx->complete);
+							     ctx->complete,
+							     ctx->irq_enable);
 				return;
 			}
 		}
@@ -536,7 +550,6 @@ at86rf230_async_state_delay(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 	struct at86rf2xx_chip_data *c = lp->data;
 	bool force = false;
-	int rc;
 
 	/* The force state changes are will show as normal states in the
 	 * state status subregister. We change the to_state to the
@@ -605,10 +618,9 @@ at86rf230_async_state_delay(void *context)
 	udelay(1);
 
 change:
-	rc = at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-				      at86rf230_async_state_assert);
-	if (rc)
-		dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
+	at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
+				 at86rf230_async_state_assert,
+				 ctx->irq_enable);
 }
 
 static void
@@ -623,10 +635,9 @@ at86rf230_async_state_change_start(void *context)
 	/* Check for "possible" STATE_TRANSITION_IN_PROGRESS */
 	if (trx_state == STATE_TRANSITION_IN_PROGRESS) {
 		udelay(1);
-		rc = at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-					      at86rf230_async_state_change_start);
-		if (rc)
-			dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
+		at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
+					 at86rf230_async_state_change_start,
+					 ctx->irq_enable);
 		return;
 	}
 
@@ -648,20 +659,28 @@ at86rf230_async_state_change_start(void *context)
 	ctx->trx.len = 2;
 	ctx->msg.complete = at86rf230_async_state_delay;
 	rc = spi_async(lp->spi, &ctx->msg);
-	if (rc)
+	if (rc) {
+		if (ctx->irq_enable)
+			enable_irq(lp->spi->irq);
+
+		at86rf230_async_error(lp, &lp->state, rc);
 		dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
+	}
 }
 
-static int
+static void
 at86rf230_async_state_change(struct at86rf230_local *lp,
 			     struct at86rf230_state_change *ctx,
-			     const u8 state, void (*complete)(void *context))
+			     const u8 state, void (*complete)(void *context),
+			     const bool irq_enable)
 {
 	/* Initialization for the state change context */
 	ctx->to_state = state;
 	ctx->complete = complete;
-	return at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-					at86rf230_async_state_change_start);
+	ctx->irq_enable = irq_enable;
+	at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
+				 at86rf230_async_state_change_start,
+				 irq_enable);
 }
 
 static void
@@ -682,12 +701,9 @@ at86rf230_sync_state_change(struct at86rf230_local *lp, unsigned int state)
 {
 	int rc;
 
-	rc = at86rf230_async_state_change(lp, &lp->state, state,
-					  at86rf230_sync_state_change_complete);
-	if (rc) {
-		at86rf230_async_error(lp, &lp->state, rc);
-		return rc;
-	}
+	at86rf230_async_state_change(lp, &lp->state, state,
+				     at86rf230_sync_state_change_complete,
+				     false);
 
 	rc = wait_for_completion_timeout(&lp->state_complete,
 					 msecs_to_jiffies(100));
@@ -714,12 +730,9 @@ at86rf230_tx_on(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	int rc;
 
-	rc = at86rf230_async_state_change(lp, &lp->irq, STATE_RX_AACK_ON,
-					  at86rf230_tx_complete);
-	if (rc)
-		at86rf230_async_error(lp, ctx, rc);
+	at86rf230_async_state_change(lp, &lp->irq, STATE_RX_AACK_ON,
+				     at86rf230_tx_complete, true);
 }
 
 static void
@@ -727,12 +740,9 @@ at86rf230_tx_trac_error(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	int rc;
 
-	rc = at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-					  at86rf230_tx_on);
-	if (rc)
-		at86rf230_async_error(lp, ctx, rc);
+	at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
+				     at86rf230_tx_on, true);
 }
 
 static void
@@ -742,17 +752,14 @@ at86rf230_tx_trac_check(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 	const u8 *buf = ctx->buf;
 	const u8 trac = (buf[1] & 0xe0) >> 5;
-	int rc;
 
 	/* If trac status is different than zero we need to do a state change
 	 * to STATE_FORCE_TRX_OFF then STATE_TX_ON to recover the transceiver
 	 * state to TX_ON.
 	 */
 	if (trac) {
-		rc = at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
-						  at86rf230_tx_trac_error);
-		if (rc)
-			at86rf230_async_error(lp, ctx, rc);
+		at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
+					     at86rf230_tx_trac_error, true);
 		return;
 	}
 
@@ -765,12 +772,9 @@ at86rf230_tx_trac_status(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	int rc;
 
-	rc = at86rf230_async_read_reg(lp, RG_TRX_STATE, ctx,
-				      at86rf230_tx_trac_check);
-	if (rc)
-		at86rf230_async_error(lp, ctx, rc);
+	at86rf230_async_read_reg(lp, RG_TRX_STATE, ctx,
+				 at86rf230_tx_trac_check, true);
 }
 
 static void
@@ -823,15 +827,21 @@ at86rf230_rx_read_frame_complete(void *context)
 	at86rf230_rx(lp, buf + 2, len);
 }
 
-static int
+static void
 at86rf230_rx_read_frame(struct at86rf230_local *lp)
 {
+	int rc;
+
 	u8 *buf = lp->irq.buf;
 
 	buf[0] = CMD_FB;
 	lp->irq.trx.len = AT86RF2XX_MAX_BUF;
 	lp->irq.msg.complete = at86rf230_rx_read_frame_complete;
-	return spi_async(lp->spi, &lp->irq.msg);
+	rc = spi_async(lp->spi, &lp->irq.msg);
+	if (rc) {
+		enable_irq(lp->spi->irq);
+		at86rf230_async_error(lp, &lp->irq, rc);
+	}
 }
 
 static void
@@ -839,7 +849,6 @@ at86rf230_rx_trac_check(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	int rc;
 
 	/* Possible check on trac status here. This could be useful to make
 	 * some stats why receive is failed. Not used at the moment, but it's
@@ -847,14 +856,10 @@ at86rf230_rx_trac_check(void *context)
 	 * The programming guide say do it so.
 	 */
 
-	rc = at86rf230_rx_read_frame(lp);
-	if (rc) {
-		enable_irq(lp->spi->irq);
-		at86rf230_async_error(lp, ctx, rc);
-	}
+	at86rf230_rx_read_frame(lp);
 }
 
-static int
+static void
 at86rf230_irq_trx_end(struct at86rf230_local *lp)
 {
 	spin_lock(&lp->lock);
@@ -863,17 +868,19 @@ at86rf230_irq_trx_end(struct at86rf230_local *lp)
 		spin_unlock(&lp->lock);
 
 		if (lp->tx_aret)
-			return at86rf230_async_state_change(lp, &lp->irq,
-							    STATE_FORCE_TX_ON,
-							    at86rf230_tx_trac_status);
+			at86rf230_async_state_change(lp, &lp->irq,
+						     STATE_FORCE_TX_ON,
+						     at86rf230_tx_trac_status,
+						     true);
 		else
-			return at86rf230_async_state_change(lp, &lp->irq,
-							    STATE_RX_AACK_ON,
-							    at86rf230_tx_complete);
+			at86rf230_async_state_change(lp, &lp->irq,
+						     STATE_RX_AACK_ON,
+						     at86rf230_tx_complete,
+						     true);
 	} else {
 		spin_unlock(&lp->lock);
-		return at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
-						at86rf230_rx_trac_check);
+		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
+					 at86rf230_rx_trac_check, true);
 	}
 }
 
@@ -884,12 +891,9 @@ at86rf230_irq_status(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 	const u8 *buf = lp->irq.buf;
 	const u8 irq = buf[1];
-	int rc;
 
 	if (irq & IRQ_TRX_END) {
-		rc = at86rf230_irq_trx_end(lp);
-		if (rc)
-			at86rf230_async_error(lp, ctx, rc);
+		at86rf230_irq_trx_end(lp);
 	} else {
 		enable_irq(lp->spi->irq);
 		dev_err(&lp->spi->dev, "not supported irq %02x received\n",
@@ -964,12 +968,9 @@ at86rf230_xmit_tx_on(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	int rc;
 
-	rc = at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
-					  at86rf230_write_frame);
-	if (rc)
-		at86rf230_async_error(lp, ctx, rc);
+	at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
+				     at86rf230_write_frame, false);
 }
 
 static int
@@ -990,12 +991,8 @@ at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
 	if (lp->tx_aret)
 		tx_complete = at86rf230_xmit_tx_on;
 
-	rc = at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-					  tx_complete);
-	if (rc) {
-		at86rf230_async_error(lp, ctx, rc);
-		return rc;
-	}
+	at86rf230_async_state_change(lp, ctx, STATE_TX_ON, tx_complete, false);
+
 	rc = wait_for_completion_interruptible_timeout(&lp->tx_complete,
 						       msecs_to_jiffies(lp->data->t_tx_timeout));
 	if (!rc) {
-- 
2.1.2

