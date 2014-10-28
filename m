Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:58588 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbaJ1RWM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:12 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so1045743lbv.0
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/17] mac802154: remove channel attributes from sdata
Date: Tue, 28 Oct 2014 18:21:29 +0100
Message-Id: <1414516892-4107-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

These channel attributes was part of "channel context switch while xmit"
which was removed by commit dc67c6b30f36d57b70b70547a30e7a8432540c6f
("mac802154: tx: remove xmit channel context switch"). This patch
removes these unnecessary variables and use the current_page and
current_channel by wpan_phy struct now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  3 ---
 net/mac802154/iface.c        |  4 ----
 net/mac802154/mib.c          | 55 ++++++++------------------------------------
 3 files changed, 9 insertions(+), 53 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index bf0b5f6..46c9fe7 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -85,9 +85,6 @@ struct ieee802154_sub_if_data {
 	__le16 short_addr;
 	__le64 extended_addr;
 
-	u8 chan;
-	u8 page;
-
 	struct ieee802154_mac_params mac_params;
 
 	/* MAC BSN field */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 2423aa7..1c0274e 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -417,8 +417,6 @@ void mac802154_wpan_setup(struct net_device *dev)
 	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	sdata->type = IEEE802154_DEV_WPAN;
 
-	sdata->chan = MAC802154_CHAN_NONE;
-
 	spin_lock_init(&sdata->mib_lock);
 	mutex_init(&sdata->sec_mtx);
 
@@ -454,6 +452,4 @@ void mac802154_monitor_setup(struct net_device *dev)
 
 	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	sdata->type = IEEE802154_DEV_MONITOR;
-
-	sdata->chan = MAC802154_CHAN_NONE; /* not initialized */
 }
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 3fbc217..0184fce 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -26,11 +26,6 @@
 #include "ieee802154_i.h"
 #include "driver-ops.h"
 
-struct phy_chan_notify_work {
-	struct work_struct work;
-	struct net_device *dev;
-};
-
 struct hw_addr_filt_notify_work {
 	struct work_struct work;
 	struct net_device *dev;
@@ -161,54 +156,22 @@ u8 mac802154_dev_get_dsn(const struct net_device *dev)
 	return sdata->dsn++;
 }
 
-static void phy_chan_notify(struct work_struct *work)
-{
-	struct phy_chan_notify_work *nw = container_of(work,
-					  struct phy_chan_notify_work, work);
-	struct net_device *dev = nw->dev;
-	struct ieee802154_local *local = mac802154_slave_get_priv(dev);
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	int res;
-
-	mutex_lock(&sdata->local->phy->pib_lock);
-	res = drv_set_channel(local, sdata->page, sdata->chan);
-	if (res) {
-		pr_debug("set_channel failed\n");
-	} else {
-		sdata->local->phy->current_channel = sdata->chan;
-		sdata->local->phy->current_page = sdata->page;
-	}
-	mutex_unlock(&sdata->local->phy->pib_lock);
-
-	kfree(nw);
-}
-
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct phy_chan_notify_work *work;
+	struct ieee802154_local *local = sdata->local;
+	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	spin_lock_bh(&sdata->mib_lock);
-	sdata->page = page;
-	sdata->chan = chan;
-	spin_unlock_bh(&sdata->mib_lock);
-
-	mutex_lock(&sdata->local->phy->pib_lock);
-	if (sdata->local->phy->current_channel != sdata->chan ||
-	    sdata->local->phy->current_page != sdata->page) {
-		mutex_unlock(&sdata->local->phy->pib_lock);
-
-		work = kzalloc(sizeof(*work), GFP_ATOMIC);
-		if (!work)
-			return;
-
-		INIT_WORK(&work->work, phy_chan_notify);
-		work->dev = dev;
-		queue_work(sdata->local->workqueue, &work->work);
+	res = drv_set_channel(local, page, chan);
+	if (res) {
+		pr_debug("set_channel failed\n");
 	} else {
-		mutex_unlock(&sdata->local->phy->pib_lock);
+		mutex_lock(&local->phy->pib_lock);
+		local->phy->current_channel = chan;
+		local->phy->current_page = page;
+		mutex_unlock(&local->phy->pib_lock);
 	}
 }
 
-- 
2.1.2

