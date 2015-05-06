Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33843 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbEFLlW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:22 -0400
Received: by wgso17 with SMTP id o17so8423917wgs.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 14/16] at86rf230: rework tx cca energy detection level
Date: Wed,  6 May 2015 13:40:26 +0200
Message-Id: <1430912428-17284-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch reworks the cca energy detection level handling. This
contains a calculation which works on all transceiver types and
add support for dump cca energy detection levels.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 10cb6a4..165c4cd 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -51,7 +51,6 @@ struct at86rf2xx_chip_data {
 	const s32 *tx_powers_table;
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
-	int (*get_desense_steps)(struct at86rf230_local *, s32);
 	int (*set_txpower)(struct at86rf230_local *, s32);
 	int (*get_txpowers)(struct at86rf230_local *, s32 *, u32);
 };
@@ -1319,28 +1318,32 @@ at86rf230_set_cca_mode(struct ieee802154_hw *hw,
 }
 
 static int
-at86rf212_get_desens_steps(struct at86rf230_local *lp, s32 level)
+at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
-	return (level - lp->data->rssi_base_val) * 100 / 207;
-}
+	struct at86rf230_local *lp = hw->priv;
+	s32 level = mbm / 100;
 
-static int
-at86rf23x_get_desens_steps(struct at86rf230_local *lp, s32 level)
-{
-	return (level - lp->data->rssi_base_val) / 2;
+	/* backwards compatible for old interface, should be removed */
+	if (level < lp->data->rssi_base_val ||
+	    level > lp->data->rssi_base_val + 2 * 0xF)
+		return -EINVAL;
+
+	return at86rf230_write_subreg(lp, SR_CCA_ED_THRES,
+				      (level - lp->data->rssi_base_val) / 2);
 }
 
+#define AT86RF230_MAX_ED_LEVELS_IDX 0xF
+
 static int
-at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
+at86rf230_get_cca_ed_levels(struct ieee802154_hw *hw, s32 *mbm, u32 idx)
 {
 	struct at86rf230_local *lp = hw->priv;
-	s32 level = mbm / 100;
 
-	if (level < lp->data->rssi_base_val || level > 30)
-		return -EINVAL;
+	if (idx > AT86RF230_MAX_ED_LEVELS_IDX)
+		return 1;
 
-	return at86rf230_write_subreg(lp, SR_CCA_ED_THRES,
-				      lp->data->get_desense_steps(lp, level));
+	*mbm = (lp->data->rssi_base_val + 2 * idx) * 100;
+	return 0;
 }
 
 static int
@@ -1413,6 +1416,7 @@ static const struct ieee802154_ops at86rf230_ops = {
 	.set_hw_addr_filt = at86rf230_set_hw_addr_filt,
 	.set_txpower = at86rf230_set_txpower,
 	.get_tx_powers = at86rf230_get_txpowers,
+	.get_cca_ed_levels = at86rf230_get_cca_ed_levels,
 	.set_lbt = at86rf230_set_lbt,
 	.set_cca_mode = at86rf230_set_cca_mode,
 	.set_cca_ed_level = at86rf230_set_cca_ed_level,
@@ -1432,7 +1436,6 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.rssi_base_val = -91,
 	.tx_powers_table = at86rf233_powers,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps,
 	.set_txpower = at86rf23x_set_txpower,
 	.get_txpowers = at86rf23x_get_txpowers,
 };
@@ -1448,7 +1451,6 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.rssi_base_val = -91,
 	.tx_powers_table = at86rf231_powers,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps,
 	.set_txpower = at86rf23x_set_txpower,
 	.get_txpowers = at86rf23x_get_txpowers,
 };
@@ -1463,7 +1465,6 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
-	.get_desense_steps = at86rf212_get_desens_steps,
 	.set_txpower = at86rf212_set_txpower,
 	.get_txpowers = at86rf212_get_txpowers,
 };
-- 
2.3.7

