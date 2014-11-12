Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62464 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbaKLCiE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:38:04 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so12981406wgg.9
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:38:03 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 18/18] ieee820154: add lbt setting support
Date: Wed, 12 Nov 2014 03:37:05 +0100
Message-Id: <1415759825-8309-19-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting listen before transmit mode via
nl802154 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  2 ++
 net/ieee802154/nl802154.c | 25 +++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |  7 +++++++
 net/mac802154/cfg.c       | 16 ++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 5c3bc12..fa0a9e5 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -51,6 +51,8 @@ struct cfg802154_ops {
 	int	(*set_max_frame_retries)(struct wpan_phy *wpan_phy,
 					 struct wpan_dev *wpan_dev,
 					 s8 max_frame_retries);
+	int	(*set_lbt_mode)(struct wpan_phy *wpan_phy,
+				struct wpan_dev *wpan_dev, bool mode);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 0e272c6..ccdf33e 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -691,6 +691,23 @@ nl802154_set_max_frame_retries(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_max_frame_retries(rdev, wpan_dev, max_frame_retries);
 }
 
+static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	bool mode;
+
+	if (netif_running(dev))
+		return -EBUSY;
+
+	if (!info->attrs[NL802154_ATTR_LBT_MODE])
+		return -EINVAL;
+
+	mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
+	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -849,6 +866,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_LBT_MODE,
+		.doit = nl802154_set_lbt_mode,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index f9171aa..a78f700 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -68,4 +68,11 @@ rdev_set_max_frame_retries(struct cfg802154_registered_device *rdev,
 						max_frame_retries);
 }
 
+static inline int
+rdev_set_lbt_mode(struct cfg802154_registered_device *rdev,
+		  struct wpan_dev *wpan_dev, const bool mode)
+{
+	return rdev->ops->set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index a8f6eaa..5d669d8 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -155,6 +155,21 @@ static int ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
 	return 0;
 }
 
+static int ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy,
+				   struct wpan_dev *wpan_dev,
+				   const bool mode)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	ASSERT_RTNL();
+
+	if (!(local->hw.flags & IEEE802154_HW_LBT))
+		return -EOPNOTSUPP;
+
+	wpan_dev->lbt = mode;
+	return 0;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
@@ -164,4 +179,5 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
 	.set_max_csma_backoffs = ieee802154_set_max_csma_backoffs,
 	.set_max_frame_retries = ieee802154_set_max_frame_retries,
+	.set_lbt_mode = ieee802154_set_lbt_mode,
 };
-- 
2.1.3

