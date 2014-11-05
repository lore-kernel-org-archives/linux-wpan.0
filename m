Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:62673 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbaKETwO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:14 -0500
Received: by mail-wi0-f177.google.com with SMTP id ex7so3057943wid.16
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:12 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/18] ieee802154: rework interface registration
Date: Wed,  5 Nov 2014 20:51:17 +0100
Message-Id: <1415217089-24919-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch meld mac802154_netdev_register into ieee802154_if_add
function. Also we have now only one alloc_netdev call with one interface
setup routine "ieee802154_if_setup" instead two different one for each
interface type. This patch checks via runtime the interface type and do
different handling now. Additional we add the wpan_dev struct in
ieee802154_sub_if_data and set the new ieee802154_ptr while netdev
registration. This behaviour is very similar the mac80211 netdev
registration functionality.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h      |   4 ++
 net/mac802154/cfg.c          |   8 ++-
 net/mac802154/ieee802154_i.h |   4 ++
 net/mac802154/iface.c        | 158 +++++++++++++++++++++----------------------
 4 files changed, 92 insertions(+), 82 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 29c6de5..57333f1 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -65,6 +65,10 @@ struct wpan_phy {
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
+struct wpan_dev {
+	struct wpan_phy *wpan_phy;
+};
+
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
 
 struct wpan_phy *
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 0a08f66..d2c4e8f 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -13,6 +13,7 @@
  * Based on: net/mac80211/cfg.c
  */
 
+#include <net/rtnetlink.h>
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
@@ -23,8 +24,13 @@ ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
 				const char *name, int type)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	struct net_device *dev;
 
-	return ieee802154_if_add(local, name, NULL, type);
+	rtnl_lock();
+	dev = ieee802154_if_add(local, name, NULL, type);
+	rtnl_unlock();
+
+	return dev;
 }
 
 static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 3ad8540..748dc5a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -20,6 +20,7 @@
 #define __IEEE802154_I_H
 
 #include <linux/mutex.h>
