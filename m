Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36048 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031285AbbD2HfR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 03:35:17 -0400
Received: by wizk4 with SMTP id k4so168974115wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 00:35:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 2/6] at86rf230: move cal_timeout to state change
Date: Wed, 29 Apr 2015 09:34:49 +0200
Message-Id: <1430292893-5752-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430292893-5752-1-git-send-email-alex.aring@gmail.com>
References: <1430292893-5752-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the calculation timeout of TRX_OFF to RX_AACK_ON
handling to the async state change functionality. With this patch we can
do a reset of calculation timeout when others TRX_OFF to RX_AACK_ON
happens instead of doing this on interface up only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9a41deb..6358788 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -611,6 +611,11 @@ at86rf230_async_state_delay(void *context)
 		switch (ctx->to_state) {
 		case STATE_RX_AACK_ON:
 			tim = ktime_set(0, c->t_off_to_aack * NSEC_PER_USEC);
+			/* state change from TRX_OFF to RX_AACK_ON to do a
+			 * calibration, we need to reset the timeout for the
+			 * next one.
+			 */
+			lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
 			goto change;
 		case STATE_TX_ON:
 			tim = ktime_set(0, c->t_off_to_tx_on * NSEC_PER_USEC);
@@ -1039,9 +1044,6 @@ at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
 static int
 at86rf230_start(struct ieee802154_hw *hw)
 {
-	struct at86rf230_local *lp = hw->priv;
-
-	lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
 	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
 }
 
-- 
2.3.6

