Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49488 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbaKLCh7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:59 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so12970385wgh.1
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:58 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/18] ieee820154: add max csma backoffs setting support
Date: Wed, 12 Nov 2014 03:37:01 +0100
Message-Id: <1415759825-8309-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch add support for max csma backoffs setting via nl802154
framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  3 +++
 net/ieee802154/nl802154.c | 33 +++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |  9 +++++++++
 net/mac802154/cfg.c       | 16 ++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 27e98d1..79b9ae0 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -45,6 +45,9 @@ struct cfg802154_ops {
 	int	(*set_backoff_exponent)(struct wpan_phy *wpan_phy,
 					struct wpan_dev *wpan_dev, u8 min_be,
 					u8 max_be);
+	int	(*set_max_csma_backoffs)(struct wpan_phy *wpan_phy,
+					 struct wpan_dev *wpan_dev,
+					 u8 max_csma_backoffs);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index d1cf302..af38355 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -642,6 +642,31 @@ nl802154_set_backoff_exponent(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
 }
 
+static int
+nl802154_set_max_csma_backoffs(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	u8 max_csma_backoffs;
+
+	/* conflict here while other running iface settings */
+	if (netif_running(dev))
+		return -EBUSY;
+
+	if (!info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS])
+		return -EINVAL;
+
+	max_csma_backoffs = nla_get_u8(
+			info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]);
+
+	/* check 802.15.4 constraints */
+	if (max_csma_backoffs > 5)
+		return -EINVAL;
+
+	return rdev_set_max_csma_backoffs(rdev, wpan_dev, max_csma_backoffs);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -784,6 +809,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_MAX_CSMA_BACKOFFS,
+		.doit = nl802154_set_max_csma_backoffs,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index dbccfa9..263095c 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -50,4 +50,13 @@ rdev_set_backoff_exponent(struct cfg802154_registered_device *rdev,
 					       min_be, max_be);
 }
 
+static inline int
+rdev_set_max_csma_backoffs(struct cfg802154_registered_device *rdev,
+			   struct wpan_dev *wpan_dev,
+			   const u8 max_csma_backoffs)
+{
+	return rdev->ops->set_max_csma_backoffs(&rdev->wpan_phy, wpan_dev,
+						max_csma_backoffs);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 67c96f9..d72feeb 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -125,6 +125,21 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 	return 0;
 }
 
+static int ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
+					    struct wpan_dev *wpan_dev,
+					    const u8 max_csma_backoffs)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	ASSERT_RTNL();
+
+	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
+		return -EOPNOTSUPP;
+
+	wpan_dev->csma_retries = max_csma_backoffs;
+	return 0;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
@@ -132,4 +147,5 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
+	.set_max_csma_backoffs = ieee802154_set_max_csma_backoffs,
 };
-- 
2.1.3

