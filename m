Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57496 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaJYTdb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:33:31 -0400
Received: by mail-lb0-f182.google.com with SMTP id f15so2826063lbj.41
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:33:29 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/10] mac802154: rename mac802154_priv to ieee802154_local
Date: Sat, 25 Oct 2014 17:16:35 +0200
Message-Id: <1414250202-32384-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch rename the mac802154_priv to ieee802154_local. The
mac802154_priv structure is like ieee80211_local and so we name it
ieee802154_local.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  12 +--
 net/mac802154/iface.c        |   4 +-
 net/mac802154/main.c         | 172 +++++++++++++++++++++----------------------
 net/mac802154/mib.c          |  21 +++---
 net/mac802154/monitor.c      |   4 +-
 net/mac802154/rx.c           |  12 +--
 net/mac802154/tx.c           |  36 ++++-----
 7 files changed, 130 insertions(+), 131 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 0cb98e8..eb55cd2 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -26,7 +26,7 @@
 #include "llsec.h"
 
 /* mac802154 device private data */
-struct mac802154_priv {
+struct ieee802154_local {
 	struct ieee802154_hw hw;
 	struct ieee802154_ops *ops;
 
@@ -69,7 +69,7 @@ struct mac802154_priv {
 struct mac802154_sub_if_data {
 	struct list_head list; /* the ieee802154_priv->slaves list */
 
-	struct mac802154_priv *hw;
+	struct ieee802154_local *hw;
 	struct net_device *dev;
 
 	int type;
@@ -99,7 +99,7 @@ struct mac802154_sub_if_data {
 	struct mac802154_llsec sec;
 };
 
-#define mac802154_to_priv(_hw)	container_of(_hw, struct mac802154_priv, hw)
+#define mac802154_to_priv(_hw)	container_of(_hw, struct ieee802154_local, hw)
 
 #define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
 
@@ -109,13 +109,13 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 int mac802154_slave_open(struct net_device *dev);
 int mac802154_slave_close(struct net_device *dev);
 
-void mac802154_monitors_rx(struct mac802154_priv *priv, struct sk_buff *skb);
+void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_monitor_setup(struct net_device *dev);
 
-void mac802154_wpans_rx(struct mac802154_priv *priv, struct sk_buff *skb);
+void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_wpan_setup(struct net_device *dev);
 
-netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
+netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
 			 u8 page, u8 chan);
 
 /* MIB callbacks */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 03eedc3..10f1ee2 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -565,7 +565,7 @@ static int mac802154_parse_frame_start(struct sk_buff *skb,
 	return 0;
 }
 
-void mac802154_wpans_rx(struct mac802154_priv *priv, struct sk_buff *skb)
+void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	int ret;
 	struct mac802154_sub_if_data *sdata;
@@ -579,7 +579,7 @@ void mac802154_wpans_rx(struct mac802154_priv *priv, struct sk_buff *skb)
 	}
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &priv->slaves, list) {
+	list_for_each_entry_rcu(sdata, &local->slaves, list) {
 		if (sdata->type != IEEE802154_DEV_WPAN ||
 		    !netif_running(sdata->dev))
 			continue;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index b0bcc06..387d4cf 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -33,7 +33,7 @@ int mac802154_slave_open(struct net_device *dev)
 {
 	struct mac802154_sub_if_data *priv = netdev_priv(dev);
 	struct mac802154_sub_if_data *subif;
-	struct mac802154_priv *ipriv = priv->hw;
+	struct ieee802154_local *local = priv->hw;
 	int res = 0;
 
 	ASSERT_RTNL();
@@ -54,17 +54,17 @@ int mac802154_slave_open(struct net_device *dev)
 	priv->running = true;
 	mutex_unlock(&priv->hw->slaves_mtx);
 
-	if (ipriv->open_count++ == 0) {
-		res = ipriv->ops->start(&ipriv->hw);
+	if (local->open_count++ == 0) {
+		res = local->ops->start(&local->hw);
 		WARN_ON(res);
 		if (res)
 			goto err;
 	}
 
-	if (ipriv->ops->ieee_addr) {
+	if (local->ops->ieee_addr) {
 		__le64 addr = ieee802154_devaddr_from_raw(dev->dev_addr);
 
-		res = ipriv->ops->ieee_addr(&ipriv->hw, addr);
+		res = local->ops->ieee_addr(&local->hw, addr);
 		WARN_ON(res);
 		if (res)
 			goto err;
@@ -82,7 +82,7 @@ err:
 int mac802154_slave_close(struct net_device *dev)
 {
 	struct mac802154_sub_if_data *priv = netdev_priv(dev);
-	struct mac802154_priv *ipriv = priv->hw;
+	struct ieee802154_local *local = priv->hw;
 
 	ASSERT_RTNL();
 
@@ -92,8 +92,8 @@ int mac802154_slave_close(struct net_device *dev)
 	priv->running = false;
 	mutex_unlock(&priv->hw->slaves_mtx);
 
-	if (!--ipriv->open_count)
-		ipriv->ops->stop(&ipriv->hw);
+	if (!--local->open_count)
+		local->ops->stop(&local->hw);
 
 	return 0;
 }
@@ -102,34 +102,34 @@ static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 {
 	struct mac802154_sub_if_data *priv;
-	struct mac802154_priv *ipriv;
+	struct ieee802154_local *local;
 	int err;
 
-	ipriv = wpan_phy_priv(phy);
+	local = wpan_phy_priv(phy);
 
 	priv = netdev_priv(dev);
 	priv->dev = dev;
-	priv->hw = ipriv;
+	priv->hw = local;
 
-	dev->needed_headroom = ipriv->hw.extra_tx_headroom;
+	dev->needed_headroom = local->hw.extra_tx_headroom;
 
-	SET_NETDEV_DEV(dev, &ipriv->phy->dev);
+	SET_NETDEV_DEV(dev, &local->phy->dev);
 
-	mutex_lock(&ipriv->slaves_mtx);
-	if (!ipriv->running) {
-		mutex_unlock(&ipriv->slaves_mtx);
+	mutex_lock(&local->slaves_mtx);
+	if (!local->running) {
+		mutex_unlock(&local->slaves_mtx);
 		return -ENODEV;
 	}
-	mutex_unlock(&ipriv->slaves_mtx);
+	mutex_unlock(&local->slaves_mtx);
 
 	err = register_netdev(dev);
 	if (err < 0)
 		return err;
 
 	rtnl_lock();
-	mutex_lock(&ipriv->slaves_mtx);
-	list_add_tail_rcu(&priv->list, &ipriv->slaves);
-	mutex_unlock(&ipriv->slaves_mtx);
+	mutex_lock(&local->slaves_mtx);
+	list_add_tail_rcu(&priv->list, &local->slaves);
+	mutex_unlock(&local->slaves_mtx);
 	rtnl_unlock();
 
 	return 0;
@@ -194,52 +194,52 @@ err:
 
 static int mac802154_set_txpower(struct wpan_phy *phy, int db)
 {
-	struct mac802154_priv *priv = wpan_phy_priv(phy);
+	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return priv->ops->set_txpower(&priv->hw, db);
+	return local->ops->set_txpower(&local->hw, db);
 }
 
 static int mac802154_set_lbt(struct wpan_phy *phy, bool on)
 {
-	struct mac802154_priv *priv = wpan_phy_priv(phy);
+	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return priv->ops->set_lbt(&priv->hw, on);
+	return local->ops->set_lbt(&local->hw, on);
 }
 
 static int mac802154_set_cca_mode(struct wpan_phy *phy, u8 mode)
 {
-	struct mac802154_priv *priv = wpan_phy_priv(phy);
+	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return priv->ops->set_cca_mode(&priv->hw, mode);
+	return local->ops->set_cca_mode(&local->hw, mode);
 }
 
 static int mac802154_set_cca_ed_level(struct wpan_phy *phy, s32 level)
 {
-	struct mac802154_priv *priv = wpan_phy_priv(phy);
+	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return priv->ops->set_cca_ed_level(&priv->hw, level);
+	return local->ops->set_cca_ed_level(&local->hw, level);
 }
 
 static int mac802154_set_csma_params(struct wpan_phy *phy, u8 min_be,
 				     u8 max_be, u8 retries)
 {
-	struct mac802154_priv *priv = wpan_phy_priv(phy);
+	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return priv->ops->set_csma_params(&priv->hw, min_be, max_be, retries);
+	return local->ops->set_csma_params(&local->hw, min_be, max_be, retries);
 }
 
 static int mac802154_set_frame_retries(struct wpan_phy *phy, s8 retries)
 {
-	struct mac802154_priv *priv = wpan_phy_priv(phy);
+	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return priv->ops->set_frame_retries(&priv->hw, retries);
+	return local->ops->set_frame_retries(&local->hw, retries);
 }
 
 struct ieee802154_hw *
 ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 {
 	struct wpan_phy *phy;
-	struct mac802154_priv *priv;
+	struct ieee802154_local *local;
 	size_t priv_size;
 
 	if (!ops || !ops->xmit || !ops->ed || !ops->start ||
@@ -249,24 +249,24 @@ ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 	}
 
 	/* Ensure 32-byte alignment of our private data and hw private data.
-	 * We use the wpan_phy priv data for both our mac802154_priv and for
+	 * We use the wpan_phy priv data for both our ieee802154_local and for
 	 * the driver's private data
 	 *
 	 * in memory it'll be like this:
 	 *
-	 * +-----------------------+
-	 * | struct wpan_phy       |
-	 * +-----------------------+
-	 * | struct mac802154_priv |
-	 * +-----------------------+
-	 * | driver's private data |
-	 * +-----------------------+
+	 * +-------------------------+
+	 * | struct wpan_phy         |
+	 * +-------------------------+
+	 * | struct ieee802154_local |
+	 * +-------------------------+
+	 * | driver's private data   |
+	 * +-------------------------+
 	 *
 	 * Due to ieee802154 layer isn't aware of driver and MAC structures,
 	 * so lets align them here.
 	 */
 
-	priv_size = ALIGN(sizeof(*priv), NETDEV_ALIGN) + priv_data_len;
+	priv_size = ALIGN(sizeof(*local), NETDEV_ALIGN) + priv_data_len;
 
 	phy = wpan_phy_alloc(priv_size);
 	if (!phy) {
@@ -274,106 +274,106 @@ ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 		return NULL;
 	}
 
-	priv = wpan_phy_priv(phy);
-	priv->phy = phy;
-	priv->hw.phy = priv->phy;
-	priv->hw.priv = (char *)priv + ALIGN(sizeof(*priv), NETDEV_ALIGN);
-	priv->ops = ops;
+	local = wpan_phy_priv(phy);
+	local->phy = phy;
+	local->hw.phy = local->phy;
+	local->hw.priv = (char *)local + ALIGN(sizeof(*local), NETDEV_ALIGN);
+	local->ops = ops;
 
-	INIT_LIST_HEAD(&priv->slaves);
-	mutex_init(&priv->slaves_mtx);
+	INIT_LIST_HEAD(&local->slaves);
+	mutex_init(&local->slaves_mtx);
 
-	return &priv->hw;
+	return &local->hw;
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
 
 void ieee802154_free_hw(struct ieee802154_hw *hw)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(hw);
+	struct ieee802154_local *local = mac802154_to_priv(hw);
 
-	BUG_ON(!list_empty(&priv->slaves));
+	BUG_ON(!list_empty(&local->slaves));
 
-	mutex_destroy(&priv->slaves_mtx);
+	mutex_destroy(&local->slaves_mtx);
 
-	wpan_phy_free(priv->phy);
+	wpan_phy_free(local->phy);
 }
 EXPORT_SYMBOL(ieee802154_free_hw);
 
 int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(hw);
+	struct ieee802154_local *local = mac802154_to_priv(hw);
 	int rc = -ENOSYS;
 
 	if (hw->flags & IEEE802154_HW_TXPOWER) {
-		if (!priv->ops->set_txpower)
+		if (!local->ops->set_txpower)
 			goto out;
 
-		priv->phy->set_txpower = mac802154_set_txpower;
+		local->phy->set_txpower = mac802154_set_txpower;
 	}
 
 	if (hw->flags & IEEE802154_HW_LBT) {
-		if (!priv->ops->set_lbt)
+		if (!local->ops->set_lbt)
 			goto out;
 
-		priv->phy->set_lbt = mac802154_set_lbt;
+		local->phy->set_lbt = mac802154_set_lbt;
 	}
 
 	if (hw->flags & IEEE802154_HW_CCA_MODE) {
-		if (!priv->ops->set_cca_mode)
+		if (!local->ops->set_cca_mode)
 			goto out;
 
-		priv->phy->set_cca_mode = mac802154_set_cca_mode;
+		local->phy->set_cca_mode = mac802154_set_cca_mode;
 	}
 
 	if (hw->flags & IEEE802154_HW_CCA_ED_LEVEL) {
-		if (!priv->ops->set_cca_ed_level)
+		if (!local->ops->set_cca_ed_level)
 			goto out;
 
-		priv->phy->set_cca_ed_level = mac802154_set_cca_ed_level;
+		local->phy->set_cca_ed_level = mac802154_set_cca_ed_level;
 	}
 
 	if (hw->flags & IEEE802154_HW_CSMA_PARAMS) {
-		if (!priv->ops->set_csma_params)
+		if (!local->ops->set_csma_params)
 			goto out;
 
-		priv->phy->set_csma_params = mac802154_set_csma_params;
+		local->phy->set_csma_params = mac802154_set_csma_params;
 	}
 
 	if (hw->flags & IEEE802154_HW_FRAME_RETRIES) {
-		if (!priv->ops->set_frame_retries)
+		if (!local->ops->set_frame_retries)
 			goto out;
 
-		priv->phy->set_frame_retries = mac802154_set_frame_retries;
+		local->phy->set_frame_retries = mac802154_set_frame_retries;
 	}
 
-	priv->dev_workqueue =
-		create_singlethread_workqueue(wpan_phy_name(priv->phy));
-	if (!priv->dev_workqueue) {
+	local->dev_workqueue =
+		create_singlethread_workqueue(wpan_phy_name(local->phy));
+	if (!local->dev_workqueue) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	wpan_phy_set_dev(priv->phy, priv->hw.parent);
+	wpan_phy_set_dev(local->phy, local->hw.parent);
 
-	priv->phy->add_iface = mac802154_add_iface;
-	priv->phy->del_iface = mac802154_del_iface;
+	local->phy->add_iface = mac802154_add_iface;
+	local->phy->del_iface = mac802154_del_iface;
 
-	rc = wpan_phy_register(priv->phy);
+	rc = wpan_phy_register(local->phy);
 	if (rc < 0)
 		goto out_wq;
 
 	rtnl_lock();
 
-	mutex_lock(&priv->slaves_mtx);
-	priv->running = MAC802154_DEVICE_RUN;
-	mutex_unlock(&priv->slaves_mtx);
+	mutex_lock(&local->slaves_mtx);
+	local->running = MAC802154_DEVICE_RUN;
+	mutex_unlock(&local->slaves_mtx);
 
 	rtnl_unlock();
 
 	return 0;
 
 out_wq:
-	destroy_workqueue(priv->dev_workqueue);
+	destroy_workqueue(local->dev_workqueue);
 out:
 	return rc;
 }
@@ -381,19 +381,19 @@ EXPORT_SYMBOL(ieee802154_register_hw);
 
 void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(hw);
+	struct ieee802154_local *local = mac802154_to_priv(hw);
 	struct mac802154_sub_if_data *sdata, *next;
 
-	flush_workqueue(priv->dev_workqueue);
-	destroy_workqueue(priv->dev_workqueue);
+	flush_workqueue(local->dev_workqueue);
+	destroy_workqueue(local->dev_workqueue);
 
 	rtnl_lock();
 
-	mutex_lock(&priv->slaves_mtx);
-	priv->running = MAC802154_DEVICE_STOPPED;
-	mutex_unlock(&priv->slaves_mtx);
+	mutex_lock(&local->slaves_mtx);
+	local->running = MAC802154_DEVICE_STOPPED;
+	mutex_unlock(&local->slaves_mtx);
 
-	list_for_each_entry_safe(sdata, next, &priv->slaves, list) {
+	list_for_each_entry_safe(sdata, next, &local->slaves, list) {
 		mutex_lock(&sdata->hw->slaves_mtx);
 		list_del(&sdata->list);
 		mutex_unlock(&sdata->hw->slaves_mtx);
@@ -403,7 +403,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_unlock();
 
-	wpan_phy_unregister(priv->phy);
+	wpan_phy_unregister(local->phy);
 }
 EXPORT_SYMBOL(ieee802154_unregister_hw);
 
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 7c94672..5d9592a 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -36,7 +36,7 @@ struct hw_addr_filt_notify_work {
 	unsigned long changed;
 };
 
-static struct mac802154_priv *mac802154_slave_get_priv(struct net_device *dev)
+static struct ieee802154_local *mac802154_slave_get_priv(struct net_device *dev)
 {
 	struct mac802154_sub_if_data *priv = netdev_priv(dev);
 
@@ -49,12 +49,11 @@ static void hw_addr_notify(struct work_struct *work)
 {
 	struct hw_addr_filt_notify_work *nw = container_of(work,
 			struct hw_addr_filt_notify_work, work);
-	struct mac802154_priv *hw = mac802154_slave_get_priv(nw->dev);
+	struct ieee802154_local *local = mac802154_slave_get_priv(nw->dev);
 	int res;
 
-	res = hw->ops->set_hw_addr_filt(&hw->hw,
-					&hw->hw.hw_filt,
-					nw->changed);
+	res = local->ops->set_hw_addr_filt(&local->hw, &local->hw.hw_filt,
+					   nw->changed);
 	if (res)
 		pr_debug("failed changed mask %lx\n", nw->changed);
 
@@ -110,13 +109,13 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 void mac802154_dev_set_ieee_addr(struct net_device *dev)
 {
 	struct mac802154_sub_if_data *priv = netdev_priv(dev);
-	struct mac802154_priv *mac = priv->hw;
+	struct ieee802154_local *local = priv->hw;
 
 	priv->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
 
-	if (mac->ops->set_hw_addr_filt &&
-	    mac->hw.hw_filt.ieee_addr != priv->extended_addr) {
-		mac->hw.hw_filt.ieee_addr = priv->extended_addr;
+	if (local->ops->set_hw_addr_filt &&
+	    local->hw.hw_filt.ieee_addr != priv->extended_addr) {
+		local->hw.hw_filt.ieee_addr = priv->extended_addr;
 		set_hw_addr_filt(dev, IEEE802154_AFILT_IEEEADDR_CHANGED);
 	}
 }
@@ -165,12 +164,12 @@ static void phy_chan_notify(struct work_struct *work)
 {
 	struct phy_chan_notify_work *nw = container_of(work,
 					  struct phy_chan_notify_work, work);
-	struct mac802154_priv *hw = mac802154_slave_get_priv(nw->dev);
+	struct ieee802154_local *local = mac802154_slave_get_priv(nw->dev);
 	struct mac802154_sub_if_data *priv = netdev_priv(nw->dev);
 	int res;
 
 	mutex_lock(&priv->hw->phy->pib_lock);
-	res = hw->ops->set_channel(&hw->hw, priv->page, priv->chan);
+	res = local->ops->set_channel(&local->hw, priv->page, priv->chan);
 	if (res) {
 		pr_debug("set_channel failed\n");
 	} else {
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index ca82c72..a107fd2 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -57,7 +57,7 @@ static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 }
 
 
-void mac802154_monitors_rx(struct mac802154_priv *priv, struct sk_buff *skb)
+void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct sk_buff *skb2;
 	struct mac802154_sub_if_data *sdata;
@@ -65,7 +65,7 @@ void mac802154_monitors_rx(struct mac802154_priv *priv, struct sk_buff *skb)
 	u8 *data;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &priv->slaves, list) {
+	list_for_each_entry_rcu(sdata, &local->slaves, list) {
 		if (sdata->type != IEEE802154_DEV_MONITOR ||
 		    !netif_running(sdata->dev))
 			continue;
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 62b5c7d..dc01817 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -49,13 +49,13 @@ struct rx_work {
 static void
 mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(hw);
+	struct ieee802154_local *local = mac802154_to_priv(hw);
 
 	mac_cb(skb)->lqi = lqi;
 	skb->protocol = htons(ETH_P_IEEE802154);
 	skb_reset_mac_header(skb);
 
-	if (!(priv->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
+	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc;
 
 		if (skb->len < 2) {
@@ -70,8 +70,8 @@ mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 		skb_trim(skb, skb->len - 2); /* CRC */
 	}
 
-	mac802154_monitors_rx(priv, skb);
-	mac802154_wpans_rx(priv, skb);
+	mac802154_monitors_rx(local, skb);
+	mac802154_wpans_rx(local, skb);
 
 	return;
 
@@ -90,7 +90,7 @@ static void mac802154_rx_worker(struct work_struct *work)
 void
 ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(hw);
+	struct ieee802154_local *local = mac802154_to_priv(hw);
 	struct rx_work *work;
 
 	if (!skb)
@@ -105,6 +105,6 @@ ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 	work->hw = hw;
 	work->lqi = lqi;
 
-	queue_work(priv->dev_workqueue, &work->work);
+	queue_work(local->dev_workqueue, &work->work);
 }
 EXPORT_SYMBOL(ieee802154_rx_irqsafe);
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 8f537bf..d4c92bd 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -33,7 +33,7 @@
 struct xmit_work {
 	struct sk_buff *skb;
 	struct work_struct work;
-	struct mac802154_priv *priv;
+	struct ieee802154_local *local;
 	u8 chan;
 	u8 page;
 };
@@ -44,10 +44,10 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct mac802154_sub_if_data *sdata;
 	int res;
 
-	mutex_lock(&xw->priv->phy->pib_lock);
-	if (xw->priv->phy->current_channel != xw->chan ||
-	    xw->priv->phy->current_page != xw->page) {
-		res = xw->priv->ops->set_channel(&xw->priv->hw,
+	mutex_lock(&xw->local->phy->pib_lock);
+	if (xw->local->phy->current_channel != xw->chan ||
+	    xw->local->phy->current_page != xw->page) {
+		res = xw->local->ops->set_channel(&xw->local->hw,
 						  xw->page,
 						  xw->chan);
 		if (res) {
@@ -55,20 +55,20 @@ static void mac802154_xmit_worker(struct work_struct *work)
 			goto out;
 		}
 
-		xw->priv->phy->current_channel = xw->chan;
-		xw->priv->phy->current_page = xw->page;
+		xw->local->phy->current_channel = xw->chan;
+		xw->local->phy->current_page = xw->page;
 	}
 
-	res = xw->priv->ops->xmit(&xw->priv->hw, xw->skb);
+	res = xw->local->ops->xmit(&xw->local->hw, xw->skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
 out:
-	mutex_unlock(&xw->priv->phy->pib_lock);
+	mutex_unlock(&xw->local->phy->pib_lock);
 
 	/* Restart the netif queue on each sub_if_data object. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &xw->priv->slaves, list)
+	list_for_each_entry_rcu(sdata, &xw->local->slaves, list)
 		netif_wake_queue(sdata->dev);
 	rcu_read_unlock();
 
@@ -77,20 +77,20 @@ out:
 	kfree(xw);
 }
 
-netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
+netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
 			 u8 page, u8 chan)
 {
 	struct xmit_work *work;
 	struct mac802154_sub_if_data *sdata;
 
-	if (!(priv->phy->channels_supported[page] & (1 << chan))) {
+	if (!(local->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
 		goto err_tx;
 	}
 
-	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
+	mac802154_monitors_rx(mac802154_to_priv(&local->hw), skb);
 
-	if (!(priv->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
+	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 		u8 *data = skb_put(skb, 2);
 
@@ -98,7 +98,7 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
 		data[1] = crc >> 8;
 	}
 
-	if (skb_cow_head(skb, priv->hw.extra_tx_headroom))
+	if (skb_cow_head(skb, local->hw.extra_tx_headroom))
 		goto err_tx;
 
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
@@ -109,17 +109,17 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
 
 	/* Stop the netif queue on each sub_if_data object. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &priv->slaves, list)
+	list_for_each_entry_rcu(sdata, &local->slaves, list)
 		netif_stop_queue(sdata->dev);
 	rcu_read_unlock();
 
 	INIT_WORK(&work->work, mac802154_xmit_worker);
 	work->skb = skb;
-	work->priv = priv;
+	work->local = local;
 	work->page = page;
 	work->chan = chan;
 
-	queue_work(priv->dev_workqueue, &work->work);
+	queue_work(local->dev_workqueue, &work->work);
 
 	return NETDEV_TX_OK;
 
-- 
2.1.2

