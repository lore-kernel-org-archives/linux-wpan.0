Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36638 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbEQTpm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:42 -0400
Received: by wizk4 with SMTP id k4so54325714wiz.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/34] mac802154: check for really changes
Date: Sun, 17 May 2015 21:44:44 +0200
Message-Id: <1431891910-32231-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch adds check if the value is really changed inside pib/mib.
If a transceiver do support only one value for e.g. max_be then this
will also handle that the driver layer doesn't need to care about
handling to set one value only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h | 12 ++++++++++++
 net/mac802154/cfg.c     | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 23abd08..37abc16 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -94,6 +94,18 @@ struct wpan_phy_cca {
 	enum nl802154_cca_opts opt;
 };
 
+static inline bool
+wpan_phy_cca_cmp(const struct wpan_phy_cca *a, const struct wpan_phy_cca *b)
+{
+	if (a->mode != b->mode)
+		return false;
+
+	if (a->mode == NL802154_CCA_ENERGY_CARRIER)
+		return a->opt == b->opt;
+
+	return true;
+}
+
 struct wpan_phy {
 	struct mutex pib_lock;
 
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index c636015..45c4dc3 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -73,6 +73,10 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 
 	ASSERT_RTNL();
 
+	if (wpan_phy->current_page == page &&
+	    wpan_phy->current_channel == channel)
+		return 0;
+
 	ret = drv_set_channel(local, page, channel);
 	if (!ret) {
 		wpan_phy->current_page = page;
@@ -91,6 +95,9 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_phy_cca_cmp(&wpan_phy->cca, cca))
+		return 0;
+
 	/* check if phy support this setting */
 	if (!(local->hw.flags & IEEE802154_HW_CCA_MODE))
 		return -EOPNOTSUPP;
@@ -108,6 +115,9 @@ ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
+	if (wpan_dev->pan_id == pan_id)
+		return 0;
+
 	wpan_dev->pan_id = pan_id;
 	return 0;
 }
@@ -121,6 +131,10 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->min_be == min_be &&
+	    wpan_dev->max_be == max_be)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
 		return -EOPNOTSUPP;
 
@@ -135,6 +149,9 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
+	if (wpan_dev->short_addr == short_addr)
+		return 0;
+
 	wpan_dev->short_addr = short_addr;
 	return 0;
 }
@@ -148,6 +165,9 @@ ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->csma_retries == max_csma_backoffs)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
 		return -EOPNOTSUPP;
 
@@ -164,6 +184,9 @@ ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->frame_retries == max_frame_retries)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_FRAME_RETRIES))
 		return -EOPNOTSUPP;
 
@@ -179,6 +202,9 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->lbt == mode)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_LBT))
 		return -EOPNOTSUPP;
 
-- 
2.3.7

