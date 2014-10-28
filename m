Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37336 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaJ1RWP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:15 -0400
Received: by mail-lb0-f182.google.com with SMTP id f15so1151217lbj.13
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 17/17] ieee802154: introduce sysfs file
Date: Tue, 28 Oct 2014 18:21:32 +0100
Message-Id: <1414516892-4107-18-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the sysfs handling in a own file. This is like wireless
sysfs file handling.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile |  2 +-
 net/ieee802154/core.c   | 73 +++-----------------------------------
 net/ieee802154/sysfs.c  | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/ieee802154/sysfs.h  |  9 +++++
 4 files changed, 108 insertions(+), 70 deletions(-)
 create mode 100644 net/ieee802154/sysfs.c
 create mode 100644 net/ieee802154/sysfs.h

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index e58c4cb..38354d4 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
-                header_ops.o
+                header_ops.o sysfs.o
 af_802154-y := af_ieee802154.o raw.o dgram.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 760b7d7..620abc2 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -20,72 +20,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154.h"
-
-#define MASTER_SHOW_COMPLEX(name, format_string, args...)		\
-static ssize_t name ## _show(struct device *dev,			\
-			    struct device_attribute *attr, char *buf)	\
-{									\
-	struct wpan_phy *phy = container_of(dev, struct wpan_phy, dev);	\
-	int ret;							\
-									\
-	mutex_lock(&phy->pib_lock);					\
-	ret = snprintf(buf, PAGE_SIZE, format_string "\n", args);	\
-	mutex_unlock(&phy->pib_lock);					\
-	return ret;							\
-}									\
-static DEVICE_ATTR_RO(name)
-
-#define MASTER_SHOW(field, format_string)				\
-	MASTER_SHOW_COMPLEX(field, format_string, phy->field)
-
-MASTER_SHOW(current_channel, "%d");
-MASTER_SHOW(current_page, "%d");
-MASTER_SHOW(transmit_power, "%d +- 1 dB");
-MASTER_SHOW(cca_mode, "%d");
-
-static ssize_t channels_supported_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct wpan_phy *phy = container_of(dev, struct wpan_phy, dev);
-	int ret;
-	int i, len = 0;
-
-	mutex_lock(&phy->pib_lock);
-	for (i = 0; i < 32; i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len,
-			       "%#09x\n", phy->channels_supported[i]);
-		if (ret < 0)
-			break;
-		len += ret;
-	}
-	mutex_unlock(&phy->pib_lock);
-	return len;
-}
-static DEVICE_ATTR_RO(channels_supported);
-
-static struct attribute *pmib_attrs[] = {
-	&dev_attr_current_channel.attr,
-	&dev_attr_current_page.attr,
-	&dev_attr_channels_supported.attr,
-	&dev_attr_transmit_power.attr,
-	&dev_attr_cca_mode.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(pmib);
-
-static void wpan_phy_release(struct device *d)
-{
-	struct wpan_phy *phy = container_of(d, struct wpan_phy, dev);
-
-	kfree(phy);
-}
-
-static struct class wpan_phy_class = {
-	.name = "ieee802154",
-	.dev_release = wpan_phy_release,
-	.dev_groups = pmib_groups,
-};
+#include "sysfs.h"
 
 static DEFINE_MUTEX(wpan_phy_mutex);
 static int wpan_phy_idx;
@@ -197,7 +132,7 @@ static int __init wpan_phy_class_init(void)
 {
 	int rc;
 
-	rc = class_register(&wpan_phy_class);
+	rc = wpan_phy_sysfs_init();
 	if (rc)
 		goto err;
 
@@ -207,7 +142,7 @@ static int __init wpan_phy_class_init(void)
 
 	return 0;
 err_nl:
-	class_unregister(&wpan_phy_class);
+	wpan_phy_sysfs_exit();
 err:
 	return rc;
 }
@@ -216,7 +151,7 @@ subsys_initcall(wpan_phy_class_init);
 static void __exit wpan_phy_class_exit(void)
 {
 	ieee802154_nl_exit();
-	class_unregister(&wpan_phy_class);
+	wpan_phy_sysfs_exit();
 }
 module_exit(wpan_phy_class_exit);
 
diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
new file mode 100644
index 0000000..eb9ca6f9
--- /dev/null
+++ b/net/ieee802154/sysfs.c
@@ -0,0 +1,94 @@
+/* This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors:
+ * Alexander Aring <aar@pengutronix.de>
+ *
+ * Based on: net/wireless/sysfs.c
+ */
+
+#include <linux/device.h>
+
+#include <net/cfg802154.h>
+
+#define MASTER_SHOW_COMPLEX(name, format_string, args...)		\
+static ssize_t name ## _show(struct device *dev,			\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct wpan_phy *phy = container_of(dev, struct wpan_phy, dev);	\
+	int ret;							\
+									\
+	mutex_lock(&phy->pib_lock);					\
+	ret = snprintf(buf, PAGE_SIZE, format_string "\n", args);	\
+	mutex_unlock(&phy->pib_lock);					\
+	return ret;							\
+}									\
+static DEVICE_ATTR_RO(name)
+
+#define MASTER_SHOW(field, format_string)				\
+	MASTER_SHOW_COMPLEX(field, format_string, phy->field)
+
+MASTER_SHOW(current_channel, "%d");
+MASTER_SHOW(current_page, "%d");
+MASTER_SHOW(transmit_power, "%d +- 1 dB");
+MASTER_SHOW(cca_mode, "%d");
+
+static ssize_t channels_supported_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct wpan_phy *phy = container_of(dev, struct wpan_phy, dev);
+	int ret;
+	int i, len = 0;
+
+	mutex_lock(&phy->pib_lock);
+	for (i = 0; i < 32; i++) {
+		ret = snprintf(buf + len, PAGE_SIZE - len,
+			       "%#09x\n", phy->channels_supported[i]);
+		if (ret < 0)
+			break;
+		len += ret;
+	}
+	mutex_unlock(&phy->pib_lock);
+	return len;
+}
+static DEVICE_ATTR_RO(channels_supported);
+
+static void wpan_phy_release(struct device *d)
+{
+	struct wpan_phy *phy = container_of(d, struct wpan_phy, dev);
+
+	kfree(phy);
+}
+
+static struct attribute *pmib_attrs[] = {
+	&dev_attr_current_channel.attr,
+	&dev_attr_current_page.attr,
+	&dev_attr_channels_supported.attr,
+	&dev_attr_transmit_power.attr,
+	&dev_attr_cca_mode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(pmib);
+
+struct class wpan_phy_class = {
+	.name = "ieee802154",
+	.dev_release = wpan_phy_release,
+	.dev_groups = pmib_groups,
+};
+
+int wpan_phy_sysfs_init(void)
+{
+	return class_register(&wpan_phy_class);
+}
+
+void wpan_phy_sysfs_exit(void)
+{
+	class_unregister(&wpan_phy_class);
+}
diff --git a/net/ieee802154/sysfs.h b/net/ieee802154/sysfs.h
new file mode 100644
index 0000000..aa42e39
--- /dev/null
+++ b/net/ieee802154/sysfs.h
@@ -0,0 +1,9 @@
+#ifndef __IEEE802154_SYSFS_H
+#define __IEEE802154_SYSFS_H
+
+int wpan_phy_sysfs_init(void);
+void wpan_phy_sysfs_exit(void);
+
+extern struct class wpan_phy_class;
+
+#endif /* __IEEE802154_SYSFS_H */
-- 
2.1.2

