Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36347 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbD3PqV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 11:46:21 -0400
Received: by wizk4 with SMTP id k4so24862567wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Apr 2015 08:46:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/13] at86rf230: change state change if from trx_off
Date: Thu, 30 Apr 2015 17:45:02 +0200
Message-Id: <1430408704-21815-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
References: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

If a transmit ends in a calibration which means the transceiver do a
TRX_OFF state change, we can directly change into TX_ARET state instead
doing a TX_ON to TX_ARET statechange.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6285145..05ef56d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -95,6 +95,7 @@ struct at86rf230_local {
 	unsigned long cal_timeout;
 	s8 max_frame_retries;
 	bool is_tx;
+	bool is_tx_from_off;
 	u8 tx_retry;
 	struct sk_buff *tx_skb;
 	struct at86rf230_state_change tx;
@@ -991,12 +992,21 @@ at86rf230_xmit_start(void *context)
 	 * are in STATE_TX_ON. The pfad differs here, so we change
 	 * the complete handler.
 	 */
-	if (lp->tx_aret)
-		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-					     at86rf230_xmit_tx_on, false);
-	else
+	if (lp->tx_aret) {
+		if (lp->is_tx_from_off) {
+			lp->is_tx_from_off = false;
+			at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
+						     at86rf230_xmit_tx_on,
+						     false);
+		} else {
+			at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
+						     at86rf230_xmit_tx_on,
+						     false);
+		}
+	} else {
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
 					     at86rf230_write_frame, false);
+	}
 }
 
 static int
@@ -1015,11 +1025,13 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	 * to TX_ON, the lp->cal_timeout should be reinit by state_delay
 	 * function then to start in the next 5 minutes.
 	 */
-	if (time_is_before_jiffies(lp->cal_timeout))
+	if (time_is_before_jiffies(lp->cal_timeout)) {
+		lp->is_tx_from_off = true;
 		at86rf230_async_state_change(lp, ctx, STATE_TRX_OFF,
 					     at86rf230_xmit_start, false);
-	else
+	} else {
 		at86rf230_xmit_start(ctx);
+	}
 
 	return 0;
 }
-- 
2.3.6

