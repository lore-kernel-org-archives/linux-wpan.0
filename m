Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53164 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbaKLChx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:53 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so13056797wgh.29
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:51 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/18] ieee820154: add channel set support
Date: Wed, 12 Nov 2014 03:36:55 +0100
Message-Id: <1415759825-8309-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds page and channel setting support to nl802154 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  1 +
 net/ieee802154/nl802154.c | 28 ++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |  7 +++++++
 net/mac802154/cfg.c       | 24 ++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 8a3edc5..391fdb3 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -37,6 +37,7 @@ struct cfg802154_ops {
 							   int type);
 	void	(*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
 					       struct net_device *dev);
+	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 46df7dc..d8ef2c8 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -23,6 +23,7 @@
 #include <net/sock.h>
 
 #include "nl802154.h"
+#include "rdev-ops.h"
 #include "core.h"
 
 static int nl802154_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
@@ -550,6 +551,25 @@ static int nl802154_get_interface(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	u8 channel, page;
+
+	if (!info->attrs[NL802154_ATTR_PAGE] ||
+	    !info->attrs[NL802154_ATTR_CHANNEL])
+		return -EINVAL;
+
+	page = nla_get_u8(info->attrs[NL802154_ATTR_PAGE]);
+	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
+
+	/* check 802.15.4 constraints */
+	if (page >= WPAN_NUM_PAGES || channel >= WPAN_NUM_CHANNELS)
+		return -EINVAL;
+
+	return rdev_set_channel(rdev, page, channel);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -660,6 +680,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_WPAN_DEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_CHANNEL,
+		.doit = nl802154_set_channel,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index ac8824e..8a3b0eb 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -20,4 +20,11 @@ rdev_del_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
 	rdev->ops->del_virtual_intf_deprecated(&rdev->wpan_phy, dev);
 }
 
+static inline int
+rdev_set_channel(struct cfg802154_registered_device *rdev, const u8 page,
+		 const u8 channel)
+{
+	return rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index d2c4e8f..9d5b189 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -17,6 +17,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 #include "cfg.h"
 
 static struct net_device *
@@ -41,7 +42,30 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 	ieee802154_if_remove(sdata);
 }
 
+static int
+ieee802154_set_channel(struct wpan_phy *wpan_phy, const u8 page,
+		       const u8 channel)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	ASSERT_RTNL();
+
+	/* check if phy support this setting */
+	if (!(wpan_phy->channels_supported[page] & BIT(channel)))
+		return -EINVAL;
+
+	ret = drv_set_channel(local, page, channel);
+	if (!ret) {
+		wpan_phy->current_page = page;
+		wpan_phy->current_channel = channel;
+	}
+
+	return ret;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
+	.set_channel = ieee802154_set_channel,
 };
-- 
2.1.3

