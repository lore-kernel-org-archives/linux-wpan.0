Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:41505 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbaJ1RWD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:03 -0400
Received: by mail-lb0-f179.google.com with SMTP id w7so1024645lbi.24
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/17] mac802154: use driver-ops function wrappers
Date: Tue, 28 Oct 2014 18:21:21 +0100
Message-Id: <1414516892-4107-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replaces all directly called driver ops by previous
introduced driver-ops function wrappers.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 25 ++++++++++++++-----------
 net/mac802154/main.c  | 13 +++++++------
 net/mac802154/mib.c   |  3 ++-
 net/mac802154/tx.c    |  5 +++--
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 0b21413..025cd5a 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -30,6 +30,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
@@ -168,7 +169,7 @@ static int mac802154_slave_open(struct net_device *dev)
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (local->open_count++ == 0) {
-		res = local->ops->start(&local->hw);
+		res = drv_start(local);
 		WARN_ON(res);
 		if (res)
 			goto err;
@@ -186,6 +187,7 @@ static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct ieee802154_local *local = sdata->local;
 	struct wpan_phy *phy = sdata->local->phy;
 
 	rc = mac802154_slave_open(dev);
@@ -195,40 +197,41 @@ static int mac802154_wpan_open(struct net_device *dev)
 	mutex_lock(&phy->pib_lock);
 
 	if (phy->set_txpower) {
-		rc = phy->set_txpower(phy, sdata->mac_params.transmit_power);
+		rc = drv_set_tx_power(local, sdata->mac_params.transmit_power);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_lbt) {
-		rc = phy->set_lbt(phy, sdata->mac_params.lbt);
+		rc = drv_set_lbt_mode(local, sdata->mac_params.lbt);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_cca_mode) {
-		rc = phy->set_cca_mode(phy, sdata->mac_params.cca_mode);
+		rc = drv_set_cca_mode(local, sdata->mac_params.cca_mode);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_cca_ed_level) {
-		rc = phy->set_cca_ed_level(phy, sdata->mac_params.cca_ed_level);
+		rc = drv_set_cca_ed_level(local,
+					  sdata->mac_params.cca_ed_level);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_csma_params) {
-		rc = phy->set_csma_params(phy, sdata->mac_params.min_be,
-					  sdata->mac_params.max_be,
-					  sdata->mac_params.csma_retries);
+		rc = drv_set_csma_params(local, sdata->mac_params.min_be,
+					 sdata->mac_params.max_be,
+					 sdata->mac_params.csma_retries);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_frame_retries) {
-		rc = phy->set_frame_retries(phy,
-					    sdata->mac_params.frame_retries);
+		rc = drv_set_max_frame_retries(local,
+					       sdata->mac_params.frame_retries);
 		if (rc < 0)
 			goto out;
 	}
@@ -255,7 +258,7 @@ static int mac802154_slave_close(struct net_device *dev)
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (!--local->open_count)
-		local->ops->stop(&local->hw);
+		drv_stop(local);
 
 	return 0;
 }
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 632707b..24ecc09 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -28,6 +28,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
@@ -124,28 +125,28 @@ static int mac802154_set_txpower(struct wpan_phy *phy, int db)
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return local->ops->set_txpower(&local->hw, db);
+	return drv_set_tx_power(local, db);
 }
 
 static int mac802154_set_lbt(struct wpan_phy *phy, bool on)
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return local->ops->set_lbt(&local->hw, on);
+	return drv_set_lbt_mode(local, on);
 }
 
 static int mac802154_set_cca_mode(struct wpan_phy *phy, u8 mode)
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return local->ops->set_cca_mode(&local->hw, mode);
+	return drv_set_cca_mode(local, mode);
 }
 
 static int mac802154_set_cca_ed_level(struct wpan_phy *phy, s32 level)
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return local->ops->set_cca_ed_level(&local->hw, level);
+	return drv_set_cca_ed_level(local, level);
 }
 
 static int mac802154_set_csma_params(struct wpan_phy *phy, u8 min_be,
@@ -153,14 +154,14 @@ static int mac802154_set_csma_params(struct wpan_phy *phy, u8 min_be,
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return local->ops->set_csma_params(&local->hw, min_be, max_be, retries);
+	return drv_set_csma_params(local, min_be, max_be, retries);
 }
 
 static int mac802154_set_frame_retries(struct wpan_phy *phy, s8 retries)
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 
-	return local->ops->set_frame_retries(&local->hw, retries);
+	return drv_set_max_frame_retries(local, retries);
 }
 
 static void ieee802154_tasklet_handler(unsigned long data)
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 16baff1..3fbc217 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -24,6 +24,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 struct phy_chan_notify_work {
 	struct work_struct work;
@@ -170,7 +171,7 @@ static void phy_chan_notify(struct work_struct *work)
 	int res;
 
 	mutex_lock(&sdata->local->phy->pib_lock);
-	res = local->ops->set_channel(&local->hw, sdata->page, sdata->chan);
+	res = drv_set_channel(local, sdata->page, sdata->chan);
 	if (res) {
 		pr_debug("set_channel failed\n");
 	} else {
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index e857673..77973a8 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -28,6 +28,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
@@ -55,7 +56,7 @@ static void ieee802154_xmit_worker(struct work_struct *work)
 	if (!netif_running(dev))
 		goto err_tx;
 
-	res = local->ops->xmit_sync(&local->hw, skb);
+	res = drv_xmit_sync(local, skb);
 	if (res)
 		goto err_tx;
 
@@ -96,7 +97,7 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 
 	/* async is priority, otherwise sync is fallback */
 	if (local->ops->xmit_async) {
-		ret = local->ops->xmit_async(&local->hw, skb);
+		ret = drv_xmit_async(local, skb);
 		if (ret) {
 			ieee802154_wake_queue(&local->hw);
 			goto err_tx;
-- 
2.1.2

