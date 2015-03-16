Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36711 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934528AbbCPWRD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 16 Mar 2015 18:17:03 -0400
Received: by wgra20 with SMTP id a20so51274178wgr.3
        for <linux-wpan@vger.kernel.org>; Mon, 16 Mar 2015 15:17:01 -0700 (PDT)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCHv2 1/2] cc2520: Do not store platform_data in spi_device
Date: Mon, 16 Mar 2015 18:16:42 -0400
Message-Id: <1426544203-60585-2-git-send-email-bradjc5@gmail.com>
In-Reply-To: <1426544203-60585-1-git-send-email-bradjc5@gmail.com>
References: <1426544203-60585-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Brad Campbell <bradjc5@gmail.com>

Storing the `platform_data` struct inside of the SPI struct when using
the device tree allows for a later function to edit the content of that
struct. This patch refactors the `cc2520_get_platformat_data` function
to accept a pointer to a `cc2520_platform_data` struct and populates
the fields inside of it.

This changes mirrors a similar change in the at86rf230.c driver.

Signed-off-by: Brad Campbell <bradjc5@gmail.com>
---
 drivers/net/ieee802154/cc2520.c | 93 +++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 181b349..275e6fb 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -714,6 +714,31 @@ static irqreturn_t cc2520_sfd_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int cc2520_get_platform_data(struct spi_device *spi,
+				    struct cc2520_platform_data *pdata)
+{
+	struct device_node *np = spi->dev.of_node;
+	struct cc2520_private *priv = spi_get_drvdata(spi);
+
+	if (!np) {
+		struct cc2520_platform_data *spi_pdata = spi->dev.platform_data;
+		*pdata = *spi_pdata;
+		return 0;
+	}
+
+	pdata->fifo = of_get_named_gpio(np, "fifo-gpio", 0);
+	priv->fifo_pin = pdata->fifo;
+
+	pdata->fifop = of_get_named_gpio(np, "fifop-gpio", 0);
+
+	pdata->sfd = of_get_named_gpio(np, "sfd-gpio", 0);
+	pdata->cca = of_get_named_gpio(np, "cca-gpio", 0);
+	pdata->vreg = of_get_named_gpio(np, "vreg-gpio", 0);
+	pdata->reset = of_get_named_gpio(np, "reset-gpio", 0);
+
+	return 0;
+}
+
 static int cc2520_hw_init(struct cc2520_private *priv)
 {
 	u8 status = 0, state = 0xff;
@@ -808,40 +833,10 @@ err_ret:
 	return ret;
 }
 
-static struct cc2520_platform_data *
-cc2520_get_platform_data(struct spi_device *spi)
-{
-	struct cc2520_platform_data *pdata;
-	struct device_node *np = spi->dev.of_node;
-	struct cc2520_private *priv = spi_get_drvdata(spi);
-
-	if (!np)
-		return spi->dev.platform_data;
-
-	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		goto done;
-
-	pdata->fifo = of_get_named_gpio(np, "fifo-gpio", 0);
-	priv->fifo_pin = pdata->fifo;
-
-	pdata->fifop = of_get_named_gpio(np, "fifop-gpio", 0);
-
-	pdata->sfd = of_get_named_gpio(np, "sfd-gpio", 0);
-	pdata->cca = of_get_named_gpio(np, "cca-gpio", 0);
-	pdata->vreg = of_get_named_gpio(np, "vreg-gpio", 0);
-	pdata->reset = of_get_named_gpio(np, "reset-gpio", 0);
-
-	spi->dev.platform_data = pdata;
-
-done:
-	return pdata;
-}
-
 static int cc2520_probe(struct spi_device *spi)
 {
 	struct cc2520_private *priv;
-	struct cc2520_platform_data *pdata;
+	struct cc2520_platform_data pdata;
 	int ret;
 
 	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
@@ -850,8 +845,8 @@ static int cc2520_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, priv);
 
