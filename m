Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35355 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756374AbbIUJZV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:21 -0400
Received: by wicge5 with SMTP id ge5so106843273wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 21/22] mrf24j40: change irq trigger type behaviour
Date: Mon, 21 Sep 2015 11:24:42 +0200
Message-Id: <1442827483-27975-22-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch changes the irq trigger type value while calling
devm_request_irq by using IRQF_TRIGGER_LOW when no irq type was given.
Additional we add support for change the irq polarity while hw init if
high level or low level triggered irq type are given.

For rising edge triggered irq's the mrf24j40 can't deal with that, this
races at position of tx completion irq, while the irq is disabled we
readout the irq status registers. This will resets the irq line so other
irq's can occur. Wile readout the irq status register the irq is still
disabled and edge triggered interrupts will be ignored.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 146ad57..9a8d517 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/ieee802154.h>
+#include <linux/irq.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
 
@@ -992,6 +993,7 @@ static irqreturn_t mrf24j40_isr(int irq, void *data)
 
 static int mrf24j40_hw_init(struct mrf24j40 *devrec)
 {
+	u32 irq_type;
 	int ret;
 
 	/* Initialize the device.
@@ -1083,6 +1085,25 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
 		regmap_write(devrec->regmap_long, REG_RFCON3, 0x28);
 	}
 
+	irq_type = irq_get_trigger_type(devrec->spi->irq);
+	if (irq_type == IRQ_TYPE_EDGE_RISING ||
+	    irq_type == IRQ_TYPE_EDGE_FALLING)
+		dev_warn(&devrec->spi->dev,
+			 "Using edge triggered irq's are not recommended, because it can cause races and result in a non-functional driver!\n");
+	switch (irq_type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		/* set interrupt polarity to rising */
+		ret = regmap_update_bits(devrec->regmap_long, REG_SLPCON0,
+					 0x02, 0x02);
+		if (ret)
+			goto err_ret;
+		break;
+	default:
+		/* default is falling edge */
+		break;
+	}
+
 	return 0;
 
 err_ret:
@@ -1182,7 +1203,7 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 
 static int mrf24j40_probe(struct spi_device *spi)
 {
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, irq_type;
 	struct ieee802154_hw *hw;
 	struct mrf24j40 *devrec;
 
@@ -1242,9 +1263,13 @@ static int mrf24j40_probe(struct spi_device *spi)
 
 	mrf24j40_phy_setup(devrec);
 
+	/* request IRQF_TRIGGER_LOW as fallback default */
+	irq_type = irq_get_trigger_type(spi->irq);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_LOW;
+
 	ret = devm_request_irq(&spi->dev, spi->irq, mrf24j40_isr,
-			       IRQF_TRIGGER_LOW, dev_name(&spi->dev),
-			       devrec);
+			       irq_type, dev_name(&spi->dev), devrec);
 	if (ret) {
 		dev_err(printdev(devrec), "Unable to get IRQ");
 		goto err_register_device;
-- 
2.5.2

