Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:47795 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbaKLCh5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:57 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so3478869wid.14
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/18] ieee820154: add backoff exponent setting support
Date: Wed, 12 Nov 2014 03:36:59 +0100
Message-Id: <1415759825-8309-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting backoff exponents via nl802154
framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  3 +++
 net/ieee802154/nl802154.c | 34 ++++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |  9 +++++++++
 net/mac802154/cfg.c       | 18 ++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index e8a4c2b..27e98d1 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -42,6 +42,9 @@ struct cfg802154_ops {
 			      struct wpan_dev *wpan_dev, u16 pan_id);
 	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
 				  struct wpan_dev *wpan_dev, u16 short_addr);
+	int	(*set_backoff_exponent)(struct wpan_phy *wpan_phy,
+					struct wpan_dev *wpan_dev, u8 min_be,
+					u8 max_be);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 2978c1a..d1cf302 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -616,6 +616,32 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_short_addr(rdev, wpan_dev, short_addr);
 }
 
+static int
+nl802154_set_backoff_exponent(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	u8 min_be, max_be;
+
+	/* should be set on netif open inside phy settings */
+	if (netif_running(dev))
+		return -EBUSY;
+
+	if (!info->attrs[NL802154_ATTR_MIN_BE] ||
+	    !info->attrs[NL802154_ATTR_MAX_BE])
+		return -EINVAL;
+
+	min_be = nla_get_u8(info->attrs[NL802154_ATTR_MIN_BE]);
+	max_be = nla_get_u8(info->attrs[NL802154_ATTR_MAX_BE]);
+
+	/* check 802.15.4 constraints */
+	if (max_be < 3 || max_be > 8 || min_be > max_be)
+		return -EINVAL;
+
+	return rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -750,6 +776,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_BACKOFF_EXPONENT,
+		.doit = nl802154_set_backoff_exponent,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 16b0de0..dbccfa9 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -41,4 +41,13 @@ rdev_set_short_addr(struct cfg802154_registered_device *rdev,
 	return rdev->ops->set_short_addr(&rdev->wpan_phy, wpan_dev, short_addr);
 }
 
+static inline int
+rdev_set_backoff_exponent(struct cfg802154_registered_device *rdev,
+			  struct wpan_dev *wpan_dev, const u8 min_be,
+			  const u8 max_be)
+{
+	return rdev->ops->set_backoff_exponent(&rdev->wpan_phy, wpan_dev,
+					       min_be, max_be);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index df29976..67c96f9 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -84,6 +84,23 @@ static int ieee802154_set_pan_id(struct wpan_phy *wpan_phy,
 }
 
 static int
+ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
+				struct wpan_dev *wpan_dev,
+				const u8 min_be, const u8 max_be)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	ASSERT_RTNL();
+
+	if (!(local->hw.flags & IEEE802154_HW_CSMA_PARAMS))
+		return -EOPNOTSUPP;
+
+	wpan_dev->min_be = min_be;
+	wpan_dev->max_be = max_be;
+	return 0;
+}
+
+static int
 ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 			  const u16 short_addr)
 {
@@ -114,4 +131,5 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_channel = ieee802154_set_channel,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
+	.set_backoff_exponent = ieee802154_set_backoff_exponent,
 };
-- 
2.1.3

