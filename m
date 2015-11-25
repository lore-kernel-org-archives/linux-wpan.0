Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:36825 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbbKYO7b (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 09:59:31 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH v2 bluetooth-next 5/7] 6lowpan: add nhc module for GHC destination extension header detection
Date: Wed, 25 Nov 2015 15:59:15 +0100
Message-Id: <1448463557-22618-6-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/6lowpan/Kconfig            |  6 ++++++
 net/6lowpan/Makefile           |  1 +
 net/6lowpan/nhc_ghc_ext_dest.c | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 net/6lowpan/nhc_ghc_ext_dest.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 0a3f5a8..e5184e6 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -75,4 +75,10 @@ config 6LOWPAN_GHC_ICMPV6
 	---help---
 	  6LoWPAN IPv6 ICMPv6 generic header compression according to RFC7400.
 
+config 6LOWPAN_GHC_EXT_HDR_DEST
+	tristate "GHC Destination Options Header Support"
+	---help---
+	  6LoWPAN IPv6 destination option generic header compression according
+	  to RFC7400.
+
 endif
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index 86af3fd..fc4bac0 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_6LOWPAN_NHC_UDP) += nhc_udp.o
 obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_HOP) += nhc_ghc_ext_hop.o
 obj-$(CONFIG_6LOWPAN_GHC_UDP) += nhc_ghc_udp.o
 obj-$(CONFIG_6LOWPAN_GHC_ICMPV6) += nhc_ghc_icmpv6.o
+obj-$(CONFIG_6LOWPAN_GHC_EXT_HDR_DEST) += nhc_ghc_ext_dest.o
diff --git a/net/6lowpan/nhc_ghc_ext_dest.c b/net/6lowpan/nhc_ghc_ext_dest.c
new file mode 100644
index 0000000..9887b3a
--- /dev/null
+++ b/net/6lowpan/nhc_ghc_ext_dest.c
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
+#define LOWPAN_GHC_EXT_DEST_IDLEN	1
+#define LOWPAN_GHC_EXT_DEST_ID_0	0xb6
+#define LOWPAN_GHC_EXT_DEST_MASK_0	0xfe
+
+static void dest_ghid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_GHC_EXT_DEST_ID_0;
+	nhc->idmask[0] = LOWPAN_GHC_EXT_DEST_MASK_0;
+}
+
+LOWPAN_NHC(ghc_ext_dest, "RFC7400 Destination Extension Header", NEXTHDR_DEST,
+	   0, dest_ghid_setup, LOWPAN_GHC_EXT_DEST_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(ghc_ext_dest);
+MODULE_DESCRIPTION("6LoWPAN generic header destination extension compression");
+MODULE_LICENSE("GPL");
-- 
2.4.3

