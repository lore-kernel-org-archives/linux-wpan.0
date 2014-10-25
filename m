Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:32869 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaJYSjf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:39:35 -0400
Received: by mail-la0-f47.google.com with SMTP id pv20so4155800lab.34
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:39:33 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/7] mac802154: move mac802154.h to ieee802154_i.h
Date: Sat, 25 Oct 2014 09:25:00 +0200
Message-Id: <1414221905-19422-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414221905-19422-1-git-send-email-alex.aring@gmail.com>
References: <1414221905-19422-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the mac802154.h internal header to ieee802154_i.h like
the wireless stack ieee80211_i.h file. This avoids confusing with the
not internal header include/net/mac802154.h header. Additional we get
the same naming conversion like mac80211 for this file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/{mac802154.h => ieee802154_i.h} | 6 +++---
 net/mac802154/llsec.c                         | 2 +-
 net/mac802154/mac_cmd.c                       | 2 +-
 net/mac802154/main.c                          | 2 +-
 net/mac802154/mib.c                           | 2 +-
 net/mac802154/monitor.c                       | 2 +-
 net/mac802154/rx.c                            | 2 +-
 net/mac802154/tx.c                            | 2 +-
 net/mac802154/wpan.c                          | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)
 rename net/mac802154/{mac802154.h => ieee802154_i.h} (98%)

diff --git a/net/mac802154/mac802154.h b/net/mac802154/ieee802154_i.h
similarity index 98%
rename from net/mac802154/mac802154.h
rename to net/mac802154/ieee802154_i.h
index e3503c1..970b621 100644
--- a/net/mac802154/mac802154.h
+++ b/net/mac802154/ieee802154_i.h
@@ -16,8 +16,8 @@
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
  */
-#ifndef MAC802154_H
-#define MAC802154_H
+#ifndef __IEEE802154_I_H
+#define __IEEE802154_I_H
 
 #include <linux/mutex.h>
 #include <net/mac802154.h>
@@ -165,4 +165,4 @@ void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t);
 void mac802154_unlock_table(struct net_device *dev);
 
-#endif /* MAC802154_H */
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
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 85f70ed..7c4b05b 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -27,7 +27,7 @@
 #include <net/mac802154.h>
 #include <net/nl802154.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 static int mac802154_mlme_start_req(struct net_device *dev,
 				    struct ieee802154_addr *addr,
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 086d4a9..d11e42a 100644
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
index 3ee6042..91cd3b2 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -23,7 +23,7 @@
 #include <net/ieee802154_netdev.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 struct phy_chan_notify_work {
 	struct work_struct work;
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index 81249bb..2647a9e 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -28,7 +28,7 @@
 #include <net/wpan-phy.h>
 #include <linux/nl802154.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 					  struct net_device *dev)
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index e99d939..bc6cffd5 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -26,7 +26,7 @@
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 /* The IEEE 802.15.4 standard defines 4 MAC packet types:
  * - beacon frame
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 95ea412..ef11cc6 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -25,7 +25,7 @@
 #include <net/mac802154.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index b11a98d..5adcbd8 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -29,7 +29,7 @@
 #include <net/ieee802154.h>
 #include <net/wpan-phy.h>
 
-#include "mac802154.h"
+#include "ieee802154_i.h"
 
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
-- 
2.1.2

