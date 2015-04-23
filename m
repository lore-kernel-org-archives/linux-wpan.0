Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37456 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbbDWQsi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:38 -0400
Received: by widdi4 with SMTP id di4so99343738wid.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:36 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 07/15] ieee802154: add several phy supported handling
Date: Thu, 23 Apr 2015 18:47:46 +0200
Message-Id: <1429807674-24849-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for phy supported handling for all other already
existing handling 802.15.4 functionality. We assume now a fully 802.15.4
complaint transceiver at phy allocation. If a transceiver can support
802.15.4 default values only, then the values should be overwirtten by
values the transceiver supports. If the transceiver doesn't set the
according hardware flags, we assume the 802.15.4 defaults now which
cannot be changed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
---
 include/net/cfg802154.h   | 24 +++++++++++++++++++++++-
 include/net/nl802154.h    | 22 ++++++++++++++++++++++
 net/ieee802154/nl802154.c | 22 +++++++++++++++++-----
 net/mac802154/main.c      | 26 ++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 7448603..0a2d367 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -59,8 +59,30 @@ struct cfg802154_ops {
 				struct wpan_dev *wpan_dev, bool mode);
 };
 
+static inline bool
+wpan_phy_supported_bool(bool b, enum nl802154_supported_bool_states st)
+{
+	switch (st) {
+	case NL802154_SUPPORTED_BOOL_TRUE:
+		return b;
+	case NL802154_SUPPORTED_BOOL_FALSE:
+		return !b;
+	case NL802154_SUPPORTED_BOOL_BOTH:
+		return true;
+	default:
+		WARN_ON(1);
+	}
+
+	return false;
+}
+
 struct wpan_phy_supported {
-	u32 channels[IEEE802154_MAX_PAGE + 1];
+	u32 channels[IEEE802154_MAX_PAGE + 1],
+	    cca_modes, cca_opts;
+	enum nl802154_supported_bool_states lbt;
+	u8 min_minbe, max_minbe, min_maxbe, max_maxbe,
+	   min_csma_backoffs, max_csma_backoffs;
+	s8 min_frame_retries, max_frame_retries;
 };
 
 struct wpan_phy_cca {
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index f8b5bc9..0552771 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -162,4 +162,26 @@ enum nl802154_cca_opts {
 	NL802154_CCA_OPT_ATTR_MAX = __NL802154_CCA_OPT_ATTR_AFTER_LAST - 1
 };
 
+/**
+ * enum nl802154_supported_bool_states - bool states for bool capability entry
+ *
+ * @NL802154_SUPPORTED_BOOL_FALSE: indicates to set false
+ * @NL802154_SUPPORTED_BOOL_TRUE: indicates to set true
+ * @__NL802154_SUPPORTED_BOOL_INVALD: reserved
+ * @NL802154_SUPPORTED_BOOL_BOTH: indicates to set true and false
+ * @__NL802154_SUPPORTED_BOOL_AFTER_LAST: Internal
+ * @NL802154_SUPPORTED_BOOL_MAX: highest value for bool states
+ */
+enum nl802154_supported_bool_states {
+	NL802154_SUPPORTED_BOOL_FALSE,
+	NL802154_SUPPORTED_BOOL_TRUE,
+	/* to handle them in a mask */
+	__NL802154_SUPPORTED_BOOL_INVALD,
+	NL802154_SUPPORTED_BOOL_BOTH,
+
+	/* keep last */
+	__NL802154_SUPPORTED_BOOL_AFTER_LAST,
+	NL802154_SUPPORTED_BOOL_MAX = __NL802154_SUPPORTED_BOOL_AFTER_LAST - 1
+};
+
 #endif /* __NL802154_H */
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index ef99ad6..779e7d9 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -642,7 +642,9 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 
 	cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
 	/* checking 802.15.4 constraints */
-	if (cca.mode < NL802154_CCA_ENERGY || cca.mode > NL802154_CCA_ATTR_MAX)
+	if (cca.mode < NL802154_CCA_ENERGY ||
+	    cca.mode > NL802154_CCA_ATTR_MAX ||
+	    !(rdev->wpan_phy.supported.cca_modes & BIT(cca.mode)))
 		return -EINVAL;
 
 	if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
@@ -650,7 +652,8 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 
 		cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
-		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
+		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX ||
+		    !(rdev->wpan_phy.supported.cca_opts & BIT(cca.opt)))
 			return -EINVAL;
 	}
 
