Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33657 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbH0Ttj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 15:49:39 -0400
Received: by wicge2 with SMTP id ge2so3123508wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 12:49:38 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/4] at86rf230: detailed edge triggered irq warning
Date: Thu, 27 Aug 2015 21:49:20 +0200
Message-Id: <1440704960-10515-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
References: <1440704960-10515-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce a more detailed information why edge triggered
irq's are currently not recommended. It could be that rising/falling
edge detection can happen while the irq is disabled.

Suggested-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 19c16b9..b8b0628 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1376,7 +1376,7 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 	if (irq_type == IRQ_TYPE_EDGE_RISING ||
 	    irq_type == IRQ_TYPE_EDGE_FALLING)
 		dev_warn(&lp->spi->dev,
-			 "Using edge triggered irq's are not recommended!\n");
+			 "Using edge triggered irq's are not recommended, because it can cause races and result in a non-functional driver!\n");
 	if (irq_type == IRQ_TYPE_EDGE_FALLING ||
 	    irq_type == IRQ_TYPE_LEVEL_LOW)
 		irq_pol = IRQ_ACTIVE_LOW;
-- 
2.5.0

