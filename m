Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:44427 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaJ1RWK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:10 -0400
Received: by mail-la0-f44.google.com with SMTP id gf13so1051756lab.31
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/17] mac802154: move local started handling
Date: Tue, 28 Oct 2014 18:21:26 +0100
Message-Id: <1414516892-4107-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the current handling of started boolean. This is
actually dead code, because mac802154_netdev_register can't never be
called before ieee802154_register_hw. This means that local->started is
always be true when mac802154_netdev_register is called. Instead we
using this now like mac80211 to indicate that an instance of sdata is
running.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/driver-ops.h   |  4 ++++
 net/mac802154/ieee802154_i.h |  7 -------
 net/mac802154/main.c         | 19 -------------------
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index bf7980b..bb3ee03 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -29,6 +29,8 @@ static inline int drv_start(struct ieee802154_local *local)
 {
 	might_sleep();
 
+	local->started = true;
+
 	return local->ops->start(&local->hw);
 }
 
@@ -37,6 +39,8 @@ static inline void drv_stop(struct ieee802154_local *local)
 	might_sleep();
 
 	local->ops->stop(&local->hw);
+
+	local->started = false;
 }
 
 static inline int drv_set_channel(struct ieee802154_local *local,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index f52afd4..bf0b5f6 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -50,19 +50,12 @@ struct ieee802154_local {
 	 */
 	struct workqueue_struct	*workqueue;
 
-	/* SoftMAC device is registered and running. One can add subinterfaces.
-	 * This flag should be modified under slaves_mtx and RTNL, so you can
-	 * read them using any of protection methods.
-	 */
 	bool started;
 
 	struct tasklet_struct tasklet;
 	struct sk_buff_head skb_queue;
 };
 
-#define	MAC802154_DEVICE_STOPPED	0x00
-#define MAC802154_DEVICE_RUN		0x01
-
 enum {
 	IEEE802154_RX_MSG        = 1,
 };
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 7458f71..21dcc56 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -46,13 +46,6 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 
 	SET_NETDEV_DEV(dev, &local->phy->dev);
 
-	mutex_lock(&local->iflist_mtx);
-	if (!local->started) {
-		mutex_unlock(&local->iflist_mtx);
-		return -ENODEV;
-	}
-	mutex_unlock(&local->iflist_mtx);
-
 	err = register_netdev(dev);
 	if (err < 0)
 		return err;
@@ -235,14 +228,6 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 	if (rc < 0)
 		goto out_wq;
 
-	rtnl_lock();
-
-	mutex_lock(&local->iflist_mtx);
-	local->started = MAC802154_DEVICE_RUN;
-	mutex_unlock(&local->iflist_mtx);
-
-	rtnl_unlock();
-
 	return 0;
 
 out_wq:
@@ -263,10 +248,6 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	mutex_lock(&local->iflist_mtx);
-	local->started = MAC802154_DEVICE_STOPPED;
-	mutex_unlock(&local->iflist_mtx);
-
 	list_for_each_entry_safe(sdata, next, &local->interfaces, list) {
 		mutex_lock(&sdata->local->iflist_mtx);
 		list_del(&sdata->list);
-- 
2.1.2

