Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37016 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbEFLlP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:15 -0400
Received: by widdi4 with SMTP id di4so18827658wid.0
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 08/16] ieee802154: add iftypes capability
Date: Wed,  6 May 2015 13:40:20 +0200
Message-Id: <1430912428-17284-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds capability flags for supported interface types.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   | 2 +-
 net/ieee802154/nl802154.c | 3 ++-
 net/mac802154/main.c      | 6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index de00e5c..387db39 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -80,7 +80,7 @@ wpan_phy_supported_bool(bool b, enum nl802154_supported_bool_states st)
 
 struct wpan_phy_supported {
 	u32 channels[IEEE802154_MAX_PAGE + 1],
-	    cca_modes, cca_opts;
+	    cca_modes, cca_opts, iftypes;
 	enum nl802154_supported_bool_states lbt;
 	u8 min_minbe, max_minbe, min_maxbe, max_maxbe,
 	   min_csma_backoffs, max_csma_backoffs;
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index fa0c404..00b646d 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -575,7 +575,8 @@ static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL802154_ATTR_IFTYPE]) {
 		type = nla_get_u32(info->attrs[NL802154_ATTR_IFTYPE]);
-		if (type > NL802154_IFTYPE_MAX)
+		if (type > NL802154_IFTYPE_MAX ||
+		    !(rdev->wpan_phy.supported.iftypes & BIT(type)))
 			return -EINVAL;
 	}
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 8834fa7..f3c0a46 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -116,6 +116,9 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	phy->supported.max_csma_backoffs = 5;
 	phy->supported.lbt = NL802154_SUPPORTED_BOOL_FALSE;
 
+	/* always supported */
+	phy->supported.iftypes = BIT(NL802154_IFTYPE_NODE);
+
 	return &local->hw;
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
@@ -181,6 +184,9 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 		local->phy->supported.max_frame_retries = -1;
 	}
 
+	if (hw->flags & IEEE802154_HW_PROMISCUOUS)
+		local->phy->supported.iftypes |= BIT(NL802154_IFTYPE_MONITOR);
+
 	rc = wpan_phy_register(local->phy);
 	if (rc < 0)
 		goto out_wq;
-- 
2.3.7

