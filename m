Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:60637 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbaKETwM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:12 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so1746206wgg.8
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:10 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/18] mac802154: move interface add handling in iface
Date: Wed,  5 Nov 2014 20:51:15 +0100
Message-Id: <1415217089-24919-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves and renames the mac802154_add_iface and
mac802154_netdev_register functions into iface.c. The function
mac802154_add_iface is renamed to ieee802154_if_add which is a similar naming
convention like mac80211.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/cfg.c          |  4 ++-
 net/mac802154/ieee802154_i.h |  3 ++
 net/mac802154/iface.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/main.c         | 67 --------------------------------------------
 4 files changed, 72 insertions(+), 68 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 3f9afad..0a08f66 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -22,7 +22,9 @@ static struct net_device *
 ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
 				const char *name, int type)
 {
-	return mac802154_add_iface(wpan_phy, name, type);
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	return ieee802154_if_add(local, name, NULL, type);
 }
 
 static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 61a6a0f..3ad8540 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -176,5 +176,8 @@ void mac802154_unlock_table(struct net_device *dev);
 struct net_device *
 mac802154_add_iface(struct wpan_phy *phy, const char *name, int type);
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
+struct net_device *
+ieee802154_if_add(struct ieee802154_local *local, const char *name,
+		  struct wpan_dev **new_wpan_dev, int type);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9d6012e..fced04b 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -444,6 +444,72 @@ void mac802154_monitor_setup(struct net_device *dev)
 	sdata->promisuous_mode = true;
 }
 
+static int
+mac802154_netdev_register(struct ieee802154_local *local,
+			  struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	int err;
+
+	sdata->dev = dev;
+	sdata->local = local;
+
+	dev->needed_headroom = local->hw.extra_tx_headroom;
+
+	SET_NETDEV_DEV(dev, &local->phy->dev);
+
+	err = register_netdev(dev);
+	if (err < 0)
+		return err;
+
+	rtnl_lock();
+	mutex_lock(&local->iflist_mtx);
+	list_add_tail_rcu(&sdata->list, &local->interfaces);
+	mutex_unlock(&local->iflist_mtx);
+	rtnl_unlock();
+
+	return 0;
+}
+
+struct net_device *
+ieee802154_if_add(struct ieee802154_local *local, const char *name,
+		  struct wpan_dev **new_wpan_dev, int type)
+{
+	struct net_device *dev;
+	int err = -ENOMEM;
+
+	switch (type) {
+	case IEEE802154_DEV_MONITOR:
+		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
+				   name, NET_NAME_UNKNOWN,
+				   mac802154_monitor_setup);
+		break;
+	case IEEE802154_DEV_WPAN:
+		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
+				   name, NET_NAME_UNKNOWN,
+				   mac802154_wpan_setup);
+		break;
+	default:
+		dev = NULL;
+		err = -EINVAL;
+		break;
+	}
+	if (!dev)
+		goto err;
+
+	err = mac802154_netdev_register(local, dev);
+	if (err)
+		goto err_free;
+
+	dev_hold(dev); /* we return an incremented device refcount */
+	return dev;
+
+err_free:
+	free_netdev(dev);
+err:
+	return ERR_PTR(err);
+}
+
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 333d33d..a371eb5 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -30,73 +30,6 @@
 #include "ieee802154_i.h"
 #include "cfg.h"
 
-static int
-mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_local *local;
-	int err;
-
-	local = wpan_phy_priv(phy);
-
-	sdata->dev = dev;
-	sdata->local = local;
-
-	dev->needed_headroom = local->hw.extra_tx_headroom;
-
-	SET_NETDEV_DEV(dev, &local->phy->dev);
-
-	err = register_netdev(dev);
-	if (err < 0)
-		return err;
-
-	rtnl_lock();
-	mutex_lock(&local->iflist_mtx);
-	list_add_tail_rcu(&sdata->list, &local->interfaces);
-	mutex_unlock(&local->iflist_mtx);
-	rtnl_unlock();
-
-	return 0;
-}
-
-struct net_device *
-mac802154_add_iface(struct wpan_phy *phy, const char *name, int type)
-{
-	struct net_device *dev;
-	int err = -ENOMEM;
-
-	switch (type) {
-	case IEEE802154_DEV_MONITOR:
-		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
-				   name, NET_NAME_UNKNOWN,
-				   mac802154_monitor_setup);
-		break;
-	case IEEE802154_DEV_WPAN:
-		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
-				   name, NET_NAME_UNKNOWN,
-				   mac802154_wpan_setup);
-		break;
-	default:
-		dev = NULL;
-		err = -EINVAL;
-		break;
-	}
-	if (!dev)
-		goto err;
-
-	err = mac802154_netdev_register(phy, dev);
-	if (err)
-		goto err_free;
-
-	dev_hold(dev); /* we return an incremented device refcount */
-	return dev;
-
-err_free:
-	free_netdev(dev);
-err:
-	return ERR_PTR(err);
-}
-
 static void ieee802154_tasklet_handler(unsigned long data)
 {
 	struct ieee802154_local *local = (struct ieee802154_local *)data;
-- 
2.1.3

