Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36912 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbbEFLlJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:09 -0400
Received: by widdi4 with SMTP id di4so18825132wid.0
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 03/16] ieee802154: change cca ed level to mbm
Date: Wed,  6 May 2015 13:40:15 +0200
Message-Id: <1430912428-17284-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch change the handling of cca energy detection level from dbm to
mbm. This prepares to handle floating point cca energy detection levels
values. The old netlink 802.15.4 will convert the dbm value to mbm for
handling backward compatibility.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ++-
 include/net/cfg802154.h            | 1 +
 include/net/mac802154.h            | 5 ++---
 net/ieee802154/nl-mac.c            | 4 ++--
 net/mac802154/driver-ops.h         | 4 ++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 3a303e4..e68d45e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1268,9 +1268,10 @@ at86rf23x_get_desens_steps(struct at86rf230_local *lp, s32 level)
 }
 
 static int
-at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 level)
+at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct at86rf230_local *lp = hw->priv;
+	s32 level = mbm / 100;
 
 	if (level < lp->data->rssi_base_val || level > 30)
 		return -EINVAL;
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index b5b3f9f..9ced2c9 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -91,6 +91,7 @@ struct wpan_phy {
 
 	__le64 perm_extended_addr;
 
+	/* current cca ed threshold in mBm */
 	s32 cca_ed_level;
 
 	/* PHY depended MAC PIB values */
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index beb07ce..3b76aab 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -184,7 +184,7 @@ struct ieee802154_hw {
  *	  Returns either zero, or negative errno.
  *
  * set_cca_ed_level
- *	  Sets the CCA energy detection threshold in dBm. Called with pib_lock
+ *	  Sets the CCA energy detection threshold in mBm. Called with pib_lock
  *	  held.
  *	  Returns either zero, or negative errno.
  *
@@ -217,8 +217,7 @@ struct ieee802154_ops {
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw,
 					const struct wpan_phy_cca *cca);
-	int		(*set_cca_ed_level)(struct ieee802154_hw *hw,
-					    s32 level);
+	int		(*set_cca_ed_level)(struct ieee802154_hw *hw, s32 mbm);
 	int		(*set_csma_params)(struct ieee802154_hw *hw,
 					   u8 min_be, u8 max_be, u8 retries);
 	int		(*set_frame_retries)(struct ieee802154_hw *hw,
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 4ba2e13..cdc1cc3 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -122,7 +122,7 @@ static int ieee802154_nl_fill_iface(struct sk_buff *msg, u32 portid,
 		    nla_put_u8(msg, IEEE802154_ATTR_CCA_MODE,
 			       params.cca.mode) ||
 		    nla_put_s32(msg, IEEE802154_ATTR_CCA_ED_LEVEL,
-				params.cca_ed_level) ||
+				params.cca_ed_level / 100) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_CSMA_RETRIES,
 			       params.csma_retries) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_CSMA_MIN_BE,
@@ -519,7 +519,7 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 		params.cca.mode = nla_get_u8(info->attrs[IEEE802154_ATTR_CCA_MODE]);
 
 	if (info->attrs[IEEE802154_ATTR_CCA_ED_LEVEL])
-		params.cca_ed_level = nla_get_s32(info->attrs[IEEE802154_ATTR_CCA_ED_LEVEL]);
+		params.cca_ed_level = nla_get_s32(info->attrs[IEEE802154_ATTR_CCA_ED_LEVEL]) * 100;
 
 	if (info->attrs[IEEE802154_ATTR_CSMA_RETRIES])
 		params.csma_retries = nla_get_u8(info->attrs[IEEE802154_ATTR_CSMA_RETRIES]);
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index d289ae3..caecd5f 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -96,7 +96,7 @@ static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
 }
 
 static inline int
-drv_set_cca_ed_level(struct ieee802154_local *local, s32 ed_level)
+drv_set_cca_ed_level(struct ieee802154_local *local, s32 mbm)
 {
 	might_sleep();
 
@@ -105,7 +105,7 @@ drv_set_cca_ed_level(struct ieee802154_local *local, s32 ed_level)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_cca_ed_level(&local->hw, ed_level);
+	return local->ops->set_cca_ed_level(&local->hw, mbm);
 }
 
 static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
-- 
2.3.7

