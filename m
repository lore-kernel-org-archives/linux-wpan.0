Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37699 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbbIUJZH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:07 -0400
Received: by wicfx3 with SMTP id fx3so102105613wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/22] mrf24j40: add regmap support
Date: Mon, 21 Sep 2015 11:24:30 +0200
Message-Id: <1442827483-27975-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch introduce regmap support for short and long address space of
mrf24j40. It's only possible to use regmap_read/write/update_bits for
long address range. This is because I added lowlevel bus operation
because the write operation need to set the 12th bit to mark a register
write, but regmap only supports to set bits for register write access in
the first byte. We use other regmap register functions than
read/write/update_bits, so this should be fine.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/Kconfig    |   1 +
 drivers/net/ieee802154/mrf24j40.c | 312 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 313 insertions(+)

diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
index 5a614b2..ce5f1a2 100644
--- a/drivers/net/ieee802154/Kconfig
+++ b/drivers/net/ieee802154/Kconfig
@@ -43,6 +43,7 @@ config IEEE802154_MRF24J40
 	tristate "Microchip MRF24J40 transceiver driver"
 	depends on IEEE802154_DRIVERS && MAC802154
 	depends on SPI
+	select REGMAP_SPI
 	---help---
 	  Say Y here to enable the MRF24J20 SPI 802.15.4 wireless
 	  controller.
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 12f0606..c8b7ce6 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -18,6 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/ieee802154.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
@@ -149,11 +150,22 @@ struct mrf24j40 {
 	struct spi_device *spi;
 	struct ieee802154_hw *hw;
 
+	struct regmap *regmap_short;
+	struct regmap *regmap_long;
 	struct mutex buffer_mutex; /* only used to protect buf */
 	struct completion tx_complete;
 	u8 *buf; /* 3 bytes. Used for SPI single-register transfers. */
 };
 
+/* regmap information for short address register access */
+#define MRF24J40_SHORT_WRITE	0x01
+#define MRF24J40_SHORT_READ	0x00
+#define MRF24J40_SHORT_NUMREGS	0x3F
+
+/* regmap information for long address register access */
+#define MRF24J40_LONG_ACCESS	0x80
+#define MRF24J40_LONG_NUMREGS	0x38F
+
 /* Read/Write SPI Commands for Short and Long Address registers. */
 #define MRF24J40_READSHORT(reg) ((reg) << 1)
 #define MRF24J40_WRITESHORT(reg) ((reg) << 1 | 1)
