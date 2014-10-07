Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35815 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaJGIjw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:52 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so7082605wib.11
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:50 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/9] at86rf230: add missing enable_irq
Date: Tue,  7 Oct 2014 10:38:30 +0200
Message-Id: <1412671113-26675-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a missing enable_irq when spi_async in isr failed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 09503fb..8754f15 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -911,6 +911,7 @@ static irqreturn_t at86rf230_isr(int irq, void *data)
 	ctx->msg.complete = at86rf230_irq_status;
 	rc = spi_async(lp->spi, &ctx->msg);
 	if (rc) {
+		enable_irq(irq);
 		at86rf230_async_error(lp, ctx, rc);
 		return IRQ_NONE;
 	}
-- 
2.1.2

