Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:63480 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbaHSQUY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 12:20:24 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so6542005wgh.1
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 09:20:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan] at86rf230: add missing enable_irq on irq handler
Date: Tue, 19 Aug 2014 18:20:08 +0200
Message-Id: <1408465208-25655-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a missing enable_irq in the at86rf230 irq handler.
If the read of irq status register failed the irq is disabled and we need
to enable the irq on failure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index c9d2a75..948c5d4 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -908,6 +908,7 @@ static irqreturn_t at86rf230_isr(int irq, void *data)
 	ctx->msg.complete = at86rf230_irq_status;
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
+		enable_irq(lp->spi->irq);
 		at86rf230_async_error(lp, ctx, rc);
 		return IRQ_NONE;
 	}
-- 
2.0.4

