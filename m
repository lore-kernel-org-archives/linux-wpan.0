Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39457 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHVc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:32 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so4705175wiw.13
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:31 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/13] mac802154: remove wpan_dev parameter in if_add
Date: Mon, 17 Nov 2014 08:20:50 +0100
Message-Id: <1416208855-8623-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This parameter was grabbed from wireless implementation with the
identically wireless dev struct. We don't need this right now and so we
remove it. Maybe we will add it later again if we found any real reason
to have such parameter.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/cfg.c          | 2 +-
 net/mac802154/ieee802154_i.h | 2 +-
 net/mac802154/iface.c        | 5 +----
 net/mac802154/main.c         | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 2b3610c..2abe7e5 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -28,7 +28,7 @@ ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
 	struct net_device *dev;
 
 	rtnl_lock();
-	dev = ieee802154_if_add(local, name, NULL, type);
+	dev = ieee802154_if_add(local, name, type);
 	rtnl_unlock();
 
 	return dev;
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 6ad5e89..4655383 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -176,7 +176,7 @@ void ieee802154_iface_exit(void);
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-		  struct wpan_dev **new_wpan_dev, enum nl802154_iftype type);
+		  enum nl802154_iftype type);
 void ieee802154_remove_interfaces(struct ieee802154_local *local);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index cc992e8..ba63ac9 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -458,7 +458,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-		  struct wpan_dev **new_wpan_dev, enum nl802154_iftype type)
+		  enum nl802154_iftype type)
 {
 	struct net_device *ndev = NULL;
 	struct ieee802154_sub_if_data *sdata = NULL;
@@ -516,9 +516,6 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	list_add_tail_rcu(&sdata->list, &local->interfaces);
 	mutex_unlock(&local->iflist_mtx);
 
-	if (new_wpan_dev)
-		*new_wpan_dev = &sdata->wpan_dev;
-
 	return ndev;
 
 err:
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 2e42fc2..bbb19dd 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -161,7 +161,7 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	dev = ieee802154_if_add(local, "wpan%d", NULL, NL802154_IFTYPE_NODE);
+	dev = ieee802154_if_add(local, "wpan%d", NL802154_IFTYPE_NODE);
 	if (IS_ERR(dev)) {
 		rtnl_unlock();
 		rc = PTR_ERR(dev);
-- 
2.1.3

