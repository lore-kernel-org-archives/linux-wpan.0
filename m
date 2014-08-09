Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:61080 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaHITCq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:46 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:20 +0200
Message-Id: <1407610943-27701-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 5/8] 6lowpan: add fragment skeleton
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Currenlty not support. Received packets with this nhc id should be
dropped.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/nhc/Makefile |  3 ++-
 net/6lowpan/nhc/core.c   |  8 ++++++++
 net/6lowpan/nhc/frag.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/frag.h   | 11 +++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/nhc/frag.c
 create mode 100644 net/6lowpan/nhc/frag.h

diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index 81aa18d..e524c57 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_6LOWPAN) += nhc.o
 nhc-y := core.o \
 	 udp.o \
 	 hop.o \
-	 route.o
+	 route.o \
+	 frag.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index db499bb..728dd06 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -18,6 +18,7 @@
 #include "udp.h"
 #include "hop.h"
 #include "route.h"
+#include "frag.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -188,9 +189,15 @@ int lowpan_init_nhc(void)
 	ret = lowpan_init_nhc_route();
 	if (ret < 0)
 		goto route_fail;
+
+	ret = lowpan_init_nhc_frag();
+	if (ret < 0)
+		goto frag_fail;
 out:
 	return ret;
 
+frag_fail:
+	lowpan_cleanup_nhc_route();
 route_fail:
 	lowpan_cleanup_nhc_hop();
 hop_fail:
@@ -203,4 +210,5 @@ void lowpan_cleanup_nhc(void)
 	lowpan_cleanup_nhc_udp();
 	lowpan_cleanup_nhc_hop();
 	lowpan_cleanup_nhc_route();
+	lowpan_cleanup_nhc_frag();
 }
diff --git a/net/6lowpan/nhc/frag.c b/net/6lowpan/nhc/frag.c
new file mode 100644
index 0000000..ac07a73
--- /dev/null
+++ b/net/6lowpan/nhc/frag.c
@@ -0,0 +1,49 @@
+/*	6LoWPAN IPv6 Fragment Header compression
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
+#include "frag.h"
+
+static int frag_uncompress(struct sk_buff **skb)
+{
+	return -ENOTSUPP;
+}
+
+static int frag_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	return -ENOTSUPP;
+}
+
+static void frag_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_FRAG_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_FRAG_MASK_0;
+}
+
+LOWPAN_NHC(frag_nhc, "IPv6 Fragment Header", NEXTHDR_FRAGMENT,
+	   frag_nhid_setup, LOWPAN_NHC_FRAG_LEN, frag_uncompress,
+	   frag_compress);
+
+int lowpan_init_nhc_frag(void)
+{
+	return lowpan_add_nhc(&frag_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_frag);
+
+void lowpan_cleanup_nhc_frag(void)
+{
+	lowpan_del_nhc(&frag_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_frag);
diff --git a/net/6lowpan/nhc/frag.h b/net/6lowpan/nhc/frag.h
new file mode 100644
index 0000000..e760720
--- /dev/null
+++ b/net/6lowpan/nhc/frag.h
@@ -0,0 +1,11 @@
+#ifndef __6LOWPAN_NHC_FRAG_H
+#define __6LOWPAN_NHC_FRAG_H
+
+#define LOWPAN_NHC_FRAG_LEN	1
+#define LOWPAN_NHC_FRAG_ID_0	0xe4
+#define LOWPAN_NHC_FRAG_MASK_0	0xfe
+
+int lowpan_init_nhc_frag(void);
+void lowpan_cleanup_nhc_frag(void);
+
+#endif /* __6LOWPAN_NHC_FRAG_H */
-- 
2.0.3

