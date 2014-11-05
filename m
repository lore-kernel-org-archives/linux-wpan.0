Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:48933 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaKETwX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:23 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so1758661wgg.36
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:22 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/18] at86rf230: generate random perm extended address
Date: Wed,  5 Nov 2014 20:51:26 +0100
Message-Id: <1415217089-24919-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for a random generated perm extended address for
the at86rf230 driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index bf47785..a6db768 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1534,6 +1534,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	lp->spi = spi;
 	hw->parent = &spi->dev;
 	hw->vif_data_size = sizeof(*lp);
+	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
 
 	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
 	if (IS_ERR(lp->regmap)) {
-- 
2.1.3

