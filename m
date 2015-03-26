Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36045 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbCZLqw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 07:46:52 -0400
Received: by wibg7 with SMTP id g7so145166048wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 26 Mar 2015 04:46:51 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] at86rf230: remove unnecessary spinlock
Date: Thu, 26 Mar 2015 12:46:29 +0100
Message-Id: <1427370390-31302-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This spinlock isn't necessary because if we are in TX_ON/TX_ARET_ON
state the transceiver can't be interrupted e.g. by receiving a frame
when a SHR was detected. In this time the transceiver doesn't leave
the TX_ON/TX_ARET_ON state until the tx complete irq change the state
into RX_AACK_ON again. This means a receiving interrupt in state
TX_ON/TX_ARET_ON can't happen and is_tx is protected by transceiver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index cc5efa1..1278dd5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -25,7 +25,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
-#include <linux/spinlock.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/at86rf230.h>
 #include <linux/regmap.h>
@@ -96,8 +95,6 @@ struct at86rf230_local {
 	unsigned long cal_timeout;
 	s8 max_frame_retries;
 	bool is_tx;
-	/* spinlock for is_tx protection */
-	spinlock_t lock;
 	u8 tx_retry;
 	struct sk_buff *tx_skb;
 	struct at86rf230_state_change tx;
@@ -878,10 +875,8 @@ at86rf230_rx_trac_check(void *context)
 static void
 at86rf230_irq_trx_end(struct at86rf230_local *lp)
 {
-	spin_lock(&lp->lock);
 	if (lp->is_tx) {
 		lp->is_tx = 0;
-		spin_unlock(&lp->lock);
 
 		if (lp->tx_aret)
 			at86rf230_async_state_change(lp, &lp->irq,
@@ -894,7 +889,6 @@ at86rf230_irq_trx_end(struct at86rf230_local *lp)
 						     at86rf230_tx_complete,
 						     true);
 	} else {
-		spin_unlock(&lp->lock);
 		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
 					 at86rf230_rx_trac_check, true);
 	}
@@ -964,9 +958,7 @@ at86rf230_write_frame(void *context)
 	u8 *buf = ctx->buf;
 	int rc;
 
-	spin_lock(&lp->lock);
 	lp->is_tx = 1;
-	spin_unlock(&lp->lock);
 
 	buf[0] = CMD_FB | CMD_WRITE;
 	buf[1] = skb->len + 2;
@@ -1698,7 +1690,6 @@ static int at86rf230_probe(struct spi_device *spi)
 	if (rc < 0)
 		goto free_dev;
 
-	spin_lock_init(&lp->lock);
 	init_completion(&lp->state_complete);
 
 	spi_set_drvdata(spi, lp);
-- 
2.3.4

