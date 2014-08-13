Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60125 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNrA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:00 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so8188215lbd.22
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:46:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:28 +0200
Message-Id: <1407937595-16415-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 05/12] mac802154: move slave open/close functions to wpan
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This function is never used outside of wpan.c and can be static there.
This patch moves these functions into the wpan.c file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  3 --
 net/mac802154/main.c         | 69 --------------------------------------------
 net/mac802154/wpan.c         | 69 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index f4d3816..c20fbc9 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -125,9 +125,6 @@ IEEE802154_DEV_TO_SUB_IF(const struct net_device *dev)
 extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
-int mac802154_slave_open(struct net_device *dev);
-int mac802154_slave_close(struct net_device *dev);
-
 void mac802154_wpan_setup(struct net_device *dev);
 
 netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index df197f4..3740c76 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -29,75 +29,6 @@
 
 #include "ieee802154_i.h"
 
-int mac802154_slave_open(struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_sub_if_data *subif;
-	struct ieee802154_local *local = sdata->local;
-	int res = 0;
-
-	ASSERT_RTNL();
-
-	if (sdata->type == NL802154_IFTYPE_NODE) {
-		mutex_lock(&sdata->local->iflist_mtx);
-		list_for_each_entry(subif, &sdata->local->interfaces, list) {
-			if (subif != sdata && subif->type == sdata->type &&
-			    subif->running) {
-				mutex_unlock(&sdata->local->iflist_mtx);
-				return -EBUSY;
-			}
-		}
-		mutex_unlock(&sdata->local->iflist_mtx);
-	}
-
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = true;
-	mutex_unlock(&sdata->local->iflist_mtx);
-
-	if (local->open_count++ == 0) {
-		res = local->ops->start(&local->hw);
-		WARN_ON(res);
-		if (res)
-			goto err;
-	}
-
-	if (local->ops->ieee_addr) {
-		__le64 addr = ieee802154_devaddr_from_raw(dev->dev_addr);
-
-		res = local->ops->ieee_addr(&local->hw, addr);
-		WARN_ON(res);
-		if (res)
-			goto err;
-		mac802154_dev_set_ieee_addr(dev);
-	}
-
-	netif_start_queue(dev);
-	return 0;
-err:
-	sdata->local->open_count--;
-
-	return res;
-}
-
-int mac802154_slave_close(struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_local *local = sdata->local;
-
-	ASSERT_RTNL();
-
-	netif_stop_queue(dev);
-
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = false;
-	mutex_unlock(&sdata->local->iflist_mtx);
-
-	if (!--local->open_count)
-		local->ops->stop(&local->hw);
-
-	return 0;
-}
-
 static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 {
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index ec20d66..8fe0072 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -35,6 +35,75 @@
 
 #include "ieee802154_i.h"
 
+static int mac802154_slave_open(struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct ieee802154_sub_if_data *subif;
+	struct ieee802154_local *local = sdata->local;
+	int res = 0;
+
+	ASSERT_RTNL();
+
+	if (sdata->type == NL802154_IFTYPE_NODE) {
+		mutex_lock(&sdata->local->iflist_mtx);
+		list_for_each_entry(subif, &sdata->local->interfaces, list) {
+			if (subif != sdata && subif->type == sdata->type &&
+			    subif->running) {
+				mutex_unlock(&sdata->local->iflist_mtx);
+				return -EBUSY;
+			}
+		}
+		mutex_unlock(&sdata->local->iflist_mtx);
+	}
+
+	mutex_lock(&sdata->local->iflist_mtx);
+	sdata->running = true;
+	mutex_unlock(&sdata->local->iflist_mtx);
+
+	if (local->open_count++ == 0) {
+		res = local->ops->start(&local->hw);
+		WARN_ON(res);
+		if (res)
+			goto err;
+	}
+
+	if (local->ops->ieee_addr) {
+		__le64 addr = ieee802154_devaddr_from_raw(dev->dev_addr);
+
+		res = local->ops->ieee_addr(&local->hw, addr);
+		WARN_ON(res);
+		if (res)
+			goto err;
+		mac802154_dev_set_ieee_addr(dev);
+	}
+
+	netif_start_queue(dev);
+	return 0;
+err:
+	sdata->local->open_count--;
+
+	return res;
+}
+
+static int mac802154_slave_close(struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct ieee802154_local *local = sdata->local;
+
+	ASSERT_RTNL();
+
+	netif_stop_queue(dev);
+
+	mutex_lock(&sdata->local->iflist_mtx);
+	sdata->running = false;
+	mutex_unlock(&sdata->local->iflist_mtx);
+
+	if (!--local->open_count)
+		local->ops->stop(&local->hw);
+
+	return 0;
+}
+
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-- 
2.0.3