+#include <net/cfg802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 
@@ -73,11 +74,14 @@ enum ieee802154_sdata_state_bits {
 struct ieee802154_sub_if_data {
 	struct list_head list; /* the ieee802154_priv->slaves list */
 
+	struct wpan_dev wpan_dev;
+
 	struct ieee802154_local *local;
 	struct net_device *dev;
 
 	int type;
 	unsigned long state;
+	char name[IFNAMSIZ];
 
 	spinlock_t mib_lock;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 78cb381..f9ed608 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -381,30 +381,23 @@ static void mac802154_wpan_free(struct net_device *dev)
 	free_netdev(dev);
 }
 
-void mac802154_wpan_setup(struct net_device *dev)
+static void ieee802154_if_setup(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata;
-
 	dev->addr_len		= IEEE802154_ADDR_LEN;
 	memset(dev->broadcast, 0xff, IEEE802154_ADDR_LEN);
 
 	dev->hard_header_len	= MAC802154_FRAME_HARD_HEADER_LEN;
-	dev->header_ops		= &mac802154_header_ops;
 	dev->needed_tailroom	= 2 + 16; /* FCS + MIC */
 	dev->mtu		= IEEE802154_MTU;
 	dev->tx_queue_len	= 300;
-	dev->type		= ARPHRD_IEEE802154;
 	dev->flags		= IFF_NOARP | IFF_BROADCAST;
+}
 
-	dev->destructor		= mac802154_wpan_free;
-	dev->netdev_ops		= &mac802154_wpan_ops;
-	dev->ml_priv		= &mac802154_mlme_wpan;
-
-	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	sdata->type = IEEE802154_DEV_WPAN;
-
-	spin_lock_init(&sdata->mib_lock);
-	mutex_init(&sdata->sec_mtx);
+static int
+ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
+{
+	/* set some type-dependent values */
+	sdata->type = type;
 
 	get_random_bytes(&sdata->bsn, 1);
 	get_random_bytes(&sdata->dsn, 1);
@@ -419,54 +412,28 @@ void mac802154_wpan_setup(struct net_device *dev)
 	sdata->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
 	sdata->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
-	sdata->promisuous_mode = false;
-
-	mac802154_llsec_init(&sdata->sec);
-}
-
-void mac802154_monitor_setup(struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata;
-
-	dev->needed_tailroom	= 2; /* room for FCS */
-	dev->mtu		= IEEE802154_MTU;
-	dev->tx_queue_len	= 10;
-	dev->type		= ARPHRD_IEEE802154_MONITOR;
-	dev->flags		= IFF_NOARP | IFF_BROADCAST;
-
-	dev->destructor		= free_netdev;
-	dev->netdev_ops		= &mac802154_monitor_ops;
-	dev->ml_priv		= &mac802154_mlme_reduced;
-
-	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	sdata->type = IEEE802154_DEV_MONITOR;
-
-	sdata->promisuous_mode = true;
-}
-
-static int
-mac802154_netdev_register(struct ieee802154_local *local,
-			  struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	int err;
-
-	sdata->dev = dev;
-	sdata->local = local;
-
-	dev->needed_headroom = local->hw.extra_tx_headroom;
-
-	SET_NETDEV_DEV(dev, &local->phy->dev);
+	switch (type) {
+	case IEEE802154_DEV_WPAN:
+		sdata->dev->header_ops = &mac802154_header_ops;
+		sdata->dev->destructor = mac802154_wpan_free;
+		sdata->dev->netdev_ops = &mac802154_wpan_ops;
+		sdata->dev->ml_priv = &mac802154_mlme_wpan;
+		sdata->promisuous_mode = false;
 
-	err = register_netdev(dev);
-	if (err < 0)
-		return err;
+		spin_lock_init(&sdata->mib_lock);
+		mutex_init(&sdata->sec_mtx);
 
-	rtnl_lock();
-	mutex_lock(&local->iflist_mtx);
-	list_add_tail_rcu(&sdata->list, &local->interfaces);
-	mutex_unlock(&local->iflist_mtx);
-	rtnl_unlock();
+		mac802154_llsec_init(&sdata->sec);
+		break;
+	case IEEE802154_DEV_MONITOR:
+		sdata->dev->destructor = free_netdev;
+		sdata->dev->netdev_ops = &mac802154_monitor_ops;
+		sdata->dev->ml_priv = &mac802154_mlme_reduced;
+		sdata->promisuous_mode = true;
+		break;
+	default:
+		BUG();
+	}
 
 	return 0;
 }
@@ -475,38 +442,67 @@ struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		  struct wpan_dev **new_wpan_dev, int type)
 {
-	struct net_device *dev;
-	int err = -ENOMEM;
+	struct net_device *ndev = NULL;
+	struct ieee802154_sub_if_data *sdata = NULL;
+	int ret = -ENOMEM;
+
+	ASSERT_RTNL();
+
+	ndev = alloc_netdev(sizeof(*sdata), name, NET_NAME_UNKNOWN,
+			    ieee802154_if_setup);
+	if (!ndev)
+		return ERR_PTR(-ENOMEM);
+
+	ndev->needed_headroom = local->hw.extra_tx_headroom;
+
+	ret = dev_alloc_name(ndev, ndev->name);
+	if (ret < 0)
+		goto err;
 
 	switch (type) {
-	case IEEE802154_DEV_MONITOR:
-		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
-				   name, NET_NAME_UNKNOWN,
-				   mac802154_monitor_setup);
-		break;
 	case IEEE802154_DEV_WPAN:
-		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
-				   name, NET_NAME_UNKNOWN,
-				   mac802154_wpan_setup);
+		ndev->type = ARPHRD_IEEE802154;
 		break;
-	default:
-		dev = NULL;
-		err = -EINVAL;
+	case IEEE802154_DEV_MONITOR:
+		ndev->type = ARPHRD_IEEE802154_MONITOR;
 		break;
+	default:
+		ret = -EINVAL;
+		goto err;
 	}
-	if (!dev)
+
+	/* TODO check this */
+	SET_NETDEV_DEV(ndev, &local->phy->dev);
+	sdata = netdev_priv(ndev);
+	ndev->ieee802154_ptr = &sdata->wpan_dev;
+	memcpy(sdata->name, ndev->name, IFNAMSIZ);
+	sdata->dev = ndev;
+	sdata->wpan_dev.wpan_phy = local->hw.phy;
+	sdata->local = local;
+
+	/* setup type-dependent data */
+	ret = ieee802154_setup_sdata(sdata, type);
+	if (ret)
 		goto err;
 
-	err = mac802154_netdev_register(local, dev);
-	if (err)
-		goto err_free;
+	if (ndev) {
+		ret = register_netdevice(ndev);
+		if (ret < 0)
+			goto err;
+	}
+
+	mutex_lock(&local->iflist_mtx);
+	list_add_tail_rcu(&sdata->list, &local->interfaces);
+	mutex_unlock(&local->iflist_mtx);
 
-	return dev;
+	if (new_wpan_dev)
+		*new_wpan_dev = &sdata->wpan_dev;
+
+	return ndev;
 
-err_free:
-	free_netdev(dev);
 err:
-	return ERR_PTR(err);
+	free_netdev(ndev);
+	return ERR_PTR(ret);
 }
 
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
-- 
2.1.3

