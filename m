Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:42500 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbaJ1RWF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:05 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so1055811lab.27
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/17] mac802154: remove driver ops in wpan-phy
Date: Tue, 28 Oct 2014 18:21:23 +0100
Message-Id: <1414516892-4107-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the driver ops callbacks inside of wpan_phy struct.
It was used to check if a phy supports this driver ops call. We do this
now via hardware flags.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h |  8 -----
 net/ieee802154/nl-mac.c | 19 ++---------
 net/mac802154/iface.c   | 12 +++----
 net/mac802154/main.c    | 85 -------------------------------------------------
 4 files changed, 8 insertions(+), 116 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 5c67467..440b9be 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -57,14 +57,6 @@ struct wpan_phy {
 					const char *name, int type);
 	void (*del_iface)(struct wpan_phy *phy, struct net_device *dev);
 
-	int (*set_txpower)(struct wpan_phy *phy, int db);
-	int (*set_lbt)(struct wpan_phy *phy, bool on);
-	int (*set_cca_mode)(struct wpan_phy *phy, u8 cca_mode);
-	int (*set_cca_ed_level)(struct wpan_phy *phy, int level);
-	int (*set_csma_params)(struct wpan_phy *phy, u8 min_be, u8 max_be,
-			       u8 retries);
-	int (*set_frame_retries)(struct wpan_phy *phy, s8 retries);
-
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index fb6866d..abd0f31 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -664,20 +664,6 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 
 	phy = ops->get_phy(dev);
 
-	if ((!phy->set_lbt && info->attrs[IEEE802154_ATTR_LBT_ENABLED]) ||
-	    (!phy->set_cca_mode && info->attrs[IEEE802154_ATTR_CCA_MODE]) ||
-	    (!phy->set_cca_ed_level &&
-	     info->attrs[IEEE802154_ATTR_CCA_ED_LEVEL]) ||
-	    (!phy->set_csma_params &&
-	     (info->attrs[IEEE802154_ATTR_CSMA_RETRIES] ||
-	      info->attrs[IEEE802154_ATTR_CSMA_MIN_BE] ||
-	      info->attrs[IEEE802154_ATTR_CSMA_MAX_BE])) ||
-	    (!phy->set_frame_retries &&
-	     info->attrs[IEEE802154_ATTR_FRAME_RETRIES])) {
-		rc = -EOPNOTSUPP;
-		goto out_phy;
-	}
-
 	ops->get_mac_params(dev, &params);
 
 	if (info->attrs[IEEE802154_ATTR_TXPOWER])
@@ -708,10 +694,9 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 
 	wpan_phy_put(phy);
 	dev_put(dev);
-	return rc;
 
-out_phy:
-	wpan_phy_put(phy);
+	return 0;
+
 out:
 	dev_put(dev);
 	return rc;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 025cd5a..300877a 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -196,32 +196,32 @@ static int mac802154_wpan_open(struct net_device *dev)
 
 	mutex_lock(&phy->pib_lock);
 
-	if (phy->set_txpower) {
+	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
 		rc = drv_set_tx_power(local, sdata->mac_params.transmit_power);
 		if (rc < 0)
 			goto out;
 	}
 
