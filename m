Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:38483 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbbB0I7Z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Feb 2015 03:59:25 -0500
Received: by wgha1 with SMTP id a1so18548299wgh.5
        for <linux-wpan@vger.kernel.org>; Fri, 27 Feb 2015 00:59:24 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv5 bluetooth-next 5/6] at86rf230: add irq low-level for polarity
Date: Fri, 27 Feb 2015 09:58:29 +0100
Message-Id: <1425027510-2672-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
References: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The at86rf2xx chips supports the setting of irq polarity if active low
or active high. This patch adds a handling for IRQ_ACTIVE_LOW if the
irq_type is IRQ_TYPE_LEVEL_LOW.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index e6dec0a..c7a30ce 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1321,7 +1321,8 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 		return rc;
 
 	irq_type = irq_get_trigger_type(lp->spi->irq);
-	if (irq_type == IRQ_TYPE_EDGE_FALLING)
+	if (irq_type == IRQ_TYPE_EDGE_FALLING ||
+	    irq_type == IRQ_TYPE_LEVEL_LOW)
 		irq_pol = IRQ_ACTIVE_LOW;
 
 	rc = at86rf230_write_subreg(lp, SR_IRQ_POLARITY, irq_pol);
-- 
2.3.0

