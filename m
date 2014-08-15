Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43368 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbaHOKaD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:03 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so655105wiw.0
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:43 +0200
Message-Id: <1408098592-13412-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 03/12] mac802154: add netdev qeue helpers
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a new file net/mac802154/util.c which contains utility
functions for drivers, etc.

This file contains functions to start and stop queues for all virtual
interfaces, this is useful for asynchronous handling in driver level.
In future the ieee802154_xmit_complete function should be contain a
delay for interfame spacing time, for now we don't provide this
information inside the mac layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h |  4 ++++
 net/mac802154/Makefile  |  2 +-
 net/mac802154/tx.c      | 14 ++-----------
 net/mac802154/util.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 13 deletions(-)
 create mode 100644 net/mac802154/util.c

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 311e595..fd3abbf 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -196,4 +196,8 @@ void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
 
 void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
 
+void ieee802154_wake_queue(struct ieee802154_hw *hw);
+void ieee802154_stop_queue(struct ieee802154_hw *hw);
+void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb);
+
 #endif /* NET_MAC802154_H */
diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index d7030d4..2e497d0 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   iface.o llsec.o
+			   iface.o llsec.o util.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 5f165ec..d99e4f5 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -45,7 +45,6 @@ struct xmit_work {
 static void mac802154_xmit_worker(struct work_struct *work)
 {
 	struct xmit_work *xw = container_of(work, struct xmit_work, work);
-	struct ieee802154_sub_if_data *sdata;
 	int res;
 
 	mutex_lock(&xw->local->phy->pib_lock);
@@ -71,12 +70,7 @@ out:
 	mutex_unlock(&xw->local->phy->pib_lock);
 
 	/* Restart the netif queue on each sub_if_data object. */
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &xw->local->interfaces, list)
-		netif_wake_queue(sdata->dev);
-	rcu_read_unlock();
-
-	dev_kfree_skb(xw->skb);
+	ieee802154_xmit_complete(&local->hw, skb);
 
 	kfree(xw);
 }
@@ -85,7 +79,6 @@ static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 				struct sk_buff *skb, u8 page, u8 chan)
 {
 	struct xmit_work *work;
-	struct ieee802154_sub_if_data *sdata;
 
 	if (!(local->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
@@ -110,10 +103,7 @@ static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 	}
 
 	/* Stop the netif queue on each sub_if_data object. */
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		netif_stop_queue(sdata->dev);
-	rcu_read_unlock();
+	ieee802154_stop_queue(&local->hw);
 
 	INIT_WORK(&work->work, mac802154_xmit_worker);
 	work->skb = skb;
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
new file mode 100644
index 0000000..117e4ef
--- /dev/null
+++ b/net/mac802154/util.c
@@ -0,0 +1,55 @@
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
+ * Based on: net/mac80211/util.c
+ */
+
+#include "ieee802154_i.h"
+
+void ieee802154_wake_queue(struct ieee802154_hw *hw)
+{
+	struct ieee802154_local *local = hw_to_local(hw);
+	struct ieee802154_sub_if_data *sdata;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		if (!sdata->dev)
+			continue;
+
+		netif_wake_queue(sdata->dev);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(ieee802154_wake_queue);
+
+void ieee802154_stop_queue(struct ieee802154_hw *hw)
+{
+	struct ieee802154_local *local = hw_to_local(hw);
+	struct ieee802154_sub_if_data *sdata;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		if (!sdata->dev)
+			continue;
+
+		netif_stop_queue(sdata->dev);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(ieee802154_stop_queue);
+
+void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb)
+{
+	ieee802154_wake_queue(hw);
+	consume_skb(skb);
+}
+EXPORT_SYMBOL(ieee802154_xmit_complete);
-- 
2.0.3

