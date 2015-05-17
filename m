Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36707 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbEQTpt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:49 -0400
Received: by wizk4 with SMTP id k4so54327606wiz.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:48 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/34] at86rf230: rework tx cca energy detection level
Date: Sun, 17 May 2015 21:44:50 +0200
Message-Id: <1431891910-32231-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch reworks the cca energy detection level handling. This
contains a calculation which works on all transceiver types and
add support for dump cca energy detection levels.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 79 ++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index dff7e47..833c426 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -50,7 +50,6 @@ struct at86rf2xx_chip_data {
 	int rssi_base_val;
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
-	int (*get_desense_steps)(struct at86rf230_local *, s32);
 	int (*set_txpower)(struct at86rf230_local *, s32);
 };
 
@@ -1080,6 +1079,50 @@ at86rf23x_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 	return at86rf230_write_subreg(lp, SR_CHANNEL, channel);
 }
 
+#define AT86RF2XX_MAX_ED_LEVELS 0xF
+static const s32 at86rf23x_ed_levels[AT86RF2XX_MAX_ED_LEVELS + 1] = {
+	-9100, -8900, -8700, -8500, -8300, -8100, -7900, -7700, -7500, -7300,
+	-7100, -6900, -6700, -6500, -6300, -6100,
+};
+
+static const s32 at86rf212_ed_levels_100[AT86RF2XX_MAX_ED_LEVELS + 1] = {
+	-10000, -9800, -9600, -9400, -9200, -9000, -8800, -8600, -8400, -8200,
+	-8000, -7800, -7600, -7400, -7200,
+};
+
+static const s32 at86rf212_ed_levels_98[AT86RF2XX_MAX_ED_LEVELS + 1] = {
+	-9800, -9600, -9400, -9200, -9000, -8800, -8600, -8400, -8200, -8000,
+	-7800, -7600, -7400, -7200, -7000,
+};
+
+static inline int
+at86rf212_update_cca_ed_level(struct at86rf230_local *lp, int rssi_base_val)
+{
+	unsigned int cca_ed_thres;
+	int rc;
+
+	rc = at86rf230_read_subreg(lp, SR_CCA_ED_THRES, &cca_ed_thres);
+	if (rc < 0)
+		return rc;
+
+	switch (rssi_base_val) {
+	case -98:
+		lp->hw->phy->supported.cca_ed_levels = at86rf212_ed_levels_98;
+		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf212_ed_levels_98);
+		lp->hw->phy->cca_ed_level = at86rf212_ed_levels_98[cca_ed_thres];
+		break;
+	case -100:
+		lp->hw->phy->supported.cca_ed_levels = at86rf212_ed_levels_100;
+		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf212_ed_levels_100);
+		lp->hw->phy->cca_ed_level = at86rf212_ed_levels_100[cca_ed_thres];
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	return 0;
+}
+
 static int
 at86rf212_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 {
@@ -1102,6 +1145,10 @@ at86rf212_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 	if (rc < 0)
 		return rc;
 
+	rc = at86rf212_update_cca_ed_level(lp, lp->data->rssi_base_val);
+	if (rc < 0)
+		return rc;
+
 	/* This sets the symbol_duration according frequency on the 212.
 	 * TODO move this handling while set channel and page in cfg802154.
 	 * We can do that, this timings are according 802.15.4 standard.
@@ -1291,29 +1338,19 @@ at86rf230_set_cca_mode(struct ieee802154_hw *hw,
 	return at86rf230_write_subreg(lp, SR_CCA_MODE, val);
 }
 
-static int
-at86rf212_get_desens_steps(struct at86rf230_local *lp, s32 level)
-{
-	return (level - lp->data->rssi_base_val) * 100 / 207;
-}
-
-static int
-at86rf23x_get_desens_steps(struct at86rf230_local *lp, s32 level)
-{
-	return (level - lp->data->rssi_base_val) / 2;
-}
 
 static int
 at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct at86rf230_local *lp = hw->priv;
-	s32 level = mbm / 100;
+	u32 i;
 
-	if (level < lp->data->rssi_base_val || level > 30)
-		return -EINVAL;
+	for (i = 0; i < hw->phy->supported.cca_ed_levels_size; i++) {
+		if (hw->phy->supported.cca_ed_levels[i] == mbm)
+			return at86rf230_write_subreg(lp, SR_CCA_ED_THRES, i);
+	}
 
-	return at86rf230_write_subreg(lp, SR_CCA_ED_THRES,
-				      lp->data->get_desense_steps(lp, level));
+	return -EINVAL;
 }
 
 static int
@@ -1403,7 +1440,6 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps,
 	.set_txpower = at86rf23x_set_txpower,
 };
 
@@ -1417,7 +1453,6 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps,
 	.set_txpower = at86rf23x_set_txpower,
 };
 
@@ -1431,7 +1466,6 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
-	.get_desense_steps = at86rf212_get_desens_steps,
 	.set_txpower = at86rf212_set_txpower,
 };
 
@@ -1618,6 +1652,9 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	lp->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
 		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
 
+	lp->hw->phy->supported.cca_ed_levels = at86rf23x_ed_levels;
+	lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf23x_ed_levels);
+
 	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
 
 	switch (part) {
@@ -1645,6 +1682,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
 		lp->hw->phy->supported.tx_powers = at86rf212_powers;
 		lp->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf212_powers);
+		lp->hw->phy->supported.cca_ed_levels = at86rf212_ed_levels_100;
+		lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf212_ed_levels_100);
 		break;
 	case 11:
 		chip = "at86rf233";
-- 
2.3.7

