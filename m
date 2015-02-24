Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:44102 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbBXPzN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 10:55:13 -0500
Received: by wesk11 with SMTP id k11so26019116wes.11
        for <linux-wpan@vger.kernel.org>; Tue, 24 Feb 2015 07:55:11 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv4 bluetooth-next 1/2] at86rf230: copy pdata to driver allocated space
Date: Tue, 24 Feb 2015 16:55:00 +0100
Message-Id: <1424793301-29931-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
References: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
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
 drivers/net/ieee802154/at86rf230.c | 51 +++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index cbfc8c5..9888b7f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1377,24 +1377,24 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 	return at86rf230_write_subreg(lp, SR_SLOTTED_OPERATION, 0);
 }
 
-static struct at86rf230_platform_data *
-at86rf230_get_pdata(struct spi_device *spi)
+static int
+at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr)
 {
-	struct at86rf230_platform_data *pdata;
+	struct at86rf230_platform_data *pdata = spi->dev.platform_data;
 
-	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node)
-		return spi->dev.platform_data;
+	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node) {
+		if (!pdata)
+			return -ENOENT;
 
-	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		goto done;
+		*rstn = pdata->rstn;
+		*slp_tr = pdata->slp_tr;
+		return 0;
+	}
 
-	pdata->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
-	pdata->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
+	*rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
+	*slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
 
-	spi->dev.platform_data = pdata;
-done:
-	return pdata;
+	return 0;
 }
 
 static int
@@ -1501,43 +1501,42 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 
 static int at86rf230_probe(struct spi_device *spi)
 {
-	struct at86rf230_platform_data *pdata;
 	struct ieee802154_hw *hw;
 	struct at86rf230_local *lp;
 	unsigned int status;
-	int rc, irq_type;
+	int rc, irq_type, rstn, slp_tr;
 
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ specified\n");
 		return -EINVAL;
 	}
 
-	pdata = at86rf230_get_pdata(spi);
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform_data\n");
-		return -EINVAL;
+	rc = at86rf230_get_pdata(spi, &rstn, &slp_tr);
+	if (rc < 0) {
+		dev_err(&spi->dev, "failed to parse platform_data: %d\n", rc);
+		return rc;
 	}
 
-	if (gpio_is_valid(pdata->rstn)) {
-		rc = devm_gpio_request_one(&spi->dev, pdata->rstn,
+	if (gpio_is_valid(rstn)) {
+		rc = devm_gpio_request_one(&spi->dev, rstn,
 					   GPIOF_OUT_INIT_HIGH, "rstn");
 		if (rc)
 			return rc;
 	}
 
-	if (gpio_is_valid(pdata->slp_tr)) {
-		rc = devm_gpio_request_one(&spi->dev, pdata->slp_tr,
+	if (gpio_is_valid(slp_tr)) {
+		rc = devm_gpio_request_one(&spi->dev, slp_tr,
 					   GPIOF_OUT_INIT_LOW, "slp_tr");
 		if (rc)
 			return rc;
 	}
 
 	/* Reset */
-	if (gpio_is_valid(pdata->rstn)) {
+	if (gpio_is_valid(rstn)) {
 		udelay(1);
-		gpio_set_value(pdata->rstn, 0);
+		gpio_set_value(rstn, 0);
 		udelay(1);
-		gpio_set_value(pdata->rstn, 1);
+		gpio_set_value(rstn, 1);
 		usleep_range(120, 240);
 	}
 
-- 
2.3.0

