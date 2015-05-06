Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34780 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbEFLlR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:17 -0400
Received: by wgso17 with SMTP id o17so8421768wgs.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 10/16] ieee802154: add support for get cca ed levels
Date: Wed,  6 May 2015 13:40:22 +0200
Message-Id: <1430912428-17284-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for get cca energy detection levels. The driver
needs to implement a driver ops callback which can iterate over each
transmit power level index. This callback can return zero for successful
iteration, 1 for ending the iteration, 2 for continue the iteration
which an index increment and values below 0 zero if failed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h    |  2 ++
 include/net/mac802154.h    |  8 ++++++++
 net/ieee802154/rdev-ops.h  | 12 ++++++++++++
 net/ieee802154/trace.h     | 14 ++++++++++++++
 net/mac802154/cfg.c        | 11 +++++++++++
 net/mac802154/driver-ops.h | 12 ++++++++++++
 6 files changed, 59 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 6758e61..3219ca9 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -45,6 +45,8 @@ struct cfg802154_ops {
 	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
 				const struct wpan_phy_cca *cca);
 	int	(*get_tx_powers)(struct wpan_phy *wpan_phy, s32 *mbm, u32 idx);
+	int	(*get_cca_ed_levels)(struct wpan_phy *wpan_phy, s32 *mbm,
+				     u32 idx);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, __le16 pan_id);
 	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index be8d3de..2d2afa0 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -180,6 +180,12 @@ struct ieee802154_hw {
  *	  Returns either zero or negative errno. One should be returned for
  *	  indicate to break the iteration of tx power settings.
  *
+ * get_cca_ed_levels
+ *	  Get cca ed levels in dBm for cca mode 3. Called when rtnl lock is
+ *	  held. Parameter idx descibes the index of cca ed levels which is
+ *	  supported. Returns either zero or negative errno. One should be
+ *	  returned to break the iteration of cca ed levels setting.
+ *
  * set_lbt
  *	  Enables or disables listen before talk on the device. Called with
  *	  pib_lock held.
@@ -222,6 +228,8 @@ struct ieee802154_ops {
 	int		(*set_txpower)(struct ieee802154_hw *hw, s32 mbm);
 	int		(*get_tx_powers)(struct ieee802154_hw *hw, s32 *mbm,
 					 u32 idx);
+	int		(*get_cca_ed_levels)(struct ieee802154_hw *hw,
+					     s32 *dbm, u32 idx);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw,
 					const struct wpan_phy_cca *cca);
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 8fc1afe..658afc6 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -75,6 +75,18 @@ rdev_set_cca_mode(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
+rdev_get_cca_ed_levels(struct cfg802154_registered_device *rdev, s32 *mbm,
+		       u32 idx)
+{
+	int ret;
+
+	trace_802154_rdev_get_cca_ed_levels(&rdev->wpan_phy, idx);
+	ret = rdev->ops->get_cca_ed_levels(&rdev->wpan_phy, mbm, idx);
+	trace_802154_rdev_return_int_mbm(&rdev->wpan_phy, ret, mbm);
+	return ret;
+}
+
+static inline int
 rdev_get_tx_powers(struct cfg802154_registered_device *rdev, s32 *mbm, u32 idx)
 {
 	int ret;
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 3c54b5e..d4bcdba 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -108,6 +108,20 @@ TRACE_EVENT(802154_rdev_set_cca_mode,
 		  WPAN_CCA_PR_ARG)
 );
 
+TRACE_EVENT(802154_rdev_get_cca_ed_levels,
+	TP_PROTO(struct wpan_phy *wpan_phy, u32 idx),
+	TP_ARGS(wpan_phy, idx),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__field(u32, idx)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__entry->idx = idx;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", idx: %d", WPAN_PHY_PR_ARG, __entry->idx)
+);
+
 TRACE_EVENT(802154_rdev_get_tx_powers,
 	TP_PROTO(struct wpan_phy *wpan_phy, u32 idx),
 	TP_ARGS(wpan_phy, idx),
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 4228069..b839f6d 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -106,6 +106,16 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 }
 
 static int
+ieee802154_get_cca_ed_levels(struct wpan_phy *wpan_phy, s32 *mbm, u32 idx)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	ASSERT_RTNL();
+
+	return drv_get_cca_ed_levels(local, mbm, idx);
+}
+
+static int
 ieee802154_get_tx_powers(struct wpan_phy *wpan_phy, s32 *mbm, u32 idx)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
@@ -206,6 +216,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_channel = ieee802154_set_channel,
 	.set_cca_mode = ieee802154_set_cca_mode,
 	.get_tx_powers = ieee802154_get_tx_powers,
+	.get_cca_ed_levels = ieee802154_get_cca_ed_levels,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 27a59dc..75e1f2a 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -120,6 +120,18 @@ drv_set_cca_ed_level(struct ieee802154_local *local, s32 mbm)
 	return local->ops->set_cca_ed_level(&local->hw, mbm);
 }
 
+static inline int
+drv_get_cca_ed_levels(struct ieee802154_local *local, s32 *mbm, u32 idx)
+{
+	might_sleep();
+
+	/* if not implemented indicate a empty list */
+	if (!local->ops->get_tx_powers)
+		return 1;
+
+	return local->ops->get_cca_ed_levels(&local->hw, mbm, idx);
+}
+
 static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
 {
 	struct ieee802154_hw_addr_filt filt;
-- 
2.3.7

