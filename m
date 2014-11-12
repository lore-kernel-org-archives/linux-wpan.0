Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37373 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbaKLChz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:55 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so12873576wgg.23
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:54 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/18] ieee820154: add pan_id setting support
Date: Wed, 12 Nov 2014 03:36:57 +0100
Message-Id: <1415759825-8309-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting pan_id via nl802154 framework.
Adding a comment because setting 0xffff as pan_id seems to be valid
setting. The pan_id 0xffff as source pan is invalid. I am not sure now
about this setting but for the current netlink interface this is an
invalid setting, so we do the same now. Maybe we need to change that
when we have coordinator support and association support.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h |  2 ++
 include/net/cfg802154.h    |  2 ++
 net/ieee802154/nl802154.c  | 31 +++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h  |  7 +++++++
 net/mac802154/cfg.c        | 20 ++++++++++++++++++++
 5 files changed, 62 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index d043449..d4037987 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -30,6 +30,8 @@
 #define IEEE802154_MTU			127
 #define IEEE802154_MIN_PSDU_LEN		5
 
+#define IEEE802154_PAN_ID_BROADCAST	0xffff
+
 #define IEEE802154_EXTENDED_ADDR_LEN	8
 
 #define IEEE802154_FC_TYPE_BEACON	0x0	/* Frame is beacon */
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 391fdb3..d07b072 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -38,6 +38,8 @@ struct cfg802154_ops {
 	void	(*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
 					       struct net_device *dev);
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
+	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
+			      struct wpan_dev *wpan_dev, u16 pan_id);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index d8ef2c8..88cd1293 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -570,6 +570,29 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_channel(rdev, page, channel);
 }
 
+static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	u16 pan_id;
+
+	/* conflict here while tx/rx calls */
+	if (netif_running(dev))
+		return -EBUSY;
+
+	/* don't change address fields on monitor */
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EINVAL;
+
+	if (!info->attrs[NL802154_ATTR_PAN_ID])
+		return -EINVAL;
+
+	pan_id = nla_get_u16(info->attrs[NL802154_ATTR_PAN_ID]);
+
+	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -688,6 +711,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_PAN_ID,
+		.doit = nl802154_set_pan_id,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 8a3b0eb..4115ea2 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -27,4 +27,11 @@ rdev_set_channel(struct cfg802154_registered_device *rdev, const u8 page,
 	return rdev->ops->set_channel(&rdev->wpan_phy, page, channel);
 }
 
+static inline int
+rdev_set_pan_id(struct cfg802154_registered_device *rdev,
+		struct wpan_dev *wpan_dev, u16 pan_id)
+{
+	return rdev->ops->set_pan_id(&rdev->wpan_phy, wpan_dev, pan_id);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 9d5b189..db6e5e9 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -64,8 +64,28 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, const u8 page,
 	return ret;
 }
 
+static int ieee802154_set_pan_id(struct wpan_phy *wpan_phy,
+				 struct wpan_dev *wpan_dev, const u16 pan_id)
+{
+	ASSERT_RTNL();
+
+	/* TODO
+	 * I am not sure about to check here on broadcast pan_id.
+	 * Broadcast is a valid setting, comment from 802.15.4:
+	 * If this value is 0xffff, the device is not associated.
+	 *
+	 * This could useful to simple deassociate an device.
+	 */
+	if (pan_id == IEEE802154_PAN_ID_BROADCAST)
+		return -EINVAL;
+
+	wpan_dev->pan_id = cpu_to_le16(pan_id);
+	return 0;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
 	.set_channel = ieee802154_set_channel,
+	.set_pan_id = ieee802154_set_pan_id,
 };
-- 
2.1.3

