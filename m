Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34954 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbbLIVrd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Dec 2015 16:47:33 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/10] 6lowpan: add nhc module for GHC routing extension header detection
Date: Wed,  9 Dec 2015 22:46:28 +0100
Message-Id: <1449697591-15991-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1449697591-15991-1-git-send-email-alex.aring@gmail.com>
References: <1449697591-15991-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>

From: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/Kconfig             |  6 ++++++
 net/6lowpan/Makefile            |  1 +
 net/6lowpan/nhc_ghc_ext_route.c | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 net/6lowpan/nhc_ghc_ext_route.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 13abcc5..bcb9d8a 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -87,4 +87,10 @@ config 6LOWPAN_GHC_EXT_HDR_FRAG
 	  6LoWPAN IPv6 fragmentation option generic header compression
 	  according to RFC7400.
 
+config 6LOWPAN_GHC_EXT_HDR_ROUTE
+	tristate "GHC Routing Options Header Support"
+	---help---
+	  6LoWPAN IPv6 routing option generic header compression according
+	  to RFC7400.
+
 endif
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index fb3f48d..9e35a5d 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_6LOWPAN_GHC_UDP) += nhc_ghc_udp.o
 obj-$(CONFIG_6LOWPAN_GHC_ICMPV6) += nhc_ghc_icmpv6.o
 obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_DEST) += nhc_ghc_ext_dest.o
 obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG) += nhc_ghc_ext_frag.o
+obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE) += nhc_ghc_ext_route.o
diff --git a/net/6lowpan/nhc_ghc_ext_route.c b/net/6lowpan/nhc_ghc_ext_route.c
new file mode 100644
index 0000000..d7e5bd7
--- /dev/null
+++ b/net/6lowpan/nhc_ghc_ext_route.c
@@ -0,0 +1,27 @@
+/*
+ *	6LoWPAN Extension Header compression according to RFC7400
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_GHC_EXT_ROUTE_IDLEN	1
+#define LOWPAN_GHC_EXT_ROUTE_ID_0	0xb2
+#define LOWPAN_GHC_EXT_ROUTE_MASK_0	0xfe
+
+static void route_ghid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_GHC_EXT_ROUTE_ID_0;
+	nhc->idmask[0] = LOWPAN_GHC_EXT_ROUTE_MASK_0;
+}
+
+LOWPAN_NHC(ghc_ext_route, "RFC7400 Routing Extension Header", NEXTHDR_ROUTING,
+	   0, route_ghid_setup, LOWPAN_GHC_EXT_ROUTE_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(ghc_ext_route);
+MODULE_DESCRIPTION("6LoWPAN generic header routing extension compression");
+MODULE_LICENSE("GPL");
-- 
2.6.1

