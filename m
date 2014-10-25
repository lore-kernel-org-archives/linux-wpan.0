Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:44214 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaJYSjH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:39:07 -0400
Received: by mail-la0-f44.google.com with SMTP id hs14so4082507lab.31
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:39:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/7] ieee802154: move wpan-phy.h to cfg802154.h
Date: Sat, 25 Oct 2014 09:25:02 +0200
Message-Id: <1414221905-19422-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414221905-19422-1-git-send-email-alex.aring@gmail.com>
References: <1414221905-19422-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

The wpan-phy header contains the wpan_phy struct information. Later this
header will be have similar function like cfg80211 header. The cfg80211
header contains the wiphy struct which is identically the wpan_phy
struct inside 802.15.4 subsystem.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c      | 2 +-
 drivers/net/ieee802154/cc2520.c         | 2 +-
 drivers/net/ieee802154/fakehard.c       | 2 +-
 drivers/net/ieee802154/fakelb.c         | 2 +-
 drivers/net/ieee802154/mrf24j40.c       | 2 +-
 include/net/{wpan-phy.h => cfg802154.h} | 7 ++++---
 net/ieee802154/nl-mac.c                 | 2 +-
 net/ieee802154/nl-phy.c                 | 2 +-
 net/ieee802154/wpan-class.c             | 2 +-
 net/mac802154/iface.c                   | 2 +-
 net/mac802154/mac_cmd.c                 | 2 +-
 net/mac802154/main.c                    | 2 +-
 net/mac802154/mib.c                     | 2 +-
 net/mac802154/monitor.c                 | 2 +-
 net/mac802154/tx.c                      | 2 +-
 15 files changed, 18 insertions(+), 17 deletions(-)
 rename include/net/{wpan-phy.h => cfg802154.h} (97%)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 83a635f..795ac11 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -32,7 +32,7 @@
 
 #include <net/ieee802154.h>
 #include <net/mac802154.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 struct at86rf230_local;
 /* at86rf2xx chip depend data.
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 571f280..f1770cf 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -23,7 +23,7 @@
 #include <linux/of_gpio.h>
 
 #include <net/mac802154.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 #include <net/ieee802154.h>
 
 #define	SPI_COMMAND_BUFFER	3
diff --git a/drivers/net/ieee802154/fakehard.c b/drivers/net/ieee802154/fakehard.c
index 9ce854f..1460bf5 100644
--- a/drivers/net/ieee802154/fakehard.c
+++ b/drivers/net/ieee802154/fakehard.c
@@ -30,7 +30,7 @@
 #include <net/ieee802154_netdev.h>
 #include <net/ieee802154.h>
 #include <net/nl802154.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 struct fakehard_priv {
 	struct wpan_phy *phy;
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index e4b1b1f..e6e2993 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -25,7 +25,7 @@
 #include <linux/device.h>
 #include <linux/spinlock.h>
 #include <net/mac802154.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 static int numlbs = 1;
 
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 0006b9a..bea7349 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -18,7 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154.h>
 
diff --git a/include/net/wpan-phy.h b/include/net/cfg802154.h
similarity index 97%
rename from include/net/wpan-phy.h
rename to include/net/cfg802154.h
index 1e9795f..5c67467 100644
--- a/include/net/wpan-phy.h
+++ b/include/net/cfg802154.h
@@ -14,8 +14,8 @@
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  */
 
-#ifndef WPAN_PHY_H
-#define WPAN_PHY_H
+#ifndef __NET_CFG802154_H
+#define __NET_CFG802154_H
 
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
@@ -99,4 +99,5 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
 {
 	return dev_name(&phy->dev);
 }
-#endif
+
+#endif /* __NET_CFG802154_H */
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 78a1529..a9c8e3e 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -31,7 +31,7 @@
 #include <net/nl802154.h>
 #include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 #include "ieee802154.h"
 
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index e943e20..0afe760 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -23,7 +23,7 @@
 #include <linux/if_arp.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 #include <net/af_ieee802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/rtnetlink.h> /* for rtnl_{un,}lock */
diff --git a/net/ieee802154/wpan-class.c b/net/ieee802154/wpan-class.c
index e4c6fb3..760b7d7 100644
--- a/net/ieee802154/wpan-class.c
+++ b/net/ieee802154/wpan-class.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 #include "ieee802154.h"
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 5adcbd8..5a60407 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -27,7 +27,7 @@
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/ieee802154.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
 
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 7c4b05b..f118ea0 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -23,7 +23,7 @@
 
 #include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 #include <net/mac802154.h>
 #include <net/nl802154.h>
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index d11e42a..9798c74 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -25,7 +25,7 @@
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/route.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
 
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 91cd3b2..7c94672 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -21,7 +21,7 @@
 
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
 
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index 2647a9e..ca1dedd 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -25,7 +25,7 @@
 #include <net/ieee802154.h>
 #include <net/mac802154.h>
 #include <net/netlink.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 #include <linux/nl802154.h>
 
 #include "ieee802154_i.h"
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index ef11cc6..8f537bf 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -23,7 +23,7 @@
 
 #include <net/ieee802154_netdev.h>
 #include <net/mac802154.h>
-#include <net/wpan-phy.h>
+#include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
 
-- 
2.1.2

