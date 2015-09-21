Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34055 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbIUHiC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 03:38:02 -0400
Received: by wicfx3 with SMTP id fx3so132614527wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 00:38:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: support edge triggered irq
Date: Mon, 21 Sep 2015 09:37:54 +0200
Message-Id: <1442821074-18592-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for edge triggered irq types. We remove the
locking for irq resources by enable/disable irq and allocate directly
some heap buffer at isr. We have still a enable/disable irq path but
this is for level-triggered irq's which need to be disabled until
spi_async clear the irq line.

There is usually a little race condition between "irq line cleared" and
"enable_irq". When in this time a edge triggered irq arrived, we will
not recognize this interrupt. This case can't happend at at86rf230. The
reason is that we unmask TRX_END irq's only which indicates a transmit
or receive completion, which depends on the current state.

On Transmit:

TRX_END arrived and transceiver is in TX_ARET_ON state again, in this
state no other TRX_END can happen until we leave the state.

On Receive:

This is protected with the RX_SAFE_MODE bit which leaves the transceiver
in RX_AACK_BUSY until we readed the framebuffer. In this state no other
TRX_END can happen.

Tested with RPi where I first detected issues between edge/level irq's.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 211 ++++++++++++++++---------------------
 1 file changed, 89 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b8b0628..23b142c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -81,7 +81,7 @@ struct at86rf230_state_change {
 	u8 from_state;
 	u8 to_state;
 
-	bool irq_enable;
+	bool free;
 };
 
 struct at86rf230_trac {
@@ -105,8 +105,6 @@ struct at86rf230_local {
 	struct completion state_complete;
 	struct at86rf230_state_change state;
 
-	struct at86rf230_state_change irq;
-
 	unsigned long cal_timeout;
 	bool is_tx;
 	bool is_tx_from_off;
@@ -122,8 +120,7 @@ struct at86rf230_local {
 static void
 at86rf230_async_state_change(struct at86rf230_local *lp,
 			     struct at86rf230_state_change *ctx,
-			     const u8 state, void (*complete)(void *context),
-			     const bool irq_enable);
+			     const u8 state, void (*complete)(void *context));
 
 static inline void
 at86rf230_sleep(struct at86rf230_local *lp)
@@ -352,8 +349,10 @@ at86rf230_async_error_recover(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 
 	lp->is_tx = 0;
-	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL, false);
+	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL);
 	ieee802154_wake_queue(lp->hw);
+	if (ctx->free)
+		kfree(ctx);
 }
 
 static inline void
@@ -363,15 +362,14 @@ at86rf230_async_error(struct at86rf230_local *lp,
 	dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
 
 	at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
-				     at86rf230_async_error_recover, false);
+				     at86rf230_async_error_recover);
 }
 
 /* Generic function to get some register value in async mode */
 static void
-at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
+at86rf230_async_read_reg(struct at86rf230_local *lp, u8 reg,
 			 struct at86rf230_state_change *ctx,
-			 void (*complete)(void *context),
-			 const bool irq_enable)
+			 void (*complete)(void *context))
 {
 	int rc;
 
@@ -379,14 +377,24 @@ at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
 
 	tx_buf[0] = (reg & CMD_REG_MASK) | CMD_REG;
 	ctx->msg.complete = complete;
-	ctx->irq_enable = irq_enable;
 	rc = spi_async(lp->spi, &ctx->msg);
-	if (rc) {
-		if (irq_enable)
-			enable_irq(ctx->irq);
+	if (rc)
+		at86rf230_async_error(lp, ctx, rc);
+}
 
+static void
+at86rf230_async_write_reg(struct at86rf230_local *lp, u8 reg, u8 val,
+			  struct at86rf230_state_change *ctx,
+			  void (*complete)(void *context))
+{
+	int rc;
+
+	ctx->buf[0] = (reg & CMD_REG_MASK) | CMD_REG | CMD_WRITE;
+	ctx->buf[1] = val;
+	ctx->msg.complete = complete;
+	rc = spi_async(lp->spi, &ctx->msg);
+	if (rc)
 		at86rf230_async_error(lp, ctx, rc);
-	}
 }
 
 static void
@@ -434,8 +442,7 @@ at86rf230_async_state_assert(void *context)
 				lp->tx_retry++;
 
 				at86rf230_async_state_change(lp, ctx, state,
-							     ctx->complete,
-							     ctx->irq_enable);
+							     ctx->complete);
 				return;
 			}
 		}
