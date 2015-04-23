Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33136 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbbDWQse (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:34 -0400
Received: by wgin8 with SMTP id n8so24785647wgi.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:33 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 04/15] mac802154: check for really changes
Date: Thu, 23 Apr 2015 18:47:43 +0200
Message-Id: <1429807674-24849-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

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
index eeda676..4fec61d 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -64,6 +64,18 @@ struct wpan_phy_cca {
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
index e53aec9..b6a986a 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -70,6 +70,10 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 
 	ASSERT_RTNL();
 
+	if (wpan_phy->current_page == page &&
+	    wpan_phy->current_channel == channel)
+		return 0;
+
 	ret = drv_set_channel(local, page, channel);
 	if (!ret) {
 		wpan_phy->current_page = page;
@@ -88,6 +92,9 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_phy_cca_cmp(&wpan_phy->cca, cca))
+		return 0;
+
 	/* check if phy support this setting */
 	if (!(local->hw.flags & IEEE802154_HW_CCA_MODE))
 		return -EOPNOTSUPP;
@@ -105,6 +112,9 @@ ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
+	if (wpan_dev->pan_id == pan_id)
+		return 0;
+
 	wpan_dev->pan_id = pan_id;
 	return 0;
 }
@@ -118,6 +128,10 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->min_be == min_be &&
+	    wpan_dev->max_be == max_be)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
 		return -EOPNOTSUPP;
 
@@ -132,6 +146,9 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
+	if (wpan_dev->short_addr == short_addr)
+		return 0;
+
 	wpan_dev->short_addr = short_addr;
 	return 0;
 }
@@ -145,6 +162,9 @@ ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->csma_retries == max_csma_backoffs)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
 		return -EOPNOTSUPP;
 
@@ -161,6 +181,9 @@ ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->frame_retries == max_frame_retries)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_FRAME_RETRIES))
 		return -EOPNOTSUPP;
 
@@ -176,6 +199,9 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 
 	ASSERT_RTNL();
 
+	if (wpan_dev->lbt == mode)
+		return 0;
+
 	if (!(local->hw.flags & IEEE802154_HW_LBT))
 		return -EOPNOTSUPP;
 
-- 
2.3.6

