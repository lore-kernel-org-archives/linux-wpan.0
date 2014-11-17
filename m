Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63883 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaKQHVb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:31 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so3179085wid.11
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:30 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/13] mac802154: use new nl802154 iftype types
Date: Mon, 17 Nov 2014 08:20:49 +0100
Message-Id: <1416208855-8623-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replace the depracted IEEE802154_DEV to the new introduced
NL802154_IFTYPE_NODE types. There is a backwards compatibility to have
the identical types for both enum definitions. Also remove some inlcude
issue with "linux/nl802154.h", because the export nl_policy inside this
header it was always necessary to have an include of "net/rtnetlink.h"
before. The reason for this is more complicated. Nevertheless we removed
this now, because "linux/nl802154.h" is the depracted netlink interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  3 ++-
 net/mac802154/iface.c        | 18 +++++++++---------
 net/mac802154/main.c         |  4 ++--
 net/mac802154/rx.c           |  7 +++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 593339a..6ad5e89 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -23,6 +23,7 @@
 #include <linux/hrtimer.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
+#include <net/nl802154.h>
 #include <net/ieee802154_netdev.h>
 
 #include "llsec.h"
@@ -175,7 +176,7 @@ void ieee802154_iface_exit(void);
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-		  struct wpan_dev **new_wpan_dev, int type);
+		  struct wpan_dev **new_wpan_dev, enum nl802154_iftype type);
 void ieee802154_remove_interfaces(struct ieee802154_local *local);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index feb0647..cc992e8 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -22,8 +22,7 @@
 #include <linux/if_arp.h>
 #include <linux/ieee802154.h>
 
-#include <net/rtnetlink.h>
-#include <linux/nl802154.h>
+#include <net/nl802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/cfg802154.h>
@@ -144,7 +143,7 @@ static int mac802154_slave_open(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	if (sdata->vif.type == IEEE802154_DEV_WPAN) {
+	if (sdata->vif.type == NL802154_IFTYPE_NODE) {
 		mutex_lock(&sdata->local->iflist_mtx);
 		list_for_each_entry(subif, &sdata->local->interfaces, list) {
 			if (subif != sdata &&
@@ -407,7 +406,8 @@ static void ieee802154_if_setup(struct net_device *dev)
 }
 
 static int
-ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
+ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
+		       enum nl802154_iftype type)
 {
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 
@@ -429,7 +429,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
 	switch (type) {
-	case IEEE802154_DEV_WPAN:
+	case NL802154_IFTYPE_NODE:
 		ieee802154_be64_to_le64(&wpan_dev->extended_addr,
 					sdata->dev->dev_addr);
 
@@ -444,7 +444,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 
 		mac802154_llsec_init(&sdata->sec);
 		break;
-	case IEEE802154_DEV_MONITOR:
+	case NL802154_IFTYPE_MONITOR:
 		sdata->dev->destructor = free_netdev;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
 		wpan_dev->promiscuous_mode = true;
@@ -458,7 +458,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-		  struct wpan_dev **new_wpan_dev, int type)
+		  struct wpan_dev **new_wpan_dev, enum nl802154_iftype type)
 {
 	struct net_device *ndev = NULL;
 	struct ieee802154_sub_if_data *sdata = NULL;
@@ -478,10 +478,10 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		goto err;
 
 	switch (type) {
-	case IEEE802154_DEV_WPAN:
+	case NL802154_IFTYPE_NODE:
 		ndev->type = ARPHRD_IEEE802154;
 		break;
-	case IEEE802154_DEV_MONITOR:
+	case NL802154_IFTYPE_MONITOR:
 		ndev->type = ARPHRD_IEEE802154_MONITOR;
 		break;
 	default:
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 5199f21..2e42fc2 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -19,7 +19,7 @@
 #include <linux/netdevice.h>
 
 #include <net/netlink.h>
-#include <linux/nl802154.h>
+#include <net/nl802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/route.h>
@@ -161,7 +161,7 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	dev = ieee802154_if_add(local, "wpan%d", NULL, IEEE802154_DEV_WPAN);
+	dev = ieee802154_if_add(local, "wpan%d", NULL, NL802154_IFTYPE_NODE);
 	if (IS_ERR(dev)) {
 		rtnl_unlock();
 		rc = PTR_ERR(dev);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index b18e755..041dbd5 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -25,8 +25,7 @@
 
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
-#include <net/rtnetlink.h>
-#include <linux/nl802154.h>
+#include <net/nl802154.h>
 
 #include "ieee802154_i.h"
 
@@ -209,7 +208,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
 	}
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->vif.type != IEEE802154_DEV_WPAN ||
+		if (sdata->vif.type != NL802154_IFTYPE_NODE ||
 		    !netif_running(sdata->dev))
 			continue;
 
@@ -234,7 +233,7 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->vif.type != IEEE802154_DEV_MONITOR)
+		if (sdata->vif.type != NL802154_IFTYPE_MONITOR)
 			continue;
 
 		if (!ieee802154_sdata_running(sdata))
-- 
2.1.3

