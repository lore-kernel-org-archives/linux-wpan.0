Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36959 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbKKRPA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Nov 2015 12:15:00 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 1/4] 6lowpan: add debugfs support
Date: Wed, 11 Nov 2015 18:14:36 +0100
Message-Id: <1447262079-2509-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1447262079-2509-1-git-send-email-alex.aring@gmail.com>
References: <1447262079-2509-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, Alexander Aring <alex.aring@gmail.com>

This patch will introduce a 6lowpan entry into the debugfs if enabled.
Inside this 6lowpan directory we create a subdirectories of all 6lowpan
interfaces to offer a per interface debugfs support.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h         |  2 +-
 net/6lowpan/6lowpan_i.h       | 25 +++++++++++++++++++++
 net/6lowpan/Kconfig           |  7 ++++++
 net/6lowpan/Makefile          |  1 +
 net/6lowpan/core.c            | 19 +++++++++++++++-
 net/6lowpan/debugfs.c         | 51 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.c       | 17 +++++++++------
 net/ieee802154/6lowpan/core.c | 14 +++++++-----
 8 files changed, 122 insertions(+), 14 deletions(-)
 create mode 100644 net/6lowpan/6lowpan_i.h
 create mode 100644 net/6lowpan/debugfs.c

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index cf3bc56..edce9a1 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -185,7 +185,7 @@ static inline void lowpan_push_hc_data(u8 **hc_ptr, const void *data,
 	*hc_ptr += len;
 }
 
-void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype);
+int lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype);
 
 /**
  * lowpan_header_decompress - replace 6LoWPAN header with IPv6 header
diff --git a/net/6lowpan/6lowpan_i.h b/net/6lowpan/6lowpan_i.h
new file mode 100644
index 0000000..102c2a4
--- /dev/null
+++ b/net/6lowpan/6lowpan_i.h
@@ -0,0 +1,25 @@
+#ifndef __6LOWPAN_I_H
+#define __6LOWPAN_I_H
+
+#include <linux/netdevice.h>
+
+#ifdef CONFIG_6LOWPAN_DEBUGFS
+int lowpan_dev_debugfs_init(struct net_device *dev);
+
+int __init lowpan_debugfs_init(void);
+void lowpan_debugfs_exit(void);
+#else
+static inline int lowpan_dev_debugfs_init(struct net_device *dev)
+{
+	return 0;
+}
+
+static inline int __init lowpan_debugfs_init(void)
+{
+	return 0;
+}
+
+static inline void lowpan_debugfs_exit(void) { }
+#endif /* CONFIG_6LOWPAN_DEBUGFS */
+
+#endif /* __6LOWPAN_I_H */
diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 7fa0f38..01c901c 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -5,6 +5,13 @@ menuconfig 6LOWPAN
 	  This enables IPv6 over Low power Wireless Personal Area Network -
 	  "6LoWPAN" which is supported by IEEE 802.15.4 or Bluetooth stacks.
 
+config 6LOWPAN_DEBUGFS
+	bool "6LoWPAN debugfs support"
+	depends on 6LOWPAN
+	---help---
+	  This enables 6LoWPAN debugfs support. For example to manipulate
+	  IPHC context information at runtime.
+
 menuconfig 6LOWPAN_NHC
 	tristate "Next Header Compression Support"
 	depends on 6LOWPAN
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index c6ffc55..54cad8d 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_6LOWPAN) += 6lowpan.o
 
 6lowpan-y := core.o iphc.o nhc.o
+6lowpan-$(CONFIG_6LOWPAN_DEBUGFS) += debugfs.o
 
 #rfc6282 nhcs
 obj-$(CONFIG_6LOWPAN_NHC_DEST) += nhc_dest.o
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 83b19e0..7f46c7e 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -15,7 +15,9 @@
 
 #include <net/6lowpan.h>
 
