Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47047 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbbIIP0o (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 11:26:44 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [RFC bluetooth-next 2/4] 6lowpan: add nhc module for GHC extension header detection
Date: Wed,  9 Sep 2015 17:26:31 +0200
Message-Id: <1441812393-32472-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
References: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, jukka.rissanen@linux.intel.com, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/6lowpan/Kconfig                |  5 +++++
 net/6lowpan/Makefile               |  3 +++
 net/6lowpan/ghc_extension_header.c | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 net/6lowpan/ghc_extension_header.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 6af7a46..f541f50 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -59,4 +59,9 @@ config 6LOWPAN_NHC_UDP
 	---help---
 	  6LoWPAN IPv6 UDP Header compression according to RFC6282.
 
+config 6LOWPAN_GHC_EXTENSION_HEADER
+	tristate "GHC Extension Header Support"
+	default y
+	---help---
+
 endif
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index c6ffc55..5320b76 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -10,3 +10,6 @@ obj-$(CONFIG_6LOWPAN_NHC_IPV6) += nhc_ipv6.o
 obj-$(CONFIG_6LOWPAN_NHC_MOBILITY) += nhc_mobility.o
 obj-$(CONFIG_6LOWPAN_NHC_ROUTING) += nhc_routing.o
 obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
+
+#rfc7400 ghcs
+obj-$(CONFIG_6LOWPAN_GHC_EXTENSION_HEADER) += ghc_extension_header.o
diff --git a/net/6lowpan/ghc_extension_header.c b/net/6lowpan/ghc_extension_header.c
new file mode 100644
index 0000000..eeeabfa
--- /dev/null
+++ b/net/6lowpan/ghc_extension_header.c
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
+#define LOWPAN_GHC_EXTENSION_HEADER_IDLEN	1
+#define LOWPAN_GHC_EXTENSION_HEADER_ID_0	0xb0
+#define LOWPAN_GHC_EXTENSION_HEADER_MASK_0	0xf8
+
+static void ext_ghid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_GHC_EXTENSION_HEADER_ID_0;
+	nhc->idmask[0] = LOWPAN_GHC_EXTENSION_HEADER_MASK_0;
+}
+
+LOWPAN_NHC(ghc_extension_header, "RFC7400 Extension Header", NEXTHDR_HOP, 0,
+	   ext_ghid_setup, LOWPAN_GHC_EXTENSION_HEADER_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(ghc_extension_header);
+MODULE_DESCRIPTION("6LoWPAN generic header RFC7400 Extension Header compression");
+MODULE_LICENSE("GPL");
-- 
2.4.3