@@ -165,6 +177,287 @@ struct mrf24j40 {
 
 #define printdev(X) (&X->spi->dev)
 
+static bool
+mrf24j40_short_reg_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_RXMCR:
+	case REG_PANIDL:
+	case REG_PANIDH:
+	case REG_SADRL:
+	case REG_SADRH:
+	case REG_EADR0:
+	case REG_EADR1:
+	case REG_EADR2:
+	case REG_EADR3:
+	case REG_EADR4:
+	case REG_EADR5:
+	case REG_EADR6:
+	case REG_EADR7:
+	case REG_RXFLUSH:
+	case REG_ORDER:
+	case REG_TXMCR:
+	case REG_ACKTMOUT:
+	case REG_ESLOTG1:
+	case REG_SYMTICKL:
+	case REG_SYMTICKH:
+	case REG_PACON0:
+	case REG_PACON1:
+	case REG_PACON2:
+	case REG_TXBCON0:
+	case REG_TXNCON:
+	case REG_TXG1CON:
+	case REG_TXG2CON:
+	case REG_ESLOTG23:
+	case REG_ESLOTG45:
+	case REG_ESLOTG67:
+	case REG_TXPEND:
+	case REG_WAKECON:
+	case REG_FROMOFFSET:
+	case REG_TXBCON1:
+	case REG_GATECLK:
+	case REG_TXTIME:
+	case REG_HSYMTMRL:
+	case REG_HSYMTMRH:
+	case REG_SOFTRST:
+	case REG_SECCON0:
+	case REG_SECCON1:
+	case REG_TXSTBL:
+	case REG_RXSR:
+	case REG_INTCON:
+	case REG_TRISGPIO:
+	case REG_GPIO:
+	case REG_RFCTL:
+	case REG_SLPACK:
+	case REG_BBREG0:
+	case REG_BBREG1:
+	case REG_BBREG2:
+	case REG_BBREG3:
+	case REG_BBREG4:
+	case REG_BBREG6:
+	case REG_CCAEDTH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool
+mrf24j40_short_reg_readable(struct device *dev, unsigned int reg)
+{
+	bool rc;
+
+	/* all writeable are also readable */
+	rc = mrf24j40_short_reg_writeable(dev, reg);
+	if (rc)
+		return rc;
+
+	/* readonly regs */
+	switch (reg) {
+	case REG_TXSTAT:
+	case REG_INTSTAT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool
+mrf24j40_short_reg_volatile(struct device *dev, unsigned int reg)
+{
+	/* can be changed during runtime */
+	switch (reg) {
+	case REG_TXSTAT:
+	case REG_INTSTAT:
+	case REG_RXFLUSH:
+	case REG_TXNCON:
+	case REG_SOFTRST:
+	case REG_RFCTL:
+	case REG_TXBCON0:
+	case REG_TXG1CON:
+	case REG_TXG2CON:
+	case REG_TXBCON1:
+	case REG_SECCON0:
+	case REG_RXSR:
+	case REG_SLPACK:
+	case REG_SECCR2:
+	case REG_BBREG6:
+	/* use them in spi_async and regmap so it's volatile */
+	case REG_BBREG1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool
+mrf24j40_short_reg_precious(struct device *dev, unsigned int reg)
+{
+	/* don't clear irq line on read */
+	switch (reg) {
+	case REG_INTSTAT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config mrf24j40_short_regmap = {
+	.name = "mrf24j40_short",
+	.reg_bits = 7,
+	.val_bits = 8,
+	.pad_bits = 1,
+	.write_flag_mask = MRF24J40_SHORT_WRITE,
+	.read_flag_mask = MRF24J40_SHORT_READ,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = MRF24J40_SHORT_NUMREGS,
+	.writeable_reg = mrf24j40_short_reg_writeable,
+	.readable_reg = mrf24j40_short_reg_readable,
+	.volatile_reg = mrf24j40_short_reg_volatile,
+	.precious_reg = mrf24j40_short_reg_precious,
+};
+
+static bool
+mrf24j40_long_reg_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_RFCON0:
+	case REG_RFCON1:
+	case REG_RFCON2:
+	case REG_RFCON3:
+	case REG_RFCON5:
+	case REG_RFCON6:
+	case REG_RFCON7:
+	case REG_RFCON8:
+	case REG_SLPCAL2:
+	case REG_SLPCON0:
+	case REG_SLPCON1:
+	case REG_WAKETIMEL:
+	case REG_WAKETIMEH:
+	case REG_REMCNTL:
+	case REG_REMCNTH:
+	case REG_MAINCNT0:
+	case REG_MAINCNT1:
+	case REG_MAINCNT2:
+	case REG_MAINCNT3:
+	case REG_TESTMODE:
+	case REG_ASSOEAR0:
+	case REG_ASSOEAR1:
+	case REG_ASSOEAR2:
+	case REG_ASSOEAR3:
+	case REG_ASSOEAR4:
+	case REG_ASSOEAR5:
+	case REG_ASSOEAR6:
+	case REG_ASSOEAR7:
+	case REG_ASSOSAR0:
+	case REG_ASSOSAR1:
+	case REG_UNONCE0:
+	case REG_UNONCE1:
+	case REG_UNONCE2:
+	case REG_UNONCE3:
+	case REG_UNONCE4:
+	case REG_UNONCE5:
+	case REG_UNONCE6:
+	case REG_UNONCE7:
+	case REG_UNONCE8:
+	case REG_UNONCE9:
+	case REG_UNONCE10:
+	case REG_UNONCE11:
+	case REG_UNONCE12:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool
+mrf24j40_long_reg_readable(struct device *dev, unsigned int reg)
+{
+	bool rc;
+
+	/* all writeable are also readable */
+	rc = mrf24j40_long_reg_writeable(dev, reg);
+	if (rc)
+		return rc;
+
+	/* readonly regs */
+	switch (reg) {
+	case REG_SLPCAL0:
+	case REG_SLPCAL1:
+	case REG_RFSTATE:
+	case REG_RSSI:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool
+mrf24j40_long_reg_volatile(struct device *dev, unsigned int reg)
+{
+	/* can be changed during runtime */
+	switch (reg) {
+	case REG_SLPCAL0:
+	case REG_SLPCAL1:
+	case REG_SLPCAL2:
+	case REG_RFSTATE:
+	case REG_RSSI:
+	case REG_MAINCNT3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config mrf24j40_long_regmap = {
+	.name = "mrf24j40_long",
+	.reg_bits = 11,
+	.val_bits = 8,
+	.pad_bits = 5,
+	.write_flag_mask = MRF24J40_LONG_ACCESS,
+	.read_flag_mask = MRF24J40_LONG_ACCESS,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = MRF24J40_LONG_NUMREGS,
+	.writeable_reg = mrf24j40_long_reg_writeable,
+	.readable_reg = mrf24j40_long_reg_readable,
+	.volatile_reg = mrf24j40_long_reg_volatile,
+};
+
+static int mrf24j40_long_regmap_write(void *context, const void *data,
+				      size_t count)
+{
+	struct spi_device *spi = context;
+	u8 buf[3];
+
+	if (count > 3)
+		return -EINVAL;
+
+	/* regmap supports read/write mask only in frist byte
+	 * long write access need to set the 12th bit, so we
+	 * make special handling for write.
+	 */
+	memcpy(buf, data, count);
+	buf[1] |= (1 << 4);
+
+	return spi_write(spi, buf, count);
+}
+
+static int
+mrf24j40_long_regmap_read(void *context, const void *reg, size_t reg_size,
+			  void *val, size_t val_size)
+{
+	struct spi_device *spi = context;
+
+	return spi_write_then_read(spi, reg, reg_size, val, val_size);
+}
+
+static const struct regmap_bus mrf24j40_long_regmap_bus = {
+	.write = mrf24j40_long_regmap_write,
+	.read = mrf24j40_long_regmap_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
 static int write_short_reg(struct mrf24j40 *devrec, u8 reg, u8 value)
 {
 	int ret;
@@ -816,6 +1109,25 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
 	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
 
+	devrec->regmap_short = devm_regmap_init_spi(spi,
+						    &mrf24j40_short_regmap);
+	if (IS_ERR(devrec->regmap_short)) {
+		ret = PTR_ERR(devrec->regmap_short);
+		dev_err(&spi->dev, "Failed to allocate short register map: %d\n",
+			ret);
+		goto err_register_device;
+	}
+
+	devrec->regmap_long = devm_regmap_init(&spi->dev,
+					       &mrf24j40_long_regmap_bus,
+					       spi, &mrf24j40_long_regmap);
+	if (IS_ERR(devrec->regmap_long)) {
+		ret = PTR_ERR(devrec->regmap_long);
+		dev_err(&spi->dev, "Failed to allocate long register map: %d\n",
+			ret);
+		goto err_register_device;
+	}
+
 	devrec->buf = devm_kzalloc(&spi->dev, 3, GFP_KERNEL);
 	if (!devrec->buf)
 		goto err_register_device;
-- 
2.5.2

