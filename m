Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:64559 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaHMNrE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:04 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so8093907lbi.24
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:47:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:31 +0200
Message-Id: <1407937595-16415-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 08/12] mac802154: introduce internal driver-ops header
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

We should not call the driver ops callbacks directly. This patch
introduce a driver-ops header file to calling these wrappers. It's like
the mac80211 driver-ops header.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/driver-ops.h | 29 +++++++++++++++++++++++++++++
 net/mac802154/iface.c      |  5 +++--
 2 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 net/mac802154/driver-ops.h

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
new file mode 100644
index 0000000..edaf75f
--- /dev/null
+++ b/net/mac802154/driver-ops.h
@@ -0,0 +1,29 @@
+#ifndef __MAC802154_DRVIER_OPS
+#define __MAC802154_DRIVER_OPS
+
+#include <net/mac802154.h>
+
+#include "ieee802154_i.h"
+
+static inline int drv_start(struct ieee802154_local *local)
+{
+	might_sleep();
+
+	smp_mb();
+	return local->ops->start(&local->hw);
+}
+
+static inline void drv_stop(struct ieee802154_local *local)
+{
+	might_sleep();
+
+	local->ops->stop(&local->hw);
+
+	/* sync away all work on the tasklet before clearing started */
+	tasklet_disable(&local->tasklet);
+	tasklet_enable(&local->tasklet);
+
+	barrier();
+}
+
+#endif /* __MAC802154_DRVIER_OPS */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9ddbf88..ae774d3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -29,6 +29,7 @@
 #include <net/ieee802154.h>
 #include <net/wpan-phy.h>
 
+#include "driver-ops.h"
 #include "ieee802154_i.h"
 
 static int mac802154_slave_open(struct net_device *dev)
@@ -57,7 +58,7 @@ static int mac802154_slave_open(struct net_device *dev)
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (local->open_count++ == 0) {
-		res = local->ops->start(&local->hw);
+		res = drv_start(local);
 		WARN_ON(res);
 		if (res)
 			goto err;
@@ -95,7 +96,7 @@ static int mac802154_slave_close(struct net_device *dev)
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (!--local->open_count)
-		local->ops->stop(&local->hw);
+		drv_stop(local);
 
 	return 0;
 }
-- 
2.0.3

