Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35177 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaJYSfG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:35:06 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so4048563lbv.12
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:35:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 6/7] ieee802154: move ieee802154 header
Date: Sat, 25 Oct 2014 09:41:04 +0200
Message-Id: <1414222865-1692-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
References: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

This patch moves the ieee802154 header into include/linux instead
include/net. Similar like wireless which have the ieee80211 header
inside of include/linux.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c  | 2 +-
 drivers/net/ieee802154/cc2520.c     | 2 +-
 drivers/net/ieee802154/fakehard.c   | 2 +-
 drivers/net/ieee802154/mrf24j40.c   | 2 +-
 include/{net => linux}/ieee802154.h | 8 +++-----
 include/net/ieee802154_netdev.h     | 2 +-
 net/ieee802154/6lowpan_rtnl.c       | 2 +-
 net/ieee802154/dgram.c              | 2 +-
 net/ieee802154/header_ops.c         | 3 ++-
 net/ieee802154/nl-mac.c             | 2 +-
 net/mac802154/iface.c               | 2 +-
 net/mac802154/llsec.c               | 2 +-
 net/mac802154/mac_cmd.c             | 2 +-
 net/mac802154/monitor.c             | 2 +-
 14 files changed, 17 insertions(+), 18 deletions(-)
 rename include/{net => linux}/ieee802154.h (98%)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 795ac11..a433d20 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -29,8 +29,8 @@
 #include <linux/regmap.h>
 #include <linux/skbuff.h>
 #include <linux/of_gpio.h>
+#include <linux/ieee802154.h>
 
-#include <net/ieee802154.h>
 #include <net/mac802154.h>
 #include <net/cfg802154.h>
 
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index f1770cf..32b3c88 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -21,10 +21,10 @@
 #include <linux/skbuff.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/of_gpio.h>
+#include <linux/ieee802154.h>
 
 #include <net/mac802154.h>
 #include <net/cfg802154.h>
-#include <net/ieee802154.h>
 
 #define	SPI_COMMAND_BUFFER	3
 #define	HIGH			1
diff --git a/drivers/net/ieee802154/fakehard.c b/drivers/net/ieee802154/fakehard.c
index 1460bf5..8be05ad 100644
--- a/drivers/net/ieee802154/fakehard.c
+++ b/drivers/net/ieee802154/fakehard.c
@@ -25,10 +25,10 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
+#include <linux/ieee802154.h>
 
 #include <net/af_ieee802154.h>
 #include <net/ieee802154_netdev.h>
-#include <net/ieee802154.h>
 #include <net/nl802154.h>
 #include <net/cfg802154.h>
 
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index bea7349..56a6959 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -18,9 +18,9 @@
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/ieee802154.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
-#include <net/ieee802154.h>
 
 /* MRF24J40 Short Address Registers */
 #define REG_RXMCR    0x00  /* Receive MAC control */
diff --git a/include/net/ieee802154.h b/include/linux/ieee802154.h
similarity index 98%
rename from include/net/ieee802154.h
rename to include/linux/ieee802154.h
index 4db4e32..2dfab2d 100644
--- a/include/net/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -20,8 +20,8 @@
  * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
  */
 
-#ifndef NET_IEEE802154_H
-#define NET_IEEE802154_H
+#ifndef LINUX_IEEE802154_H
+#define LINUX_IEEE802154_H
 
 #define IEEE802154_MTU			127
 
@@ -186,6 +186,4 @@ enum {
 };
 
 
-#endif
-
-
+#endif /* LINUX_IEEE802154_H */
diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index f874206..5e62d75 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -23,10 +23,10 @@
 #ifndef IEEE802154_NETDEVICE_H
 #define IEEE802154_NETDEVICE_H
 
-#include <net/ieee802154.h>
 #include <net/af_ieee802154.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/ieee802154.h>
 
 struct ieee802154_sechdr {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 0c1a49b..1779a08 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -49,8 +49,8 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
+#include <linux/ieee802154.h>
 #include <net/af_ieee802154.h>
-#include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
diff --git a/net/ieee802154/dgram.c b/net/ieee802154/dgram.c
index 71e99a0..3d58bef 100644
--- a/net/ieee802154/dgram.c
+++ b/net/ieee802154/dgram.c
@@ -23,9 +23,9 @@
 #include <linux/if_arp.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/ieee802154.h>
 #include <net/sock.h>
 #include <net/af_ieee802154.h>
-#include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
 
 #include <asm/ioctls.h>
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index c09294e..a051b69 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -14,8 +14,9 @@
  * Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
  */
 
+#include <linux/ieee802154.h>
+
 #include <net/mac802154.h>
-#include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
 
 static int
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index a9c8e3e..fb6866d 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
+#include <linux/ieee802154.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
 #include <net/sock.h>
@@ -29,7 +30,6 @@
 #include <linux/export.h>
 #include <net/af_ieee802154.h>
 #include <net/nl802154.h>
-#include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/cfg802154.h>
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 5a60407..03eedc3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -20,13 +20,13 @@
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/if_arp.h>
+#include <linux/ieee802154.h>
 
 #include <net/rtnetlink.h>
 #include <linux/nl802154.h>
 #include <net/af_ieee802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
-#include <net/ieee802154.h>
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 26f8761..fa0d523 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/bug.h>
 #include <linux/completion.h>
-#include <net/ieee802154.h>
+#include <linux/ieee802154.h>
 #include <crypto/algapi.h>
 
 #include "ieee802154_i.h"
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index f118ea0..ad09d54 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -20,8 +20,8 @@
 
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
+#include <linux/ieee802154.h>
 
-#include <net/ieee802154.h>
 #include <net/ieee802154_netdev.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index ca1dedd..ca82c72 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -21,8 +21,8 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 #include <linux/crc-ccitt.h>
+#include <linux/ieee802154.h>
 
-#include <net/ieee802154.h>
 #include <net/mac802154.h>
 #include <net/netlink.h>
 #include <net/cfg802154.h>
-- 
2.1.2

