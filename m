Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:39175 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNq5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:46:57 -0400
Received: by mail-la0-f43.google.com with SMTP id hr17so9094363lab.2
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:46:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:26 +0200
Message-Id: <1407937595-16415-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 03/12] mac802154: rename sdata slaves and slaves_mtx
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch namens the slaves attribute in sdata to interfaces and
slaves_mtx to iflist_mtx. This patch is part to get the wireless feeling
into the 802.15.4 implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  4 ++--
 net/mac802154/main.c         | 54 ++++++++++++++++++++++----------------------
 net/mac802154/rx.c           |  2 +-
 net/mac802154/tx.c           |  4 ++--
 net/mac802154/wpan.c         |  8 +++----
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 65b26f9..f4d102a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -87,8 +87,8 @@ struct ieee802154_local {
 	 *
 	 * So atomic readers can use any of this protection methods.
 	 */
-	struct list_head	slaves;
-	struct mutex		slaves_mtx;
+	struct list_head	interfaces;
+	struct mutex		iflist_mtx;
 
 	/* This one is used for scanning and other jobs not to be interfered
 	 * with serial driver.
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index d9c5cbe..2f070e9 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -39,20 +39,20 @@ int mac802154_slave_open(struct net_device *dev)
 	ASSERT_RTNL();
 
 	if (sdata->type == NL802154_IFTYPE_NODE) {
-		mutex_lock(&sdata->local->slaves_mtx);
-		list_for_each_entry(subif, &sdata->local->slaves, list) {
+		mutex_lock(&sdata->local->iflist_mtx);
+		list_for_each_entry(subif, &sdata->local->interfaces, list) {
 			if (subif != sdata && subif->type == sdata->type &&
 			    subif->running) {
-				mutex_unlock(&sdata->local->slaves_mtx);
+				mutex_unlock(&sdata->local->iflist_mtx);
 				return -EBUSY;
 			}
 		}
-		mutex_unlock(&sdata->local->slaves_mtx);
+		mutex_unlock(&sdata->local->iflist_mtx);
 	}
 
-	mutex_lock(&sdata->local->slaves_mtx);
+	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->running = true;
-	mutex_unlock(&sdata->local->slaves_mtx);
+	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (local->open_count++ == 0) {
 		res = local->ops->start(&local->hw);
@@ -88,9 +88,9 @@ int mac802154_slave_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	mutex_lock(&sdata->local->slaves_mtx);
+	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->running = false;
-	mutex_unlock(&sdata->local->slaves_mtx);
+	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (!--local->open_count)
 		local->ops->stop(&local->hw);
@@ -115,21 +115,21 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 
 	SET_NETDEV_DEV(dev, &local->phy->dev);
 
-	mutex_lock(&local->slaves_mtx);
+	mutex_lock(&local->iflist_mtx);
 	if (!local->running) {
-		mutex_unlock(&local->slaves_mtx);
+		mutex_unlock(&local->iflist_mtx);
 		return -ENODEV;
 	}
-	mutex_unlock(&local->slaves_mtx);
+	mutex_unlock(&local->iflist_mtx);
 
 	err = register_netdev(dev);
 	if (err < 0)
 		return err;
 
 	rtnl_lock();
-	mutex_lock(&local->slaves_mtx);
-	list_add_tail_rcu(&sdata->list, &local->slaves);
-	mutex_unlock(&local->slaves_mtx);
+	mutex_lock(&local->iflist_mtx);
+	list_add_tail_rcu(&sdata->list, &local->interfaces);
+	mutex_unlock(&local->iflist_mtx);
 	rtnl_unlock();
 
 	return 0;
@@ -146,9 +146,9 @@ mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
 
 	BUG_ON(sdata->local->phy != phy);
 
-	mutex_lock(&sdata->local->slaves_mtx);
+	mutex_lock(&sdata->local->iflist_mtx);
 	list_del_rcu(&sdata->list);
-	mutex_unlock(&sdata->local->slaves_mtx);
+	mutex_unlock(&sdata->local->iflist_mtx);
 
 	synchronize_rcu();
 	unregister_netdevice(sdata->dev);
@@ -298,8 +298,8 @@ ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 	local->hw.priv = (char *)local + ALIGN(sizeof(*local), NETDEV_ALIGN);
 	local->ops = ops;
 
-	INIT_LIST_HEAD(&local->slaves);
-	mutex_init(&local->slaves_mtx);
+	INIT_LIST_HEAD(&local->interfaces);
+	mutex_init(&local->iflist_mtx);
 
 	tasklet_init(&local->tasklet,
 		     ieee802154_tasklet_handler,
@@ -315,9 +315,9 @@ void ieee802154_free_hw(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
 
-	BUG_ON(!list_empty(&local->slaves));
+	BUG_ON(!list_empty(&local->interfaces));
 
-	mutex_destroy(&local->slaves_mtx);
+	mutex_destroy(&local->iflist_mtx);
 
 	wpan_phy_free(local->phy);
 }
@@ -388,9 +388,9 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	mutex_lock(&local->slaves_mtx);
+	mutex_lock(&local->iflist_mtx);
 	local->running = MAC802154_DEVICE_RUN;
-	mutex_unlock(&local->slaves_mtx);
+	mutex_unlock(&local->iflist_mtx);
 
 	rtnl_unlock();
 
@@ -414,14 +414,14 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	mutex_lock(&local->slaves_mtx);
+	mutex_lock(&local->iflist_mtx);
 	local->running = MAC802154_DEVICE_STOPPED;
-	mutex_unlock(&local->slaves_mtx);
+	mutex_unlock(&local->iflist_mtx);
 
-	list_for_each_entry_safe(sdata, next, &local->slaves, list) {
-		mutex_lock(&sdata->local->slaves_mtx);
+	list_for_each_entry_safe(sdata, next, &local->interfaces, list) {
+		mutex_lock(&sdata->local->iflist_mtx);
 		list_del(&sdata->list);
-		mutex_unlock(&sdata->local->slaves_mtx);
+		mutex_unlock(&sdata->local->iflist_mtx);
 
 		unregister_netdevice(sdata->dev);
 	}
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index cc3aa33..394601a 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -205,7 +205,7 @@ mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	}
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->slaves, list) {
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (sdata->type != NL802154_IFTYPE_NODE ||
 		    !netif_running(sdata->dev))
 			continue;
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 23735dd..277ccd1 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -72,7 +72,7 @@ out:
 
 	/* Restart the netif queue on each sub_if_data object. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &xw->local->slaves, list)
+	list_for_each_entry_rcu(sdata, &xw->local->interfaces, list)
 		netif_wake_queue(sdata->dev);
 	rcu_read_unlock();
 
@@ -111,7 +111,7 @@ netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
 
 	/* Stop the netif queue on each sub_if_data object. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->slaves, list)
+	list_for_each_entry_rcu(sdata, &local->interfaces, list)
 		netif_stop_queue(sdata->dev);
 	rcu_read_unlock();
 
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index 865e1a5..c480501 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -129,9 +129,9 @@ int mac802154_set_mac_params(struct net_device *dev,
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mutex_lock(&sdata->local->slaves_mtx);
+	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->mac_params = *params;
-	mutex_unlock(&sdata->local->slaves_mtx);
+	mutex_unlock(&sdata->local->iflist_mtx);
 
 	return 0;
 }
@@ -141,9 +141,9 @@ void mac802154_get_mac_params(struct net_device *dev,
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mutex_lock(&sdata->local->slaves_mtx);
+	mutex_lock(&sdata->local->iflist_mtx);
 	*params = sdata->mac_params;
-	mutex_unlock(&sdata->local->slaves_mtx);
+	mutex_unlock(&sdata->local->iflist_mtx);
 }
 
 static int mac802154_wpan_open(struct net_device *dev)
-- 
2.0.3