-void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
+#include "6lowpan_i.h"
+
+int lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
 {
 	dev->addr_len = EUI64_ADDR_LEN;
 	dev->type = ARPHRD_6LOWPAN;
@@ -23,11 +25,19 @@ void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
 	dev->priv_flags |= IFF_NO_QUEUE;
 
 	lowpan_priv(dev)->lltype = lltype;
+
+	return lowpan_dev_debugfs_init(dev);
 }
 EXPORT_SYMBOL(lowpan_netdev_setup);
 
 static int __init lowpan_module_init(void)
 {
+	int ret;
+
+	ret = lowpan_debugfs_init();
+	if (ret < 0)
+		return ret;
+
 	request_module_nowait("ipv6");
 
 	request_module_nowait("nhc_dest");
@@ -40,6 +50,13 @@ static int __init lowpan_module_init(void)
 
 	return 0;
 }
+
+static void __exit lowpan_module_exit(void)
+{
+	lowpan_debugfs_exit();
+}
+
 module_init(lowpan_module_init);
+module_exit(lowpan_module_exit);
 
 MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
new file mode 100644
index 0000000..e70eee4
--- /dev/null
+++ b/net/6lowpan/debugfs.c
@@ -0,0 +1,51 @@
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
+ * (C) 2015 Pengutronix, Alexander Aring <aar@pengutronix.de>
+ * Copyright (c)  2015 Nordic Semiconductor. All Rights Reserved.
+ */
+
+#include <linux/debugfs.h>
+
+#include <net/6lowpan.h>
+
+#include "6lowpan_i.h"
+
+static struct dentry *lowpan_debugfs;
+
+int lowpan_dev_debugfs_init(struct net_device *dev)
+{
+	static struct dentry *iface;
+
+	/* creating the root */
+	iface = debugfs_create_dir(dev->name, lowpan_debugfs);
+	if (!iface)
+		goto fail;
+
+	return 0;
+
+fail:
+	lowpan_debugfs_exit();
+	return -EINVAL;
+}
+
+int __init lowpan_debugfs_init(void)
+{
+	lowpan_debugfs = debugfs_create_dir("6lowpan", NULL);
+	if (!lowpan_debugfs)
+		return -EINVAL;
+
+	return 0;
+}
+
+void lowpan_debugfs_exit(void)
+{
+	debugfs_remove_recursive(lowpan_debugfs);
+}
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9e9cca3..57aa5ff 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -825,16 +825,14 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
 	spin_unlock(&devices_lock);
 
-	lowpan_netdev_setup(netdev, LOWPAN_LLTYPE_BTLE);
+	err = lowpan_netdev_setup(netdev, LOWPAN_LLTYPE_BTLE);
+	if (err < 0)
+		goto free_netdev;
 
 	err = register_netdev(netdev);
 	if (err < 0) {
 		BT_INFO("register_netdev failed %d", err);
-		spin_lock(&devices_lock);
-		list_del_rcu(&(*dev)->list);
-		spin_unlock(&devices_lock);
-		free_netdev(netdev);
-		goto out;
+		goto free_netdev;
 	}
 
 	BT_DBG("ifindex %d peer bdaddr %pMR type %d my addr %pMR type %d",
@@ -844,7 +842,12 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 
 	return 0;
 
-out:
+free_netdev:
+	spin_lock(&devices_lock);
+	list_del_rcu(&(*dev)->list);
+	spin_unlock(&devices_lock);
+	free_netdev(netdev);
+
 	return err;
 }
 
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 20c49c7..67ed7dc 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -161,16 +161,20 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 				wdev->needed_headroom;
 	ldev->needed_tailroom = wdev->needed_tailroom;
 
-	lowpan_netdev_setup(ldev, LOWPAN_LLTYPE_IEEE802154);
+	ret = lowpan_netdev_setup(ldev, LOWPAN_LLTYPE_IEEE802154);
+	if (ret < 0)
+		goto dev_put;
 
 	ret = register_netdevice(ldev);
-	if (ret < 0) {
-		dev_put(wdev);
-		return ret;
-	}
+	if (ret < 0)
+		goto dev_put;
 
 	wdev->ieee802154_ptr->lowpan_dev = ldev;
 	return 0;
+
+dev_put:
+	dev_put(wdev);
+	return ret;
 }
 
 static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
-- 
2.6.1

