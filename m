Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:51841 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbaHITCp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:45 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:19 +0200
Message-Id: <1407610943-27701-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 4/8] 6lowpan: add routing skeleton
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Currenlty not support. Received packets with this nhc id should be
dropped.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/nhc/Makefile |  3 ++-
 net/6lowpan/nhc/core.c   |  8 ++++++++
 net/6lowpan/nhc/route.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/route.h  | 11 +++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/nhc/route.c
 create mode 100644 net/6lowpan/nhc/route.h

diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index b82135a..81aa18d 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_6LOWPAN) += nhc.o
 
 nhc-y := core.o \
 	 udp.o \
-	 hop.o
+	 hop.o \
+	 route.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index 80ed357..db499bb 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -17,6 +17,7 @@
 #include "core.h"
 #include "udp.h"
 #include "hop.h"
+#include "route.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -183,9 +184,15 @@ int lowpan_init_nhc(void)
 	ret = lowpan_init_nhc_hop();
 	if (ret < 0)
 		goto hop_fail;
+
+	ret = lowpan_init_nhc_route();
+	if (ret < 0)
+		goto route_fail;
 out:
 	return ret;
 
+route_fail:
+	lowpan_cleanup_nhc_hop();
 hop_fail:
 	lowpan_cleanup_nhc_udp();
 	goto out;
@@ -195,4 +202,5 @@ void lowpan_cleanup_nhc(void)
 {
 	lowpan_cleanup_nhc_udp();
 	lowpan_cleanup_nhc_hop();
+	lowpan_cleanup_nhc_route();
 }
diff --git a/net/6lowpan/nhc/route.c b/net/6lowpan/nhc/route.c
new file mode 100644
index 0000000..e5d8045
--- /dev/null
+++ b/net/6lowpan/nhc/route.c
@@ -0,0 +1,48 @@
+/*	6LoWPAN IPv6 Routing Header compression
+ *
+ *
+ *	Authors:
+ *	Alexander Aring		<aar@pengutronix.de>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <net/6lowpan.h>
+#include <linux/skbuff.h>
+
+#include "core.h"
+#include "route.h"
+
+static int route_uncompress(struct sk_buff **skb)
+{
+	return -ENOTSUPP;
+}
+
+static int route_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	return -ENOTSUPP;
+}
+
+static void route_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_ROUTE_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_ROUTE_MASK_0;
+}
+
+LOWPAN_NHC(route_nhc, "IPv6 Routing Header", NEXTHDR_ROUTING, route_nhid_setup,
+	   LOWPAN_NHC_ROUTE_LEN, route_uncompress, route_compress);
+
+int lowpan_init_nhc_route(void)
+{
+	return lowpan_add_nhc(&route_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_route);
+
+void lowpan_cleanup_nhc_route(void)
+{
+	lowpan_del_nhc(&route_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_route);
diff --git a/net/6lowpan/nhc/route.h b/net/6lowpan/nhc/route.h
new file mode 100644
index 0000000..78cd6b5
--- /dev/null
+++ b/net/6lowpan/nhc/route.h
@@ -0,0 +1,11 @@
+#ifndef __6LOWPAN_NHC_ROUTE_H
+#define __6LOWPAN_NHC_ROUTE_H
+
+#define LOWPAN_NHC_ROUTE_LEN	1
+#define LOWPAN_NHC_ROUTE_ID_0	0xe2
+#define LOWPAN_NHC_ROUTE_MASK_0	0xfe
+
+int lowpan_init_nhc_route(void);
+void lowpan_cleanup_nhc_route(void);
+
+#endif /* __6LOWPAN_NHC_ROUTE_H */
-- 
2.0.3

