Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43649 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHVf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:35 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so4693220wid.15
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:34 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/13] ieee802154: add del interface command
Date: Mon, 17 Nov 2014 08:20:53 +0100
Message-Id: <1416208855-8623-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for deleting a wpan interface via nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h      |  2 ++
 net/ieee802154/nl802154.c    | 28 ++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h    |  7 +++++++
 net/mac802154/cfg.c          |  9 +++++++++
 net/mac802154/ieee802154_i.h |  6 ++++++
 5 files changed, 52 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 4a9bb0e..507ac9d 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -43,6 +43,8 @@ struct cfg802154_ops {
 				    const char *name,
 				    enum nl802154_iftype type,
 				    __le64 extended_addr);
+	int	(*del_virtual_intf)(struct wpan_phy *wpan_phy,
+				    struct wpan_dev *wpan_dev);
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, u16 pan_id);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 49c4d8a..6b9bc93 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -583,6 +583,26 @@ static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
 				     type, extended_addr);
 }
 
+static int nl802154_del_interface(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct wpan_dev *wpan_dev = info->user_ptr[1];
+
+	if (!rdev->ops->del_virtual_intf)
+		return -EOPNOTSUPP;
+
+	/* If we remove a wpan device without a netdev then clear
+	 * user_ptr[1] so that nl802154_post_doit won't dereference it
+	 * to check if it needs to do dev_put(). Otherwise it crashes
+	 * since the wpan_dev has been freed, unlike with a netdev where
+	 * we need the dev_put() for the netdev to really be freed.
+	 */
+	if (!wpan_dev->netdev)
+		info->user_ptr[1] = NULL;
+
+	return rdev_del_virtual_intf(rdev, wpan_dev);
+}
+
 static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
@@ -859,6 +879,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_DEL_INTERFACE,
+		.doit = nl802154_del_interface,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_DEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_SET_CHANNEL,
 		.doit = nl802154_set_channel,
 		.policy = nl802154_policy,
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 06e9754..40ffbc0 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -29,6 +29,13 @@ rdev_add_virtual_intf(struct cfg802154_registered_device *rdev, char *name,
 }
 
 static inline int
+rdev_del_virtual_intf(struct cfg802154_registered_device *rdev,
+		      struct wpan_dev *wpan_dev)
+{
+	return rdev->ops->del_virtual_intf(&rdev->wpan_phy, wpan_dev);
+}
+
+static inline int
 rdev_set_channel(struct cfg802154_registered_device *rdev, u8 page, u8 channel)
 {
 	return rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 568d712..7def262 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -58,6 +58,14 @@ ieee802154_add_iface(struct wpan_phy *phy, const char *name,
 }
 
 static int
+ieee802154_del_iface(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev)
+{
+	ieee802154_if_remove(IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev));
+
+	return 0;
+}
+
+static int
 ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
@@ -191,6 +199,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
 	.add_virtual_intf = ieee802154_add_iface,
+	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index cc69163..bebd70f 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -115,6 +115,12 @@ IEEE802154_DEV_TO_SUB_IF(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline struct ieee802154_sub_if_data *
+IEEE802154_WPAN_DEV_TO_SUB_IF(struct wpan_dev *wpan_dev)
+{
+	return container_of(wpan_dev, struct ieee802154_sub_if_data, wpan_dev);
+}
+
 static inline bool
 ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
 {
-- 
2.1.3

