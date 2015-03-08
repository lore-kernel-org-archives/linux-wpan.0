Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44540 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbCHIRl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 8 Mar 2015 04:17:41 -0400
Received: by wivr20 with SMTP id r20so12971674wiv.3
        for <linux-wpan@vger.kernel.org>; Sun, 08 Mar 2015 00:17:40 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 2/2] at86rf230: add support for dt or pdata extended addr
Date: Sun,  8 Mar 2015 09:17:23 +0100
Message-Id: <1425802643-5798-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
References: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting the extended address over devicetree
or platform data.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 15 ++++++++++++---
 include/linux/spi/at86rf230.h      |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index edf575c..fc06d83 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -29,6 +29,7 @@
 #include <linux/regmap.h>
 #include <linux/skbuff.h>
 #include <linux/of_gpio.h>
+#include <linux/of_net.h>
 #include <linux/ieee802154.h>
 
 #include <net/mac802154.h>
@@ -1434,7 +1435,7 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 
 static int
 at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr,
-		    u8 *xtal_trim)
+		    u8 *xtal_trim, __le64 *extended_addr)
 {
 	struct at86rf230_platform_data *pdata = spi->dev.platform_data;
 	int ret;
@@ -1446,6 +1447,7 @@ at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr,
 		*rstn = pdata->rstn;
 		*slp_tr = pdata->slp_tr;
 		*xtal_trim = pdata->xtal_trim;
+		*extended_addr = cpu_to_le64(pdata->extended_addr);
 		return 0;
 	}
 
@@ -1455,6 +1457,7 @@ at86rf230_get_pdata(struct spi_device *spi, int *rstn, int *slp_tr,
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
 
+	*extended_addr = of_get_extended_address(spi->dev.of_node);
 	return 0;
 }
 
@@ -1572,6 +1575,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	struct at86rf230_local *lp;
 	unsigned int status;
 	int rc, irq_type, rstn, slp_tr;
+	__le64 extended_addr;
 	u8 xtal_trim = 0;
 
 	if (!spi->irq) {
@@ -1579,7 +1583,8 @@ static int at86rf230_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	rc = at86rf230_get_pdata(spi, &rstn, &slp_tr, &xtal_trim);
+	rc = at86rf230_get_pdata(spi, &rstn, &slp_tr, &xtal_trim,
+				 &extended_addr);
 	if (rc < 0) {
 		dev_err(&spi->dev, "failed to parse platform_data: %d\n", rc);
 		return rc;
@@ -1617,7 +1622,11 @@ static int at86rf230_probe(struct spi_device *spi)
 	lp->spi = spi;
 	hw->parent = &spi->dev;
 	hw->vif_data_size = sizeof(*lp);
-	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
+
+	if (ieee802154_is_valid_extended_addr(extended_addr))
+		hw->phy->perm_extended_addr = extended_addr;
+	else
+		ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
 
 	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
 	if (IS_ERR(lp->regmap)) {
diff --git a/include/linux/spi/at86rf230.h b/include/linux/spi/at86rf230.h
index b63fe6f..094b8b2 100644
--- a/include/linux/spi/at86rf230.h
+++ b/include/linux/spi/at86rf230.h
@@ -23,6 +23,7 @@ struct at86rf230_platform_data {
 	int slp_tr;
 	int dig2;
 	u8 xtal_trim;
+	u64 extended_addr;
 };
 
 #endif
-- 
2.3.0

