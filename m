Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:36830 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbbKYO7a (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 09:59:30 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH v2 bluetooth-next 4/7] 6lowpan: add nhc module for GHC ICMPv6 detection
Date: Wed, 25 Nov 2015 15:59:14 +0100
Message-Id: <1448463557-22618-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/6lowpan/Kconfig          |  5 +++++
 net/6lowpan/Makefile         |  1 +
 net/6lowpan/nhc_ghc_icmpv6.c | 27 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 net/6lowpan/nhc_ghc_icmpv6.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 94d5178..0a3f5a8 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -70,4 +70,9 @@ config 6LOWPAN_GHC_UDP
 	---help---
 	  6LoWPAN IPv6 UDP generic header compression according to RFC7400.
 
+config 6LOWPAN_GHC_ICMPV6
+	tristate "GHC ICMPv6 Support"
+	---help---
+	  6LoWPAN IPv6 ICMPv6 generic header compression according to RFC7400.
+
 endif
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index 5e4f2f3..86af3fd 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
 #rfc7400 ghcs
 obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_HOP) += nhc_ghc_ext_hop.o
 obj-$(CONFIG_6LOWPAN_GHC_UDP) += nhc_ghc_udp.o
+obj-$(CONFIG_6LOWPAN_GHC_ICMPV6) += nhc_ghc_icmpv6.o
diff --git a/net/6lowpan/nhc_ghc_icmpv6.c b/net/6lowpan/nhc_ghc_icmpv6.c
new file mode 100644
index 0000000..32e7c2c
--- /dev/null
+++ b/net/6lowpan/nhc_ghc_icmpv6.c
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
+LOWPAN_NHC(ghc_icmpv6, "RFC7400 ICMPv6", NEXTHDR_ICMP, 0,
+	   icmpv6_ghid_setup, LOWPAN_GHC_ICMPV6_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(ghc_icmpv6);
+MODULE_DESCRIPTION("6LoWPAN generic header ICMPv6 compression");
+MODULE_LICENSE("GPL");
-- 
2.4.3

