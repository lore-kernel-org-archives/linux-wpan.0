Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:61888 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbaKLChp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:45 -0500
Received: by mail-wi0-f173.google.com with SMTP id n3so3471044wiv.12
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:44 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/18] mac820154: move interface unregistration into iface
Date: Wed, 12 Nov 2014 03:36:48 +0100
Message-Id: <1415759825-8309-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch move the iface unregistration into iface.c file to have
a behaviour which is similar like mac80211. Also iface handling should
be inside iface.c file only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  1 +
 net/mac802154/iface.c        | 13 +++++++++++++
 net/mac802154/main.c         |  9 +--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index e22f509..abb1970 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -172,5 +172,6 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		  struct wpan_dev **new_wpan_dev, int type);
+void ieee802154_remove_interfaces(struct ieee802154_local *local);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 83715b5..8d90fba 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -535,3 +535,16 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 	synchronize_rcu();
 	unregister_netdevice(sdata->dev);
 }
+
+void ieee802154_remove_interfaces(struct ieee802154_local *local)
+{
+	struct ieee802154_sub_if_data *sdata, *next;
+
+	list_for_each_entry_safe(sdata, next, &local->interfaces, list) {
+		mutex_lock(&sdata->local->iflist_mtx);
+		list_del(&sdata->list);
+		mutex_unlock(&sdata->local->iflist_mtx);
+
+		unregister_netdevice(sdata->dev);
+	}
+}
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 234084d..709dcc5 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -165,7 +165,6 @@ EXPORT_SYMBOL(ieee802154_register_hw);
 void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
-	struct ieee802154_sub_if_data *sdata, *next;
 
 	tasklet_kill(&local->tasklet);
 	flush_workqueue(local->workqueue);
@@ -173,13 +172,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	list_for_each_entry_safe(sdata, next, &local->interfaces, list) {
-		mutex_lock(&sdata->local->iflist_mtx);
-		list_del(&sdata->list);
-		mutex_unlock(&sdata->local->iflist_mtx);
-
-		unregister_netdevice(sdata->dev);
-	}
+	ieee802154_remove_interfaces(local);
 
 	rtnl_unlock();
 
-- 
2.1.3

