Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54957 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaKIHh2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:28 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so6616056wgg.3
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:27 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/15] ieee802154: add cfg802154_registered_device list
Date: Sun,  9 Nov 2014 08:36:48 +0100
Message-Id: <1415518619-4370-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new cfg802154_rdev_list to remember all registered
cfg802154_registered_device structs. This is needed to prepare the
upcomming nl802154 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 net/ieee802154/core.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index a3aa23f..11a1d2e 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -18,11 +18,16 @@
 #include <linux/device.h>
 
 #include <net/cfg802154.h>
+#include <net/rtnetlink.h>
 
 #include "ieee802154.h"
 #include "sysfs.h"
 #include "core.h"
 
+/* RCU-protected (and RTNL for writers) */
+static LIST_HEAD(cfg802154_rdev_list);
+static int cfg802154_rdev_list_generation;
+
 static int wpan_phy_match(struct device *dev, const void *data)
 {
 	return !strcmp(dev_name(dev), (const char *)data);
@@ -109,13 +114,51 @@ EXPORT_SYMBOL(wpan_phy_new);
 
 int wpan_phy_register(struct wpan_phy *phy)
 {
-	return device_add(&phy->dev);
+	struct cfg802154_registered_device *rdev = wpan_phy_to_rdev(phy);
+	int ret;
+
+	rtnl_lock();
+	ret = device_add(&phy->dev);
+	if (ret) {
+		rtnl_unlock();
+		return ret;
+	}
+
+	list_add_rcu(&rdev->list, &cfg802154_rdev_list);
+	cfg802154_rdev_list_generation++;
+
+	/* TODO phy registered lock */
+	rtnl_unlock();
+
+	/* TODO nl802154 phy notify */
+
+	return 0;
 }
 EXPORT_SYMBOL(wpan_phy_register);
 
 void wpan_phy_unregister(struct wpan_phy *phy)
 {
+	struct cfg802154_registered_device *rdev = wpan_phy_to_rdev(phy);
+
+	/* TODO open count */
+
+	rtnl_lock();
+	/* TODO nl802154 phy notify */
+	/* TODO phy registered lock */
+
+	/* TODO WARN_ON wpan_dev_list */
+
+	/* First remove the hardware from everywhere, this makes
+	 * it impossible to find from userspace.
+	 */
+	list_del_rcu(&rdev->list);
+	synchronize_rcu();
+
+	cfg802154_rdev_list_generation++;
+
 	device_del(&phy->dev);
+
+	rtnl_unlock();
 }
 EXPORT_SYMBOL(wpan_phy_unregister);
 
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index fea60b3..38887cb2 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -5,6 +5,7 @@
 
 struct cfg802154_registered_device {
 	const struct cfg802154_ops *ops;
+	struct list_head list;
 
 	/* wpan_phy index, internal only */
 	int wpan_phy_idx;
-- 
2.1.3

