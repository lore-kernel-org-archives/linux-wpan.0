Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37365 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbCAUz5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:55:57 -0500
Received: by wivr20 with SMTP id r20so10705779wiv.2
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:55:53 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/6] at86rf230: add transmit retry support
Date: Sun,  1 Mar 2015 21:55:28 +0100
Message-Id: <1425243333-8344-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce a transmit retry handling into at86rf230 transmit
path. Current behaviour is to wait the normal receive time if we want
to go into STATE_TX_ON when the transceiver is in STATE_BUSY_RX_AACK
which indicates that a frame is currently receiving. A non force state
change will not interrupt the the receiving state.

The current behaviour is that after the normal receive time we will
start a force change into STATE_TX_ON. With this patch we do seven
retries to go into STATE_TX_ON without forcing. After we hit the
AT86RF2XX_MAX_TX_RETRIES we will start the force state change.
This is a polling like method to go into STATE_TX_ON in times of maximum
receiving time.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1d438bc..503fabd 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -52,7 +52,13 @@ struct at86rf2xx_chip_data {
 	int (*get_desense_steps)(struct at86rf230_local *, s32);
 };
 
-#define AT86RF2XX_MAX_BUF (127 + 3)
+#define AT86RF2XX_MAX_BUF		(127 + 3)
+/* tx retries to access the TX_ON state
+ * if it's above then force change will be started.
+ *
+ * We assume the max_frame_retries (7) value of 802.15.4 here.
+ */
+#define AT86RF2XX_MAX_TX_RETRIES	7
 
 struct at86rf230_state_change {
 	struct at86rf230_local *lp;
@@ -85,6 +91,7 @@ struct at86rf230_local {
 	bool is_tx;
 	/* spinlock for is_tx protection */
 	spinlock_t lock;
+	u8 tx_retry;
 	struct sk_buff *tx_skb;
 	struct at86rf230_state_change tx;
 };
@@ -512,10 +519,20 @@ at86rf230_async_state_assert(void *context)
 			 * in STATE_BUSY_RX_AACK, we run a force state change
 			 * to STATE_TX_ON. This is a timeout handling, if the
 			 * transceiver stucks in STATE_BUSY_RX_AACK.
+			 *
+			 * Additional we do several retries to try to get into
+			 * TX_ON state without forcing. If the retries are
+			 * higher or equal than AT86RF2XX_MAX_TX_RETRIES we
+			 * will do a force change.
 			 */
 			if (ctx->to_state == STATE_TX_ON) {
-				at86rf230_async_state_change(lp, ctx,
-							     STATE_FORCE_TX_ON,
+				u8 state = STATE_TX_ON;
+
+				if (lp->tx_retry >= AT86RF2XX_MAX_TX_RETRIES)
+					state = STATE_FORCE_TX_ON;
+				lp->tx_retry++;
+
+				at86rf230_async_state_change(lp, ctx, state,
 							     ctx->complete,
 							     ctx->irq_enable);
 				return;
@@ -963,6 +980,7 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	if (lp->tx_aret)
 		tx_complete = at86rf230_xmit_tx_on;
 
+	lp->tx_retry = 0;
 	at86rf230_async_state_change(lp, ctx, STATE_TX_ON, tx_complete, false);
 
 	return 0;
-- 
2.3.0