@@ -744,7 +747,11 @@ nl802154_set_backoff_exponent(struct sk_buff *skb, struct genl_info *info)
 	max_be = nla_get_u8(info->attrs[NL802154_ATTR_MAX_BE]);
 
 	/* check 802.15.4 constraints */
-	if (max_be < 3 || max_be > 8 || min_be > max_be)
+	if (min_be < rdev->wpan_phy.supported.min_minbe ||
+	    min_be > rdev->wpan_phy.supported.max_minbe ||
+	    max_be < rdev->wpan_phy.supported.min_maxbe ||
+	    max_be > rdev->wpan_phy.supported.max_maxbe ||
+	    min_be > max_be)
 		return -EINVAL;
 
 	return rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
@@ -769,7 +776,8 @@ nl802154_set_max_csma_backoffs(struct sk_buff *skb, struct genl_info *info)
 			info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]);
 
 	/* check 802.15.4 constraints */
-	if (max_csma_backoffs > 5)
+	if (max_csma_backoffs < rdev->wpan_phy.supported.min_csma_backoffs ||
+	    max_csma_backoffs > rdev->wpan_phy.supported.max_csma_backoffs)
 		return -EINVAL;
 
 	return rdev_set_max_csma_backoffs(rdev, wpan_dev, max_csma_backoffs);
@@ -793,7 +801,8 @@ nl802154_set_max_frame_retries(struct sk_buff *skb, struct genl_info *info)
 			info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]);
 
 	/* check 802.15.4 constraints */
-	if (max_frame_retries < -1 || max_frame_retries > 7)
+	if (max_frame_retries < rdev->wpan_phy.supported.min_frame_retries ||
+	    max_frame_retries > rdev->wpan_phy.supported.max_frame_retries)
 		return -EINVAL;
 
 	return rdev_set_max_frame_retries(rdev, wpan_dev, max_frame_retries);
@@ -813,6 +822,9 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
+	if (!wpan_phy_supported_bool(mode, rdev->wpan_phy.supported.lbt))
+		return -EINVAL;
+
 	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
 }
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 8500378..68d08c4 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -107,6 +107,15 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 
 	skb_queue_head_init(&local->skb_queue);
 
+	/* init supported flags with 802.15.4 default ranges */
+	phy->supported.max_minbe = 8;
+	phy->supported.min_maxbe = 3;
+	phy->supported.max_maxbe = 8;
+	phy->supported.min_frame_retries = -1;
+	phy->supported.max_frame_retries = 7;
+	phy->supported.max_csma_backoffs = 5;
+	phy->supported.lbt = NL802154_SUPPORTED_BOOL_FALSE;
+
 	return &local->hw;
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
@@ -155,6 +164,23 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	ieee802154_setup_wpan_phy_pib(local->phy);
 
+	if (!(hw->flags & IEEE802154_HW_CSMA_PARAMS)) {
+		local->phy->supported.min_csma_backoffs = 4;
+		local->phy->supported.max_csma_backoffs = 4;
+		local->phy->supported.min_maxbe = 5;
+		local->phy->supported.max_maxbe = 5;
+		local->phy->supported.min_minbe = 3;
+		local->phy->supported.max_minbe = 3;
+	}
+
+	if (!(hw->flags & IEEE802154_HW_FRAME_RETRIES)) {
+		/* TODO should be 3, but our default value is -1 which means
+		 * no ARET handling.
+		 */
+		local->phy->supported.min_frame_retries = -1;
+		local->phy->supported.max_frame_retries = -1;
+	}
+
 	rc = wpan_phy_register(local->phy);
 	if (rc < 0)
 		goto out_wq;
-- 
2.3.6

