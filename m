Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47053 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbbIIP0q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 11:26:46 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [RFC bluetooth-next 4/4] 6lowpan: add nhc module for GHC ICMPv6 detection
Date: Wed,  9 Sep 2015 17:26:33 +0200
Message-Id: <1441812393-32472-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
References: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, jukka.rissanen@linux.intel.com, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/6lowpan/Kconfig      |  5 +++++
 net/6lowpan/Makefile     |  1 +
 net/6lowpan/ghc_icmpv6.c | 27 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 net/6lowpan/ghc_icmpv6.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 67a786b..a34693d 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -69,4 +69,9 @@ config 6LOWPAN_GHC_UDP
 	default y
 	---help---
 
+config 6LOWPAN_GHC_ICMPV6
+	tristate "GHC ICMPv6 Support"
+	default y
+	---help---
+
 endif
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index 4df6334..c1a496b 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
 #rfc7400 ghcs
 obj-$(CONFIG_6LOWPAN_GHC_EXTENSION_HEADER) += ghc_extension_header.o
 obj-$(CONFIG_6LOWPAN_GHC_UDP) += ghc_udp.o
+obj-$(CONFIG_6LOWPAN_GHC_ICMPV6) += ghc_icmpv6.o
diff --git a/net/6lowpan/ghc_icmpv6.c b/net/6lowpan/ghc_icmpv6.c
new file mode 100644
index 0000000..378ebfe
--- /dev/null
+++ b/net/6lowpan/ghc_icmpv6.c
@@ -0,0 +1,27 @@
+/*
+ *	6LoWPAN ICMPv6 compression according to RFC7400
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_GHC_ICMPV6_IDLEN		1
+#define LOWPAN_GHC_ICMPV6_ID_0		0xdf
+#define LOWPAN_GHC_ICMPV6_MASK_0	0xff
+
+static void icmpv6_ghid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_GHC_ICMPV6_ID_0;
+	nhc->idmask[0] = LOWPAN_GHC_ICMPV6_MASK_0;
+}
+
+LOWPAN_NHC(ghc_icmpv6, "RFC7400 ICMPv6", NEXTHDR_HOP, 0,
+	   icmpv6_ghid_setup, LOWPAN_GHC_ICMPV6_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(ghc_icmpv6);
+MODULE_DESCRIPTION("6LoWPAN generic header RFC7400 ICMPv6 compression");
+MODULE_LICENSE("GPL");
-- 
2.4.3

