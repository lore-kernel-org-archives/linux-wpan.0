Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36696 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbEQTps (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:48 -0400
Received: by wizk4 with SMTP id k4so54327300wiz.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/34] at86rf230: rework tx power support
Date: Sun, 17 May 2015 21:44:49 +0200
Message-Id: <1431891910-32231-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch adds support for get transmit power levels and reworks the
set of transmit power levels which was broken before.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 83 +++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index fabde3a..dff7e47 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -51,6 +51,7 @@ struct at86rf2xx_chip_data {
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
 	int (*get_desense_steps)(struct at86rf230_local *, s32);
+	int (*set_txpower)(struct at86rf230_local *, s32);
 };
 
 #define AT86RF2XX_MAX_BUF		(127 + 3)
@@ -124,9 +125,12 @@ struct at86rf230_local {
 #define SR_IRQ_2_EXT_EN		0x04, 0x40, 6
 #define SR_PA_EXT_EN		0x04, 0x80, 7
 #define RG_PHY_TX_PWR	(0x05)
-#define SR_TX_PWR		0x05, 0x0f, 0
-#define SR_PA_LT		0x05, 0x30, 4
-#define SR_PA_BUF_LT		0x05, 0xc0, 6
+#define SR_TX_PWR_23X		0x05, 0x0f, 0
+#define SR_PA_LT_230		0x05, 0x30, 4
+#define SR_PA_BUF_LT_230	0x05, 0xc0, 6
+#define SR_TX_PWR_212		0x05, 0x1f, 0
+#define SR_GC_PA_212		0x05, 0x60, 5
+#define SR_PA_BOOST_LT_212	0x05, 0x80, 7
 #define RG_PHY_RSSI	(0x06)
 #define SR_RSSI			0x06, 0x1f, 0
 #define SR_RND_VALUE		0x06, 0x60, 5
@@ -1193,24 +1197,56 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 	return 0;
 }
 
+#define AT86RF23X_MAX_TX_POWERS 0xF
+static const s32 at86rf233_powers[AT86RF23X_MAX_TX_POWERS + 1] = {
+	400, 370, 340, 300, 250, 200, 100, 0, -100, -200, -300, -400, -600,
+	-800, -1200, -1700,
+};
+
+static const s32 at86rf231_powers[AT86RF23X_MAX_TX_POWERS + 1] = {
+	300, 280, 230, 180, 130, 70, 0, -100, -200, -300, -400, -500, -700,
+	-900, -1200, -1700,
+};
+
+#define AT86RF212_MAX_TX_POWERS 0x1F
+static const s32 at86rf212_powers[AT86RF212_MAX_TX_POWERS + 1] = {
+	500, 400, 300, 200, 100, 0, -100, -200, -300, -400, -500, -600, -700,
+	-800, -900, -1000, -1100, -1200, -1300, -1400, -1500, -1600, -1700,
+	-1800, -1900, -2000, -2100, -2200, -2300, -2400, -2500, -2600,
+};
+
 static int
-at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+at86rf23x_set_txpower(struct at86rf230_local *lp, s32 mbm)
 {
-	struct at86rf230_local *lp = hw->priv;
-	s8 db = mbm / 100;
+	u32 i;
 
-	/* typical maximum output is 5dBm with RG_PHY_TX_PWR 0x60, lower five
-	 * bits decrease power in 1dB steps. 0x60 represents extra PA gain of
-	 * 0dB.
-	 * thus, supported values for db range from -26 to 5, for 31dB of
-	 * reduction to 0dB of reduction.
-	 */
-	if (db > 5 || db < -26)
-		return -EINVAL;
+	for (i = 0; i < lp->hw->phy->supported.tx_powers_size; i++) {
+		if (lp->hw->phy->supported.tx_powers[i] == mbm)
+			return at86rf230_write_subreg(lp, SR_TX_PWR_23X, i);
+	}
+
+	return -EINVAL;
+}
+
+static int
+at86rf212_set_txpower(struct at86rf230_local *lp, s32 mbm)
+{
+	u32 i;
+
+	for (i = 0; i < lp->hw->phy->supported.tx_powers_size; i++) {
+		if (lp->hw->phy->supported.tx_powers[i] == mbm)
+			return at86rf230_write_subreg(lp, SR_TX_PWR_212, i);
+	}
 
-	db = -(db - 5);
+	return -EINVAL;
+}
+
+static int
+at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct at86rf230_local *lp = hw->priv;
 
-	return __at86rf230_write(lp, RG_PHY_TX_PWR, 0x60 | db);
+	return lp->data->set_txpower(lp, mbm);
 }
 
 static int
@@ -1367,7 +1403,8 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps
+	.get_desense_steps = at86rf23x_get_desens_steps,
+	.set_txpower = at86rf23x_set_txpower,
 };
 
 static struct at86rf2xx_chip_data at86rf231_data = {
@@ -1380,7 +1417,8 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps
+	.get_desense_steps = at86rf23x_get_desens_steps,
+	.set_txpower = at86rf23x_set_txpower,
 };
 
 static struct at86rf2xx_chip_data at86rf212_data = {
@@ -1393,7 +1431,8 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
-	.get_desense_steps = at86rf212_get_desens_steps
+	.get_desense_steps = at86rf212_get_desens_steps,
+	.set_txpower = at86rf212_set_txpower,
 };
 
 static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
@@ -1592,6 +1631,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 11;
 		lp->hw->phy->symbol_duration = 16;
+		lp->hw->phy->supported.tx_powers = at86rf231_powers;
+		lp->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf231_powers);
 		break;
 	case 7:
 		chip = "at86rf212";
@@ -1602,6 +1643,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
 		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
+		lp->hw->phy->supported.tx_powers = at86rf212_powers;
+		lp->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf212_powers);
 		break;
 	case 11:
 		chip = "at86rf233";
@@ -1609,6 +1652,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 13;
 		lp->hw->phy->symbol_duration = 16;
+		lp->hw->phy->supported.tx_powers = at86rf233_powers;
+		lp->hw->phy->supported.tx_powers_size = ARRAY_SIZE(at86rf233_powers);
 		break;
 	default:
 		chip = "unknown";
-- 
2.3.7

