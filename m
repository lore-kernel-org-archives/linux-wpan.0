Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35885 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbaKETwK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:10 -0500
Received: by mail-wi0-f179.google.com with SMTP id h11so3102713wiw.0
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:09 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/18] mac802154: move interface del handling in iface
Date: Wed,  5 Nov 2014 20:51:14 +0100
Message-Id: <1415217089-24919-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves and rename the mac802154_del_iface function into
iface.c and rename the function to ieee802154_if_remove which is a similar
naming convention like mac80211.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/cfg.c          |  4 +++-
 net/mac802154/ieee802154_i.h |  2 +-
 net/mac802154/iface.c        | 12 ++++++++++++
 net/mac802154/main.c         | 16 ----------------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 0c69b44..3f9afad 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -28,7 +28,9 @@ ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
 static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 					    struct net_device *dev)
 {
-	mac802154_del_iface(wpan_phy, dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+
+	ieee802154_if_remove(sdata);
 }
 
 const struct cfg802154_ops mac802154_config_ops = {
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 27e17e6..61a6a0f 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -175,6 +175,6 @@ void mac802154_unlock_table(struct net_device *dev);
 
 struct net_device *
 mac802154_add_iface(struct wpan_phy *phy, const char *name, int type);
-void mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev);
+void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 0c9d00c..9d6012e 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -443,3 +443,15 @@ void mac802154_monitor_setup(struct net_device *dev)
 
 	sdata->promisuous_mode = true;
 }
+
+void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
+{
+	ASSERT_RTNL();
+
+	mutex_lock(&sdata->local->iflist_mtx);
+	list_del_rcu(&sdata->list);
+	mutex_unlock(&sdata->local->iflist_mtx);
+
+	synchronize_rcu();
+	unregister_netdevice(sdata->dev);
+}
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index b34ddbf..333d33d 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -59,22 +59,6 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 	return 0;
 }
 
-void mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	ASSERT_RTNL();
-
-	BUG_ON(sdata->local->phy != phy);
-
-	mutex_lock(&sdata->local->iflist_mtx);
-	list_del_rcu(&sdata->list);
-	mutex_unlock(&sdata->local->iflist_mtx);
-
-	synchronize_rcu();
-	unregister_netdevice(sdata->dev);
-}
-
 struct net_device *
 mac802154_add_iface(struct wpan_phy *phy, const char *name, int type)
 {
-- 
2.1.3

