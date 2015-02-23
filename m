Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34043 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbBWPGJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 10:06:09 -0500
Received: by mail-wi0-f170.google.com with SMTP id hi2so20387838wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 07:06:07 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: add support for setting external xtal
Date: Mon, 23 Feb 2015 16:05:50 +0100
Message-Id: <1424703950-4066-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting external xtal. This is recommended
by the at86rf230 transceivers to reduce power consuming and for a better
clock source.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 .../bindings/net/ieee802154/at86rf230.txt          |  6 ++++++
 drivers/net/ieee802154/at86rf230.c                 | 25 ++++++++++++++++++++--
 include/linux/spi/at86rf230.h                      |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
index d3bbdded..4d47c2e 100644
--- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
+++ b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
@@ -11,6 +11,10 @@ Required properties:
 Optional properties:
   - reset-gpio:		GPIO spec for the rstn pin
   - sleep-gpio:		GPIO spec for the slp_tr pin
+  - external-xtal:	boolean to use external xtal if present
+  - xtal-trim:		u8 value to fine tuning the internal capacitance
+			arrays of xtal pins. This value should not above 0x0F
+			and only present when external-xtal is enabled
 
 Example:
 
@@ -20,4 +24,6 @@ Example:
 		reg = <0>;
 		interrupts = <19 1>;
 		interrupt-parent = <&gpio3>;
+		external-xtal;
+		xtal-trim = /bits/ 8 <0x06>;
 	};
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index cbfc8c5..1a95520 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1315,7 +1315,8 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.get_desense_steps = at86rf212_get_desens_steps
 };
 
-static int at86rf230_hw_init(struct at86rf230_local *lp)
+static int at86rf230_hw_init(struct at86rf230_local *lp,
+			     const struct at86rf230_platform_data *pdata)
 {
 	int rc, irq_type, irq_pol = IRQ_ACTIVE_HIGH;
 	unsigned int dvdd;
@@ -1362,6 +1363,16 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 	usleep_range(lp->data->t_sleep_cycle,
 		     lp->data->t_sleep_cycle + 100);
 
+	if (pdata->xtal) {
+		rc = at86rf230_write_subreg(lp, SR_XTAL_TRIM, pdata->xtal_trim);
+		if (rc)
+			return rc;
+
+		rc = at86rf230_write_subreg(lp, SR_XTAL_MODE, 0x5);
+		if (rc)
+			return rc;
+	}
+
 	rc = at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
 	if (rc)
 		return rc;
@@ -1392,6 +1403,16 @@ at86rf230_get_pdata(struct spi_device *spi)
 	pdata->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
 	pdata->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
 
+	pdata->xtal = of_property_read_bool(spi->dev.of_node, "external-xtal");
+	if (pdata->xtal) {
+		int ret;
+
+		ret = of_property_read_u8(spi->dev.of_node, "xtal-trim",
+					  &pdata->xtal_trim);
+		if (ret < 0 || pdata->xtal_trim > 0xF)
+			return NULL;
+	}
+
 	spi->dev.platform_data = pdata;
 done:
 	return pdata;
@@ -1571,7 +1592,7 @@ static int at86rf230_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, lp);
 
-	rc = at86rf230_hw_init(lp);
+	rc = at86rf230_hw_init(lp, pdata);
 	if (rc)
 		goto free_dev;
 
diff --git a/include/linux/spi/at86rf230.h b/include/linux/spi/at86rf230.h
index cd519a1..632ad90 100644
--- a/include/linux/spi/at86rf230.h
+++ b/include/linux/spi/at86rf230.h
@@ -22,6 +22,8 @@ struct at86rf230_platform_data {
 	int rstn;
 	int slp_tr;
 	int dig2;
+	bool xtal;
+	u8 xtal_trim;
 };
 
 #endif
-- 
2.3.0

