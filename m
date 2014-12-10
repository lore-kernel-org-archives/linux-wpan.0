Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:55495 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390AbaLJOdh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Dec 2014 09:33:37 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so3774860wgg.7
        for <linux-wpan@vger.kernel.org>; Wed, 10 Dec 2014 06:33:36 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/4] nl802154: introduce support for cca settings
Date: Wed, 10 Dec 2014 15:33:13 +0100
Message-Id: <1418221994-17976-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
References: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting cca parameters via nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  3 +++
 include/net/nl802154.h    |  2 +-
 net/ieee802154/nl802154.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 net/ieee802154/rdev-ops.h |  7 +++++++
 net/mac802154/cfg.c       | 21 +++++++++++++++++++++
 5 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 6ee2618..eeda676 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -25,6 +25,7 @@
 #include <net/nl802154.h>
 
 struct wpan_phy;
+struct wpan_phy_cca;
 
 struct cfg802154_ops {
 	struct net_device * (*add_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
@@ -39,6 +40,8 @@ struct cfg802154_ops {
 	int	(*del_virtual_intf)(struct wpan_phy *wpan_phy,
 				    struct wpan_dev *wpan_dev);
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
+	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
+				const struct wpan_phy_cca *cca);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, __le16 pan_id);
 	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 86c1b2f..f8b5bc9 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -82,7 +82,7 @@ enum nl802154_attrs {
 	NL802154_ATTR_TX_POWER,
 
 	NL802154_ATTR_CCA_MODE,
-	NL802154_ATTR_CCA_MODE3_AND,
+	NL802154_ATTR_CCA_OPT,
 	NL802154_ATTR_CCA_ED_LEVEL,
 
 	NL802154_ATTR_MAX_FRAME_RETRIES,
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 1efbe42..a25b9bb 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -209,7 +209,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 
 	[NL802154_ATTR_TX_POWER] = { .type = NLA_S8, },
 
-	[NL802154_ATTR_CCA_MODE] = { .type = NLA_U8, },
+	[NL802154_ATTR_CCA_MODE] = { .type = NLA_U32, },
+	[NL802154_ATTR_CCA_OPT] = { .type = NLA_U32, },
 
 	[NL802154_ATTR_SUPPORTED_CHANNEL] = { .type = NLA_U32, },
 
@@ -290,10 +291,16 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 		goto nla_put_failure;
 
 	/* cca mode */
-	if (nla_put_u8(msg, NL802154_ATTR_CCA_MODE,
-		       rdev->wpan_phy.cca.mode))
+	if (nla_put_u32(msg, NL802154_ATTR_CCA_MODE,
+			rdev->wpan_phy.cca.mode))
 		goto nla_put_failure;
 
+	if (rdev->wpan_phy.cca.mode == NL802154_CCA_ENERGY_CARRIER) {
+		if (nla_put_u32(msg, NL802154_ATTR_CCA_OPT,
+				rdev->wpan_phy.cca.opt))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_s8(msg, NL802154_ATTR_TX_POWER,
 		       rdev->wpan_phy.transmit_power))
 		goto nla_put_failure;
@@ -622,6 +629,31 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_channel(rdev, page, channel);
 }
 
+static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct wpan_phy_cca cca;
+
+	if (!info->attrs[NL802154_ATTR_CCA_MODE])
+		return -EINVAL;
+
+	cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
+	/* checking 802.15.4 constraints */
+	if (cca.mode < NL802154_CCA_ENERGY || cca.mode > NL802154_CCA_ATTR_MAX)
+		return -EINVAL;
+
+	if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
+		if (!info->attrs[NL802154_ATTR_CCA_OPT])
+			return -EINVAL;
+
+		cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
+		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
+			return -EINVAL;
+	}
+
+	return rdev_set_cca_mode(rdev, &cca);
+}
+
 static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
@@ -895,6 +927,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_SET_CCA_MODE,
+		.doit = nl802154_set_cca_mode,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_SET_PAN_ID,
 		.doit = nl802154_set_pan_id,
 		.policy = nl802154_policy,
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index aff54fb..7c46732 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -42,6 +42,13 @@ rdev_set_channel(struct cfg802154_registered_device *rdev, u8 page, u8 channel)
 }
 
 static inline int
+rdev_set_cca_mode(struct cfg802154_registered_device *rdev,
+		  const struct wpan_phy_cca *cca)
+{
+	return rdev->ops->set_cca_mode(&rdev->wpan_phy, cca);
+}
+
+static inline int
 rdev_set_pan_id(struct cfg802154_registered_device *rdev,
 		struct wpan_dev *wpan_dev, __le16 pan_id)
 {
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index c035708..7d31da5 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -87,6 +87,26 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 }
 
 static int
+ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
+			const struct wpan_phy_cca *cca)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	ASSERT_RTNL();
+
+	/* check if phy support this setting */
+	if (!(local->hw.flags & IEEE802154_HW_CCA_MODE))
+		return -EOPNOTSUPP;
+
+	ret = drv_set_cca_mode(local, cca);
+	if (!ret)
+		wpan_phy->cca = *cca;
+
+	return ret;
+}
+
+static int
 ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		      __le16 pan_id)
 {
@@ -201,6 +221,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf = ieee802154_add_iface,
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
+	.set_cca_mode = ieee802154_set_cca_mode,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
-- 
2.1.3

