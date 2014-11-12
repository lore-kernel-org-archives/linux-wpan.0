Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:52336 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbaKLCiB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:38:01 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so3502021wid.2
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:38:00 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/18] ieee820154: add max frame retries setting support
Date: Wed, 12 Nov 2014 03:37:03 +0100
Message-Id: <1415759825-8309-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch add support for setting mac frame retries setting via
nl802154 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  3 +++
 net/ieee802154/nl802154.c | 32 ++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |  9 +++++++++
 net/mac802154/cfg.c       | 16 ++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 79b9ae0..5c3bc12 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -48,6 +48,9 @@ struct cfg802154_ops {
 	int	(*set_max_csma_backoffs)(struct wpan_phy *wpan_phy,
 					 struct wpan_dev *wpan_dev,
 					 u8 max_csma_backoffs);
+	int	(*set_max_frame_retries)(struct wpan_phy *wpan_phy,
+					 struct wpan_dev *wpan_dev,
+					 s8 max_frame_retries);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index af38355..0e272c6 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -667,6 +667,30 @@ nl802154_set_max_csma_backoffs(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_max_csma_backoffs(rdev, wpan_dev, max_csma_backoffs);
 }
 
+static int
+nl802154_set_max_frame_retries(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	s8 max_frame_retries;
+
+	if (netif_running(dev))
+		return -EBUSY;
+
+	if (!info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES])
+		return -EINVAL;
+
+	max_frame_retries = nla_get_s8(
+			info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]);
+
+	/* check 802.15.4 constraints */
+	if (max_frame_retries < -1 || max_frame_retries > 7)
+		return -EINVAL;
+
+	return rdev_set_max_frame_retries(rdev, wpan_dev, max_frame_retries);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -817,6 +841,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_MAX_FRAME_RETRIES,
+		.doit = nl802154_set_max_frame_retries,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 263095c..f9171aa 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -59,4 +59,13 @@ rdev_set_max_csma_backoffs(struct cfg802154_registered_device *rdev,
 						max_csma_backoffs);
 }
 
+static inline int
+rdev_set_max_frame_retries(struct cfg802154_registered_device *rdev,
+			   struct wpan_dev *wpan_dev,
+			   const s8 max_frame_retries)
+{
+	return rdev->ops->set_max_frame_retries(&rdev->wpan_phy, wpan_dev,
+						max_frame_retries);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index d72feeb..a8f6eaa 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -140,6 +140,21 @@ static int ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
 	return 0;
 }
 
+static int ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
+					    struct wpan_dev *wpan_dev,
+					    const s8 max_frame_retries)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	ASSERT_RTNL();
+
+	if (!(local->hw.flags & IEEE802154_HW_FRAME_RETRIES))
+		return -EOPNOTSUPP;
+
+	wpan_dev->frame_retries = max_frame_retries;
+	return 0;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
@@ -148,4 +163,5 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_short_addr = ieee802154_set_short_addr,
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
 	.set_max_csma_backoffs = ieee802154_set_max_csma_backoffs,
+	.set_max_frame_retries = ieee802154_set_max_frame_retries,
 };
-- 
2.1.3

