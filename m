Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49466 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaJBJ4a (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:56:30 -0400
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCH linux-wpan v3] ieee802154: mrf24j40: Add support for MRF24J40MC
Date: Thu,  2 Oct 2014 10:55:58 +0100
Message-Id: <1412243758-6901-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, alan@signal11.us, Simon Vincent <simon.vincent@xsilon.com>

The MRF24J40MC module has an external amplifier which should be
enabled. The TX power has to be lowered to meet FCC regs.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
---
v2 -> v3: 
* Added extra code comments and removed check of spi return values.

 drivers/net/ieee802154/mrf24j40.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 07e0b88..ff3ca07 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -43,6 +43,8 @@
 #define REG_TXSTBL   0x2E  /* TX Stabilization */
 #define REG_INTSTAT  0x31  /* Interrupt Status */
 #define REG_INTCON   0x32  /* Interrupt Control */
+#define REG_GPIO     0x33  /* GPIO */
+#define REG_TRISGPIO 0x34  /* GPIO direction */
 #define REG_RFCTL    0x36  /* RF Control Mode Register */
 #define REG_BBREG1   0x39  /* Baseband Registers */
 #define REG_BBREG2   0x3A  /* */
@@ -63,6 +65,7 @@
 #define REG_SLPCON1    0x220
 #define REG_WAKETIMEL  0x222  /* Wake-up Time Match Value Low */
 #define REG_WAKETIMEH  0x223  /* Wake-up Time Match Value High */
+#define REG_TESTMODE   0x22F  /* Test mode */
 #define REG_RX_FIFO    0x300  /* Receive FIFO */
 
 /* Device configuration: Only channels 11-26 on page 0 are supported. */
@@ -75,6 +78,8 @@
 #define RX_FIFO_SIZE 144 /* From datasheet */
 #define SET_CHANNEL_DELAY_US 192 /* From datasheet */
 
+enum mrf24j40_modules { MRF24J40, MRF24J40MA, MRF24J40MC };
+
 /* Device Private Data */
 struct mrf24j40 {
 	struct spi_device *spi;
@@ -691,6 +696,28 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
 	if (ret)
 		goto err_ret;
 
+	if (spi_get_device_id(devrec->spi)->driver_data == MRF24J40MC) {
+		/* Enable external amplifier.
+		 * From MRF24J40MC datasheet section 1.3: Operation.
+		 */
+		write_long_reg(devrec, REG_TESTMODE, &val);
+		val |= 0x7; /* Configure GPIO 0-2 to control amplifier */
+		write_long_reg(devrec, REG_TESTMODE, val);
+
+		read_short_reg(devrec, REG_TRISGPIO, &val);
+		val |= 0x8; /* Set GPIO3 as output. */
+		write_short_reg(devrec, REG_TRISGPIO, val);
+
+		read_short_reg(devrec, REG_GPIO, &val);
+		val |= 0x8; /* Set GPIO3 HIGH to enable U5 voltage regulator */
+		write_short_reg(devrec, REG_GPIO, val);
+
+		/* Reduce TX pwr to meet FCC requirements.
+		 * From MRF24J40MC datasheet section 3.1.1
+		 */
+		write_long_reg(devrec, REG_RFCON3, 0x28);
+	}
+
 	return 0;
 
 err_ret:
@@ -779,8 +806,9 @@ static int mrf24j40_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id mrf24j40_ids[] = {
-	{ "mrf24j40", 0 },
-	{ "mrf24j40ma", 0 },
+	{ "mrf24j40", MRF24J40 },
+	{ "mrf24j40ma", MRF24J40MA },
+	{ "mrf24j40mc", MRF24J40MC },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, mrf24j40_ids);
-- 
1.9.1

