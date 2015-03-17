Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36477 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbCQU0S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 16:26:18 -0400
Received: by wibg7 with SMTP id g7so72910891wib.1
        for <linux-wpan@vger.kernel.org>; Tue, 17 Mar 2015 13:26:17 -0700 (PDT)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCHv3 bluetooth-next 2/2] cc2520: Add support for CC2591 amplifier.
Date: Tue, 17 Mar 2015 16:25:46 -0400
Message-Id: <1426623946-6651-3-git-send-email-bradjc5@gmail.com>
In-Reply-To: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
References: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Brad Campbell <bradjc5@gmail.com>

The TI CC2521 is an RF power amplifier that is designed to interface
with the CC2520. Conveniently, it directly interfaces with the CC2520
and does not require any pins to be connected to a
microcontroller/processor. Adding a CC2591 increases the CC2520's range,
which is useful for border router and other wall-powered applications.

Using the CC2591 with the CC2520 requires configuring the CC2520 GPIOs
that are connected to the CC2591 to correctly set the CC2591 into TX and
RX modes. Further, TI recommends that the CC2520_TXPOWER and
CC2520_AGCCTRL1 registers are set differently to maximize the CC2591's
performance. These settings are covered in TI Application Note AN065.

This patch adds an optional `amplified` field to the cc2520 entry in the
device tree. If present, the CC2520 will be configured to operate with a
CC2591.

The expected pin mapping is:
CC2520 GPIO0 --> CC2591 EN
CC2520 GPIO5 --> CC2591 PAEN

Signed-off-by: Brad Campbell <bradjc5@gmail.com>
---
 .../devicetree/bindings/net/ieee802154/cc2520.txt  |  4 ++
 drivers/net/ieee802154/cc2520.c                    | 55 ++++++++++++++++++----
 include/linux/spi/cc2520.h                         |  1 +
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
index 0071883..fb6d49f 100644
--- a/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
+++ b/Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
@@ -13,11 +13,15 @@ Required properties:
 	- cca-gpio:		GPIO spec for the CCA pin
 	- vreg-gpio:		GPIO spec for the VREG pin
 	- reset-gpio:		GPIO spec for the RESET pin
+Optional properties:
+	- amplified:		include if the CC2520 is connected to a CC2591 amplifier
+
 Example:
 	cc2520@0 {
 		compatible = "ti,cc2520";
 		reg = <0>;
 		spi-max-frequency = <4000000>;
+		amplified;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cc2520_cape_pins>;
 		fifo-gpio = <&gpio1 18 0>;
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 233b6c6..f833b8b 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -738,6 +738,8 @@ static int cc2520_get_platform_data(struct spi_device *spi,
 	pdata->vreg = of_get_named_gpio(np, "vreg-gpio", 0);
 	pdata->reset = of_get_named_gpio(np, "reset-gpio", 0);
 
+	pdata->amplified = of_property_read_bool(np, "amplified");
+
 	return 0;
 }
 
@@ -746,6 +748,11 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 	u8 status = 0, state = 0xff;
 	int ret;
 	int timeout = 100;
+	struct cc2520_platform_data pdata;
+
+	ret = cc2520_get_platform_data(priv->spi, &pdata);
+	if (ret)
+		goto err_ret;
 
 	ret = cc2520_read_register(priv, CC2520_FSMSTAT1, &state);
 	if (ret)
@@ -768,11 +775,47 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 
 	dev_vdbg(&priv->spi->dev, "oscillator brought up\n");
 
-	/* Registers default value: section 28.1 in Datasheet */
-	ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
-	if (ret)
-		goto err_ret;
+	/* If the CC2520 is connected to a CC2591 amplifier, we must both
+	 * configure GPIOs on the CC2520 to correctly configure the CC2591
+	 * and change a couple settings of the CC2520 to work with the
+	 * amplifier. See section 8 page 17 of TI application note AN065.
+	 * http://www.ti.com/lit/an/swra229a/swra229a.pdf
+	 */
+	if (pdata.amplified) {
+		ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF9);
+		if (ret)
+			goto err_ret;
 
+		ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x16);
+		if (ret)
+			goto err_ret;
+
+		ret = cc2520_write_register(priv, CC2520_GPIOCTRL0, 0x46);
+		if (ret)
+			goto err_ret;
+
+		ret = cc2520_write_register(priv, CC2520_GPIOCTRL5, 0x47);
+		if (ret)
+			goto err_ret;
+
+		ret = cc2520_write_register(priv, CC2520_GPIOPOLARITY, 0x1e);
+		if (ret)
+			goto err_ret;
+
+		ret = cc2520_write_register(priv, CC2520_TXCTRL, 0xc1);
+		if (ret)
+			goto err_ret;
+	} else {
+		ret = cc2520_write_register(priv, CC2520_TXPOWER, 0xF7);
+		if (ret)
+			goto err_ret;
+
+		ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x11);
+		if (ret)
+			goto err_ret;
+	}
+
+	/* Registers default value: section 28.1 in Datasheet */
 	ret = cc2520_write_register(priv, CC2520_CCACTRL0, 0x1A);
 	if (ret)
 		goto err_ret;
@@ -797,10 +840,6 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 	if (ret)
 		goto err_ret;
 
-	ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x11);
-	if (ret)
-		goto err_ret;
-
 	ret = cc2520_write_register(priv, CC2520_ADCTEST0, 0x10);
 	if (ret)
 		goto err_ret;
diff --git a/include/linux/spi/cc2520.h b/include/linux/spi/cc2520.h
index 85b8ee6..e741e8b 100644
--- a/include/linux/spi/cc2520.h
+++ b/include/linux/spi/cc2520.h
@@ -21,6 +21,7 @@ struct cc2520_platform_data {
 	int sfd;
 	int reset;
 	int vreg;
+	bool amplified;
 };
 
 #endif
-- 
2.3.2

