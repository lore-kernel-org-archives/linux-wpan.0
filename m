Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:47140 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaKBDTP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:15 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so8901734wgh.14
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:14 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/16] cfg802154: introduce cfg802154_registered_device
Date: Sun,  2 Nov 2014 04:18:35 +0100
Message-Id: <1414898327-20759-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce the cfg802154_registered_device struct. Like
cfg80211_registered_device in wireless this should contain similar
functionality for cfg802154. This patch should not change any behaviour.
We just adds cfg802154_registered_device as container for wpan_phy struct.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h |  8 +++++++-
 net/ieee802154/core.c   | 39 ++++++++++++++++++++++++++-------------
 net/ieee802154/core.h   | 18 ++++++++++++++++++
 net/ieee802154/sysfs.c  | 15 ++++++++++++---
 net/mac802154/main.c    |  2 +-
 5 files changed, 64 insertions(+), 18 deletions(-)
 create mode 100644 net/ieee802154/core.h

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 440b9be..12de66b 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -29,6 +29,11 @@
 #define WPAN_NUM_CHANNELS	27
 #define WPAN_NUM_PAGES		32
 
+struct wpan_phy;
+
+struct cfg802154_ops {
+};
+
 struct wpan_phy {
 	struct mutex pib_lock;
 
@@ -62,7 +67,8 @@ struct wpan_phy {
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
 
-struct wpan_phy *wpan_phy_alloc(size_t priv_size);
+struct wpan_phy *
+wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size);
 static inline void wpan_phy_set_dev(struct wpan_phy *phy, struct device *dev)
 {
 	phy->dev.parent = dev;
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index dc294a4..ed5b014 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -21,6 +21,7 @@
 
 #include "ieee802154.h"
 #include "sysfs.h"
+#include "core.h"
 
 static DEFINE_MUTEX(wpan_phy_mutex);
 static int wpan_phy_idx;
@@ -76,31 +77,38 @@ static int wpan_phy_idx_valid(int idx)
 	return idx >= 0;
 }
 
-struct wpan_phy *wpan_phy_alloc(size_t priv_size)
+struct wpan_phy *
+wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size)
 {
-	struct wpan_phy *phy = kzalloc(sizeof(*phy) + priv_size,
-			GFP_KERNEL);
+	struct cfg802154_registered_device *rdev;
+	size_t alloc_size;
+
+	alloc_size = sizeof(*rdev) + priv_size;
+	rdev = kzalloc(alloc_size, GFP_KERNEL);
+	if (!rdev)
+		return NULL;
+
+	rdev->ops = ops;
 
-	if (!phy)
-		goto out;
 	mutex_lock(&wpan_phy_mutex);
-	phy->idx = wpan_phy_idx++;
-	if (unlikely(!wpan_phy_idx_valid(phy->idx))) {
+	rdev->wpan_phy.idx = wpan_phy_idx++;
+	if (unlikely(!wpan_phy_idx_valid(rdev->wpan_phy.idx))) {
 		wpan_phy_idx--;
 		mutex_unlock(&wpan_phy_mutex);
-		kfree(phy);
+		kfree(rdev);
 		goto out;
 	}
 	mutex_unlock(&wpan_phy_mutex);
 
-	mutex_init(&phy->pib_lock);
+	mutex_init(&rdev->wpan_phy.pib_lock);
 
-	device_initialize(&phy->dev);
-	dev_set_name(&phy->dev, "wpan-phy%d", phy->idx);
+	device_initialize(&rdev->wpan_phy.dev);
+	dev_set_name(&rdev->wpan_phy.dev, "wpan-phy%d", rdev->wpan_phy.idx);
 
-	phy->dev.class = &wpan_phy_class;
+	rdev->wpan_phy.dev.class = &wpan_phy_class;
+	rdev->wpan_phy.dev.platform_data = rdev;
 
-	return phy;
+	return &rdev->wpan_phy;
 
 out:
 	return NULL;
@@ -125,6 +133,11 @@ void wpan_phy_free(struct wpan_phy *phy)
 }
 EXPORT_SYMBOL(wpan_phy_free);
 
+void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
+{
+	kfree(rdev);
+}
+
 static int __init wpan_phy_class_init(void)
 {
 	int rc;
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
new file mode 100644
index 0000000..26752ca
--- /dev/null
+++ b/net/ieee802154/core.h
@@ -0,0 +1,18 @@
+#ifndef __IEEE802154_CORE_H
+#define __IEEE802154_CORE_H
+
+#include <net/cfg802154.h>
+
+struct cfg802154_registered_device {
+	const struct cfg802154_ops *ops;
+
+	/* must be last because of the way we do wpan_phy_priv(),
+	 * and it should at least be aligned to NETDEV_ALIGN
+	 */
+	struct wpan_phy wpan_phy __aligned(NETDEV_ALIGN);
+};
+
+/* free object */
+void cfg802154_dev_free(struct cfg802154_registered_device *rdev);
+
+#endif /* __IEEE802154_CORE_H */
diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index eb9ca6f9..c6e0380 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -17,6 +17,15 @@
 
 #include <net/cfg802154.h>
 
+#include "core.h"
+
+static inline struct cfg802154_registered_device *
+dev_to_rdev(struct device *dev)
+{
+	return container_of(dev, struct cfg802154_registered_device,
+			    wpan_phy.dev);
+}
+
 #define MASTER_SHOW_COMPLEX(name, format_string, args...)		\
 static ssize_t name ## _show(struct device *dev,			\
 			    struct device_attribute *attr, char *buf)	\
@@ -60,11 +69,11 @@ static ssize_t channels_supported_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(channels_supported);
 
-static void wpan_phy_release(struct device *d)
+static void wpan_phy_release(struct device *dev)
 {
-	struct wpan_phy *phy = container_of(d, struct wpan_phy, dev);
+	struct cfg802154_registered_device *rdev = dev_to_rdev(dev);
 
-	kfree(phy);
+	cfg802154_dev_free(rdev);
 }
 
 static struct attribute *pmib_attrs[] = {
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 86e533e..ebc2bb1 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -169,7 +169,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 
 	priv_size = ALIGN(sizeof(*local), NETDEV_ALIGN) + priv_data_len;
 
-	phy = wpan_phy_alloc(priv_size);
+	phy = wpan_phy_alloc(NULL, priv_size);
 	if (!phy) {
 		pr_err("failure to allocate master IEEE802.15.4 device\n");
 		return NULL;
-- 
2.1.3

