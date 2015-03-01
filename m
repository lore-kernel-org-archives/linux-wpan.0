Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38562 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbCAU4D (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:56:03 -0500
Received: by wgha1 with SMTP id a1so29860969wgh.5
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:56:00 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/6] at86rf230: restore trx len when needed
Date: Sun,  1 Mar 2015 21:55:33 +0100
Message-Id: <1425243333-8344-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

In the most cases the spi messages has a length of two. Currently we
always set the the len field to two before transmit a spi message. In
cases for read out/write in the frame buffer we need another len. This
patch use trx len two as default. For the frame buffer cases we restore
the trx len to two on success and failure. This will reduce the len
setting of two when it's already two.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 216c80c..088fa68 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -478,7 +478,6 @@ at86rf230_async_read_reg(struct at86rf230_local *lp, const u8 reg,
 	u8 *tx_buf = ctx->buf;
 
 	tx_buf[0] = (reg & CMD_REG_MASK) | CMD_REG;
-	ctx->trx.len = 2;
 	ctx->msg.complete = complete;
 	ctx->irq_enable = irq_enable;
 	rc = spi_async(lp->spi, &ctx->msg);
@@ -663,7 +662,6 @@ at86rf230_async_state_change_start(void *context)
 	 */
 	buf[0] = (RG_TRX_STATE & CMD_REG_MASK) | CMD_REG | CMD_WRITE;
 	buf[1] = ctx->to_state;
-	ctx->trx.len = 2;
 	ctx->msg.complete = at86rf230_async_state_delay;
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
@@ -799,6 +797,7 @@ at86rf230_rx_read_frame_complete(void *context)
 	lqi = buf[2 + len];
 
 	memcpy(rx_local_buf, buf + 2, len);
+	ctx->trx.len = 2;
 	enable_irq(ctx->irq);
 
 	skb = dev_alloc_skb(IEEE802154_MTU);
@@ -824,6 +823,7 @@ at86rf230_rx_read_frame(void *context)
 	ctx->msg.complete = at86rf230_rx_read_frame_complete;
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
+		ctx->trx.len = 2;
 		enable_irq(ctx->irq);
 		at86rf230_async_error(lp, ctx, rc);
 	}
@@ -893,7 +893,6 @@ static irqreturn_t at86rf230_isr(int irq, void *data)
 	disable_irq_nosync(irq);
 
 	buf[0] = (RG_IRQ_STATUS & CMD_REG_MASK) | CMD_REG;
-	ctx->trx.len = 2;
 	ctx->msg.complete = at86rf230_irq_status;
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
@@ -941,8 +940,10 @@ at86rf230_write_frame(void *context)
 	ctx->trx.len = skb->len + 2;
 	ctx->msg.complete = at86rf230_write_frame_complete;
 	rc = spi_async(lp->spi, &ctx->msg);
-	if (rc)
+	if (rc) {
+		ctx->trx.len = 2;
 		at86rf230_async_error(lp, ctx, rc);
+	}
 }
 
 static void
@@ -1541,6 +1542,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	lp->state.irq = lp->spi->irq;
 	spi_message_init(&lp->state.msg);
 	lp->state.msg.context = &lp->state;
+	lp->state.trx.len = 2;
 	lp->state.trx.tx_buf = lp->state.buf;
 	lp->state.trx.rx_buf = lp->state.buf;
 	spi_message_add_tail(&lp->state.trx, &lp->state.msg);
@@ -1549,6 +1551,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	lp->irq.irq = lp->spi->irq;
 	spi_message_init(&lp->irq.msg);
 	lp->irq.msg.context = &lp->irq;
+	lp->irq.trx.len = 2;
 	lp->irq.trx.tx_buf = lp->irq.buf;
 	lp->irq.trx.rx_buf = lp->irq.buf;
 	spi_message_add_tail(&lp->irq.trx, &lp->irq.msg);
@@ -1557,6 +1560,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 	lp->tx.irq = lp->spi->irq;
 	spi_message_init(&lp->tx.msg);
 	lp->tx.msg.context = &lp->tx;
+	lp->tx.trx.len = 2;
 	lp->tx.trx.tx_buf = lp->tx.buf;
 	lp->tx.trx.rx_buf = lp->tx.buf;
 	spi_message_add_tail(&lp->tx.trx, &lp->tx.msg);
-- 
2.3.0

