Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34716 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbaLHPvt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Dec 2014 10:51:49 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 3/3] 6lowpan: nhc: add other known rfc6282 compressions
Date: Mon,  8 Dec 2014 16:50:38 +0100
Message-Id: <1418053838-8692-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418053838-8692-1-git-send-email-alex.aring@gmail.com>
References: <1418053838-8692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

This patch adds other known rfc6282 compression formats to the nhc
framework. These compression formats are known but not implemented yet.
For now this is useful to printout a warning which compression format
isn't supported.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>
---
 net/6lowpan/Kconfig             | 44 +++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/Makefile            |  6 ++++++
 net/6lowpan/iphc.c              |  6 ++++++
 net/6lowpan/nhc_rfc6282_dest.c  | 27 +++++++++++++++++++++++++
 net/6lowpan/nhc_rfc6282_frag.c  | 26 ++++++++++++++++++++++++
 net/6lowpan/nhc_rfc6282_hop.c   | 26 ++++++++++++++++++++++++
 net/6lowpan/nhc_rfc6282_ipv6.c  | 26 ++++++++++++++++++++++++
 net/6lowpan/nhc_rfc6282_mobil.c | 26 ++++++++++++++++++++++++
 net/6lowpan/nhc_rfc6282_route.c | 26 ++++++++++++++++++++++++
 9 files changed, 213 insertions(+)
 create mode 100644 net/6lowpan/nhc_rfc6282_dest.c
 create mode 100644 net/6lowpan/nhc_rfc6282_frag.c
 create mode 100644 net/6lowpan/nhc_rfc6282_hop.c
 create mode 100644 net/6lowpan/nhc_rfc6282_ipv6.c
 create mode 100644 net/6lowpan/nhc_rfc6282_mobil.c
 create mode 100644 net/6lowpan/nhc_rfc6282_route.c

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index bef92b2..b6faf4f 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -18,3 +18,47 @@ config 6LOWPAN_NHC_RFC6282_UDP
 	default y
 	---help---
 	  6LoWPAN IPv6 UDP Header compression according to RFC6282
+
+config 6LOWPAN_NHC_RFC6282_DEST
+	tristate "Destination Options Header Support"
+	depends on 6LOWPAN_NHC_RFC6282
+	default y
+	---help---
+	  6LoWPAN IPv6 Destination Options Header compression according to
+	  RFC6282.
+
+config 6LOWPAN_NHC_RFC6282_FRAG
+	tristate "Fragment Header Support"
+	depends on 6LOWPAN_NHC_RFC6282
+	default y
+	---help---
+	  6LoWPAN IPv6 Fragment Header compression according to RFC6282.
+
+config 6LOWPAN_NHC_RFC6282_HOP
+	tristate "Hop-by-Hop Options Header Support"
+	depends on 6LOWPAN_NHC_RFC6282
+	default y
+	---help---
+	  6LoWPAN IPv6 Hop-by-Hop Options Header compression according to
+	  RFC6282.
+
+config 6LOWPAN_NHC_RFC6282_IPV6
+	tristate "IPv6 Header Support"
+	depends on 6LOWPAN_NHC_RFC6282
+	default y
+	---help---
+	  6LoWPAN IPv6 Header compression according to RFC6282.
+
+config 6LOWPAN_NHC_RFC6282_MOBIL
+	tristate "Mobility Header Support"
+	depends on 6LOWPAN_NHC_RFC6282
+	default y
+	---help---
+	  6LoWPAN IPv6 Mobility Header compression according to RFC6282.
+
+config 6LOWPAN_NHC_RFC6282_ROUTE
+	tristate "Routing Header Support"
+	depends on 6LOWPAN_NHC_RFC6282
+	default y
+	---help---
+	  6LoWPAN IPv6 Routing Header compression according to RFC6282.
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index 9593f48..5466fe5 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -4,3 +4,9 @@ obj-$(CONFIG_6LOWPAN) += 6lowpan.o
 
 #rfc6282 nhc
 obj-$(CONFIG_6LOWPAN_NHC_RFC6282_UDP) += nhc_rfc6282_udp.o
