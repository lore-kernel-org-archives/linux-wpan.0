Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38587 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbLIWYH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Dec 2015 17:24:07 -0500
Received: by wmec201 with SMTP id c201so756731wme.1
        for <linux-wpan@vger.kernel.org>; Wed, 09 Dec 2015 14:24:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth] mac802154: tx: fix synced xmit deadlock
Date: Wed,  9 Dec 2015 23:23:56 +0100
Message-Id: <1449699836-8260-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>

This patch reverts 6001d52 ("mac802154: tx: don't allow if down while
sync tx"). This has side effects with stop callback which flush the
transmit workqueue. The stop callback will wait until the workqueue is
flushed and holding the rtnl lock. That means it can happen that the stop
callback waits forever because it try to lock the rtnl mutex which is
already hold by stop callback.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
changes since v2:
 - remove ASSERT_RTNL as well in "xmit sync" driver-ops.

 net/mac802154/driver-ops.h | 3 ---
 net/mac802154/tx.c         | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 0550f33..fd9daf2 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -18,9 +18,6 @@ drv_xmit_async(struct ieee802154_local *local, struct sk_buff *skb)
 static inline int
 drv_xmit_sync(struct ieee802154_local *local, struct sk_buff *skb)
 {
-	/* don't allow other operations while sync xmit */
-	ASSERT_RTNL();
-
 	might_sleep();
 
 	return local->ops->xmit_sync(&local->hw, skb);
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 3827f35..7e25345 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -38,12 +38,6 @@ void ieee802154_xmit_worker(struct work_struct *work)
 	struct net_device *dev = skb->dev;
 	int res;
 
-	rtnl_lock();
-
-	/* check if ifdown occurred while schedule */
-	if (!netif_running(dev))
-		goto err_tx;
-
 	res = drv_xmit_sync(local, skb);
 	if (res)
 		goto err_tx;
@@ -53,14 +47,11 @@ void ieee802154_xmit_worker(struct work_struct *work)
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	rtnl_unlock();
-
 	return;
 
 err_tx:
 	/* Restart the netif queue on each sub_if_data object. */
 	ieee802154_wake_queue(&local->hw);
-	rtnl_unlock();
 	kfree_skb(skb);
 	netdev_dbg(dev, "transmission failed\n");
 }
-- 
2.6.1

