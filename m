Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35089 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966257AbbDWQsp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:45 -0400
Received: by wgyo15 with SMTP id o15so24736036wgy.2
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 14/15] at86rf230: rework tx cca energy detection level
Date: Thu, 23 Apr 2015 18:47:53 +0200
Message-Id: <1429807674-24849-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch reworks the cca energy detection level handling. This
contains a calculation which works on all transceiver types and
add support for dump cca energy detection levels.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b4fce87..4feab9a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -51,7 +51,6 @@ struct at86rf2xx_chip_data {
 	const s8 *tx_powers_table;
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
-	int (*get_desense_steps)(struct at86rf230_local *, s32);
 	int (*set_txpower)(struct at86rf230_local *, s8);
 	int (*get_txpowers)(struct at86rf230_local *, s8 *, u32);
 };
@@ -1307,27 +1306,29 @@ at86rf230_set_cca_mode(struct ieee802154_hw *hw,
 }
 
 static int
-at86rf212_get_desens_steps(struct at86rf230_local *lp, s32 level)
+at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 level)
 {
-	return (level - lp->data->rssi_base_val) * 100 / 207;
-}
+	struct at86rf230_local *lp = hw->priv;
 
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
 
 static int
-at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 level)
+at86rf230_get_cca_ed_levels(struct ieee802154_hw *hw, s32 *dbm, u32 idx)
 {
 	struct at86rf230_local *lp = hw->priv;
 
-	if (level < lp->data->rssi_base_val || level > 30)
-		return -EINVAL;
+	if (idx > 0xF)
+		return 1;
 
-	return at86rf230_write_subreg(lp, SR_CCA_ED_THRES,
-				      lp->data->get_desense_steps(lp, level));
+	*dbm = lp->data->rssi_base_val + 2 * idx;
+	return 0;
 }
 
 static int
@@ -1400,6 +1401,7 @@ static const struct ieee802154_ops at86rf230_ops = {
 	.set_hw_addr_filt = at86rf230_set_hw_addr_filt,
 	.set_txpower = at86rf230_set_txpower,
 	.get_tx_powers = at86rf230_get_txpowers,
+	.get_cca_ed_levels = at86rf230_get_cca_ed_levels,
 	.set_lbt = at86rf230_set_lbt,
 	.set_cca_mode = at86rf230_set_cca_mode,
 	.set_cca_ed_level = at86rf230_set_cca_ed_level,
@@ -1419,7 +1421,6 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.rssi_base_val = -91,
 	.tx_powers_table = at86rf233_powers,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps,
 	.set_txpower = at86rf23x_set_txpower,
 	.get_txpowers = at86rf23x_get_txpowers,
 };
@@ -1435,7 +1436,6 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.rssi_base_val = -91,
 	.tx_powers_table = at86rf231_powers,
 	.set_channel = at86rf23x_set_channel,
-	.get_desense_steps = at86rf23x_get_desens_steps,
 	.set_txpower = at86rf23x_set_txpower,
 	.get_txpowers = at86rf23x_get_txpowers,
 };
@@ -1450,7 +1450,6 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_p_ack = 545,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
-	.get_desense_steps = at86rf212_get_desens_steps,
 	.set_txpower = at86rf212_set_txpower,
 	.get_txpowers = at86rf212_get_txpowers,
 };
-- 
2.3.6