+obj-$(CONFIG_6LOWPAN_NHC_RFC6282_DEST) += nhc_rfc6282_dest.o
+obj-$(CONFIG_6LOWPAN_NHC_RFC6282_FRAG) += nhc_rfc6282_frag.o
+obj-$(CONFIG_6LOWPAN_NHC_RFC6282_HOP) += nhc_rfc6282_hop.o
+obj-$(CONFIG_6LOWPAN_NHC_RFC6282_IPV6) += nhc_rfc6282_ipv6.o
+obj-$(CONFIG_6LOWPAN_NHC_RFC6282_MOBIL) += nhc_rfc6282_mobil.o
+obj-$(CONFIG_6LOWPAN_NHC_RFC6282_ROUTE) += nhc_rfc6282_route.o
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index d7b624d..7f106c5 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -644,6 +644,12 @@ EXPORT_SYMBOL_GPL(lowpan_header_compress);
 
 static int __init lowpan_module_init(void)
 {
+	request_module_nowait("nhc_rfc6282_dest");
+	request_module_nowait("nhc_rfc6282_frag");
+	request_module_nowait("nhc_rfc6282_hop");
+	request_module_nowait("nhc_rfc6282_ipv6");
+	request_module_nowait("nhc_rfc6282_mobil");
+	request_module_nowait("nhc_rfc6282_route");
 	request_module_nowait("nhc_rfc6282_udp");
 
 	return 0;
diff --git a/net/6lowpan/nhc_rfc6282_dest.c b/net/6lowpan/nhc_rfc6282_dest.c
new file mode 100644
index 0000000..6306907
--- /dev/null
+++ b/net/6lowpan/nhc_rfc6282_dest.c
@@ -0,0 +1,27 @@
+/*
+ *	6LoWPAN IPv6 Destination Options Header compression according to
+ *	RFC6282
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_DEST_IDLEN	1
+#define LOWPAN_NHC_DEST_ID_0	0xe6
+#define LOWPAN_NHC_DEST_MASK_0	0xfe
+
+static void dest_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_DEST_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_DEST_MASK_0;
+}
+
+LOWPAN_NHC(nhc_dest, "RFC6282 Destination Options", NEXTHDR_DEST, 0,
+	   dest_nhid_setup, LOWPAN_NHC_DEST_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(nhc_dest);
+MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/nhc_rfc6282_frag.c b/net/6lowpan/nhc_rfc6282_frag.c
new file mode 100644
index 0000000..1ca80ab
--- /dev/null
+++ b/net/6lowpan/nhc_rfc6282_frag.c
@@ -0,0 +1,26 @@
+/*
+ *	6LoWPAN IPv6 Fragment Header compression according to RFC6282
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_FRAG_IDLEN	1
+#define LOWPAN_NHC_FRAG_ID_0	0xe4
+#define LOWPAN_NHC_FRAG_MASK_0	0xfe
+
+static void frag_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_FRAG_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_FRAG_MASK_0;
+}
+
+LOWPAN_NHC(nhc_frag, "RFC6282 Fragment", NEXTHDR_FRAGMENT, 0,
+	   frag_nhid_setup, LOWPAN_NHC_FRAG_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(nhc_frag);
+MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/nhc_rfc6282_hop.c b/net/6lowpan/nhc_rfc6282_hop.c
new file mode 100644
index 0000000..c4fa968
--- /dev/null
+++ b/net/6lowpan/nhc_rfc6282_hop.c
@@ -0,0 +1,26 @@
+/*
+ *	6LoWPAN IPv6 Hop-by-Hop Options Header compression according to RFC6282
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_HOP_IDLEN	1
+#define LOWPAN_NHC_HOP_ID_0	0xe0
+#define LOWPAN_NHC_HOP_MASK_0	0xfe
+
+static void hop_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_HOP_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_HOP_MASK_0;
+}
+
+LOWPAN_NHC(nhc_hop, "RFC6282 Hop-by-Hop Options", NEXTHDR_HOP, 0,
+	   hop_nhid_setup, LOWPAN_NHC_HOP_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(nhc_hop);
+MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/nhc_rfc6282_ipv6.c b/net/6lowpan/nhc_rfc6282_ipv6.c
new file mode 100644
index 0000000..306295f
--- /dev/null
+++ b/net/6lowpan/nhc_rfc6282_ipv6.c
@@ -0,0 +1,26 @@
+/*
+ *	6LoWPAN IPv6 Header compression according to RFC6282
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_IPV6_IDLEN	1
+#define LOWPAN_NHC_IPV6_ID_0	0xee
+#define LOWPAN_NHC_IPV6_MASK_0	0xfe
+
+static void ipv6_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_IPV6_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_IPV6_MASK_0;
+}
+
+LOWPAN_NHC(nhc_ipv6, "RFC6282 IPv6", NEXTHDR_IPV6, 0, ipv6_nhid_setup,
+	   LOWPAN_NHC_IPV6_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(nhc_ipv6);
+MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/nhc_rfc6282_mobil.c b/net/6lowpan/nhc_rfc6282_mobil.c
new file mode 100644
index 0000000..b2ed933
--- /dev/null
+++ b/net/6lowpan/nhc_rfc6282_mobil.c
@@ -0,0 +1,26 @@
+/*
+ *	6LoWPAN IPv6 Mobility Header compression according to RFC6282
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_MOBIL_IDLEN	1
+#define LOWPAN_NHC_MOBIL_ID_0	0xe8
+#define LOWPAN_NHC_MOBIL_MASK_0	0xfe
+
+static void mobil_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_MOBIL_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_MOBIL_MASK_0;
+}
+
+LOWPAN_NHC(nhc_mobil, "RFC6282 Mobility", NEXTHDR_MOBILITY, 0,
+	   mobil_nhid_setup, LOWPAN_NHC_MOBIL_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(nhc_mobil);
+MODULE_LICENSE("GPL");
diff --git a/net/6lowpan/nhc_rfc6282_route.c b/net/6lowpan/nhc_rfc6282_route.c
new file mode 100644
index 0000000..f4b065a
--- /dev/null
+++ b/net/6lowpan/nhc_rfc6282_route.c
@@ -0,0 +1,26 @@
+/*
+ *	6LoWPAN IPv6 Routing Header compression according to RFC6282
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_ROUTE_IDLEN	1
+#define LOWPAN_NHC_ROUTE_ID_0	0xe2
+#define LOWPAN_NHC_ROUTE_MASK_0	0xfe
+
+static void route_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_ROUTE_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_ROUTE_MASK_0;
+}
+
+LOWPAN_NHC(nhc_route, "RFC6282 Routing", NEXTHDR_ROUTING, 0, route_nhid_setup,
+	   LOWPAN_NHC_ROUTE_IDLEN, NULL, NULL);
+
+module_lowpan_nhc(nhc_route);
+MODULE_LICENSE("GPL");
-- 
2.1.3

