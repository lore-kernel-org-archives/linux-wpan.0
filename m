Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34405 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbbHKToi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Aug 2015 15:44:38 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/4] 6lowpan: move module_init into core functionality
Date: Tue, 11 Aug 2015 21:44:09 +0200
Message-Id: <1439322250-32039-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
References: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch moves module_init of 6lowpan module into core functionality
of 6lowpan module. To load the ipv6 module at probing of the 6lowpan
module should be core functionality. Loading next header compression
modules is iphc specific. Nevertheless we only support IPHC for the
generic 6LoWPAN branch right now so we can put it into the core
functionality. If possible new compression formats are introduced nhc
should load only when iphc is build.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/core.c | 20 ++++++++++++++++++++
 net/6lowpan/iphc.c | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index ed0eec9..ae1896f 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -11,6 +11,8 @@
  * (C) 2015 Pengutronix, Alexander Aring <aar@pengutronix.de>
  */
 
+#include <linux/module.h>
+
 #include <net/6lowpan.h>
 
 void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
@@ -18,3 +20,21 @@ void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
 	lowpan_priv(dev)->lltype = lltype;
 }
 EXPORT_SYMBOL(lowpan_netdev_setup);
+
+static int __init lowpan_module_init(void)
+{
+	request_module_nowait("ipv6");
+
+	request_module_nowait("nhc_dest");
+	request_module_nowait("nhc_fragment");
+	request_module_nowait("nhc_hop");
+	request_module_nowait("nhc_ipv6");
+	request_module_nowait("nhc_mobility");
+	request_module_nowait("nhc_routing");
+	request_module_nowait("nhc_udp");
+
+	return 0;
+}
+module_init(lowpan_module_init);
+
+MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 74e56d7..1e0071f 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -48,7 +48,6 @@
 
 #include <linux/bitops.h>
 #include <linux/if_arp.h>
-#include <linux/module.h>
 #include <linux/netdevice.h>
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
@@ -610,21 +609,3 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(lowpan_header_compress);
-
-static int __init lowpan_module_init(void)
-{
-	request_module_nowait("ipv6");
-
-	request_module_nowait("nhc_dest");
-	request_module_nowait("nhc_fragment");
-	request_module_nowait("nhc_hop");
-	request_module_nowait("nhc_ipv6");
-	request_module_nowait("nhc_mobility");
-	request_module_nowait("nhc_routing");
-	request_module_nowait("nhc_udp");
-
-	return 0;
-}
-module_init(lowpan_module_init);
-
-MODULE_LICENSE("GPL");
-- 
2.5.0

