Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:57363 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbaHLNOl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:41 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so7988188lan.33
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:39 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:12 +0200
Message-Id: <1407849255-11500-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 08/11] mac802154: rename mac802154.h to ieee802154_i.h
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch name the mac802154.h INTERNAL header to ieee802154_i.h like
wireless stack. This avoids confusing with the not internal header
net/mac802154.h header.

This patch is part of getting wireless feeling into the ieee802154
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 167 ++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/llsec.c        |   2 +-
 net/mac802154/mac802154.h    | 169 -------------------------------------------
 net/mac802154/mac_cmd.c      |   2 +-
 net/mac802154/main.c         |   2 +-
 net/mac802154/mib.c          |   2 +-
 net/mac802154/rx.c           |   2 +-
 net/mac802154/tx.c           |   2 +-
 net/mac802154/wpan.c         |   2 +-
 9 files changed, 174 insertions(+), 176 deletions(-)
 create mode 100644 net/mac802154/ieee802154_i.h
 delete mode 100644 net/mac802154/mac802154.h

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
new file mode 100644
index 0000000..e7a1b11
--- /dev/null
+++ b/net/mac802154/ieee802154_i.h
@@ -0,0 +1,167 @@
+/*
+ * Copyright (C) 2007-2012 Siemens AG
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Written by:
+ * Pavel Smolenskiy <pavel.smolenskiy@gmail.com>
+ * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
+ * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
+ * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
+ */
+#ifndef __IEEE802154_I_H
+#define __IEEE802154_I_H
+
+#include <linux/mutex.h>
+#include <net/mac802154.h>
+#include <net/ieee802154_netdev.h>
+
+#include "llsec.h"
+
+struct ieee802154_local;
+
+/* Slave interface definition.
+ *
+ * Slaves represent typical network interfaces available from userspace.
+ * Each ieee802154 device/transceiver may have several slaves and able
+ * to be associated with several networks at the same time.
+ */
+struct ieee802154_sub_if_data {
+	struct list_head list; /* the ieee802154_priv->slaves list */
+
+	struct ieee802154_local *hw;
+	struct net_device *dev;
+
+	int type;
+	bool running;
+
+	spinlock_t mib_lock;
+
+	__le16 pan_id;
+	__le16 short_addr;
+	__le64 extended_addr;
+
+	u8 chan;
+	u8 page;
+
+	struct ieee802154_mac_params mac_params;
+
+	/* MAC BSN field */
+	u8 bsn;
+	/* MAC DSN field */
+	u8 dsn;
+
+	/* protects sec from concurrent access by netlink. access by
+	 * encrypt/decrypt/header_create safe without additional protection.
+	 */
+	struct mutex sec_mtx;
+
+	struct mac802154_llsec sec;
+};
+
+/* mac802154 device private data */
+struct ieee802154_local {
+	struct ieee802154_hw hw;
+	struct ieee802154_ops *ops;
+
+	/* ieee802154 phy */
+	struct wpan_phy *phy;
+
+	int open_count;
+
+	/* As in mac80211 slaves list is modified:
+	 * 1) under the RTNL
+	 * 2) protected by slaves_mtx;
+	 * 3) in an RCU manner
+	 *
+	 * So atomic readers can use any of this protection methods.
+	 */
+	struct list_head	slaves;
+	struct mutex		slaves_mtx;
+
+	/* This one is used for scanning and other jobs not to be interfered
+	 * with serial driver.
+	 */
+	struct workqueue_struct	*dev_workqueue;
+
+	/* SoftMAC device is registered and running. One can add subinterfaces.
+	 * This flag should be modified under slaves_mtx and RTNL, so you can
+	 * read them using any of protection methods.
+	 */
+	bool running;
+};
+
+#define	MAC802154_DEVICE_STOPPED	0x00
+#define MAC802154_DEVICE_RUN		0x01
+
+#define mac802154_to_priv(_hw)	container_of(_hw, struct ieee802154_local, hw)
+
+#define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
+
+extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
+extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
+
+int mac802154_slave_open(struct net_device *dev);
+int mac802154_slave_close(struct net_device *dev);
+
+void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb);
+void mac802154_wpan_setup(struct net_device *dev);
+
+netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
+			 u8 page, u8 chan);
+
+/* MIB callbacks */
+void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
+__le16 mac802154_dev_get_short_addr(const struct net_device *dev);
+void mac802154_dev_set_ieee_addr(struct net_device *dev);
+__le16 mac802154_dev_get_pan_id(const struct net_device *dev);
+void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val);
+void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
+u8 mac802154_dev_get_dsn(const struct net_device *dev);
+
+int mac802154_set_mac_params(struct net_device *dev,
+			     const struct ieee802154_mac_params *params);
+void mac802154_get_mac_params(struct net_device *dev,
+			      struct ieee802154_mac_params *params);
+
+int mac802154_get_params(struct net_device *dev,
+			 struct ieee802154_llsec_params *params);
+int mac802154_set_params(struct net_device *dev,
+			 const struct ieee802154_llsec_params *params,
+			 int changed);
+
+int mac802154_add_key(struct net_device *dev,
+		      const struct ieee802154_llsec_key_id *id,
+		      const struct ieee802154_llsec_key *key);
+int mac802154_del_key(struct net_device *dev,
+		      const struct ieee802154_llsec_key_id *id);
+
+int mac802154_add_dev(struct net_device *dev,
+		      const struct ieee802154_llsec_device *llsec_dev);
+int mac802154_del_dev(struct net_device *dev, __le64 dev_addr);
+
+int mac802154_add_devkey(struct net_device *dev,
+			 __le64 device_addr,
+			 const struct ieee802154_llsec_device_key *key);
+int mac802154_del_devkey(struct net_device *dev,
+			 __le64 device_addr,
+			 const struct ieee802154_llsec_device_key *key);
+
+int mac802154_add_seclevel(struct net_device *dev,
+			   const struct ieee802154_llsec_seclevel *sl);
+int mac802154_del_seclevel(struct net_device *dev,
+			   const struct ieee802154_llsec_seclevel *sl);
+
+void mac802154_lock_table(struct net_device *dev);
+void mac802154_get_table(struct net_device *dev,
+			 struct ieee802154_llsec_table **t);
+void mac802154_unlock_table(struct net_device *dev);
+
+#endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 4570581..26f8761 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -20,7 +20,7 @@
 #include <net/ieee802154.h>
 #include <crypto/algapi.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 #include "llsec.h"
 
 static void llsec_key_put(struct mac802154_llsec_key *key);
