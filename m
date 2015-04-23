Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35988 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030228AbbDWQsf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:35 -0400
Received: by wgen6 with SMTP id n6so24670754wge.3
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 05/15] mac802154: remove check if operation is supported
Date: Thu, 23 Apr 2015 18:47:44 +0200
Message-Id: <1429807674-24849-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the check if operation is supported by driver layer.
This is done now by capabilities flags, if these are valid then the
driver should support the operation, otherwise a WARN_ON occurs.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/cfg.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index b6a986a..c252a45 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -95,10 +95,6 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 	if (wpan_phy_cca_cmp(&wpan_phy->cca, cca))
 		return 0;
 
-	/* check if phy support this setting */
-	if (!(local->hw.flags & IEEE802154_HW_CCA_MODE))
-		return -EOPNOTSUPP;
-
 	ret = drv_set_cca_mode(local, cca);
 	if (!ret)
 		wpan_phy->cca = *cca;
@@ -124,17 +120,12 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 				struct wpan_dev *wpan_dev,
 				u8 min_be, u8 max_be)
 {
-	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
-
 	ASSERT_RTNL();
 
 	if (wpan_dev->min_be == min_be &&
 	    wpan_dev->max_be == max_be)
 		return 0;
 
-	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
-		return -EOPNOTSUPP;
-
 	wpan_dev->min_be = min_be;
 	wpan_dev->max_be = max_be;
 	return 0;
@@ -158,16 +149,11 @@ ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
 				 struct wpan_dev *wpan_dev,
 				 u8 max_csma_backoffs)
 {
-	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
-
 	ASSERT_RTNL();
 
 	if (wpan_dev->csma_retries == max_csma_backoffs)
 		return 0;
 
-	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
-		return -EOPNOTSUPP;
-
 	wpan_dev->csma_retries = max_csma_backoffs;
 	return 0;
 }
@@ -177,16 +163,11 @@ ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
 				 struct wpan_dev *wpan_dev,
 				 s8 max_frame_retries)
 {
-	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
-
 	ASSERT_RTNL();
 
 	if (wpan_dev->frame_retries == max_frame_retries)
 		return 0;
 
-	if (!(local->hw.flags & IEEE802154_HW_FRAME_RETRIES))
-		return -EOPNOTSUPP;
-
 	wpan_dev->frame_retries = max_frame_retries;
 	return 0;
 }
@@ -195,16 +176,11 @@ static int
 ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 			bool mode)
 {
-	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
-
 	ASSERT_RTNL();
 
 	if (wpan_dev->lbt == mode)
 		return 0;
 
-	if (!(local->hw.flags & IEEE802154_HW_LBT))
-		return -EOPNOTSUPP;
-
 	wpan_dev->lbt = mode;
 	return 0;
 }
-- 
2.3.6

