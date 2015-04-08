Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36022 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbDHLTB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 07:19:01 -0400
Received: by wizk4 with SMTP id k4so50840558wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 04:19:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 3/4] ieee802154: add several phy supported handling
Date: Wed,  8 Apr 2015 13:18:31 +0200
Message-Id: <1428491912-14027-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for phy supported handling for all other already
existing handling 802.15.4 functionality. We assume now a fully 802.15.4
complaint transceiver at phy allocation. If a transceiver can support
802.15.4 default values only, then the values should be overwirtten by
values the transceiver supports.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
---
 include/net/cfg802154.h   |  5 +++++
 net/ieee802154/nl802154.c | 31 +++++++++++++++++++++----------
 net/mac802154/main.c      | 10 ++++++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index c4d42ad..c9d09b1 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -61,6 +61,11 @@ struct cfg802154_ops {
 
 struct wpan_phy_supported {
 	u32 channels[IEEE802154_MAX_PAGE + 1];
+	u8 cca_modes, cca_opts;
+	u8 min_minbe, max_minbe, min_maxbe, max_maxbe;
+	s8 min_frame_retries, max_frame_retries;
+	u8 min_csma_backoffs, max_csma_backoffs;
+	bool lbt;
 };
 
 struct wpan_phy_cca {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 4ea64ef..7e3b2cc 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -625,11 +625,8 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
 
 	/* check 802.15.4 constraints */
-	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL)
-		return -EINVAL;
-
-	/* check if phy support this setting */
-	if (!(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
+	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL ||
+	    !(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
 		return -EINVAL;
 
 	return rdev_set_channel(rdev, page, channel);
@@ -645,7 +642,9 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 
 	cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
 	/* checking 802.15.4 constraints */
-	if (cca.mode < NL802154_CCA_ENERGY || cca.mode > NL802154_CCA_ATTR_MAX)
+	if (cca.mode < NL802154_CCA_ENERGY ||
+	    cca.mode > NL802154_CCA_ATTR_MAX ||
+	    !(rdev->wpan_phy.supported.cca_modes & BIT(cca.mode)))
 		return -EINVAL;
 
 	if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
@@ -653,7 +652,8 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 
 		cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
-		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
+		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX ||
+		    !(rdev->wpan_phy.supported.cca_opts & BIT(cca.opt)))
 			return -EINVAL;
 	}
 
@@ -726,7 +726,11 @@ nl802154_set_backoff_exponent(struct sk_buff *skb, struct genl_info *info)
 	max_be = nla_get_u8(info->attrs[NL802154_ATTR_MAX_BE]);
 
 	/* check 802.15.4 constraints */
-	if (max_be < 3 || max_be > 8 || min_be > max_be)
+	if (max_be < 3 || max_be > 8 || min_be > max_be ||
+	    min_be < rdev->wpan_phy.supported.min_minbe ||
+	    min_be > rdev->wpan_phy.supported.max_minbe ||
+	    max_be < rdev->wpan_phy.supported.min_maxbe ||
+	    max_be > rdev->wpan_phy.supported.max_maxbe)
 		return -EINVAL;
 
 	return rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
@@ -751,7 +755,9 @@ nl802154_set_max_csma_backoffs(struct sk_buff *skb, struct genl_info *info)
 			info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]);
 
 	/* check 802.15.4 constraints */
-	if (max_csma_backoffs > 5)
+	if (max_csma_backoffs > 5 ||
+	    max_csma_backoffs < rdev->wpan_phy.supported.min_csma_backoffs ||
+	    max_csma_backoffs > rdev->wpan_phy.supported.max_csma_backoffs)
 		return -EINVAL;
 
 	return rdev_set_max_csma_backoffs(rdev, wpan_dev, max_csma_backoffs);
@@ -775,7 +781,9 @@ nl802154_set_max_frame_retries(struct sk_buff *skb, struct genl_info *info)
 			info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]);
 
 	/* check 802.15.4 constraints */
-	if (max_frame_retries < -1 || max_frame_retries > 7)
+	if (max_frame_retries < -1 || max_frame_retries > 7 ||
+	    max_frame_retries < rdev->wpan_phy.supported.min_frame_retries ||
+	    max_frame_retries > rdev->wpan_phy.supported.max_frame_retries)
 		return -EINVAL;
 
 	return rdev_set_max_frame_retries(rdev, wpan_dev, max_frame_retries);
@@ -795,6 +803,9 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
+	if (mode && !rdev->wpan_phy.supported.lbt)
+		return -ENOTSUPP;
+
 	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
 }
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 8500378..a92eb5f 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -107,6 +107,16 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 
 	skb_queue_head_init(&local->skb_queue);
 
+	/* init supported flags with 802.15.4 constraints */
+	phy->supported.max_minbe = 8;
+	phy->supported.min_maxbe = 3;
+	phy->supported.max_maxbe = 8;
+	phy->supported.min_frame_retries = -1;
+	phy->supported.max_frame_retries = 7;
+	phy->supported.max_csma_backoffs = 5;
+	phy->supported.cca_modes = 0xFF;
+	phy->supported.cca_opts = 0xFF;
+
 	return &local->hw;
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
-- 
2.3.5

