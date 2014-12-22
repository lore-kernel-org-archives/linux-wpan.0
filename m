Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53783 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726AbaLVWRh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 22 Dec 2014 17:17:37 -0500
From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/3] net: ieee802154: don't use devm_pinctrl_get_select_default() in probe
Date: Mon, 22 Dec 2014 23:16:55 +0100
Message-Id: <1419286616-9893-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1419286616-9893-1-git-send-email-wsa@the-dreams.de>
References: <1419286616-9893-1-git-send-email-wsa@the-dreams.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Since commit ab78029ecc34 (drivers/pinctrl: grab default handles from device
core), we can rely on device core for setting the default pins.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/net/ieee802154/cc2520.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index c2b7da3da183..033473448d9f 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -19,7 +19,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/skbuff.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/of_gpio.h>
 #include <linux/ieee802154.h>
 
@@ -841,7 +840,6 @@ done:
 static int cc2520_probe(struct spi_device *spi)
 {
 	struct cc2520_private *priv;
-	struct pinctrl *pinctrl;
 	struct cc2520_platform_data *pdata;
 	int ret;
 
@@ -854,11 +852,6 @@ static int cc2520_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, priv);
 
-	pinctrl = devm_pinctrl_get_select_default(&spi->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&spi->dev,
-			 "pinctrl pins are not configured\n");
-
 	pdata = cc2520_get_platform_data(spi);
 	if (!pdata) {
 		dev_err(&spi->dev, "no platform data\n");
-- 
2.1.3

