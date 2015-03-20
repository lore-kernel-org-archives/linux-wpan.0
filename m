Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35476 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbCTHW6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 03:22:58 -0400
Received: by pdbop1 with SMTP id op1so100772091pdb.2
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 00:22:57 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154: add set transmit power support
Date: Fri, 20 Mar 2015 12:52:18 +0530
Message-Id: <1426836141-21528-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch adds transmission power setting support to nl802154.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/cfg802154.h   |    1 +
 net/ieee802154/nl802154.c |   20 ++++++++++++++++++++
 net/ieee802154/rdev-ops.h |    7 +++++++
 net/mac802154/cfg.c       |   19 +++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index eeda676..b163d4e 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -57,6 +57,7 @@ struct cfg802154_ops {
 					 s8 max_frame_retries);
 	int	(*set_lbt_mode)(struct wpan_phy *wpan_phy,
 				struct wpan_dev *wpan_dev, bool mode);
+	int	(*set_tx_power)(struct wpan_phy *wpan_phy, s8 power);
 };
 
 struct wpan_phy_cca {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a4daf91..8288fcb 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -794,6 +794,18 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
 }
 
+static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	s8 power;
+
+	if (!info->attrs[NL802154_ATTR_TX_POWER])
+		return -EINVAL;
+
+	power = nla_get_s8(info->attrs[NL802154_ATTR_TX_POWER]);
+	return rdev_set_tx_power(rdev, power);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -984,6 +996,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_TX_POWER,
+		.doit = nl802154_set_tx_power,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 7c46732..3de05a8 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -91,6 +91,13 @@ rdev_set_lbt_mode(struct cfg802154_registered_device *rdev,
 		  struct wpan_dev *wpan_dev, bool mode)
 {
 	return rdev->ops->set_lbt_mode(&rdev->wpan_phy, wpan_dev, mode);
+
 }
 
+static inline int
+rdev_set_tx_power(struct cfg802154_registered_device *rdev,
+		  u8 power)
+{
+	return rdev->ops->set_tx_power(&rdev->wpan_phy, power);
+}
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 5d9f68c..dde26f1 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -212,6 +212,24 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 	return 0;
 }
 
+static int
+ieee802154_set_tx_power(struct wpan_phy *wpan_phy, s8 power)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (!(local->hw.flags & IEEE802154_HW_TXPOWER))
+		return -EOPNOTSUPP;
+
+	ret = drv_set_tx_power(local, power);
+	if (!ret)
+		wpan_phy->transmit_power = power;
+
+	return ret;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
@@ -225,4 +243,5 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_max_csma_backoffs = ieee802154_set_max_csma_backoffs,
 	.set_max_frame_retries = ieee802154_set_max_frame_retries,
 	.set_lbt_mode = ieee802154_set_lbt_mode,
+	.set_tx_power = ieee802154_set_tx_power,
 };
-- 
1.7.9.5

