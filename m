Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:36830 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbKYO72 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 09:59:28 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH v2 bluetooth-next 2/7] 6lowpan: add nhc module for GHC hop-by-hopextension header detection
Date: Wed, 25 Nov 2015 15:59:12 +0100
Message-Id: <1448463557-22618-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/6lowpan/Kconfig           |  6 ++++++
 net/6lowpan/Makefile          |  3 +++
 net/6lowpan/nhc_ghc_ext_hop.c | 27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 net/6lowpan/nhc_ghc_ext_hop.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 6af7a46..1bd49eb 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -59,4 +59,10 @@ config 6LOWPAN_NHC_UDP
 	---help---
 	  6LoWPAN IPv6 UDP Header compression according to RFC6282.
 
+config 6LOWPAN_GHC_EXT_HDR_HOP
+	tristate "GHC Hop-by-Hop Options Header Support"
+	---help---
+	  6LoWPAN IPv6 Hop-by-Hop option generic header compression according
+	  to RFC7400.
+
 endif
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index c6ffc55..ba20e01 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -10,3 +10,6 @@ obj-$(CONFIG_6LOWPAN_NHC_IPV6) += nhc_ipv6.o
 obj-$(CONFIG_6LOWPAN_NHC_MOBILITY) += nhc_mobility.o
 obj-$(CONFIG_6LOWPAN_NHC_ROUTING) += nhc_routing.o
 obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
+
+#rfc7400 ghcs
+obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_HOP) += nhc_ghc_ext_hop.o
diff --git a/net/6lowpan/nhc_ghc_ext_hop.c b/net/6lowpan/nhc_ghc_ext_hop.c
new file mode 100644
index 0000000..baec86f
--- /dev/null
+++ b/net/6lowpan/nhc_ghc_ext_hop.c
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
+#define LOWPAN_GHC_EXT_HOP_IDLEN	1
+#define LOWPAN_GHC_EXT_HOP_ID_0		0xb0
+#define LOWPAN_GHC_EXT_HOP_MASK_0	0xfe
+
+static void hop_ghid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_GHC_EXT_HOP_ID_0;
+	nhc->idmask[0] = LOWPAN_GHC_EXT_HOP_MASK_0;
+}
+
+LOWPAN_NHC(ghc_ext_hop, "RFC7400 Hop-by-Hop Extension Header", NEXTHDR_HOP, 0,
+	   hop_ghid_setup, LOWPAN_GHC_EXT_HOP_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(ghc_ext_hop);
+MODULE_DESCRIPTION("6LoWPAN generic header hop-by-hop extension compression");
+MODULE_LICENSE("GPL");
-- 
2.4.3

