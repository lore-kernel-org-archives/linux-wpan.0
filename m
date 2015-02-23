Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:38625 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbBWT35 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 14:29:57 -0500
Received: by wesw55 with SMTP id w55so20817761wes.5
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 11:29:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/2] at86rf230: copy pdata to driver allocated space
Date: Mon, 23 Feb 2015 20:29:43 +0100
Message-Id: <1424719784-15012-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch copies the platform data in driver allocated space at first.
With this change we ensure that we access the allocated platform data as
readonly space.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ieee802154/at86rf230.c | 49 ++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index cbfc8c5..c495f23 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1377,24 +1377,21 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 	return at86rf230_write_subreg(lp, SR_SLOTTED_OPERATION, 0);
 }
 
-static struct at86rf230_platform_data *
-at86rf230_get_pdata(struct spi_device *spi)
+static int at86rf230_get_pdata(struct spi_device *spi,
+			       struct at86rf230_platform_data *cfg)
 {
-	struct at86rf230_platform_data *pdata;
+	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node) {
+		if (!spi->dev.platform_data)
+			return -ENOENT;
 
-	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node)
-		return spi->dev.platform_data;
-
-	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		goto done;
+		memcpy(cfg, spi->dev.platform_data, sizeof(*cfg));
+		return 0;
+	}
 
-	pdata->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
-	pdata->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
+	cfg->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
+	cfg->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
 
-	spi->dev.platform_data = pdata;
-done:
-	return pdata;
+	return 0;
 }
 
 static int
@@ -1501,7 +1498,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 
 static int at86rf230_probe(struct spi_device *spi)
 {
-	struct at86rf230_platform_data *pdata;
+	struct at86rf230_platform_data cfg;
 	struct ieee802154_hw *hw;
 	struct at86rf230_local *lp;
 	unsigned int status;
@@ -1512,32 +1509,32 @@ static int at86rf230_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	pdata = at86rf230_get_pdata(spi);
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform_data\n");
-		return -EINVAL;
+	rc = at86rf230_get_pdata(spi, &cfg);
+	if (rc < 0) {
+		dev_err(&spi->dev, "failed to parse platform_data: %d\n", rc);
+		return rc;
 	}
 
-	if (gpio_is_valid(pdata->rstn)) {
-		rc = devm_gpio_request_one(&spi->dev, pdata->rstn,
+	if (gpio_is_valid(cfg.rstn)) {
+		rc = devm_gpio_request_one(&spi->dev, cfg.rstn,
 					   GPIOF_OUT_INIT_HIGH, "rstn");
 		if (rc)
 			return rc;
 	}
 
-	if (gpio_is_valid(pdata->slp_tr)) {
-		rc = devm_gpio_request_one(&spi->dev, pdata->slp_tr,
+	if (gpio_is_valid(cfg.slp_tr)) {
+		rc = devm_gpio_request_one(&spi->dev, cfg.slp_tr,
 					   GPIOF_OUT_INIT_LOW, "slp_tr");
 		if (rc)
 			return rc;
 	}
 
 	/* Reset */
-	if (gpio_is_valid(pdata->rstn)) {
+	if (gpio_is_valid(cfg.rstn)) {
 		udelay(1);
-		gpio_set_value(pdata->rstn, 0);
+		gpio_set_value(cfg.rstn, 0);
 		udelay(1);
-		gpio_set_value(pdata->rstn, 1);
+		gpio_set_value(cfg.rstn, 1);
 		usleep_range(120, 240);
 	}
 
-- 
2.3.0

