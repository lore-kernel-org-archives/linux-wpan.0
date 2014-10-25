Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:53101 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaJYTHg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:07:36 -0400
Received: by mail-la0-f49.google.com with SMTP id gf13so2839167lab.8
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:07:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/10] mac802154: rename hw subif_data variable to local
Date: Sat, 25 Oct 2014 17:16:37 +0200
Message-Id: <1414250202-32384-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the hw attribute in struct ieee802154_sub_if_data to
local. This avoid confusing with the struct ieee802154_hw hw; inside of
local struct.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  2 +-
 net/mac802154/iface.c        | 12 ++++++------
 net/mac802154/mac_cmd.c      |  2 +-
 net/mac802154/main.c         | 34 +++++++++++++++++-----------------
 net/mac802154/mib.c          | 38 +++++++++++++++++++-------------------
 net/mac802154/monitor.c      |  6 +++---
 6 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index daaca37..c5b1ab7 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -69,7 +69,7 @@ struct ieee802154_local {
 struct ieee802154_sub_if_data {
 	struct list_head list; /* the ieee802154_priv->slaves list */
 
-	struct ieee802154_local *hw;
+	struct ieee802154_local *local;
 	struct net_device *dev;
 
 	int type;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index d3eb8a4..6eace90 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -125,9 +125,9 @@ int mac802154_set_mac_params(struct net_device *dev,
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mutex_lock(&sdata->hw->slaves_mtx);
+	mutex_lock(&sdata->local->slaves_mtx);
 	sdata->mac_params = *params;
-	mutex_unlock(&sdata->hw->slaves_mtx);
+	mutex_unlock(&sdata->local->slaves_mtx);
 
 	return 0;
 }
@@ -137,16 +137,16 @@ void mac802154_get_mac_params(struct net_device *dev,
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mutex_lock(&sdata->hw->slaves_mtx);
+	mutex_lock(&sdata->local->slaves_mtx);
 	*params = sdata->mac_params;
-	mutex_unlock(&sdata->hw->slaves_mtx);
+	mutex_unlock(&sdata->local->slaves_mtx);
 }
 
 static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
-	struct wpan_phy *phy = sdata->hw->phy;
+	struct wpan_phy *phy = sdata->local->phy;
 
 	rc = mac802154_slave_open(dev);
 	if (rc < 0)
@@ -339,7 +339,7 @@ mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(sdata->hw, skb, page, chan);
+	return mac802154_tx(sdata->local, skb, page, chan);
 }
 
 static struct header_ops mac802154_header_ops = {
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index bccaefb..5ee1088 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -79,7 +79,7 @@ static struct wpan_phy *mac802154_get_phy(const struct net_device *dev)
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	return to_phy(get_device(&sdata->hw->phy->dev));
+	return to_phy(get_device(&sdata->local->phy->dev));
 }
 
 static struct ieee802154_llsec_ops mac802154_llsec_ops = {
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 6f630d4..9b2644f 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -33,26 +33,26 @@ int mac802154_slave_open(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	struct ieee802154_sub_if_data *subif;
-	struct ieee802154_local *local = sdata->hw;
+	struct ieee802154_local *local = sdata->local;
 	int res = 0;
 
 	ASSERT_RTNL();
 
 	if (sdata->type == IEEE802154_DEV_WPAN) {
-		mutex_lock(&sdata->hw->slaves_mtx);
-		list_for_each_entry(subif, &sdata->hw->slaves, list) {
+		mutex_lock(&sdata->local->slaves_mtx);
+		list_for_each_entry(subif, &sdata->local->slaves, list) {
 			if (subif != sdata && subif->type == sdata->type &&
 			    subif->running) {
-				mutex_unlock(&sdata->hw->slaves_mtx);
+				mutex_unlock(&sdata->local->slaves_mtx);
 				return -EBUSY;
 			}
 		}
-		mutex_unlock(&sdata->hw->slaves_mtx);
+		mutex_unlock(&sdata->local->slaves_mtx);
 	}
 
-	mutex_lock(&sdata->hw->slaves_mtx);
+	mutex_lock(&sdata->local->slaves_mtx);
 	sdata->running = true;
-	mutex_unlock(&sdata->hw->slaves_mtx);
+	mutex_unlock(&sdata->local->slaves_mtx);
 
 	if (local->open_count++ == 0) {
 		res = local->ops->start(&local->hw);
@@ -74,7 +74,7 @@ int mac802154_slave_open(struct net_device *dev)
 	netif_start_queue(dev);
 	return 0;
 err:
-	sdata->hw->open_count--;
+	sdata->local->open_count--;
 
 	return res;
 }
@@ -82,15 +82,15 @@ err:
 int mac802154_slave_close(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
-	struct ieee802154_local *local = sdata->hw;
+	struct ieee802154_local *local = sdata->local;
 
 	ASSERT_RTNL();
 
 	netif_stop_queue(dev);
 
-	mutex_lock(&sdata->hw->slaves_mtx);
+	mutex_lock(&sdata->local->slaves_mtx);
 	sdata->running = false;
-	mutex_unlock(&sdata->hw->slaves_mtx);
+	mutex_unlock(&sdata->local->slaves_mtx);
 
 	if (!--local->open_count)
 		local->ops->stop(&local->hw);
@@ -109,7 +109,7 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 
 	sdata = netdev_priv(dev);
 	sdata->dev = dev;
-	sdata->hw = local;
+	sdata->local = local;
 
 	dev->needed_headroom = local->hw.extra_tx_headroom;
 
@@ -144,11 +144,11 @@ mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
 
 	sdata = netdev_priv(dev);
 
-	BUG_ON(sdata->hw->phy != phy);
+	BUG_ON(sdata->local->phy != phy);
 
-	mutex_lock(&sdata->hw->slaves_mtx);
+	mutex_lock(&sdata->local->slaves_mtx);
 	list_del_rcu(&sdata->list);
-	mutex_unlock(&sdata->hw->slaves_mtx);
+	mutex_unlock(&sdata->local->slaves_mtx);
 
 	synchronize_rcu();
 	unregister_netdevice(sdata->dev);
@@ -394,9 +394,9 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 	mutex_unlock(&local->slaves_mtx);
 
 	list_for_each_entry_safe(sdata, next, &local->slaves, list) {
-		mutex_lock(&sdata->hw->slaves_mtx);
+		mutex_lock(&sdata->local->slaves_mtx);
 		list_del(&sdata->list);
-		mutex_unlock(&sdata->hw->slaves_mtx);
+		mutex_unlock(&sdata->local->slaves_mtx);
 
 		unregister_netdevice(sdata->dev);
 	}
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index ef05b3b..1ffca5c 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -42,7 +42,7 @@ static struct ieee802154_local *mac802154_slave_get_priv(struct net_device *dev)
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	return sdata->hw;
+	return sdata->local;
 }
 
 static void hw_addr_notify(struct work_struct *work)
@@ -72,7 +72,7 @@ static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 	INIT_WORK(&work->work, hw_addr_notify);
 	work->dev = dev;
 	work->changed = changed;
-	queue_work(sdata->hw->dev_workqueue, &work->work);
+	queue_work(sdata->local->dev_workqueue, &work->work);
 }
 
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
@@ -85,9 +85,9 @@ void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 	sdata->short_addr = val;
 	spin_unlock_bh(&sdata->mib_lock);
 
-	if ((sdata->hw->ops->set_hw_addr_filt) &&
-	    (sdata->hw->hw.hw_filt.short_addr != sdata->short_addr)) {
-		sdata->hw->hw.hw_filt.short_addr = sdata->short_addr;
+	if ((sdata->local->ops->set_hw_addr_filt) &&
+	    (sdata->local->hw.hw_filt.short_addr != sdata->short_addr)) {
+		sdata->local->hw.hw_filt.short_addr = sdata->short_addr;
 		set_hw_addr_filt(dev, IEEE802154_AFILT_SADDR_CHANGED);
 	}
 }
@@ -109,7 +109,7 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 void mac802154_dev_set_ieee_addr(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
-	struct ieee802154_local *local = sdata->hw;
+	struct ieee802154_local *local = sdata->local;
 
 	sdata->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
 
@@ -144,9 +144,9 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 	sdata->pan_id = val;
 	spin_unlock_bh(&sdata->mib_lock);
 
-	if ((sdata->hw->ops->set_hw_addr_filt) &&
-	    (sdata->hw->hw.hw_filt.pan_id != sdata->pan_id)) {
-		sdata->hw->hw.hw_filt.pan_id = sdata->pan_id;
+	if ((sdata->local->ops->set_hw_addr_filt) &&
+	    (sdata->local->hw.hw_filt.pan_id != sdata->pan_id)) {
+		sdata->local->hw.hw_filt.pan_id = sdata->pan_id;
 		set_hw_addr_filt(dev, IEEE802154_AFILT_PANID_CHANGED);
 	}
 }
@@ -168,15 +168,15 @@ static void phy_chan_notify(struct work_struct *work)
 	struct ieee802154_sub_if_data *sdata = netdev_priv(nw->dev);
 	int res;
 
-	mutex_lock(&sdata->hw->phy->pib_lock);
+	mutex_lock(&sdata->local->phy->pib_lock);
 	res = local->ops->set_channel(&local->hw, sdata->page, sdata->chan);
 	if (res) {
 		pr_debug("set_channel failed\n");
 	} else {
-		sdata->hw->phy->current_channel = sdata->chan;
-		sdata->hw->phy->current_page = sdata->page;
+		sdata->local->phy->current_channel = sdata->chan;
+		sdata->local->phy->current_page = sdata->page;
 	}
-	mutex_unlock(&sdata->hw->phy->pib_lock);
+	mutex_unlock(&sdata->local->phy->pib_lock);
 
 	kfree(nw);
 }
@@ -193,10 +193,10 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 	sdata->chan = chan;
 	spin_unlock_bh(&sdata->mib_lock);
 
-	mutex_lock(&sdata->hw->phy->pib_lock);
-	if (sdata->hw->phy->current_channel != sdata->chan ||
-	    sdata->hw->phy->current_page != sdata->page) {
-		mutex_unlock(&sdata->hw->phy->pib_lock);
+	mutex_lock(&sdata->local->phy->pib_lock);
+	if (sdata->local->phy->current_channel != sdata->chan ||
+	    sdata->local->phy->current_page != sdata->page) {
+		mutex_unlock(&sdata->local->phy->pib_lock);
 
 		work = kzalloc(sizeof(*work), GFP_ATOMIC);
 		if (!work)
@@ -204,9 +204,9 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 
 		INIT_WORK(&work->work, phy_chan_notify);
 		work->dev = dev;
-		queue_work(sdata->hw->dev_workqueue, &work->work);
+		queue_work(sdata->local->dev_workqueue, &work->work);
 	} else {
-		mutex_unlock(&sdata->hw->phy->pib_lock);
+		mutex_unlock(&sdata->local->phy->pib_lock);
 	}
 }
 
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index bd63e12..79bce52 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -39,8 +39,8 @@ static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 	sdata = netdev_priv(dev);
 
 	/* FIXME: locking */
-	chan = sdata->hw->phy->current_channel;
-	page = sdata->hw->phy->current_page;
+	chan = sdata->local->phy->current_channel;
+	page = sdata->local->phy->current_page;
 
 	if (chan == MAC802154_CHAN_NONE) /* not initialized */
 		return NETDEV_TX_OK;
@@ -53,7 +53,7 @@ static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(sdata->hw, skb, page, chan);
+	return mac802154_tx(sdata->local, skb, page, chan);
 }
 
 
-- 
2.1.2