@@ -456,8 +463,7 @@ static enum hrtimer_restart at86rf230_async_state_timer(struct hrtimer *timer)
 	struct at86rf230_local *lp = ctx->lp;
 
 	at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-				 at86rf230_async_state_assert,
-				 ctx->irq_enable);
+				 at86rf230_async_state_assert);
 
 	return HRTIMER_NORESTART;
 }
@@ -562,14 +568,12 @@ at86rf230_async_state_change_start(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 	u8 *buf = ctx->buf;
 	const u8 trx_state = buf[1] & TRX_STATE_MASK;
-	int rc;
 
 	/* Check for "possible" STATE_TRANSITION_IN_PROGRESS */
 	if (trx_state == STATE_TRANSITION_IN_PROGRESS) {
 		udelay(1);
 		at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-					 at86rf230_async_state_change_start,
-					 ctx->irq_enable);
+					 at86rf230_async_state_change_start);
 		return;
 	}
 
@@ -586,31 +590,20 @@ at86rf230_async_state_change_start(void *context)
 	/* Going into the next step for a state change which do a timing
 	 * relevant delay.
 	 */
-	buf[0] = (RG_TRX_STATE & CMD_REG_MASK) | CMD_REG | CMD_WRITE;
-	buf[1] = ctx->to_state;
-	ctx->msg.complete = at86rf230_async_state_delay;
-	rc = spi_async(lp->spi, &ctx->msg);
-	if (rc) {
-		if (ctx->irq_enable)
-			enable_irq(ctx->irq);
-
-		at86rf230_async_error(lp, ctx, rc);
-	}
+	at86rf230_async_write_reg(lp, RG_TRX_STATE, ctx->to_state, ctx,
+				  at86rf230_async_state_delay);
 }
 
 static void
 at86rf230_async_state_change(struct at86rf230_local *lp,
 			     struct at86rf230_state_change *ctx,
-			     const u8 state, void (*complete)(void *context),
-			     const bool irq_enable)
+			     const u8 state, void (*complete)(void *context))
 {
 	/* Initialization for the state change context */
 	ctx->to_state = state;
 	ctx->complete = complete;
-	ctx->irq_enable = irq_enable;
 	at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-				 at86rf230_async_state_change_start,
-				 irq_enable);
+				 at86rf230_async_state_change_start);
 }
 
 static void
@@ -632,8 +625,7 @@ at86rf230_sync_state_change(struct at86rf230_local *lp, unsigned int state)
 	unsigned long rc;
 
 	at86rf230_async_state_change(lp, &lp->state, state,
-				     at86rf230_sync_state_change_complete,
-				     false);
+				     at86rf230_sync_state_change_complete);
 
 	rc = wait_for_completion_timeout(&lp->state_complete,
 					 msecs_to_jiffies(100));
@@ -651,9 +643,8 @@ at86rf230_tx_complete(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	enable_irq(ctx->irq);
-
 	ieee802154_xmit_complete(lp->hw, lp->tx_skb, false);
+	kfree(ctx);
 }
 
 static void
@@ -663,7 +654,7 @@ at86rf230_tx_on(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 
 	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON,
-				     at86rf230_tx_complete, true);
+				     at86rf230_tx_complete);
 }
 
 static void
@@ -697,8 +688,7 @@ at86rf230_tx_trac_check(void *context)
 		}
 	}
 
-	at86rf230_async_state_change(lp, &lp->irq, STATE_TX_ON,
-				     at86rf230_tx_on, true);
+	at86rf230_async_state_change(lp, ctx, STATE_TX_ON, at86rf230_tx_on);
 }
 
 static void
@@ -706,7 +696,6 @@ at86rf230_rx_read_frame_complete(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	u8 rx_local_buf[AT86RF2XX_MAX_BUF];
 	const u8 *buf = ctx->buf;
 	struct sk_buff *skb;
 	u8 len, lqi;
@@ -718,18 +707,16 @@ at86rf230_rx_read_frame_complete(void *context)
 	}
 	lqi = buf[2 + len];
 
-	memcpy(rx_local_buf, buf + 2, len);
-	ctx->trx.len = 2;
-	enable_irq(ctx->irq);
-
 	skb = dev_alloc_skb(IEEE802154_MTU);
 	if (!skb) {
 		dev_vdbg(&lp->spi->dev, "failed to allocate sk_buff\n");
+		kfree(ctx);
 		return;
 	}
 
