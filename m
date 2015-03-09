Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40246 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbbCIM4X (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 08:56:23 -0400
Received: by wivr20 with SMTP id r20so19929702wiv.5
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 05:56:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] at86rf230: add support for calibration timeout
Date: Mon,  9 Mar 2015 13:56:11 +0100
Message-Id: <1425905772-28560-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
References: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, Werner Almesberger <werner@almesberger.net>

This patch adds a handling for calibration if we are 5 minutes in PLL
state. I first tried to implement the calibration functionality in
TX_ON state via register values CF_START and DCU_START, but this occurs
a one second delay at each calibration time.

An another solution to start a calibration is to switch from TRX_OFF
state into TX_ON, then a calibration is done automatically by
transceiver. This method will be used in this patch, after each transmit
of a frame we check with jiffies if the PLL is set 5 minutes without
doing a TRX_OFF->(TX_ON || RX_AACK_ON) or channel switch. The worst case
would be a transceiver in receiving mode only, but this is under normal
operation very unlikely.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: Werner Almesberger <werner@almesberger.net>
---
 drivers/net/ieee802154/at86rf230.c | 72 ++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index cdcd152..3b81c62 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/hrtimer.h>
+#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -60,6 +61,8 @@ struct at86rf2xx_chip_data {
  * We assume the max_frame_retries (7) value of 802.15.4 here.
  */
 #define AT86RF2XX_MAX_TX_RETRIES	7
+/* We use the recommended 5 minutes timeout to recalibrate */
+#define AT86RF2XX_CAL_LOOP_TIMEOUT	(5 * 60 * HZ)
 
 struct at86rf230_state_change {
 	struct at86rf230_local *lp;
@@ -90,6 +93,7 @@ struct at86rf230_local {
 	struct at86rf230_state_change irq;
 
 	bool tx_aret;
+	unsigned long cal_timeout;
 	s8 max_frame_retries;
 	bool is_tx;
 	/* spinlock for is_tx protection */
@@ -491,6 +495,14 @@ at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
 	}
 }
 
+static inline u8 at86rf230_state_to_force(u8 state)
+{
+	if (state == STATE_TX_ON)
+		return STATE_FORCE_TX_ON;
+	else
+		return STATE_FORCE_TRX_OFF;
+}
+
 static void
 at86rf230_async_state_assert(void *context)
 {
@@ -527,11 +539,12 @@ at86rf230_async_state_assert(void *context)
 			 * higher or equal than AT86RF2XX_MAX_TX_RETRIES we
 			 * will do a force change.
 			 */
-			if (ctx->to_state == STATE_TX_ON) {
-				u8 state = STATE_TX_ON;
+			if (ctx->to_state == STATE_TX_ON ||
+			    ctx->to_state == STATE_TRX_OFF) {
+				u8 state = ctx->to_state;
 
 				if (lp->tx_retry >= AT86RF2XX_MAX_TX_RETRIES)
-					state = STATE_FORCE_TX_ON;
+					state = at86rf230_state_to_force(state);
 				lp->tx_retry++;
 
 				at86rf230_async_state_change(lp, ctx, state,
@@ -599,6 +612,11 @@ at86rf230_async_state_delay(void *context)
 			goto change;
 		case STATE_TX_ON:
 			tim = ktime_set(0, c->t_off_to_tx_on * NSEC_PER_USEC);
+			/* state change from TRX_OFF to TX_ON to do a
+			 * calibration, we need to reset the timeout for the
+			 * next one.
+			 */
+			lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
 			goto change;
 		default:
 			break;
@@ -606,10 +624,11 @@ at86rf230_async_state_delay(void *context)
 		break;
 	case STATE_BUSY_RX_AACK:
 		switch (ctx->to_state) {
+		case STATE_TRX_OFF:
 		case STATE_TX_ON:
 			/* Wait for worst case receiving time if we
 			 * didn't make a force change from BUSY_RX_AACK
-			 * to TX_ON.
+			 * to TX_ON or TRX_OFF.
 			 */
 			if (!force) {
 				tim = ktime_set(0, (c->t_frame + c->t_p_ack) *
@@ -969,25 +988,45 @@ at86rf230_xmit_tx_on(void *context)
 				     at86rf230_write_frame, false);
 }
 
-static int
-at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
+static void
+at86rf230_xmit_start(void *context)
 {
-	struct at86rf230_local *lp = hw->priv;
-	struct at86rf230_state_change *ctx = &lp->tx;
-
-	void (*tx_complete)(void *context) = at86rf230_write_frame;
-
-	lp->tx_skb = skb;
+	struct at86rf230_state_change *ctx = context;
+	struct at86rf230_local *lp = ctx->lp;
 
 	/* In ARET mode we need to go into STATE_TX_ARET_ON after we
 	 * are in STATE_TX_ON. The pfad differs here, so we change
 	 * the complete handler.
 	 */
 	if (lp->tx_aret)
-		tx_complete = at86rf230_xmit_tx_on;
+		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
+					     at86rf230_xmit_tx_on, false);
+	else
+		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
+					     at86rf230_write_frame, false);
+}
+
+static int
+at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
+{
+	struct at86rf230_local *lp = hw->priv;
+	struct at86rf230_state_change *ctx = &lp->tx;
 
+	lp->tx_skb = skb;
 	lp->tx_retry = 0;
-	at86rf230_async_state_change(lp, ctx, STATE_TX_ON, tx_complete, false);
+
+	/* After 5 minutes in PLL and the same frequency we run again the
+	 * calibration loops which is recommended by at86rf2xx datasheets.
+	 *
+	 * The calibration is initiate by a state change from TRX_OFF
+	 * to TX_ON, the lp->cal_timeout should be reinit by state_delay
+	 * function then to start in the next 5 minutes.
+	 */
+	if (time_is_before_jiffies(lp->cal_timeout))
+		at86rf230_async_state_change(lp, ctx, STATE_TRX_OFF,
+					     at86rf230_xmit_start, false);
+	else
+		at86rf230_xmit_start(ctx);
 
 	return 0;
 }
@@ -1003,6 +1042,9 @@ at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
 static int
 at86rf230_start(struct ieee802154_hw *hw)
 {
+	struct at86rf230_local *lp = hw->priv;
+
+	lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
 	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
 }
 
@@ -1083,6 +1125,8 @@ at86rf230_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	/* Wait for PLL */
 	usleep_range(lp->data->t_channel_switch,
 		     lp->data->t_channel_switch + 10);
+
+	lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
 	return rc;
 }
 
-- 
2.3.0

