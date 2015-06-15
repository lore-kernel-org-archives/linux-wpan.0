Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33973 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbbFOTES (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Jun 2015 15:04:18 -0400
Received: by wicnd19 with SMTP id nd19so33808647wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 15 Jun 2015 12:04:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] at86rf230: fix phy settings while sleeping
Date: Mon, 15 Jun 2015 21:03:45 +0200
Message-Id: <1434395026-4638-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

While in sleep state and we can't access the at86rf2xx registers. This
can currently occur on phy settings only. All other driver callbacks are
accessible between the start <-> stop period which puts the phy into
another state than sleep.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 90 ++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6b31f47..428238d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -90,6 +90,7 @@ struct at86rf230_local {
 	struct at86rf2xx_chip_data *data;
 	struct regmap *regmap;
 	int slp_tr;
+	bool sleep;
 
 	struct completion state_complete;
 	struct at86rf230_state_change state;
@@ -158,6 +159,28 @@ at86rf230_slp_tr_rising_edge(struct at86rf230_local *lp)
 	gpio_set_value(lp->slp_tr, 0);
 }
 
+static inline void
+at86rf230_sleep(struct at86rf230_local *lp)
+{
+	if (gpio_is_valid(lp->slp_tr)) {
+		gpio_set_value(lp->slp_tr, 1);
+		usleep_range(lp->data->t_off_to_sleep,
+			     lp->data->t_off_to_sleep + 10);
+		lp->sleep = true;
+	}
+}
+
+static inline void
+at86rf230_awake(struct at86rf230_local *lp)
+{
+	if (gpio_is_valid(lp->slp_tr)) {
+		gpio_set_value(lp->slp_tr, 0);
+		usleep_range(lp->data->t_sleep_to_off,
+			     lp->data->t_sleep_to_off + 100);
+		lp->sleep = false;
+	}
+}
+
 static bool
 at86rf230_reg_writeable(struct device *dev, unsigned int reg)
 {
@@ -873,12 +896,7 @@ at86rf230_start(struct ieee802154_hw *hw)
 {
 	struct at86rf230_local *lp = hw->priv;
 
-	if (gpio_is_valid(lp->slp_tr)) {
-		gpio_set_value(lp->slp_tr, 0);
-		usleep_range(lp->data->t_sleep_to_off,
-			     lp->data->t_sleep_to_off + 100);
-	}
-
+	at86rf230_awake(lp);
 	enable_irq(lp->spi->irq);
 
 	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
@@ -892,12 +910,7 @@ at86rf230_stop(struct ieee802154_hw *hw)
 	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
 
 	disable_irq(lp->spi->irq);
-
-	if (gpio_is_valid(lp->slp_tr)) {
-		gpio_set_value(lp->slp_tr, 1);
-		usleep_range(lp->data->t_off_to_sleep,
-			     lp->data->t_off_to_sleep + 10);
-	}
+	at86rf230_sleep(lp);
 }
 
 static int
@@ -1013,14 +1026,24 @@ static int
 at86rf230_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	struct at86rf230_local *lp = hw->priv;
+	bool sleep = lp->sleep;
 	int rc;
 
+	/* awake for register setting if sleep */
+	if (sleep)
+		at86rf230_awake(lp);
+
 	rc = lp->data->set_channel(lp, page, channel);
 	/* Wait for PLL */
 	usleep_range(lp->data->t_channel_switch,
 		     lp->data->t_channel_switch + 10);
 
 	lp->cal_timeout = jiffies + AT86RF2XX_CAL_LOOP_TIMEOUT;
+
+	/* sleep again if was sleeping */
+	if (sleep)
+		at86rf230_sleep(lp);
+
 	return rc;
 }
 
@@ -1119,8 +1142,20 @@ static int
 at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct at86rf230_local *lp = hw->priv;
+	bool sleep = lp->sleep;
+	int ret;
+
+	/* awake for register setting if sleep */
+	if (sleep)
+		at86rf230_awake(lp);
+
+	ret = lp->data->set_txpower(lp, mbm);
 
-	return lp->data->set_txpower(lp, mbm);
+	/* sleep again if was sleeping */
+	if (sleep)
+		at86rf230_sleep(lp);
+
+	return ret;
 }
 
 static int
@@ -1136,6 +1171,8 @@ at86rf230_set_cca_mode(struct ieee802154_hw *hw,
 		       const struct wpan_phy_cca *cca)
 {
 	struct at86rf230_local *lp = hw->priv;
+	bool sleep = lp->sleep;
+	int ret;
 	u8 val;
 
 	/* mapping 802.15.4 to driver spec */
@@ -1162,7 +1199,17 @@ at86rf230_set_cca_mode(struct ieee802154_hw *hw,
 		return -EINVAL;
 	}
 
-	return at86rf230_write_subreg(lp, SR_CCA_MODE, val);
+	/* awake for register setting if sleep */
+	if (sleep)
+		at86rf230_awake(lp);
+
+	ret = at86rf230_write_subreg(lp, SR_CCA_MODE, val);
+
+	/* sleep again if was sleeping */
+	if (sleep)
+		at86rf230_sleep(lp);
+
+	return ret;
 }
 
 
@@ -1170,13 +1217,22 @@ static int
 at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct at86rf230_local *lp = hw->priv;
+	bool sleep = lp->sleep;
 	u32 i;
 
+	/* awake for register setting if sleep */
+	if (sleep)
+		at86rf230_awake(lp);
+
 	for (i = 0; i < hw->phy->supported.cca_ed_levels_size; i++) {
 		if (hw->phy->supported.cca_ed_levels[i] == mbm)
 			return at86rf230_write_subreg(lp, SR_CCA_ED_THRES, i);
 	}
 
+	/* sleep again if was sleeping */
+	if (sleep)
+		at86rf230_sleep(lp);
+
 	return -EINVAL;
 }
 
@@ -1672,11 +1728,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	disable_irq(spi->irq);
 
 	/* going into sleep by default */
-	if (gpio_is_valid(slp_tr)) {
-		gpio_set_value(slp_tr, 1);
-		usleep_range(lp->data->t_off_to_sleep,
-			     lp->data->t_off_to_sleep + 10);
-	}
+	at86rf230_sleep(lp);
 
 	rc = ieee802154_register_hw(lp->hw);
 	if (rc)
-- 
2.4.1

