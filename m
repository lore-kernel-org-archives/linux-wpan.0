Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:36825 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbbKYO7d (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 09:59:33 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH v2 bluetooth-next 7/7] 6lowpan: add nhc module for GHC routing extension header detection
Date: Wed, 25 Nov 2015 15:59:17 +0100
Message-Id: <1448463557-22618-8-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
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
2.4.3

