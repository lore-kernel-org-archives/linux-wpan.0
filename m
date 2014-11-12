Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51252 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbaKLCh4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:56 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so12980094wgh.39
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:55 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/18] ieee820154: add short_addr setting support
Date: Wed, 12 Nov 2014 03:36:58 +0100
Message-Id: <1415759825-8309-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting short address via nl802154 framework.
Also added a comment because a 0xffff seems to be valid address that we
don't have a short address. This is a valid setting but we need
more checks in upper layers to don't allow this address as source address.
Also the current netlink interface doesn't allow to set the short_addr
to 0xffff. Same for the 0xfffe short address which describes a not
allocated short address.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h |  2 ++
 include/net/cfg802154.h    |  2 ++
 net/ieee802154/nl802154.c  | 31 +++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h  |  7 +++++++
 net/mac802154/cfg.c        | 26 ++++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index d4037987..ce0f96a 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -31,6 +31,8 @@
 #define IEEE802154_MIN_PSDU_LEN		5
 
 #define IEEE802154_PAN_ID_BROADCAST	0xffff
+#define IEEE802154_ADDR_SHORT_BROADCAST	0xffff
+#define IEEE802154_ADDR_SHORT_UNSPEC	0xfffe
 
 #define IEEE802154_EXTENDED_ADDR_LEN	8
 
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index d07b072..e8a4c2b 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -40,6 +40,8 @@ struct cfg802154_ops {
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, u16 pan_id);
+	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
+				  struct wpan_dev *wpan_dev, u16 short_addr);
 };
 
 struct wpan_phy {
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 88cd1293..2978c1a 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -593,6 +593,29 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
 }
 
+static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	u16 short_addr;
+
+	/* conflict here while tx/rx calls */
+	if (netif_running(dev))
+		return -EBUSY;
+
+	/* don't change address fields on monitor */
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EINVAL;
+
+	if (!info->attrs[NL802154_ATTR_SHORT_ADDR])
+		return -EINVAL;
+
+	short_addr = nla_get_u16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
+
+	return rdev_set_short_addr(rdev, wpan_dev, short_addr);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -719,6 +742,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_SHORT_ADDR,
+		.doit = nl802154_set_short_addr,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 4115ea2..16b0de0 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -34,4 +34,11 @@ rdev_set_pan_id(struct cfg802154_registered_device *rdev,
 	return rdev->ops->set_pan_id(&rdev->wpan_phy, wpan_dev, pan_id);
 }
 
+static inline int
+rdev_set_short_addr(struct cfg802154_registered_device *rdev,
+		    struct wpan_dev *wpan_dev, u16 short_addr)
+{
+	return rdev->ops->set_short_addr(&rdev->wpan_phy, wpan_dev, short_addr);
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index db6e5e9..df29976 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -83,9 +83,35 @@ static int ieee802154_set_pan_id(struct wpan_phy *wpan_phy,
 	return 0;
 }
 
+static int
+ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+			  const u16 short_addr)
+{
+	ASSERT_RTNL();
+
+	/* TODO
+	 * I am not sure about to check here on broadcast short_addr.
+	 * Broadcast is a valid setting, comment from 802.15.4:
+	 * A value of 0xfffe indicates that the device has
+	 * associated but has not been allocated an address. A
+	 * value of 0xffff indicates that the device does not
+	 * have a short address.
+	 *
+	 * I think we should allow to set these settings but
+	 * don't allow to allow socket communication with it.
+	 */
+	if (short_addr == IEEE802154_ADDR_SHORT_UNSPEC ||
+	    short_addr == IEEE802154_ADDR_SHORT_BROADCAST)
+		return -EINVAL;
+
+	wpan_dev->short_addr = cpu_to_le16(short_addr);
+	return 0;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
 	.set_channel = ieee802154_set_channel,
 	.set_pan_id = ieee802154_set_pan_id,
+	.set_short_addr = ieee802154_set_short_addr,
 };
-- 
2.1.3

