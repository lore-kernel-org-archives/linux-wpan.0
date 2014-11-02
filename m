Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35566 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaKBDTS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:18 -0400
Received: by mail-wg0-f43.google.com with SMTP id y10so5923685wgg.30
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/16] cfg802154: convert deprecated iface add and del
Date: Sun,  2 Nov 2014 04:18:38 +0100
Message-Id: <1414898327-20759-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the wpan_phy callbacks for add and del an interface
on a phy. Instead we introduce deprecated cfg802154 callbacks for this.
Furthermore we introduce a new netlink interface nl802154 which use
different callbacks. The deprecated function is to have a backwards
compatibility with the current netlink interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h      |  9 +++++----
 net/ieee802154/nl-phy.c      | 19 ++++++-------------
 net/ieee802154/rdev-ops.h    | 23 +++++++++++++++++++++++
 net/mac802154/cfg.c          | 17 +++++++++++++++++
 net/mac802154/ieee802154_i.h |  4 ++++
 net/mac802154/main.c         |  8 ++------
 6 files changed, 57 insertions(+), 23 deletions(-)
 create mode 100644 net/ieee802154/rdev-ops.h

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 12de66b..864bce2 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -32,6 +32,11 @@
 struct wpan_phy;
 
 struct cfg802154_ops {
+	struct net_device * (*add_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
+							   const char *name,
+							   int type);
+	void (*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
+					    struct net_device *dev);
 };
 
 struct wpan_phy {
@@ -58,10 +63,6 @@ struct wpan_phy {
 	struct device dev;
 	int idx;
 
-	struct net_device *(*add_iface)(struct wpan_phy *phy,
-					const char *name, int type);
-	void (*del_iface)(struct wpan_phy *phy, struct net_device *dev);
-
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 0afe760..5d914d3 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -30,6 +30,8 @@
 #include <linux/nl802154.h>
 
 #include "ieee802154.h"
+#include "rdev-ops.h"
+#include "core.h"
 
 static int ieee802154_nl_fill_phy(struct sk_buff *msg, u32 portid,
 				  u32 seq, int flags, struct wpan_phy *phy)
@@ -203,11 +205,6 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		goto out_dev;
 
-	if (!phy->add_iface) {
-		rc = -EINVAL;
-		goto nla_put_failure;
-	}
-
 	if (info->attrs[IEEE802154_ATTR_HW_ADDR] &&
 	    nla_len(info->attrs[IEEE802154_ATTR_HW_ADDR]) !=
 			IEEE802154_ADDR_LEN) {
@@ -223,7 +220,8 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	dev = phy->add_iface(phy, devname, type);
+	dev = rdev_add_virtual_intf_deprecated(wpan_phy_to_rdev(phy), devname,
+					       type);
 	if (IS_ERR(dev)) {
 		rc = PTR_ERR(dev);
 		goto nla_put_failure;
@@ -257,7 +255,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 
 dev_unregister:
 	rtnl_lock(); /* del_iface must be called with RTNL lock */
-	phy->del_iface(phy, dev);
+	rdev_del_virtual_intf_deprecated(wpan_phy_to_rdev(phy), dev);
 	dev_put(dev);
 	rtnl_unlock();
 nla_put_failure:
@@ -319,13 +317,8 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		goto out_dev;
 
-	if (!phy->del_iface) {
-		rc = -EINVAL;
-		goto nla_put_failure;
-	}
-
 	rtnl_lock();
-	phy->del_iface(phy, dev);
+	rdev_del_virtual_intf_deprecated(wpan_phy_to_rdev(phy), dev);
 
 	/* We don't have device anymore */
 	dev_put(dev);
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
new file mode 100644
index 0000000..ac8824e
--- /dev/null
+++ b/net/ieee802154/rdev-ops.h
@@ -0,0 +1,23 @@
+#ifndef __CFG802154_RDEV_OPS
+#define __CFG802154_RDEV_OPS
+
+#include <net/cfg802154.h>
+
+#include "core.h"
+
+static inline struct net_device *
+rdev_add_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
+				 const char *name, int type)
+{
+	return rdev->ops->add_virtual_intf_deprecated(&rdev->wpan_phy, name,
+						      type);
+}
+
+static inline void
+rdev_del_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
+				 struct net_device *dev)
+{
+	rdev->ops->del_virtual_intf_deprecated(&rdev->wpan_phy, dev);
+}
+
+#endif /* __CFG802154_RDEV_OPS */
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 105468e..75a5d25 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -15,5 +15,22 @@
 
 #include <net/cfg802154.h>
 
+#include "ieee802154_i.h"
+
+static struct net_device *
+ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
+				const char *name, int type)
+{
+	return mac802154_add_iface(wpan_phy, name, type);
+}
+
+static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
+					    struct net_device *dev)
+{
+	mac802154_del_iface(wpan_phy, dev);
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
+	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
+	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
 };
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 1086a9d..39af6ea 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -174,4 +174,8 @@ void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t);
 void mac802154_unlock_table(struct net_device *dev);
 
+struct net_device *
+mac802154_add_iface(struct wpan_phy *phy, const char *name, int type);
+void mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev);
+
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 785abb1..b34ddbf 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -59,8 +59,7 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 	return 0;
 }
 
-static void
-mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
+void mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
@@ -76,7 +75,7 @@ mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
 	unregister_netdevice(sdata->dev);
 }
 
-static struct net_device *
+struct net_device *
 mac802154_add_iface(struct wpan_phy *phy, const char *name, int type)
 {
 	struct net_device *dev;
@@ -221,9 +220,6 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	wpan_phy_set_dev(local->phy, local->hw.parent);
 
-	local->phy->add_iface = mac802154_add_iface;
-	local->phy->del_iface = mac802154_del_iface;
-
 	rc = wpan_phy_register(local->phy);
 	if (rc < 0)
 		goto out_wq;
-- 
2.1.3