-	memcpy(skb_put(skb, len), rx_local_buf, len);
+	memcpy(skb_put(skb, len), buf + 2, len);
 	ieee802154_rx_irqsafe(lp->hw, skb, lqi);
+	kfree(ctx);
 }
 
 static void
@@ -765,21 +752,23 @@ at86rf230_rx_trac_check(void *context)
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
 		ctx->trx.len = 2;
-		enable_irq(ctx->irq);
 		at86rf230_async_error(lp, ctx, rc);
 	}
 }
 
 static void
-at86rf230_irq_trx_end(struct at86rf230_local *lp)
+at86rf230_irq_trx_end(void *context)
 {
+	struct at86rf230_state_change *ctx = context;
+	struct at86rf230_local *lp = ctx->lp;
+
 	if (lp->is_tx) {
 		lp->is_tx = 0;
-		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
-					 at86rf230_tx_trac_check, true);
+		at86rf230_async_read_reg(lp, RG_TRX_STATE, ctx,
+					 at86rf230_tx_trac_check);
 	} else {
-		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
-					 at86rf230_rx_trac_check, true);
+		at86rf230_async_read_reg(lp, RG_TRX_STATE, ctx,
+					 at86rf230_rx_trac_check);
 	}
 }
 
@@ -789,32 +778,59 @@ at86rf230_irq_status(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	const u8 *buf = ctx->buf;
-	const u8 irq = buf[1];
+	u8 irq = buf[1];
+
+	enable_irq(lp->spi->irq);
 
 	if (irq & IRQ_TRX_END) {
-		at86rf230_irq_trx_end(lp);
+		at86rf230_irq_trx_end(ctx);
 	} else {
-		enable_irq(ctx->irq);
 		dev_err(&lp->spi->dev, "not supported irq %02x received\n",
 			irq);
+		kfree(ctx);
 	}
 }
 
+static void
+at86rf230_setup_spi_messages(struct at86rf230_local *lp,
+			     struct at86rf230_state_change *state)
+{
+	state->lp = lp;
+	state->irq = lp->spi->irq;
+	spi_message_init(&state->msg);
+	state->msg.context = state;
+	state->trx.len = 2;
+	state->trx.tx_buf = state->buf;
+	state->trx.rx_buf = state->buf;
+	spi_message_add_tail(&state->trx, &state->msg);
+	hrtimer_init(&state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	state->timer.function = at86rf230_async_state_timer;
+}
+
 static irqreturn_t at86rf230_isr(int irq, void *data)
 {
 	struct at86rf230_local *lp = data;
-	struct at86rf230_state_change *ctx = &lp->irq;
-	u8 *buf = ctx->buf;
+	struct at86rf230_state_change *ctx;
 	int rc;
 
 	disable_irq_nosync(irq);
 
-	buf[0] = (RG_IRQ_STATUS & CMD_REG_MASK) | CMD_REG;
+	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx) {
+		enable_irq(irq);
+		return IRQ_NONE;
+	}
+
+	at86rf230_setup_spi_messages(lp, ctx);
+	/* tell on error handling to free ctx */
+	ctx->free = true;
+
+	ctx->buf[0] = (RG_IRQ_STATUS & CMD_REG_MASK) | CMD_REG;
 	ctx->msg.complete = at86rf230_irq_status;
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
-		enable_irq(irq);
 		at86rf230_async_error(lp, ctx, rc);
+		enable_irq(irq);
 		return IRQ_NONE;
 	}
 
@@ -826,21 +842,14 @@ at86rf230_write_frame_complete(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	u8 *buf = ctx->buf;
-	int rc;
 
 	ctx->trx.len = 2;
 
-	if (gpio_is_valid(lp->slp_tr)) {
+	if (gpio_is_valid(lp->slp_tr))
 		at86rf230_slp_tr_rising_edge(lp);
-	} else {
-		buf[0] = (RG_TRX_STATE & CMD_REG_MASK) | CMD_REG | CMD_WRITE;
-		buf[1] = STATE_BUSY_TX;
-		ctx->msg.complete = NULL;
-		rc = spi_async(lp->spi, &ctx->msg);
-		if (rc)
-			at86rf230_async_error(lp, ctx, rc);
-	}
+	else
+		at86rf230_async_write_reg(lp, RG_TRX_STATE, STATE_BUSY_TX, ctx,
+					  NULL);
 }
 
 static void
