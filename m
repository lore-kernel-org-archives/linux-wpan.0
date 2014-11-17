Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:56573 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHVd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:33 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so8052292wid.6
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:32 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/13] ieee802154: add new interface command
Date: Mon, 17 Nov 2014 08:20:51 +0100
Message-Id: <1416208855-8623-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new nl802154 command for adding a new interface
according to a wpan phy via nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  5 +++++
 net/ieee802154/nl802154.c | 34 ++++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |  7 +++++++
 net/mac802154/cfg.c       | 15 +++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 17b4fc0..24c7321 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -21,6 +21,8 @@
 #include <linux/mutex.h>
 #include <linux/bug.h>
 
+#include <net/nl802154.h>
+
 /* According to the IEEE 802.15.4 stadard the upper most significant bits of
  * the 32-bit channel bitmaps shall be used as an integer value to specify 32
  * possible channel pages. The lower 27 bits of the channel bit map shall be
@@ -37,6 +39,9 @@ struct cfg802154_ops {
 							   int type);
 	void	(*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
 					       struct net_device *dev);
+	int	(*add_virtual_intf)(struct wpan_phy *wpan_phy,
+				    const char *name,
+				    enum nl802154_iftype type);
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, u16 pan_id);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index ccdf33e..e7224f3 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -551,6 +551,32 @@ static int nl802154_get_interface(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	enum nl802154_iftype type = NL802154_IFTYPE_UNSPEC;
+
+	/* TODO avoid failing a new interface
+	 * creation due to pending removal?
+	 */
+
+	if (!info->attrs[NL802154_ATTR_IFNAME])
+		return -EINVAL;
+
+	if (info->attrs[NL802154_ATTR_IFTYPE]) {
+		type = nla_get_u32(info->attrs[NL802154_ATTR_IFTYPE]);
+		if (type > NL802154_IFTYPE_MAX)
+			return -EINVAL;
+	}
+
+	if (!rdev->ops->add_virtual_intf)
+		return -EOPNOTSUPP;
+
+	return rdev_add_virtual_intf(rdev,
+				     nla_data(info->attrs[NL802154_ATTR_IFNAME]),
+				     type);
+}
+
 static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
@@ -819,6 +845,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_NEW_INTERFACE,
+		.doit = nl802154_new_interface,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_SET_CHANNEL,
 		.doit = nl802154_set_channel,
 		.policy = nl802154_policy,
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 578bc41..d3a4f94 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -21,6 +21,13 @@ rdev_del_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
+rdev_add_virtual_intf(struct cfg802154_registered_device *rdev, char *name,
+		      enum nl802154_iftype type)
+{
+	return rdev->ops->add_virtual_intf(&rdev->wpan_phy, name, type);
+}
+
+static inline int
 rdev_set_channel(struct cfg802154_registered_device *rdev, u8 page, u8 channel)
 {
 	return rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 2abe7e5..ae1a9ef 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -43,6 +43,20 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 }
 
 static int
+ieee802154_add_iface(struct wpan_phy *phy, const char *name,
+		     enum nl802154_iftype type)
+{
+	struct ieee802154_local *local = wpan_phy_priv(phy);
+	struct net_device *err;
+
+	err = ieee802154_if_add(local, name, type);
+	if (IS_ERR(err))
+		return PTR_ERR(err);
+
+	return 0;
+}
+
+static int
 ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
@@ -175,6 +189,7 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
+	.add_virtual_intf = ieee802154_add_iface,
 	.set_channel = ieee802154_set_channel,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
-- 
2.1.3

