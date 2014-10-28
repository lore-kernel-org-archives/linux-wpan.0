Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58433 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaJ1RWH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:07 -0400
Received: by mail-la0-f45.google.com with SMTP id gm9so1051050lab.4
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/17] mac802154: rename running to started
Date: Tue, 28 Oct 2014 18:21:25 +0100
Message-Id: <1414516892-4107-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This variable should be handled like ieee80211_local struct of mac80211.
We rename this variable to started now to have the same name convention.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 2 +-
 net/mac802154/main.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index e34fe51..f52afd4 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -54,7 +54,7 @@ struct ieee802154_local {
 	 * This flag should be modified under slaves_mtx and RTNL, so you can
 	 * read them using any of protection methods.
 	 */
-	bool running;
+	bool started;
 
 	struct tasklet_struct tasklet;
 	struct sk_buff_head skb_queue;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 9fa9514..7458f71 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -47,7 +47,7 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 	SET_NETDEV_DEV(dev, &local->phy->dev);
 
 	mutex_lock(&local->iflist_mtx);
-	if (!local->running) {
+	if (!local->started) {
 		mutex_unlock(&local->iflist_mtx);
 		return -ENODEV;
 	}
@@ -238,7 +238,7 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 	rtnl_lock();
 
 	mutex_lock(&local->iflist_mtx);
-	local->running = MAC802154_DEVICE_RUN;
+	local->started = MAC802154_DEVICE_RUN;
 	mutex_unlock(&local->iflist_mtx);
 
 	rtnl_unlock();
@@ -264,7 +264,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 	rtnl_lock();
 
 	mutex_lock(&local->iflist_mtx);
-	local->running = MAC802154_DEVICE_STOPPED;
+	local->started = MAC802154_DEVICE_STOPPED;
 	mutex_unlock(&local->iflist_mtx);
 
 	list_for_each_entry_safe(sdata, next, &local->interfaces, list) {
-- 
2.1.2

