Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38414 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbEFLlX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:23 -0400
Received: by wiun10 with SMTP id n10so18810399wiu.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 15/16] ieee802154: check transmit power before driver layer
Date: Wed,  6 May 2015 13:40:27 +0200
Message-Id: <1430912428-17284-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the validation check of transmit power mbm values to
the netlink layer by using the callback to get all transmit power levels
mbm values.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 22 +++-----------------
 net/mac802154/mac_cmd.c            | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 165c4cd..2484f16 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1225,17 +1225,7 @@ at86rf23x_set_txpower(struct at86rf230_local *lp, s32 mbm)
 static int
 at86rf212_set_txpower(struct at86rf230_local *lp, s32 mbm)
 {
-	s8 db = mbm / 100;
-	/* typical maximum output is 5dBm with RG_PHY_TX_PWR 0x60, lower five
-	 * bits decrease power in 1dB steps. 0x60 represents extra PA gain of
-	 * 0dB.
-	 * thus, supported values for db range from -26 to 5, for 31dB of
-	 * reduction to 0dB of reduction.
-	 */
-	if (db > 5 || db < -26)
-		return -EINVAL;
-
-	return at86rf230_write_subreg(lp, SR_TX_PWR_212, -(db - 5));
+	return at86rf230_write_subreg(lp, SR_TX_PWR_212, -((mbm / 100) - 5));
 }
 
 static int
@@ -1321,15 +1311,9 @@ static int
 at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct at86rf230_local *lp = hw->priv;
-	s32 level = mbm / 100;
-
-	/* backwards compatible for old interface, should be removed */
-	if (level < lp->data->rssi_base_val ||
-	    level > lp->data->rssi_base_val + 2 * 0xF)
-		return -EINVAL;
+	s32 val = ((mbm / 100) - lp->data->rssi_base_val) / 2;
 
-	return at86rf230_write_subreg(lp, SR_CCA_ED_THRES,
-				      (level - lp->data->rssi_base_val) / 2);
+	return at86rf230_write_subreg(lp, SR_CCA_ED_THRES, val);
 }
 
 #define AT86RF230_MAX_ED_LEVELS_IDX 0xF
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index bdccb4e..f09d8fb 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -76,6 +76,7 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	int ret;
+	s32 idx;
 
 	ASSERT_RTNL();
 
@@ -92,6 +93,26 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	wpan_dev->lbt = params->lbt;
 
 	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
+		bool found = false;
+		s32 pwr;
+
+		idx = 0;
+		while (1) {
+			ret = drv_get_tx_powers(local, &pwr, idx++);
+			if (ret < 0)
+				return ret;
+			else if (ret == 1)
+				break;
+
+			if (pwr == params->transmit_power) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			return -EINVAL;
+
 		ret = drv_set_tx_power(local, params->transmit_power);
 		if (ret < 0)
 			return ret;
@@ -104,6 +125,26 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	}
 
 	if (local->hw.flags & IEEE802154_HW_CCA_ED_LEVEL) {
+		bool found = false;
+		s32 ed;
+
+		idx = 0;
+		while (1) {
+			ret = drv_get_cca_ed_levels(local, &ed, idx++);
+			if (ret < 0)
+				return ret;
+			else if (ret == 1)
+				break;
+
+			if (ed == params->cca_ed_level) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			return -EINVAL;
+
 		ret = drv_set_cca_ed_level(local, params->cca_ed_level);
 		if (ret < 0)
 			return ret;
-- 
2.3.7

