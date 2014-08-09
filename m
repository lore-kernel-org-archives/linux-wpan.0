Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:51772 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbaHITCs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:48 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:22 +0200
Message-Id: <1407610943-27701-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 7/8] 6lowpan: add mobility skeleton
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Currenlty not support. Received packets with this nhc id should be
dropped.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/nhc/Makefile |  3 ++-
 net/6lowpan/nhc/core.c   |  8 ++++++++
 net/6lowpan/nhc/mobil.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/mobil.h  | 11 +++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/nhc/mobil.c
 create mode 100644 net/6lowpan/nhc/mobil.h

diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index 1b67930..9915c31 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -5,4 +5,5 @@ nhc-y := core.o \
 	 hop.o \
 	 route.o \
 	 frag.o \
-	 dest.o
+	 dest.o \
+	 mobil.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index 73d9e1e..1ee9750 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -20,6 +20,7 @@
 #include "route.h"
 #include "frag.h"
 #include "dest.h"
+#include "mobil.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -198,9 +199,15 @@ int lowpan_init_nhc(void)
 	ret = lowpan_init_nhc_dest();
 	if (ret < 0)
 		goto dest_fail;
+
+	ret = lowpan_init_nhc_mobil();
+	if (ret < 0)
+		goto mobil_fail;
 out:
 	return ret;
 
+mobil_fail:
+	lowpan_cleanup_nhc_dest();
 dest_fail:
 	lowpan_cleanup_nhc_frag();
 frag_fail:
@@ -219,4 +226,5 @@ void lowpan_cleanup_nhc(void)
 	lowpan_cleanup_nhc_route();
 	lowpan_cleanup_nhc_frag();
 	lowpan_cleanup_nhc_dest();
+	lowpan_cleanup_nhc_mobil();
 }
diff --git a/net/6lowpan/nhc/mobil.c b/net/6lowpan/nhc/mobil.c
new file mode 100644
index 0000000..66c7817
--- /dev/null
+++ b/net/6lowpan/nhc/mobil.c
@@ -0,0 +1,49 @@
+/*	6LoWPAN IPv6 Mobility Header compression
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
+#include "mobil.h"
+
+static int mobil_uncompress(struct sk_buff **skb)
+{
+	return -ENOTSUPP;
+}
+
+static int mobil_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	return -ENOTSUPP;
+}
+
+static void mobil_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_MOBIL_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_MOBIL_MASK_0;
+}
+
+LOWPAN_NHC(mobil_nhc, "IPv6 Mobility Header", NEXTHDR_MOBILITY,
+	   mobil_nhid_setup, LOWPAN_NHC_MOBIL_LEN, mobil_uncompress,
+	   mobil_compress);
+
+int lowpan_init_nhc_mobil(void)
+{
+	return lowpan_add_nhc(&mobil_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_mobil);
+
+void lowpan_cleanup_nhc_mobil(void)
+{
+	lowpan_del_nhc(&mobil_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_mobil);
diff --git a/net/6lowpan/nhc/mobil.h b/net/6lowpan/nhc/mobil.h
new file mode 100644
index 0000000..fcfdb55
--- /dev/null
+++ b/net/6lowpan/nhc/mobil.h
@@ -0,0 +1,11 @@
+#ifndef __6LOWPAN_NHC_MOBIL_H
+#define __6LOWPAN_NHC_MOBIL_H
+
+#define LOWPAN_NHC_MOBIL_LEN	1
+#define LOWPAN_NHC_MOBIL_ID_0	0xe8
+#define LOWPAN_NHC_MOBIL_MASK_0	0xfe
+
+int lowpan_init_nhc_mobil(void);
+void lowpan_cleanup_nhc_mobil(void);
+
+#endif /* __6LOWPAN_NHC_MOBIL_H */
-- 
2.0.3

