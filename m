Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40771 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbBXPzO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 10:55:14 -0500
Received: by mail-wi0-f169.google.com with SMTP id em10so28161908wid.0
        for <linux-wpan@vger.kernel.org>; Tue, 24 Feb 2015 07:55:13 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv4 bluetooth-next 2/2] at86rf230: add support for external xtal trim
Date: Tue, 24 Feb 2015 16:55:01 +0100
Message-Id: <1424793301-29931-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
References: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting the xtal trim register. Some at86rf2xx
transceiver boards needs fine tuning the xtal capacitor.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 .../devicetree/bindings/net/ieee802154/at86rf230.txt  |  3 +++
 drivers/net/ieee802154/at86rf230.c                    | 19 +++++++++++++++----
 include/linux/spi/at86rf230.h                         |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
index d3bbdded..1ae5100 100644
--- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
+++ b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
@@ -11,6 +11,8 @@ Required properties:
 Optional properties:
   - reset-gpio:		GPIO spec for the rstn pin
   - sleep-gpio:		GPIO spec for the slp_tr pin
+  - xtal-trim:		u8 value for fine tuning the internal capacitance
+			arrays of xtal pins: 0 = +0 pF, 0xf = +4.5 pF
 
 Example:
 
@@ -20,4 +22,5 @@ Example:
 		reg = <0>;
 		interrupts = <19 1>;
 		interrupt-parent = <&gpio3>;
+		xtal-trim = /bits/ 8 <0x06>;
 	};
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9888b7f..266e67e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1315,7 +1315,7 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.get_desense_steps = at86rf212_get_desens_steps
 };
 
-static int at86rf230_hw_init(struct at86rf230_local *lp)
+static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 {
 	int rc, irq_type, irq_pol = IRQ_ACTIVE_HIGH;
 	unsigned int dvdd;
@@ -1362,6 +1362,10 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 	usleep_range(lp->data->t_sleep_cycle,
 		     lp->data->t_sleep_cycle + 100);
 
+	rc = at86rf230_write_subreg(lp, SR_XTAL_TRIM, xtal_trim);
+	if (rc)
+		return rc;
+
 	rc = at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
 	if (rc)
 		return rc;
@@ -1378,9 +1382,11 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 }
 
 static int
-at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr)
+at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr,
+		    u8 *xtal_trim)
 {
 	struct at86rf230_platform_data *pdata = spi->dev.platform_data;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node) {
 		if (!pdata)
@@ -1388,11 +1394,15 @@ at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr)
 
 		*rstn = pdata->rstn;
 		*slp_tr = pdata->slp_tr;
+		*xtal_trim = pdata->xtal_trim;
 		return 0;
 	}
 
 	*rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
 	*slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
+	ret = of_property_read_u8(spi->dev.of_node, "xtal-trim", xtal_trim);
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
 
 	return 0;
 }
@@ -1505,13 +1515,14 @@ static int at86rf230_probe(struct spi_device *spi)
 	struct at86rf230_local *lp;
 	unsigned int status;
 	int rc, irq_type, rstn, slp_tr;
+	u8 xtal_trim;
 
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ specified\n");
 		return -EINVAL;
 	}
 
-	rc = at86rf230_get_pdata(spi, &rstn, &slp_tr);
+	rc = at86rf230_get_pdata(spi, &rstn, &slp_tr, &xtal_trim);
 	if (rc < 0) {
 		dev_err(&spi->dev, "failed to parse platform_data: %d\n", rc);
 		return rc;
@@ -1570,7 +1581,7 @@ static int at86rf230_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, lp);
 
-	rc = at86rf230_hw_init(lp);
+	rc = at86rf230_hw_init(lp, xtal_trim);
 	if (rc)
 		goto free_dev;
 
diff --git a/include/linux/spi/at86rf230.h b/include/linux/spi/at86rf230.h
index cd519a1..b63fe6f 100644
--- a/include/linux/spi/at86rf230.h
+++ b/include/linux/spi/at86rf230.h
@@ -22,6 +22,7 @@ struct at86rf230_platform_data {
 	int rstn;
 	int slp_tr;
 	int dig2;
+	u8 xtal_trim;
 };
 
 #endif
-- 
2.3.0

