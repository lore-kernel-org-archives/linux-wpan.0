Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:41759 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNrI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:08 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so8961878lab.26
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:47:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:35 +0200
Message-Id: <1407937595-16415-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 12/12] mac802154: rework sdata state change to running
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch reworks the handling for setting the state like mac80211. We
use bit's instead a bool variable. The mutex is not needed because it's
locked by rtnl lock.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  6 +++++-
 net/mac802154/iface.c        | 10 ++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index c20fbc9..5bfdec0 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -31,6 +31,10 @@ enum {
 	IEEE802154_RX_MSG        = 1,
 };
 
+enum ieee802154_sdata_state_bits {
+	SDATA_STATE_RUNNING,
+};
+
 /* Slave interface definition.
  *
  * Slaves represent typical network interfaces available from userspace.
@@ -44,7 +48,7 @@ struct ieee802154_sub_if_data {
 	struct net_device *dev;
 
 	int type;
-	bool running;
+	unsigned long state;
 
 	spinlock_t mib_lock;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 4655be5..d221562 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -47,9 +47,7 @@ static int mac802154_slave_open(struct net_device *dev)
 			goto err;
 	}
 
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = true;
-	mutex_unlock(&sdata->local->iflist_mtx);
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	local->open_count++;
 
@@ -57,6 +55,8 @@ static int mac802154_slave_open(struct net_device *dev)
 
 	return 0;
 err:
+	/* might already be clear but that doesn't matter */
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 	return res;
 }
 
@@ -71,9 +71,7 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	local->open_count--;
 
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->running = false;
-	mutex_unlock(&sdata->local->iflist_mtx);
+	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	if (!local->open_count)
 		drv_stop(local);
-- 
2.0.3

