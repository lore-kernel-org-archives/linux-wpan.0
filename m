Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51780 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaJ1RWG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:06 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so1047010lbv.33
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/17] mac802154: rework sdata state change to running
Date: Tue, 28 Oct 2014 18:21:24 +0100
Message-Id: <1414516892-4107-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch reworks the handling for setting the state like mac80211. We
use bit's instead a bool variable. The mutex is not needed because it use
test and set bits which are atomic operations.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 12 +++++++++++-
 net/mac802154/iface.c        | 12 +++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index a379b97..e34fe51 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -67,6 +67,10 @@ enum {
 	IEEE802154_RX_MSG        = 1,
 };
 
+enum ieee802154_sdata_state_bits {
+	SDATA_STATE_RUNNING,
+};
+
 /* Slave interface definition.
  *
  * Slaves represent typical network interfaces available from userspace.
@@ -80,7 +84,7 @@ struct ieee802154_sub_if_data {
 	struct net_device *dev;
 
 	int type;
-	bool running;
+	unsigned long state;
 
 	spinlock_t mib_lock;
 
@@ -120,6 +124,12 @@ IEEE802154_DEV_TO_SUB_IF(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline bool
+ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
+{
+	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
+}
+
 extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 300877a..e10fd78 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -156,7 +156,7 @@ static int mac802154_slave_open(struct net_device *dev)
 		mutex_lock(&sdata->local->iflist_mtx);
 		list_for_each_entry(subif, &sdata->local->interfaces, list) {
 			if (subif != sdata && subif->type == sdata->type &&
-			    subif->running) {
+			    ieee802154_sdata_running(subif)) {
 				mutex_unlock(&sdata->local->iflist_mtx);
 				return -EBUSY;
 			}
@@ -164,9 +164,7 @@ static int mac802154_slave_open(struct net_device *dev)
 		mutex_unlock(&sdata->local->iflist_mtx);
 	}
 
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = true;
-	mutex_unlock(&sdata->local->iflist_mtx);
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	if (local->open_count++ == 0) {
 		res = drv_start(local);
@@ -178,6 +176,8 @@ static int mac802154_slave_open(struct net_device *dev)
 	netif_start_queue(dev);
 	return 0;
 err:
+	/* might already be clear but that doesn't matter */
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	sdata->local->open_count--;
 
 	return res;
@@ -253,9 +253,7 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = false;
-	mutex_unlock(&sdata->local->iflist_mtx);
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	if (!--local->open_count)
 		drv_stop(local);
-- 
2.1.2