-	pdata = cc2520_get_platform_data(spi);
-	if (!pdata) {
+	ret = cc2520_get_platform_data(spi, &pdata);
+	if (ret < 0) {
 		dev_err(&spi->dev, "no platform data\n");
 		return -EINVAL;
 	}
@@ -869,76 +864,76 @@ static int cc2520_probe(struct spi_device *spi)
 	init_completion(&priv->tx_complete);
 
 	/* Request all the gpio's */
-	if (!gpio_is_valid(pdata->fifo)) {
+	if (!gpio_is_valid(pdata.fifo)) {
 		dev_err(&spi->dev, "fifo gpio is not valid\n");
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
 
-	ret = devm_gpio_request_one(&spi->dev, pdata->fifo,
+	ret = devm_gpio_request_one(&spi->dev, pdata.fifo,
 				    GPIOF_IN, "fifo");
 	if (ret)
 		goto err_hw_init;
 
-	if (!gpio_is_valid(pdata->cca)) {
+	if (!gpio_is_valid(pdata.cca)) {
 		dev_err(&spi->dev, "cca gpio is not valid\n");
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
 
-	ret = devm_gpio_request_one(&spi->dev, pdata->cca,
+	ret = devm_gpio_request_one(&spi->dev, pdata.cca,
 				    GPIOF_IN, "cca");
 	if (ret)
 		goto err_hw_init;
 
-	if (!gpio_is_valid(pdata->fifop)) {
+	if (!gpio_is_valid(pdata.fifop)) {
 		dev_err(&spi->dev, "fifop gpio is not valid\n");
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
 
-	ret = devm_gpio_request_one(&spi->dev, pdata->fifop,
+	ret = devm_gpio_request_one(&spi->dev, pdata.fifop,
 				    GPIOF_IN, "fifop");
 	if (ret)
 		goto err_hw_init;
 
-	if (!gpio_is_valid(pdata->sfd)) {
+	if (!gpio_is_valid(pdata.sfd)) {
 		dev_err(&spi->dev, "sfd gpio is not valid\n");
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
 
-	ret = devm_gpio_request_one(&spi->dev, pdata->sfd,
+	ret = devm_gpio_request_one(&spi->dev, pdata.sfd,
 				    GPIOF_IN, "sfd");
 	if (ret)
 		goto err_hw_init;
 
-	if (!gpio_is_valid(pdata->reset)) {
+	if (!gpio_is_valid(pdata.reset)) {
 		dev_err(&spi->dev, "reset gpio is not valid\n");
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
 
-	ret = devm_gpio_request_one(&spi->dev, pdata->reset,
+	ret = devm_gpio_request_one(&spi->dev, pdata.reset,
 				    GPIOF_OUT_INIT_LOW, "reset");
 	if (ret)
 		goto err_hw_init;
 
-	if (!gpio_is_valid(pdata->vreg)) {
+	if (!gpio_is_valid(pdata.vreg)) {
 		dev_err(&spi->dev, "vreg gpio is not valid\n");
 		ret = -EINVAL;
 		goto err_hw_init;
 	}
 
-	ret = devm_gpio_request_one(&spi->dev, pdata->vreg,
+	ret = devm_gpio_request_one(&spi->dev, pdata.vreg,
 				    GPIOF_OUT_INIT_LOW, "vreg");
 	if (ret)
 		goto err_hw_init;
 
-	gpio_set_value(pdata->vreg, HIGH);
+	gpio_set_value(pdata.vreg, HIGH);
 	usleep_range(100, 150);
 
-	gpio_set_value(pdata->reset, HIGH);
+	gpio_set_value(pdata.reset, HIGH);
 	usleep_range(200, 250);
 
 	ret = cc2520_hw_init(priv);
@@ -947,7 +942,7 @@ static int cc2520_probe(struct spi_device *spi)
 
 	/* Set up fifop interrupt */
 	ret = devm_request_irq(&spi->dev,
-			       gpio_to_irq(pdata->fifop),
+			       gpio_to_irq(pdata.fifop),
 			       cc2520_fifop_isr,
 			       IRQF_TRIGGER_RISING,
 			       dev_name(&spi->dev),
@@ -959,7 +954,7 @@ static int cc2520_probe(struct spi_device *spi)
 
 	/* Set up sfd interrupt */
 	ret = devm_request_irq(&spi->dev,
-			       gpio_to_irq(pdata->sfd),
+			       gpio_to_irq(pdata.sfd),
 			       cc2520_sfd_isr,
 			       IRQF_TRIGGER_FALLING,
 			       dev_name(&spi->dev),
-- 
2.3.2

