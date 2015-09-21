Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33754 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369AbbIUJZS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:18 -0400
Received: by wiclk2 with SMTP id lk2so136958248wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 18/22] mrf24j40: add cca ed level support
Date: Mon, 21 Sep 2015 11:24:39 +0200
Message-Id: <1442827483-27975-19-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch supports handling to set the cca energy detection level for
the mrf24j40 transceiver.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 50 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 086eee0..c23936e 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -822,6 +822,48 @@ static int mrf24j40_set_cca_mode(struct ieee802154_hw *hw,
 				  val << 6);
 }
 
+/* array for representing ed levels */
+static const s32 mrf24j40_ed_levels[] = {
+	-9000, -8900, -8800, -8700, -8600, -8500, -8400, -8300, -8200, -8100,
+	-8000, -7900, -7800, -7700, -7600, -7500, -7400, -7300, -7200, -7100,
+	-7000, -6900, -6800, -6700, -6600, -6500, -6400, -6300, -6200, -6100,
+	-6000, -5900, -5800, -5700, -5600, -5500, -5400, -5300, -5200, -5100,
+	-5000, -4900, -4800, -4700, -4600, -4500, -4400, -4300, -4200, -4100,
+	-4000, -3900, -3800, -3700, -3600, -3500
+};
+
+/* map ed levels to register value */
+static const s32 mrf24j40_ed_levels_map[][2] = {
+	{ -9000, 0 }, { -8900, 1 }, { -8800, 2 }, { -8700, 5 }, { -8600, 9 },
+	{ -8500, 13 }, { -8400, 18 }, { -8300, 23 }, { -8200, 27 },
+	{ -8100, 32 }, { -8000, 37 }, { -7900, 43 }, { -7800, 48 },
+	{ -7700, 53 }, { -7600, 58 }, { -7500, 63 }, { -7400, 68 },
+	{ -7300, 73 }, { -7200, 78 }, { -7100, 83 }, { -7000, 89 },
+	{ -6900, 95 }, { -6800, 100 }, { -6700, 107 }, { -6600, 111 },
+	{ -6500, 117 }, { -6400, 121 }, { -6300, 125 }, { -6200, 129 },
+	{ -6100, 133 },	{ -6000, 138 }, { -5900, 143 }, { -5800, 148 },
+	{ -5700, 153 }, { -5600, 159 },	{ -5500, 165 }, { -5400, 170 },
+	{ -5300, 176 }, { -5200, 183 }, { -5100, 188 }, { -5000, 193 },
+	{ -4900, 198 }, { -4800, 203 }, { -4700, 207 }, { -4600, 212 },
+	{ -4500, 216 }, { -4400, 221 }, { -4300, 225 }, { -4200, 228 },
+	{ -4100, 233 }, { -4000, 239 }, { -3900, 245 }, { -3800, 250 },
+	{ -3700, 253 }, { -3600, 254 }, { -3500, 255 },
+};
+
+static int mrf24j40_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct mrf24j40 *devrec = hw->priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mrf24j40_ed_levels_map); i++) {
+		if (mrf24j40_ed_levels_map[i][0] == mbm)
+			return regmap_write(devrec->regmap_short, REG_CCAEDTH,
+					    mrf24j40_ed_levels_map[i][1]);
+	}
+
+	return -EINVAL;
+}
+
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = mrf24j40_tx,
@@ -832,6 +874,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
 	.set_hw_addr_filt = mrf24j40_filter,
 	.set_csma_params = mrf24j40_csma_params,
 	.set_cca_mode = mrf24j40_set_cca_mode,
+	.set_cca_ed_level = mrf24j40_set_cca_ed_level,
 };
 
 static void mrf24j40_intstat_complete(void *context)
@@ -1041,6 +1084,10 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 					       BIT(NL802154_CCA_CARRIER) |
 					       BIT(NL802154_CCA_ENERGY_CARRIER);
 	devrec->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND);
+
+	devrec->hw->phy->cca_ed_level = -6900;
+	devrec->hw->phy->supported.cca_ed_levels = mrf24j40_ed_levels;
+	devrec->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(mrf24j40_ed_levels);
 }
 
 static int mrf24j40_probe(struct spi_device *spi)
@@ -1066,7 +1113,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
 			    IEEE802154_HW_CSMA_PARAMS;
 
-	devrec->hw->phy->flags = WPAN_PHY_FLAG_CCA_MODE;
+	devrec->hw->phy->flags = WPAN_PHY_FLAG_CCA_MODE |
+				 WPAN_PHY_FLAG_CCA_ED_LEVEL;
 
 	mrf24j40_setup_tx_spi_messages(devrec);
 	mrf24j40_setup_rx_spi_messages(devrec);
-- 
2.5.2

