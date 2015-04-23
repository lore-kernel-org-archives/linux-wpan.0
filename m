Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33244 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030228AbbDWQsk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:40 -0400
Received: by wgin8 with SMTP id n8so24788402wgi.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:39 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 09/15] ieee802154: add support for get tx powers
Date: Thu, 23 Apr 2015 18:47:48 +0200
Message-Id: <1429807674-24849-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for get transmit power levels. The driver needs
to implement a driver ops callback which can iterate over each transmit
power level index. This callback can return zero for successful
iteration, 1 for ending the iteration, 2 for continue the iteration
which an index increment and values below 0 zero if failed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h    |  1 +
 include/net/mac802154.h    | 10 ++++++++++
 net/ieee802154/rdev-ops.h  | 11 +++++++++++
 net/ieee802154/trace.h     | 31 +++++++++++++++++++++++++++++++
 net/mac802154/cfg.c        | 11 +++++++++++
 net/mac802154/driver-ops.h | 12 ++++++++++++
 6 files changed, 76 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index a4fde09..89995dd 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -42,6 +42,7 @@ struct cfg802154_ops {
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
 				const struct wpan_phy_cca *cca);
+	int	(*get_tx_powers)(struct wpan_phy *wpan_phy, s8 *dbm, u32 idx);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, __le16 pan_id);
 	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index e18e7fd..c489946 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -174,6 +174,14 @@ struct ieee802154_hw {
  *	  Set radio transmit power in dB. Called with pib_lock held.
  *	  Returns either zero, or negative errno.
  *
+ * get_txpowers:
+ *	  Get radio transmit powers in dB. Called when rtnl lock is held.
+ *	  Parameter idx descibes the index of transmit power which is supported.
+ *	  Returns either zero or negative errno. One should be returned for
+ *	  indicate to break the iteration of tx power settings. Two should be
+ *	  returned for skipping dbm but increment idx value, this can be useful
+ *	  for register to dbm array mapping.
+ *
  * set_lbt
  *	  Enables or disables listen before talk on the device. Called with
  *	  pib_lock held.
@@ -214,6 +222,8 @@ struct ieee802154_ops {
 					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
 	int		(*set_txpower)(struct ieee802154_hw *hw, s8 dbm);
+	int		(*get_tx_powers)(struct ieee802154_hw *hw, s8 *dbm,
+					 u32 idx);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw,
 					const struct wpan_phy_cca *cca);
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 624413e..d944a7a 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -71,6 +71,17 @@ rdev_set_cca_mode(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
+rdev_get_tx_powers(struct cfg802154_registered_device *rdev, s8 *dbm, u32 idx)
+{
+	int ret;
+
+	trace_802154_rdev_get_tx_powers(&rdev->wpan_phy, idx);
+	ret = rdev->ops->get_tx_powers(&rdev->wpan_phy, dbm, idx);
+	trace_802154_rdev_return_int_tx_powers(&rdev->wpan_phy, ret, dbm);
+	return ret;
+}
+
+static inline int
 rdev_set_pan_id(struct cfg802154_registered_device *rdev,
 		struct wpan_dev *wpan_dev, __le16 pan_id)
 {
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 8ed9f97..94ac3b9 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -108,6 +108,37 @@ TRACE_EVENT(802154_rdev_set_cca_mode,
 		  WPAN_CCA_PR_ARG)
 );
 
+TRACE_EVENT(802154_rdev_get_tx_powers,
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
+TRACE_EVENT(802154_rdev_return_int_tx_powers,
+	TP_PROTO(struct wpan_phy *wpan_phy, int ret, s8 *dbm),
+	TP_ARGS(wpan_phy, ret, dbm),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__field(int, ret)
+		__field(s8, dbm)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__entry->ret = ret;
+		__entry->dbm = *dbm;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", returned: %d, dbm: %d", WPAN_PHY_PR_ARG,
+		  __entry->ret, __entry->dbm)
+);
+
 DECLARE_EVENT_CLASS(802154_le16_template,
 	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		 __le16 le16arg),
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index c252a45..2b80a77 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -103,6 +103,16 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 }
 
 static int
+ieee802154_get_tx_powers(struct wpan_phy *wpan_phy, s8 *dbm, u32 idx)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	ASSERT_RTNL();
+
+	return drv_get_tx_powers(local, dbm, idx);
+}
+
+static int
 ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		      __le16 pan_id)
 {
@@ -192,6 +202,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
 	.set_cca_mode = ieee802154_set_cca_mode,
+	.get_tx_powers = ieee802154_get_tx_powers,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index a053335..08e2b09 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -70,6 +70,18 @@ static inline int drv_set_tx_power(struct ieee802154_local *local, s8 dbm)
 	return local->ops->set_txpower(&local->hw, dbm);
 }
 
+static inline int
+drv_get_tx_powers(struct ieee802154_local *local, s8 *dbm, u32 idx)
+{
+	might_sleep();
+
+	/* if not implemented indicate a empty list */
+	if (!local->ops->get_tx_powers)
+		return 1;
+
+	return local->ops->get_tx_powers(&local->hw, dbm, idx);
+}
+
 static inline int drv_set_cca_mode(struct ieee802154_local *local,
 				   const struct wpan_phy_cca *cca)
 {
-- 
2.3.6

