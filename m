Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33445 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031727AbbD2JTF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 05:19:05 -0400
Received: by wief7 with SMTP id f7so35484160wie.0
        for <linux-wpan@vger.kernel.org>; Wed, 29 Apr 2015 02:19:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 wpan-next 3/6] at86rf230: add TX_ARET_ON for calibration timeout
Date: Wed, 29 Apr 2015 11:18:43 +0200
Message-Id: <1430299126-14855-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430299126-14855-1-git-send-email-alex.aring@gmail.com>
References: <1430299126-14855-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a calibration timeout reset when change from TRX_OFF to
TX_ARET_ON which also occurs a calibration.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6358788..f99dce5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -617,10 +617,11 @@ at86rf230_async_state_delay(void *context)
 			 */
 			lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
 			goto change;
+		case STATE_TX_ARET_ON:
 		case STATE_TX_ON:
 			tim = ktime_set(0, c->t_off_to_tx_on * NSEC_PER_USEC);
-			/* state change from TRX_OFF to TX_ON to do a
-			 * calibration, we need to reset the timeout for the
+			/* state change from TRX_OFF to TX_ON or ARET_ON to do
+			 * a calibration, we need to reset the timeout for the
 			 * next one.
 			 */
 			lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
-- 
2.3.6

