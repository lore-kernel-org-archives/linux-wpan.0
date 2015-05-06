Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38367 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbbEFLlV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:21 -0400
Received: by wiun10 with SMTP id n10so18809208wiu.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 13/16] at86rf230: rework tx power support
Date: Wed,  6 May 2015 13:40:25 +0200
Message-Id: <1430912428-17284-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for get transmit power levels and reworks the
set of transmit power levels which was broken before.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 94 +++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 14e743c..10cb6a4 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -48,9 +48,12 @@ struct at86rf2xx_chip_data {
 	u16 t_frame;
 	u16 t_p_ack;
 	int rssi_base_val;
+	const s32 *tx_powers_table;
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
 	int (*get_desense_steps)(struct at86rf230_local *, s32);
+	int (*set_txpower)(struct at86rf230_local *, s32);
+	int (*get_txpowers)(struct at86rf230_local *, s32 *, u32);
 };
 
 #define AT86RF2XX_MAX_BUF		(127 + 3)
@@ -124,9 +127,12 @@ struct at86rf230_local {
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
@@ -1193,12 +1199,34 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
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
 static int
-at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+at86rf23x_set_txpower(struct at86rf230_local *lp, s32 mbm)
 {
-	struct at86rf230_local *lp = hw->priv;
-	s8 db = mbm / 100;
+	u32 i;
 
+	for (i = 0; i < AT86RF23X_MAX_TX_POWERS; i++) {
+		if (lp->data->tx_powers_table[i] == mbm)
+			return at86rf230_write_subreg(lp, SR_TX_PWR_23X, i);
+	}
+
+	return -EINVAL;
+}
+
+static int
+at86rf212_set_txpower(struct at86rf230_local *lp, s32 mbm)
+{
+	s8 db = mbm / 100;
 	/* typical maximum output is 5dBm with RG_PHY_TX_PWR 0x60, lower five
 	 * bits decrease power in 1dB steps. 0x60 represents extra PA gain of
 	 * 0dB.
@@ -1208,9 +1236,44 @@ at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 	if (db > 5 || db < -26)
 		return -EINVAL;
 
-	db = -(db - 5);
+	return at86rf230_write_subreg(lp, SR_TX_PWR_212, -(db - 5));
+}
+
+static int
+at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct at86rf230_local *lp = hw->priv;
+
+	return lp->data->set_txpower(lp, mbm);
+}
+
+static int
+at86rf23x_get_txpowers(struct at86rf230_local *lp, s32 *mbm, u32 idx)
+{
+	if (idx > AT86RF23X_MAX_TX_POWERS)
+		return 1;
+
+	*mbm = lp->data->tx_powers_table[idx];
+	return 0;
+}
+
+#define AT86RF212_MAX_TX_POWERS 0x1F
+static int
+at86rf212_get_txpowers(struct at86rf230_local *lp, s32 *mbm, u32 idx)
+{
+	if (idx > AT86RF212_MAX_TX_POWERS)
+		return 1;
+
+	*mbm = (5 - idx) * 100;
+	return 0;
+}
+
+static int
+at86rf230_get_txpowers(struct ieee802154_hw *hw, s32 *mbm, u32 idx)
+{
+	struct at86rf230_local *lp = hw->priv;
 
-	return __at86rf230_write(lp, RG_PHY_TX_PWR, 0x60 | db);
+	return lp->data->get_txpowers(lp, mbm, idx);
 }
 
 static int
@@ -1349,6 +1412,7 @@ static const struct ieee802154_ops at86rf230_ops = {
 	.stop = at86rf230_stop,
 	.set_hw_addr_filt = at86rf230_set_hw_addr_filt,
 	.set_txpower = at86rf230_set_txpower,
+	.get_tx_powers = at86rf230_get_txpowers,
 	.set_lbt = at86rf230_set_lbt,
 	.set_cca_mode = at86rf230_set_cca_mode,
 	.set_cca_ed_level = at86rf230_set_cca_ed_level,
@@ -1366,8 +1430,11 @@ static struct at86rf2xx_chip_data at86rf233_data = {
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
@@ -1379,8 +1446,11 @@ static struct at86rf2xx_chip_data at86rf231_data = {
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
@@ -1393,7 +1463,9 @@ static struct at86rf2xx_chip_data at86rf212_data = {
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
2.3.7

