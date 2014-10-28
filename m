Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41827 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaJ1RV4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:21:56 -0400
Received: by mail-lb0-f175.google.com with SMTP id b6so1009083lbj.20
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:21:55 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/17] mac802154: monitor: merge into iface implementation
Date: Tue, 28 Oct 2014 18:21:16 +0100
Message-Id: <1414516892-4107-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the monitor implementation file and put all monitor
stuff into iface file. It's now small enough to put all necessary
handling into iface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/Makefile  |  2 +-
 net/mac802154/iface.c   | 30 +++++++++++++++++++++++++
 net/mac802154/monitor.c | 59 -------------------------------------------------
 3 files changed, 31 insertions(+), 60 deletions(-)
 delete mode 100644 net/mac802154/monitor.c

diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index e68deba..2e497d0 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   monitor.o iface.o llsec.o util.o
+			   iface.o llsec.o util.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 7e4bffc..dafb2c3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -320,6 +320,12 @@ static const struct net_device_ops mac802154_wpan_ops = {
 	.ndo_set_mac_address	= mac802154_wpan_mac_addr,
 };
 
+static const struct net_device_ops mac802154_monitor_ops = {
+	.ndo_open		= mac802154_slave_open,
+	.ndo_stop		= mac802154_slave_close,
+	.ndo_start_xmit		= ieee802154_monitor_start_xmit,
+};
+
 static void mac802154_wpan_free(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
@@ -373,3 +379,27 @@ void mac802154_wpan_setup(struct net_device *dev)
 
 	mac802154_llsec_init(&sdata->sec);
 }
+
+void mac802154_monitor_setup(struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata;
+
+	dev->addr_len		= 0;
+	dev->hard_header_len	= 0;
+	dev->needed_tailroom	= 2; /* room for FCS */
+	dev->mtu		= IEEE802154_MTU;
+	dev->tx_queue_len	= 10;
+	dev->type		= ARPHRD_IEEE802154_MONITOR;
+	dev->flags		= IFF_NOARP | IFF_BROADCAST;
+	dev->watchdog_timeo	= 0;
+
+	dev->destructor		= free_netdev;
+	dev->netdev_ops		= &mac802154_monitor_ops;
+	dev->ml_priv		= &mac802154_mlme_reduced;
+
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	sdata->type = IEEE802154_DEV_MONITOR;
+
+	sdata->chan = MAC802154_CHAN_NONE; /* not initialized */
+	sdata->page = 0;
+}
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
deleted file mode 100644
index dfdedc2..0000000
--- a/net/mac802154/monitor.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright 2007, 2008, 2009 Siemens AG
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
- * Written by:
- * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
- * Sergey Lapin <slapin@ossfans.org>
- * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
- * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
- */
-
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/ieee802154.h>
-
-#include <net/mac802154.h>
-#include <net/netlink.h>
-#include <net/cfg802154.h>
-#include <linux/nl802154.h>
-
-#include "ieee802154_i.h"
-
-static const struct net_device_ops mac802154_monitor_ops = {
-	.ndo_open		= mac802154_slave_open,
-	.ndo_stop		= mac802154_slave_close,
-	.ndo_start_xmit		= ieee802154_monitor_start_xmit,
-};
-
-void mac802154_monitor_setup(struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata;
-
-	dev->addr_len		= 0;
-	dev->hard_header_len	= 0;
-	dev->needed_tailroom	= 2; /* room for FCS */
-	dev->mtu		= IEEE802154_MTU;
-	dev->tx_queue_len	= 10;
-	dev->type		= ARPHRD_IEEE802154_MONITOR;
-	dev->flags		= IFF_NOARP | IFF_BROADCAST;
-	dev->watchdog_timeo	= 0;
-
-	dev->destructor		= free_netdev;
-	dev->netdev_ops		= &mac802154_monitor_ops;
-	dev->ml_priv		= &mac802154_mlme_reduced;
-
-	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	sdata->type = IEEE802154_DEV_MONITOR;
-
-	sdata->chan = MAC802154_CHAN_NONE; /* not initialized */
-	sdata->page = 0;
-}
-- 
2.1.2

