Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36164 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030313AbbDWQsp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:45 -0400
Received: by wgen6 with SMTP id n6so24675269wge.3
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:43 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 13/15] at86rf230: rework tx power support
Date: Thu, 23 Apr 2015 18:47:52 +0200
Message-Id: <1429807674-24849-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for get transmit power levels and reworks the
set of transmit power levels which was broken before.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 102 +++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 04a4e8e..b4fce87 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -48,9 +48,12 @@ struct at86rf2xx_chip_data {
 	u16 t_frame;
 	u16 t_p_ack;
 	int rssi_base_val;
+	const s8 *tx_powers_table;
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
 	int (*get_desense_steps)(struct at86rf230_local *, s32);
+	int (*set_txpower)(struct at86rf230_local *, s8);
+	int (*get_txpowers)(struct at86rf230_local *, s8 *, u32);
 };
 
 #define AT86RF2XX_MAX_BUF		(127 + 3)
@@ -122,9 +125,12 @@ struct at86rf230_local {
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
@@ -1172,11 +1178,34 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 	return 0;
 }
 
+#define AT86RF23X_MAX_TX_POWERS 0xF
+static const s8 at86rf233_powers[AT86RF23X_MAX_TX_POWERS + 1] = {
+	4, S8_MAX /* 3.7 */, S8_MAX /* 3.4 */, 3, S8_MAX /* 2.5 */, 2, 1, 0,
+	-1, -2, -3, -4, -6, -8, -12, -17,
+};
+
+static const s8 at86rf231_powers[AT86RF23X_MAX_TX_POWERS + 1] = {
+	3, S8_MAX /* 2.8 */, S8_MAX /* 2.3 */, 2 /* 1.8 */, S8_MAX /* 1.3 */,
+	1 /* 0.7 */, 0, -1, -2, -3, -4, -5, -7, -9, -12, -17,
+};
+
 static int
-at86rf230_set_txpower(struct ieee802154_hw *hw, s8 db)
+at86rf23x_set_txpower(struct at86rf230_local *lp, s8 db)
 {
-	struct at86rf230_local *lp = hw->priv;
+	u32 i;
+
+	for (i = 0; i < AT86RF23X_MAX_TX_POWERS; i++) {
+		if (lp->data->tx_powers_table[i] == db &&
+		    lp->data->tx_powers_table[i] != S8_MAX)
+			return at86rf230_write_subreg(lp, SR_TX_PWR_23X, i);
+	}
+
+	return -EINVAL;
+}
 
+static int
+at86rf212_set_txpower(struct at86rf230_local *lp, s8 db)
+{
 	/* typical maximum output is 5dBm with RG_PHY_TX_PWR 0x60, lower five
 	 * bits decrease power in 1dB steps. 0x60 represents extra PA gain of
 	 * 0dB.
@@ -1186,9 +1215,53 @@ at86rf230_set_txpower(struct ieee802154_hw *hw, s8 db)
 	if (db > 5 || db < -26)
 		return -EINVAL;
 
-	db = -(db - 5);
+	return at86rf230_write_subreg(lp, SR_TX_PWR_212, -(db - 5));
+}
+
+static int
+at86rf230_set_txpower(struct ieee802154_hw *hw, s8 db)
+{
+	struct at86rf230_local *lp = hw->priv;
+
+	return lp->data->set_txpower(lp, db);
+}
+
+static int
+at86rf23x_get_txpowers(struct at86rf230_local *lp, s8 *db, u32 idx)
+{
+	if (!lp->data->tx_powers_table)
+		return -EOPNOTSUPP;
+
+	if (idx > AT86RF23X_MAX_TX_POWERS)
+		return 1;
+
+	if (lp->data->tx_powers_table[idx] == S8_MAX)
+		return 2;
+
+	*db = lp->data->tx_powers_table[idx];
+	return 0;
+}
+
+#define AT86RF212_MAX_TX_POWERS 0x1F
+static int
+at86rf212_get_txpowers(struct at86rf230_local *lp, s8 *db, u32 idx)
+{
+	if (!lp->data->tx_powers_table)
+		return -EOPNOTSUPP;
+
+	if (idx > AT86RF212_MAX_TX_POWERS)
+		return 1;
+
+	*db = 5 - idx;
+	return 0;
+}
+
+static int
+at86rf230_get_txpowers(struct ieee802154_hw *hw, s8 *db, u32 idx)
+{
+	struct at86rf230_local *lp = hw->priv;
 
-	return __at86rf230_write(lp, RG_PHY_TX_PWR, 0x60 | db);
+	return lp->data->get_txpowers(lp, db, idx);
 }
 
 static int
@@ -1326,6 +1399,7 @@ static const struct ieee802154_ops at86rf230_ops = {
 	.stop = at86rf230_stop,
 	.set_hw_addr_filt = at86rf230_set_hw_addr_filt,
 	.set_txpower = at86rf230_set_txpower,
+	.get_tx_powers = at86rf230_get_txpowers,
 	.set_lbt = at86rf230_set_lbt,
 	.set_cca_mode = at86rf230_set_cca_mode,
 	.set_cca_ed_level = at86rf230_set_cca_ed_level,
@@ -1343,8 +1417,11 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
+	.tx_powers_table = at86rf233_powers,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps
+	.get_desense_steps = at86rf23x_get_desens_steps,
+	.set_txpower = at86rf23x_set_txpower,
+	.get_txpowers = at86rf23x_get_txpowers,
 };
 
 static struct at86rf2xx_chip_data at86rf231_data = {
@@ -1356,8 +1433,11 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
+	.tx_powers_table = at86rf231_powers,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps
+	.get_desense_steps = at86rf23x_get_desens_steps,
+	.set_txpower = at86rf23x_set_txpower,
+	.get_txpowers = at86rf23x_get_txpowers,
 };
 
 static struct at86rf2xx_chip_data at86rf212_data = {
@@ -1370,7 +1450,9 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
-	.get_desense_steps = at86rf212_get_desens_steps
+	.get_desense_steps = at86rf212_get_desens_steps,
+	.set_txpower = at86rf212_set_txpower,
+	.get_txpowers = at86rf212_get_txpowers,
 };
 
 static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
-- 
2.3.6