-	if (phy->set_lbt) {
+	if (local->hw.flags & IEEE802154_HW_LBT) {
 		rc = drv_set_lbt_mode(local, sdata->mac_params.lbt);
 		if (rc < 0)
 			goto out;
 	}
 
-	if (phy->set_cca_mode) {
+	if (local->hw.flags & IEEE802154_HW_CCA_MODE) {
 		rc = drv_set_cca_mode(local, sdata->mac_params.cca_mode);
 		if (rc < 0)
 			goto out;
 	}
 
-	if (phy->set_cca_ed_level) {
+	if (local->hw.flags & IEEE802154_HW_CCA_ED_LEVEL) {
 		rc = drv_set_cca_ed_level(local,
 					  sdata->mac_params.cca_ed_level);
 		if (rc < 0)
 			goto out;
 	}
 
-	if (phy->set_csma_params) {
+	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
 		rc = drv_set_csma_params(local, sdata->mac_params.min_be,
 					 sdata->mac_params.max_be,
 					 sdata->mac_params.csma_retries);
@@ -229,7 +229,7 @@ static int mac802154_wpan_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (phy->set_frame_retries) {
+	if (local->hw.flags & IEEE802154_HW_FRAME_RETRIES) {
 		rc = drv_set_max_frame_retries(local,
 					       sdata->mac_params.frame_retries);
 		if (rc < 0)
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 24ecc09..9fa9514 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -121,49 +121,6 @@ err:
 	return ERR_PTR(err);
 }
 
-static int mac802154_set_txpower(struct wpan_phy *phy, int db)
-{
-	struct ieee802154_local *local = wpan_phy_priv(phy);
-
-	return drv_set_tx_power(local, db);
-}
-
-static int mac802154_set_lbt(struct wpan_phy *phy, bool on)
-{
-	struct ieee802154_local *local = wpan_phy_priv(phy);
-
-	return drv_set_lbt_mode(local, on);
-}
-
-static int mac802154_set_cca_mode(struct wpan_phy *phy, u8 mode)
-{
-	struct ieee802154_local *local = wpan_phy_priv(phy);
-
-	return drv_set_cca_mode(local, mode);
-}
-
-static int mac802154_set_cca_ed_level(struct wpan_phy *phy, s32 level)
-{
-	struct ieee802154_local *local = wpan_phy_priv(phy);
-
-	return drv_set_cca_ed_level(local, level);
-}
-
-static int mac802154_set_csma_params(struct wpan_phy *phy, u8 min_be,
-				     u8 max_be, u8 retries)
-{
-	struct ieee802154_local *local = wpan_phy_priv(phy);
-
-	return drv_set_csma_params(local, min_be, max_be, retries);
-}
-
-static int mac802154_set_frame_retries(struct wpan_phy *phy, s8 retries)
-{
-	struct ieee802154_local *local = wpan_phy_priv(phy);
-
-	return drv_set_max_frame_retries(local, retries);
-}
-
 static void ieee802154_tasklet_handler(unsigned long data)
 {
 	struct ieee802154_local *local = (struct ieee802154_local *)data;
@@ -262,48 +219,6 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 	struct ieee802154_local *local = hw_to_local(hw);
 	int rc = -ENOSYS;
 
-	if (hw->flags & IEEE802154_HW_TXPOWER) {
-		if (!local->ops->set_txpower)
-			goto out;
-
-		local->phy->set_txpower = mac802154_set_txpower;
-	}
-
-	if (hw->flags & IEEE802154_HW_LBT) {
-		if (!local->ops->set_lbt)
-			goto out;
-
-		local->phy->set_lbt = mac802154_set_lbt;
-	}
-
-	if (hw->flags & IEEE802154_HW_CCA_MODE) {
-		if (!local->ops->set_cca_mode)
-			goto out;
-
-		local->phy->set_cca_mode = mac802154_set_cca_mode;
-	}
-
-	if (hw->flags & IEEE802154_HW_CCA_ED_LEVEL) {
-		if (!local->ops->set_cca_ed_level)
-			goto out;
-
-		local->phy->set_cca_ed_level = mac802154_set_cca_ed_level;
-	}
-
-	if (hw->flags & IEEE802154_HW_CSMA_PARAMS) {
-		if (!local->ops->set_csma_params)
-			goto out;
-
-		local->phy->set_csma_params = mac802154_set_csma_params;
-	}
-
-	if (hw->flags & IEEE802154_HW_FRAME_RETRIES) {
-		if (!local->ops->set_frame_retries)
-			goto out;
-
-		local->phy->set_frame_retries = mac802154_set_frame_retries;
-	}
-
 	local->workqueue =
 		create_singlethread_workqueue(wpan_phy_name(local->phy));
 	if (!local->workqueue) {
-- 
2.1.2

