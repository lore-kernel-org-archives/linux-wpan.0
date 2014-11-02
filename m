Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43741 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaKBDTQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:16 -0400
Received: by mail-wg0-f42.google.com with SMTP id k14so8939985wgh.15
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:15 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/16] mac802154: introduce mac802154_config_ops
Date: Sun,  2 Nov 2014 04:18:36 +0100
Message-Id: <1414898327-20759-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduces mac802154_config_ops struct. Like wireless this
struct should be the only one interface between ieee802154 to mac802154
or possible HardMAC drivers.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/Makefile |  2 +-
 net/mac802154/cfg.c    | 19 +++++++++++++++++++
 net/mac802154/cfg.h    |  9 +++++++++
 net/mac802154/main.c   |  3 ++-
 4 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 net/mac802154/cfg.c
 create mode 100644 net/mac802154/cfg.h

diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 2e497d0..702d8b4 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   iface.o llsec.o util.o
+			   iface.o llsec.o util.o cfg.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
new file mode 100644
index 0000000..105468e
--- /dev/null
+++ b/net/mac802154/cfg.c
@@ -0,0 +1,19 @@
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
+ * Based on: net/mac80211/cfg.c
+ */
+
+#include <net/cfg802154.h>
+
+const struct cfg802154_ops mac802154_config_ops = {
+};
diff --git a/net/mac802154/cfg.h b/net/mac802154/cfg.h
new file mode 100644
index 0000000..e2718f9
--- /dev/null
+++ b/net/mac802154/cfg.h
@@ -0,0 +1,9 @@
+/* mac802154 configuration hooks for cfg802154
+ */
+
+#ifndef __CFG_H
+#define __CFG_H
+
+extern const struct cfg802154_ops mac802154_config_ops;
+
+#endif /* __CFG_H */
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ebc2bb1..785abb1 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -28,6 +28,7 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
+#include "cfg.h"
 
 static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
@@ -169,7 +170,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 
 	priv_size = ALIGN(sizeof(*local), NETDEV_ALIGN) + priv_data_len;
 
-	phy = wpan_phy_alloc(NULL, priv_size);
+	phy = wpan_phy_alloc(&mac802154_config_ops, priv_size);
 	if (!phy) {
 		pr_err("failure to allocate master IEEE802.15.4 device\n");
 		return NULL;
-- 
2.1.3

