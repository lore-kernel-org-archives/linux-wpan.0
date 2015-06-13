Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36187 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbFMUQE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 13 Jun 2015 16:16:04 -0400
Received: by wigg3 with SMTP id g3so42741725wig.1
        for <linux-wpan@vger.kernel.org>; Sat, 13 Jun 2015 13:16:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/4] at86rf230: use level high as fallback default
Date: Sat, 13 Jun 2015 22:15:53 +0200
Message-Id: <1434226554-1450-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch use high level interrupt type as fallback handling when no
irq type is given.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1bf86d2..25e1ede 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1633,7 +1633,7 @@ static int at86rf230_probe(struct spi_device *spi)
 
 	irq_type = irq_get_trigger_type(spi->irq);
 	if (!irq_type)
-		irq_type = IRQF_TRIGGER_RISING;
+		irq_type = IRQF_TRIGGER_HIGH;
 
 	rc = devm_request_irq(&spi->dev, spi->irq, at86rf230_isr,
 			      IRQF_SHARED | irq_type, dev_name(&spi->dev), lp);
-- 
2.4.1

