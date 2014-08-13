Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:53728 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaHMNrF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:05 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so8994707lab.40
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:47:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:33 +0200
Message-Id: <1407937595-16415-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 10/12] mac802154: rework open count
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Some cleanup to avoid pre- and post-calculation with the open_count
variable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ab23246..c1e5096 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -40,17 +40,17 @@ static int mac802154_slave_open(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = true;
-	mutex_unlock(&sdata->local->iflist_mtx);
-
-	if (local->open_count++ == 0) {
+	if (!local->open_count) {
 		res = drv_start(local);
 		WARN_ON(res);
 		if (res)
 			goto err;
 	}
 
+	mutex_lock(&sdata->local->iflist_mtx);
+	sdata->running = true;
+	mutex_unlock(&sdata->local->iflist_mtx);
+
 	if (local->ops->ieee_addr) {
 		__le64 addr = ieee802154_devaddr_from_raw(dev->dev_addr);
 
@@ -61,11 +61,12 @@ static int mac802154_slave_open(struct net_device *dev)
 		mac802154_dev_set_ieee_addr(dev);
 	}
 
+	local->open_count++;
+
 	netif_start_queue(dev);
+
 	return 0;
 err:
-	sdata->local->open_count--;
-
 	return res;
 }
 
@@ -78,11 +79,13 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
+	local->open_count--;
+
 	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->running = false;
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-	if (!--local->open_count)
+	if (!local->open_count)
 		drv_stop(local);
 
 	return 0;
-- 
2.0.3