@@ -873,7 +882,7 @@ at86rf230_xmit_tx_on(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 
 	at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
-				     at86rf230_write_frame, false);
+				     at86rf230_write_frame);
 }
 
 static void
@@ -886,12 +895,10 @@ at86rf230_xmit_start(void *context)
 	if (lp->is_tx_from_off) {
 		lp->is_tx_from_off = false;
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
-					     at86rf230_write_frame,
-					     false);
+					     at86rf230_write_frame);
 	} else {
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-					     at86rf230_xmit_tx_on,
-					     false);
+					     at86rf230_xmit_tx_on);
 	}
 }
 
@@ -914,7 +921,7 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	if (time_is_before_jiffies(lp->cal_timeout)) {
 		lp->is_tx_from_off = true;
 		at86rf230_async_state_change(lp, ctx, STATE_TRX_OFF,
-					     at86rf230_xmit_start, false);
+					     at86rf230_xmit_start);
 	} else {
 		at86rf230_xmit_start(ctx);
 	}
@@ -1373,10 +1380,6 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 		return rc;
 
 	irq_type = irq_get_trigger_type(lp->spi->irq);
-	if (irq_type == IRQ_TYPE_EDGE_RISING ||
-	    irq_type == IRQ_TYPE_EDGE_FALLING)
-		dev_warn(&lp->spi->dev,
-			 "Using edge triggered irq's are not recommended, because it can cause races and result in a non-functional driver!\n");
 	if (irq_type == IRQ_TYPE_EDGE_FALLING ||
 	    irq_type == IRQ_TYPE_LEVEL_LOW)
 		irq_pol = IRQ_ACTIVE_LOW;
@@ -1602,43 +1605,6 @@ not_supp:
 	return rc;
 }
 
-static void
-at86rf230_setup_spi_messages(struct at86rf230_local *lp)
-{
-	lp->state.lp = lp;
-	lp->state.irq = lp->spi->irq;
-	spi_message_init(&lp->state.msg);
-	lp->state.msg.context = &lp->state;
-	lp->state.trx.len = 2;
-	lp->state.trx.tx_buf = lp->state.buf;
-	lp->state.trx.rx_buf = lp->state.buf;
-	spi_message_add_tail(&lp->state.trx, &lp->state.msg);
-	hrtimer_init(&lp->state.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	lp->state.timer.function = at86rf230_async_state_timer;
-
-	lp->irq.lp = lp;
-	lp->irq.irq = lp->spi->irq;
-	spi_message_init(&lp->irq.msg);
-	lp->irq.msg.context = &lp->irq;
-	lp->irq.trx.len = 2;
-	lp->irq.trx.tx_buf = lp->irq.buf;
-	lp->irq.trx.rx_buf = lp->irq.buf;
-	spi_message_add_tail(&lp->irq.trx, &lp->irq.msg);
-	hrtimer_init(&lp->irq.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	lp->irq.timer.function = at86rf230_async_state_timer;
-
-	lp->tx.lp = lp;
-	lp->tx.irq = lp->spi->irq;
-	spi_message_init(&lp->tx.msg);
-	lp->tx.msg.context = &lp->tx;
-	lp->tx.trx.len = 2;
-	lp->tx.trx.tx_buf = lp->tx.buf;
-	lp->tx.trx.rx_buf = lp->tx.buf;
-	spi_message_add_tail(&lp->tx.trx, &lp->tx.msg);
-	hrtimer_init(&lp->tx.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	lp->tx.timer.function = at86rf230_async_state_timer;
-}
-
 #ifdef CONFIG_IEEE802154_AT86RF230_DEBUGFS
 static struct dentry *at86rf230_debugfs_root;
 
@@ -1775,7 +1741,8 @@ static int at86rf230_probe(struct spi_device *spi)
 		goto free_dev;
 	}
 
-	at86rf230_setup_spi_messages(lp);
+	at86rf230_setup_spi_messages(lp, &lp->state);
+	at86rf230_setup_spi_messages(lp, &lp->tx);
 
 	rc = at86rf230_detect_device(lp);
 	if (rc < 0)
-- 
2.5.2

