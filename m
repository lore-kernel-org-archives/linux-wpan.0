Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:62589 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaKBDTX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:23 -0400
Received: by mail-wi0-f176.google.com with SMTP id h11so3992320wiw.9
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/16] mac802154: set panid address filter on ifup
Date: Sun,  2 Nov 2014 04:18:43 +0100
Message-Id: <1414898327-20759-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the setting of hardware panid address filtering
inside of interface up instead doing it it directly inside of netlink
interface. The netlink call which can only be called when netif isn't
running sets only the necessary panid value in sdata. After an
interface up the address filter will be set with this value.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c |  4 ++++
 net/mac802154/mib.c   | 51 ---------------------------------------------------
 2 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 1bae29d..5f94c70 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -205,6 +205,10 @@ static int mac802154_wpan_open(struct net_device *dev)
 	}
 
 	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		rc = drv_set_pan_id(local, sdata->pan_id);
+		if (rc < 0)
+			goto out;
+
 		rc = drv_set_extended_addr(local, sdata->extended_addr);
 		if (rc < 0)
 			goto out;
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 755befd..6fa7491 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -26,51 +26,6 @@
 #include "ieee802154_i.h"
 #include "driver-ops.h"
 
-struct hw_addr_filt_notify_work {
-	struct work_struct work;
-	struct net_device *dev;
-	unsigned long changed;
-};
-
-static struct ieee802154_local *mac802154_slave_get_priv(struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	return sdata->local;
-}
-
-static void hw_addr_notify(struct work_struct *work)
-{
-	struct hw_addr_filt_notify_work *nw = container_of(work,
-			struct hw_addr_filt_notify_work, work);
-	struct ieee802154_local *local = mac802154_slave_get_priv(nw->dev);
-	int res;
-
-	res = local->ops->set_hw_addr_filt(&local->hw, &local->hw.hw_filt,
-					   nw->changed);
-	if (res)
-		pr_debug("failed changed mask %lx\n", nw->changed);
-
-	kfree(nw);
-}
-
-static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct hw_addr_filt_notify_work *work;
-
-	work = kzalloc(sizeof(*work), GFP_ATOMIC);
-	if (!work)
-		return;
-
-	INIT_WORK(&work->work, hw_addr_notify);
-	work->dev = dev;
-	work->changed = changed;
-	queue_work(sdata->local->workqueue, &work->work);
-}
-
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
@@ -119,12 +74,6 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 	spin_lock_bh(&sdata->mib_lock);
 	sdata->pan_id = val;
 	spin_unlock_bh(&sdata->mib_lock);
-
-	if ((sdata->local->ops->set_hw_addr_filt) &&
-	    (sdata->local->hw.hw_filt.pan_id != sdata->pan_id)) {
-		sdata->local->hw.hw_filt.pan_id = sdata->pan_id;
-		set_hw_addr_filt(dev, IEEE802154_AFILT_PANID_CHANGED);
-	}
 }
 
 u8 mac802154_dev_get_dsn(const struct net_device *dev)
-- 
2.1.3

