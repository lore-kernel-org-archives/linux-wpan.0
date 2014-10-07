Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:53833 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGIju (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:50 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so7058500wiv.8
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:49 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/9] at86rf230: squash unnecessary dereferencing
Date: Tue,  7 Oct 2014 10:38:29 +0200
Message-Id: <1412671113-26675-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes dereferencing irq number over spi struct. Instead we
doing it directly over isr paramater.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b26135f..09503fb 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -904,7 +904,7 @@ static irqreturn_t at86rf230_isr(int irq, void *data)
 	u8 *buf = ctx->buf;
 	int rc;
 
-	disable_irq_nosync(lp->spi->irq);
+	disable_irq_nosync(irq);
 
 	buf[0] = (RG_IRQ_STATUS & CMD_REG_MASK) | CMD_REG;
 	ctx->trx.len = 2;
-- 
2.1.2

