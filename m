Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:63428 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbaKETwH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:07 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so12407787wiv.0
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/18] ieee802154: rework wpan_phy index assignment
Date: Wed,  5 Nov 2014 20:51:12 +0100
Message-Id: <1415217089-24919-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch reworks the wpan_phy index incrementation. It's now similar
like wireless wiphy index incrementation. We move the wpan_phy index
attribute inside of cfg802154_registered_device and use atomic
operations instead locking mechanism via wpan_phy_mutex.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h |  1 -
 net/ieee802154/core.c   | 30 +++++++++++-------------------
 net/ieee802154/core.h   |  3 +++
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 864bce2..29c6de5 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -61,7 +61,6 @@ struct wpan_phy {
 	s32 cca_ed_level;
 
 	struct device dev;
-	int idx;
 
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index ed5b014..d1cd0ed 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -23,9 +23,6 @@
 #include "sysfs.h"
 #include "core.h"
 
-static DEFINE_MUTEX(wpan_phy_mutex);
-static int wpan_phy_idx;
-
 static int wpan_phy_match(struct device *dev, const void *data)
 {
 	return !strcmp(dev_name(dev), (const char *)data);
@@ -72,14 +69,10 @@ int wpan_phy_for_each(int (*fn)(struct wpan_phy *phy, void *data),
 }
 EXPORT_SYMBOL(wpan_phy_for_each);
 
-static int wpan_phy_idx_valid(int idx)
-{
-	return idx >= 0;
-}
-
 struct wpan_phy *
 wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size)
 {
+	static atomic_t wpan_phy_counter = ATOMIC_INIT(0);
 	struct cfg802154_registered_device *rdev;
 	size_t alloc_size;
 
@@ -90,28 +83,27 @@ wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size)
 
 	rdev->ops = ops;
 
-	mutex_lock(&wpan_phy_mutex);
-	rdev->wpan_phy.idx = wpan_phy_idx++;
-	if (unlikely(!wpan_phy_idx_valid(rdev->wpan_phy.idx))) {
-		wpan_phy_idx--;
-		mutex_unlock(&wpan_phy_mutex);
+	rdev->wpan_phy_idx = atomic_inc_return(&wpan_phy_counter);
+
+	if (unlikely(rdev->wpan_phy_idx < 0)) {
+		/* ugh, wrapped! */
+		atomic_dec(&wpan_phy_counter);
 		kfree(rdev);
-		goto out;
+		return NULL;
 	}
-	mutex_unlock(&wpan_phy_mutex);
+
+	/* atomic_inc_return makes it start at 1, make it start at 0 */
+	rdev->wpan_phy_idx--;
 
 	mutex_init(&rdev->wpan_phy.pib_lock);
 
 	device_initialize(&rdev->wpan_phy.dev);
-	dev_set_name(&rdev->wpan_phy.dev, "wpan-phy%d", rdev->wpan_phy.idx);
+	dev_set_name(&rdev->wpan_phy.dev, "wpan-phy%d", rdev->wpan_phy_idx);
 
 	rdev->wpan_phy.dev.class = &wpan_phy_class;
 	rdev->wpan_phy.dev.platform_data = rdev;
 
 	return &rdev->wpan_phy;
-
-out:
-	return NULL;
 }
 EXPORT_SYMBOL(wpan_phy_alloc);
 
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index 1bc1725..fea60b3 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -6,6 +6,9 @@
 struct cfg802154_registered_device {
 	const struct cfg802154_ops *ops;
 
+	/* wpan_phy index, internal only */
+	int wpan_phy_idx;
+
 	/* must be last because of the way we do wpan_phy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN
 	 */
-- 
2.1.3

