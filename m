Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38477 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbHMMXi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:38 -0400
Received: by wicja10 with SMTP id ja10so67749941wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:37 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 19/21] mrf24j40: add tx power support
Date: Thu, 13 Aug 2015 14:22:46 +0200
Message-Id: <1439468568-22288-20-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch supports setting of transmit power for the mrf24j40ma
transceiver only. The mrf24j40mc has some amplifier to change the
transmit power, I am currently not sure how the mapping for this
amplifier looks like.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 00fd97e..e9a03fd 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -863,6 +863,65 @@ static int mrf24j40_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 	return -EINVAL;
 }
 
+static const s32 mrf24j40ma_powers[] = {
+	0, -50, -120, -190, -280, -370, -490, -630, -1000, -1050, -1120, -1190,
+	-1280, -1370, -1490, -1630, -2000, -2050, -2120, -2190, -2280, -2370,
+	-2490, -2630, -3000, -3050, -3120, -3190, -3280, -3370, -3490, -3630,
+};
+
+static int mrf24j40_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct mrf24j40 *devrec = hw->priv;
+	s32 small_scale;
+	u8 val;
+
+	if (0 >= mbm && mbm > -1000) {
+		val = 0;
+		small_scale = mbm;
+	} else if (-1000 >= mbm && mbm > -2000) {
+		val = 0x40;
+		small_scale = mbm + 1000;
+	} else if (-2000 >= mbm && mbm > -3000) {
+		val = 0x80;
+		small_scale = mbm + 2000;
+	} else if (-3000 >= mbm && mbm > -4000) {
+		val = 0xc0;
+		small_scale = mbm + 3000;
+	} else {
+		return -EINVAL;
+	}
+
+	switch (small_scale) {
+	case 0:
+		break;
+	case -50:
+		val |= 0x08;
+		break;
+	case -120:
+		val |= 0x10;
+		break;
+	case -190:
+		val |= 0x18;
+		break;
+	case -280:
+		val |= 0x20;
+		break;
+	case -370:
+		val |= 0x28;
+		break;
+	case -490:
+		val |= 0x30;
+		break;
+	case -630:
+		val |= 0x38;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(devrec->regmap_long, REG_RFCON3, 0xf8, val);
+}
+
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = mrf24j40_tx,
@@ -874,6 +933,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
 	.set_csma_params = mrf24j40_csma_params,
 	.set_cca_mode = mrf24j40_set_cca_mode,
 	.set_cca_ed_level = mrf24j40_set_cca_ed_level,
+	.set_txpower = mrf24j40_set_txpower,
 };
 
 static void mrf24j40_intstat_complete(void *context)
@@ -1085,6 +1145,16 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 	devrec->hw->phy->cca_ed_level = -6900;
 	devrec->hw->phy->supported.cca_ed_levels = mrf24j40_ed_levels;
 	devrec->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(mrf24j40_ed_levels);
+
+	switch (spi_get_device_id(devrec->spi)->driver_data) {
+	case MRF24J40MA:
+		devrec->hw->phy->supported.tx_powers = mrf24j40ma_powers;
+		devrec->hw->phy->supported.tx_powers_size = ARRAY_SIZE(mrf24j40ma_powers);
+		devrec->hw->phy->flags |= WPAN_PHY_FLAG_TXPOWER;
+		break;
+	default:
+		break;
+	}
 }
 
 static int mrf24j40_probe(struct spi_device *spi)
-- 
2.5.0

