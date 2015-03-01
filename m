Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39816 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbCAU4C (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:56:02 -0500
Received: by widex7 with SMTP id ex7so10689543wid.4
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:55:58 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/6] at86rf230: remove multiple dereferencing for ctx
Date: Sun,  1 Mar 2015 21:55:32 +0100
Message-Id: <1425243333-8344-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the referencing for the state change context
variable. The state change context should only set once and this is by
initial a state change. This patch will use the initial state change
variable in the complete handler of the state change by using the ctx
context which should be always the same like the initial state change
context.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7f27fa3..216c80c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -738,7 +738,7 @@ at86rf230_tx_on(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	at86rf230_async_state_change(lp, &lp->irq, STATE_RX_AACK_ON,
+	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON,
 				     at86rf230_tx_complete, true);
 }
 
@@ -787,7 +787,7 @@ at86rf230_rx_read_frame_complete(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	u8 rx_local_buf[AT86RF2XX_MAX_BUF];
-	const u8 *buf = lp->irq.buf;
+	const u8 *buf = ctx->buf;
 	struct sk_buff *skb;
 	u8 len, lqi;
 
@@ -816,17 +816,16 @@ at86rf230_rx_read_frame(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
+	u8 *buf = ctx->buf;
 	int rc;
 
-	u8 *buf = lp->irq.buf;
-
 	buf[0] = CMD_FB;
-	lp->irq.trx.len = AT86RF2XX_MAX_BUF;
-	lp->irq.msg.complete = at86rf230_rx_read_frame_complete;
-	rc = spi_async(lp->spi, &lp->irq.msg);
+	ctx->trx.len = AT86RF2XX_MAX_BUF;
+	ctx->msg.complete = at86rf230_rx_read_frame_complete;
+	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
 		enable_irq(ctx->irq);
-		at86rf230_async_error(lp, &lp->irq, rc);
+		at86rf230_async_error(lp, ctx, rc);
 	}
 }
 
@@ -872,7 +871,7 @@ at86rf230_irq_status(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
-	const u8 *buf = lp->irq.buf;
+	const u8 *buf = ctx->buf;
 	const u8 irq = buf[1];
 
 	if (irq & IRQ_TRX_END) {
@@ -929,7 +928,7 @@ at86rf230_write_frame(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	struct sk_buff *skb = lp->tx_skb;
-	u8 *buf = lp->tx.buf;
+	u8 *buf = ctx->buf;
 	int rc;
 
 	spin_lock(&lp->lock);
@@ -939,9 +938,9 @@ at86rf230_write_frame(void *context)
 	buf[0] = CMD_FB | CMD_WRITE;
 	buf[1] = skb->len + 2;
 	memcpy(buf + 2, skb->data, skb->len);
-	lp->tx.trx.len = skb->len + 2;
-	lp->tx.msg.complete = at86rf230_write_frame_complete;
-	rc = spi_async(lp->spi, &lp->tx.msg);
+	ctx->trx.len = skb->len + 2;
+	ctx->msg.complete = at86rf230_write_frame_complete;
+	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc)
 		at86rf230_async_error(lp, ctx, rc);
 }
-- 
2.3.0