diff --git a/net/mac802154/mac802154.h b/net/mac802154/mac802154.h
deleted file mode 100644
index 9fe20cd..0000000
--- a/net/mac802154/mac802154.h
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- * Copyright (C) 2007-2012 Siemens AG
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Written by:
- * Pavel Smolenskiy <pavel.smolenskiy@gmail.com>
- * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
- * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
- * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
- */
-#ifndef MAC802154_H
-#define MAC802154_H
-
-#include <linux/mutex.h>
-#include <net/mac802154.h>
-#include <net/ieee802154_netdev.h>
-
-#include "llsec.h"
-
-/* mac802154 device private data */
-struct ieee802154_local {
-	struct ieee802154_hw hw;
-	struct ieee802154_ops *ops;
-
-	/* ieee802154 phy */
-	struct wpan_phy *phy;
-
-	int open_count;
-
-	/* As in mac80211 slaves list is modified:
-	 * 1) under the RTNL
-	 * 2) protected by slaves_mtx;
-	 * 3) in an RCU manner
-	 *
-	 * So atomic readers can use any of this protection methods.
-	 */
-	struct list_head	slaves;
-	struct mutex		slaves_mtx;
-
-	/* This one is used for scanning and other jobs not to be interfered
-	 * with serial driver.
-	 */
-	struct workqueue_struct	*dev_workqueue;
-
-	/* SoftMAC device is registered and running. One can add subinterfaces.
-	 * This flag should be modified under slaves_mtx and RTNL, so you can
-	 * read them using any of protection methods.
-	 */
-	bool running;
-};
-
-#define	MAC802154_DEVICE_STOPPED	0x00
-#define MAC802154_DEVICE_RUN		0x01
-
-/* Slave interface definition.
- *
- * Slaves represent typical network interfaces available from userspace.
- * Each ieee802154 device/transceiver may have several slaves and able
- * to be associated with several networks at the same time.
- */
-struct ieee802154_sub_if_data {
-	struct list_head list; /* the ieee802154_priv->slaves list */
-
-	struct ieee802154_local *hw;
-	struct net_device *dev;
-
-	int type;
-	bool running;
-
-	spinlock_t mib_lock;
-
-	__le16 pan_id;
-	__le16 short_addr;
-	__le64 extended_addr;
-
-	u8 chan;
-	u8 page;
-
-	struct ieee802154_mac_params mac_params;
-
-	/* MAC BSN field */
-	u8 bsn;
-	/* MAC DSN field */
-	u8 dsn;
-
-	/* protects sec from concurrent access by netlink. access by
-	 * encrypt/decrypt/header_create safe without additional protection.
-	 */
-	struct mutex sec_mtx;
-
-	struct mac802154_llsec sec;
-};
-
-#define mac802154_to_priv(_hw)	container_of(_hw, struct ieee802154_local, hw)
-
-#define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
-
-extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
-extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
-
-int mac802154_slave_open(struct net_device *dev);
-int mac802154_slave_close(struct net_device *dev);
-
-void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb);
-void mac802154_wpan_setup(struct net_device *dev);
-
-netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
-			 u8 page, u8 chan);
-
-/* MIB callbacks */
-void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
-__le16 mac802154_dev_get_short_addr(const struct net_device *dev);
-void mac802154_dev_set_ieee_addr(struct net_device *dev);
-__le16 mac802154_dev_get_pan_id(const struct net_device *dev);
-void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val);
-void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
-u8 mac802154_dev_get_dsn(const struct net_device *dev);
-
-int mac802154_set_mac_params(struct net_device *dev,
-			     const struct ieee802154_mac_params *params);
-void mac802154_get_mac_params(struct net_device *dev,
-			      struct ieee802154_mac_params *params);
-
-int mac802154_get_params(struct net_device *dev,
-			 struct ieee802154_llsec_params *params);
-int mac802154_set_params(struct net_device *dev,
-			 const struct ieee802154_llsec_params *params,
-			 int changed);
-
-int mac802154_add_key(struct net_device *dev,
-		      const struct ieee802154_llsec_key_id *id,
-		      const struct ieee802154_llsec_key *key);
-int mac802154_del_key(struct net_device *dev,
-		      const struct ieee802154_llsec_key_id *id);
-
-int mac802154_add_dev(struct net_device *dev,
-		      const struct ieee802154_llsec_device *llsec_dev);
-int mac802154_del_dev(struct net_device *dev, __le64 dev_addr);
-
-int mac802154_add_devkey(struct net_device *dev,
-			 __le64 device_addr,
-			 const struct ieee802154_llsec_device_key *key);
-int mac802154_del_devkey(struct net_device *dev,
-			 __le64 device_addr,
-			 const struct ieee802154_llsec_device_key *key);
-
-int mac802154_add_seclevel(struct net_device *dev,
-			   const struct ieee802154_llsec_seclevel *sl);
-int mac802154_del_seclevel(struct net_device *dev,
-			   const struct ieee802154_llsec_seclevel *sl);
-
-void mac802154_lock_table(struct net_device *dev);
-void mac802154_get_table(struct net_device *dev,
-			 struct ieee802154_llsec_table **t);
-void mac802154_unlock_table(struct net_device *dev);
-
-#endif /* MAC802154_H */
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 08a6161..9dfa8ff 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -31,7 +31,7 @@
 #include <net/mac802154.h>
 #include <net/nl802154.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 static int mac802154_mlme_start_req(struct net_device *dev,
 				    struct ieee802154_addr *addr,
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index eb17dbc..9d90892 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -27,7 +27,7 @@
 #include <net/route.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 int mac802154_slave_open(struct net_device *dev)
 {
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 40c9952..c8fee8d 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -27,7 +27,7 @@
 #include <net/ieee802154_netdev.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 struct phy_chan_notify_work {
 	struct work_struct work;
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 5389fb7..730e56d 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -30,7 +30,7 @@
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 /* The IEEE 802.15.4 standard defines 4 MAC packet types:
  * - beacon frame
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 192b0dd..23735dd 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -29,7 +29,7 @@
 #include <net/mac802154.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index 663f89d..d2fc40b 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -33,7 +33,7 @@
 #include <net/ieee802154.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
-- 
2.0.3

