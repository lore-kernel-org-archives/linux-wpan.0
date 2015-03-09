Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:37498 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbbCIM4W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 08:56:22 -0400
Received: by wesx3 with SMTP id x3so27557522wes.4
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 05:56:21 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/3] at86rf230: replace state change sleeps with hrtimer
Date: Mon,  9 Mar 2015 13:56:10 +0100
Message-Id: <1425905772-28560-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
References: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replace the state change timing relevant sleeps with
hrtimers. Currently the sleeps are done in the complete handler of
spi_async. The relation of doing the state change timing sleep with a
timer will get the sleep functionality out of spi_async complete handler
context.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 39 ++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 088fa68..cdcd152 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -19,6 +19,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -64,6 +65,7 @@ struct at86rf230_state_change {
 	struct at86rf230_local *lp;
 	int irq;
 
+	struct hrtimer timer;
 	struct spi_message msg;
 	struct spi_transfer trx;
 	u8 buf[AT86RF2XX_MAX_BUF];
@@ -548,6 +550,19 @@ done:
 		ctx->complete(context);
 }
 
+static enum hrtimer_restart at86rf230_async_state_timer(struct hrtimer *timer)
+{
+	struct at86rf230_state_change *ctx =
+		container_of(timer, struct at86rf230_state_change, timer);
+	struct at86rf230_local *lp = ctx->lp;
+
+	at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
+				 at86rf230_async_state_assert,
+				 ctx->irq_enable);
+
+	return HRTIMER_NORESTART;
+}
+
 /* Do state change timing delay. */
 static void
 at86rf230_async_state_delay(void *context)
@@ -556,6 +571,7 @@ at86rf230_async_state_delay(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 	struct at86rf2xx_chip_data *c = lp->data;
 	bool force = false;
+	ktime_t tim;
 
 	/* The force state changes are will show as normal states in the
 	 * state status subregister. We change the to_state to the
@@ -579,11 +595,10 @@ at86rf230_async_state_delay(void *context)
 	case STATE_TRX_OFF:
 		switch (ctx->to_state) {
 		case STATE_RX_AACK_ON:
-			usleep_range(c->t_off_to_aack, c->t_off_to_aack + 10);
+			tim = ktime_set(0, c->t_off_to_aack * NSEC_PER_USEC);
 			goto change;
 		case STATE_TX_ON:
-			usleep_range(c->t_off_to_tx_on,
-				     c->t_off_to_tx_on + 10);
+			tim = ktime_set(0, c->t_off_to_tx_on * NSEC_PER_USEC);
 			goto change;
 		default:
 			break;
@@ -597,8 +612,8 @@ at86rf230_async_state_delay(void *context)
 			 * to TX_ON.
 			 */
 			if (!force) {
-				usleep_range(c->t_frame + c->t_p_ack,
-					     c->t_frame + c->t_p_ack + 1000);
+				tim = ktime_set(0, (c->t_frame + c->t_p_ack) *
+						   NSEC_PER_USEC);
 				goto change;
 			}
 			break;
@@ -610,7 +625,7 @@ at86rf230_async_state_delay(void *context)
 	case STATE_P_ON:
 		switch (ctx->to_state) {
 		case STATE_TRX_OFF:
-			usleep_range(c->t_reset_to_off, c->t_reset_to_off + 10);
+			tim = ktime_set(0, c->t_reset_to_off * NSEC_PER_USEC);
 			goto change;
 		default:
 			break;
@@ -621,12 +636,10 @@ at86rf230_async_state_delay(void *context)
 	}
 
 	/* Default delay is 1us in the most cases */
-	udelay(1);
+	tim = ktime_set(0, NSEC_PER_USEC);
 
 change:
-	at86rf230_async_read_reg(lp, RG_TRX_STATUS, ctx,
-				 at86rf230_async_state_assert,
-				 ctx->irq_enable);
+	hrtimer_start(&ctx->timer, tim, HRTIMER_MODE_REL);
 }
 
 static void
@@ -1546,6 +1559,8 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	lp->state.trx.tx_buf = lp->state.buf;
 	lp->state.trx.rx_buf = lp->state.buf;
 	spi_message_add_tail(&lp->state.trx, &lp->state.msg);
+	hrtimer_init(&lp->state.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	lp->state.timer.function = at86rf230_async_state_timer;
 
 	lp->irq.lp = lp;
 	lp->irq.irq = lp->spi->irq;
@@ -1555,6 +1570,8 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	lp->irq.trx.tx_buf = lp->irq.buf;
 	lp->irq.trx.rx_buf = lp->irq.buf;
 	spi_message_add_tail(&lp->irq.trx, &lp->irq.msg);
+	hrtimer_init(&lp->irq.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	lp->irq.timer.function = at86rf230_async_state_timer;
 
 	lp->tx.lp = lp;
 	lp->tx.irq = lp->spi->irq;
@@ -1564,6 +1581,8 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	lp->tx.trx.tx_buf = lp->tx.buf;
 	lp->tx.trx.rx_buf = lp->tx.buf;
 	spi_message_add_tail(&lp->tx.trx, &lp->tx.msg);
+	hrtimer_init(&lp->tx.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	lp->tx.timer.function = at86rf230_async_state_timer;
 }
 
 static int at86rf230_probe(struct spi_device *spi)
-- 
2.3.0

