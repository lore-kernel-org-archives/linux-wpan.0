Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:53680 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbaHITCr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:47 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:21 +0200
Message-Id: <1407610943-27701-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 6/8] 6lowpan: add destination options skeleton
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Currenlty not support. Received packets with this nhc id should be
dropped.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/nhc/Makefile |  3 ++-
 net/6lowpan/nhc/core.c   |  8 ++++++++
 net/6lowpan/nhc/dest.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/dest.h   | 11 +++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/nhc/dest.c
 create mode 100644 net/6lowpan/nhc/dest.h

diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index e524c57..1b67930 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -4,4 +4,5 @@ nhc-y := core.o \
 	 udp.o \
 	 hop.o \
 	 route.o \
-	 frag.o
+	 frag.o \
+	 dest.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index 728dd06..73d9e1e 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -19,6 +19,7 @@
 #include "hop.h"
 #include "route.h"
 #include "frag.h"
+#include "dest.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -193,9 +194,15 @@ int lowpan_init_nhc(void)
 	ret = lowpan_init_nhc_frag();
 	if (ret < 0)
 		goto frag_fail;
+
+	ret = lowpan_init_nhc_dest();
+	if (ret < 0)
+		goto dest_fail;
 out:
 	return ret;
 
+dest_fail:
+	lowpan_cleanup_nhc_frag();
 frag_fail:
 	lowpan_cleanup_nhc_route();
 route_fail:
@@ -211,4 +218,5 @@ void lowpan_cleanup_nhc(void)
 	lowpan_cleanup_nhc_hop();
 	lowpan_cleanup_nhc_route();
 	lowpan_cleanup_nhc_frag();
+	lowpan_cleanup_nhc_dest();
 }
diff --git a/net/6lowpan/nhc/dest.c b/net/6lowpan/nhc/dest.c
new file mode 100644
index 0000000..29469f3
--- /dev/null
+++ b/net/6lowpan/nhc/dest.c
@@ -0,0 +1,49 @@
+/*	6LoWPAN IPv6 Destination Options Header compression
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
+#include "dest.h"
+
+static int dest_uncompress(struct sk_buff **skb)
+{
+	return -ENOTSUPP;
+}
+
+static int dest_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	return -ENOTSUPP;
+}
+
+static void dest_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_DEST_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_DEST_MASK_0;
+}
+
+LOWPAN_NHC(dest_nhc, "IPv6 Destination Options Header", NEXTHDR_DEST,
+	   dest_nhid_setup, LOWPAN_NHC_DEST_LEN, dest_uncompress,
+	   dest_compress);
+
+int lowpan_init_nhc_dest(void)
+{
+	return lowpan_add_nhc(&dest_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_dest);
+
+void lowpan_cleanup_nhc_dest(void)
+{
+	lowpan_del_nhc(&dest_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_dest);
diff --git a/net/6lowpan/nhc/dest.h b/net/6lowpan/nhc/dest.h
new file mode 100644
index 0000000..f537e3f
--- /dev/null
+++ b/net/6lowpan/nhc/dest.h
@@ -0,0 +1,11 @@
+#ifndef __6LOWPAN_NHC_DEST_H
+#define __6LOWPAN_NHC_DEST_H
+
+#define LOWPAN_NHC_DEST_LEN	1
+#define LOWPAN_NHC_DEST_ID_0	0xe6
+#define LOWPAN_NHC_DEST_MASK_0	0xfe
+
+int lowpan_init_nhc_dest(void);
+void lowpan_cleanup_nhc_dest(void);
+
+#endif /* __6LOWPAN_NHC_DEST_H */
-- 
2.0.3

