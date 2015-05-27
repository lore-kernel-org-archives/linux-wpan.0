Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36448 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbE0LmU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 07:42:20 -0400
Received: by wizk4 with SMTP id k4so108313213wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 04:42:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] nl802154: add support to set cca ed level
Date: Wed, 27 May 2015 13:42:10 +0200
Message-Id: <1432726930-20126-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432726930-20126-1-git-send-email-alex.aring@gmail.com>
References: <1432726930-20126-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting the current cca ed level value over
nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  1 +
 net/ieee802154/nl802154.c | 30 ++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h | 11 +++++++++++
 net/ieee802154/trace.h    | 15 +++++++++++++++
 net/mac802154/cfg.c       | 19 +++++++++++++++++++
 5 files changed, 76 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 2e3bb01..290a9a6 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -44,6 +44,7 @@ struct cfg802154_ops {
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
 				const struct wpan_phy_cca *cca);
+	int     (*set_cca_ed_level)(struct wpan_phy *wpan_phy, s32 ed_level);
 	int     (*set_tx_power)(struct wpan_phy *wpan_phy, s32 power);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, __le16 pan_id);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a89d9d0..7dbb1f4 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -790,6 +790,28 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_cca_mode(rdev, &cca);
 }
 
+static int nl802154_set_cca_ed_level(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	s32 ed_level;
+	int i;
+
+	if (!(rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_ED_LEVEL))
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL802154_ATTR_CCA_ED_LEVEL])
+		return -EINVAL;
+
+	ed_level = nla_get_s32(info->attrs[NL802154_ATTR_CCA_ED_LEVEL]);
+
+	for (i = 0; i < rdev->wpan_phy.supported.cca_ed_levels_size; i++) {
+		if (ed_level == rdev->wpan_phy.supported.cca_ed_levels[i])
+			return rdev_set_cca_ed_level(rdev, ed_level);
+	}
+
+	return -EINVAL;
+}
+
 static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
@@ -1123,6 +1145,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_SET_CCA_ED_LEVEL,
+		.doit = nl802154_set_cca_ed_level,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_SET_TX_POWER,
 		.doit = nl802154_set_tx_power,
 		.policy = nl802154_policy,
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 3645611..b2155a1 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -75,6 +75,17 @@ rdev_set_cca_mode(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
+rdev_set_cca_ed_level(struct cfg802154_registered_device *rdev, s32 ed_level)
+{
+	int ret;
+
+	trace_802154_rdev_set_cca_ed_level(&rdev->wpan_phy, ed_level);
+	ret = rdev->ops->set_cca_ed_level(&rdev->wpan_phy, ed_level);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
+}
+
+static inline int
 rdev_set_tx_power(struct cfg802154_registered_device *rdev,
 		  s32 power)
 {
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 1f1cecc..257806d 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -123,6 +123,21 @@ TRACE_EVENT(802154_rdev_set_cca_mode,
 		  WPAN_CCA_PR_ARG)
 );
 
+TRACE_EVENT(802154_rdev_set_cca_ed_level,
+	TP_PROTO(struct wpan_phy *wpan_phy, s32 ed_level),
+	TP_ARGS(wpan_phy, ed_level),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__field(s32, ed_level)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__entry->ed_level = ed_level;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", ed_level: %d", WPAN_PHY_PR_ARG,
+		  __entry->ed_level)
+);
+
 DECLARE_EVENT_CLASS(802154_le16_template,
 	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		 __le16 le16arg),
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index ab12fa2..317c466 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -106,6 +106,24 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 }
 
 static int
+ieee802154_set_cca_ed_level(struct wpan_phy *wpan_phy, s32 ed_level)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (wpan_phy->cca_ed_level == ed_level)
+		return 0;
+
+	ret = drv_set_cca_ed_level(local, ed_level);
+	if (!ret)
+		wpan_phy->cca_ed_level = ed_level;
+
+	return ret;
+}
+
+static int
 ieee802154_set_tx_power(struct wpan_phy *wpan_phy, s32 power)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
@@ -213,6 +231,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
 	.set_cca_mode = ieee802154_set_cca_mode,
+	.set_cca_ed_level = ieee802154_set_cca_ed_level,
 	.set_tx_power = ieee802154_set_tx_power,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
-- 
2.4.1

