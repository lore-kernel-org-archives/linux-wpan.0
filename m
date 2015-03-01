Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41112 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbCAUz6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:55:58 -0500
Received: by wghl18 with SMTP id l18so29826298wgh.8
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:55:57 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/6] at86rf230: remove multiple dereferencing for irq
Date: Sun,  1 Mar 2015 21:55:31 +0100
Message-Id: <1425243333-8344-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

By holding the irq variable inside at86rf230_state_change we can squash
some multiple dereferencing for getting irq num.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 8e93ea4..7f27fa3 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -62,6 +62,7 @@ struct at86rf2xx_chip_data {
 
 struct at86rf230_state_change {
 	struct at86rf230_local *lp;
+	int irq;
 
 	struct spi_message msg;
 	struct spi_transfer trx;
@@ -483,7 +484,7 @@ at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
 		if (irq_enable)
-			enable_irq(lp->spi->irq);
+			enable_irq(ctx->irq);
 
 		at86rf230_async_error(lp, ctx, rc);
 	}
@@ -667,7 +668,7 @@ at86rf230_async_state_change_start(void *context)
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
 		if (ctx->irq_enable)
-			enable_irq(lp->spi->irq);
+			enable_irq(ctx->irq);
 
 		at86rf230_async_error(lp, ctx, rc);
 	}
@@ -726,7 +727,7 @@ at86rf230_tx_complete(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	enable_irq(lp->spi->irq);
+	enable_irq(ctx->irq);
 
 	ieee802154_xmit_complete(lp->hw, lp->tx_skb, !lp->tx_aret);
 }
@@ -798,7 +799,7 @@ at86rf230_rx_read_frame_complete(void *context)
 	lqi = buf[2 + len];
 
 	memcpy(rx_local_buf, buf + 2, len);
-	enable_irq(lp->spi->irq);
+	enable_irq(ctx->irq);
 
 	skb = dev_alloc_skb(IEEE802154_MTU);
 	if (!skb) {
@@ -811,8 +812,10 @@ at86rf230_rx_read_frame_complete(void *context)
 }
 
 static void
-at86rf230_rx_read_frame(struct at86rf230_local *lp)
+at86rf230_rx_read_frame(void *context)
 {
+	struct at86rf230_state_change *ctx = context;
+	struct at86rf230_local *lp = ctx->lp;
 	int rc;
 
 	u8 *buf = lp->irq.buf;
@@ -822,7 +825,7 @@ at86rf230_rx_read_frame(struct at86rf230_local *lp)
 	lp->irq.msg.complete = at86rf230_rx_read_frame_complete;
 	rc = spi_async(lp->spi, &lp->irq.msg);
 	if (rc) {
-		enable_irq(lp->spi->irq);
+		enable_irq(ctx->irq);
 		at86rf230_async_error(lp, &lp->irq, rc);
 	}
 }
@@ -830,16 +833,13 @@ at86rf230_rx_read_frame(struct at86rf230_local *lp)
 static void
 at86rf230_rx_trac_check(void *context)
 {
-	struct at86rf230_state_change *ctx = context;
-	struct at86rf230_local *lp = ctx->lp;
-
 	/* Possible check on trac status here. This could be useful to make
 	 * some stats why receive is failed. Not used at the moment, but it's
 	 * maybe timing relevant. Datasheet doesn't say anything about this.
 	 * The programming guide say do it so.
 	 */
 
-	at86rf230_rx_read_frame(lp);
+	at86rf230_rx_read_frame(context);
 }
 
 static void
@@ -878,7 +878,7 @@ at86rf230_irq_status(void *context)
 	if (irq & IRQ_TRX_END) {
 		at86rf230_irq_trx_end(lp);
 	} else {
-		enable_irq(lp->spi->irq);
+		enable_irq(ctx->irq);
 		dev_err(&lp->spi->dev, "not supported irq %02x received\n",
 			irq);
 	}
@@ -1539,6 +1539,7 @@ static void
 at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 {
 	lp->state.lp = lp;
+	lp->state.irq = lp->spi->irq;
 	spi_message_init(&lp->state.msg);
 	lp->state.msg.context = &lp->state;
 	lp->state.trx.tx_buf = lp->state.buf;
@@ -1546,6 +1547,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	spi_message_add_tail(&lp->state.trx, &lp->state.msg);
 
 	lp->irq.lp = lp;
+	lp->irq.irq = lp->spi->irq;
 	spi_message_init(&lp->irq.msg);
 	lp->irq.msg.context = &lp->irq;
 	lp->irq.trx.tx_buf = lp->irq.buf;
@@ -1553,6 +1555,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	spi_message_add_tail(&lp->irq.trx, &lp->irq.msg);
 
 	lp->tx.lp = lp;
+	lp->tx.irq = lp->spi->irq;
 	spi_message_init(&lp->tx.msg);
 	lp->tx.msg.context = &lp->tx;
 	lp->tx.trx.tx_buf = lp->tx.buf;
-- 
2.3.0

