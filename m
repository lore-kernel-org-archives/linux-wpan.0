Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:41161 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaJ1RV6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:21:58 -0400
Received: by mail-la0-f46.google.com with SMTP id hs14so1070510lab.33
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:21:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/17] mac802154: main: move open and close into iface
Date: Tue, 28 Oct 2014 18:21:17 +0100
Message-Id: <1414516892-4107-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

These functions can be static inside the iface file, because it's not
used anywhere else. This patch moves these functions into iface file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  3 ---
 net/mac802154/iface.c        | 59 ++++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/main.c         | 59 --------------------------------------------
 3 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index ac907d9..4408c46 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -123,9 +123,6 @@ IEEE802154_DEV_TO_SUB_IF(const struct net_device *dev)
 extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
-int mac802154_slave_open(struct net_device *dev);
-int mac802154_slave_close(struct net_device *dev);
-
 void mac802154_monitor_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index dafb2c3..0b21413 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -142,6 +142,46 @@ void mac802154_get_mac_params(struct net_device *dev,
 	mutex_unlock(&sdata->local->iflist_mtx);
 }
 
+static int mac802154_slave_open(struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct ieee802154_sub_if_data *subif;
+	struct ieee802154_local *local = sdata->local;
+	int res = 0;
+
+	ASSERT_RTNL();
+
+	if (sdata->type == IEEE802154_DEV_WPAN) {
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
+	netif_start_queue(dev);
+	return 0;
+err:
+	sdata->local->open_count--;
+
+	return res;
+}
+
 static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
@@ -201,6 +241,25 @@ out:
 	return rc;
 }
 
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
 static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 					 struct ieee802154_hdr *hdr,
 					 const struct ieee802154_mac_cb *cb)
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ff0de0f..2c6d772 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -29,65 +29,6 @@
 
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
-	if (sdata->type == IEEE802154_DEV_WPAN) {
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
-- 
2.1.2

