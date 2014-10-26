Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48216 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaJZIha (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:30 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so4320637lbg.4
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:29 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 05/15] mac802154: add netdev qeue helpers
Date: Sun, 26 Oct 2014 09:37:05 +0100
Message-Id: <1414312635-19396-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new file net/mac802154/util.c which contains utility
functions for drivers, etc. This file contains functions to start and
stop queues for all virtual interfaces, this is useful for asynchronous
handling by driver level.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h |  4 ++++
 net/mac802154/Makefile  |  2 +-
 net/mac802154/util.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 net/mac802154/util.c

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index ba8ddff..29af5c3 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -190,4 +190,8 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw);
 void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
 			   u8 lqi);
 
+void ieee802154_wake_queue(struct ieee802154_hw *hw);
+void ieee802154_stop_queue(struct ieee802154_hw *hw);
+void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb);
+
 #endif /* NET_MAC802154_H */
diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 203f42d..e68deba 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   monitor.o iface.o llsec.o
+			   monitor.o iface.o llsec.o util.o
 
 ccflags-y += -D__CHECK_ENDIAN__
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
2.1.2

