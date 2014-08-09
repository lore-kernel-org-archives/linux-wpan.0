Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39855 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbaHITCo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:44 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:18 +0200
Message-Id: <1407610943-27701-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 3/8] 6lowpan: add hop-by-hop options skeleton
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Currenlty not support. Received packets with this nhc id should be
dropped.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/nhc/Makefile |  3 ++-
 net/6lowpan/nhc/core.c   | 18 +++++++++++++++++-
 net/6lowpan/nhc/hop.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/hop.h    | 11 +++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 net/6lowpan/nhc/hop.c
 create mode 100644 net/6lowpan/nhc/hop.h

diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index 07431c2..b82135a 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_6LOWPAN) += nhc.o
 
 nhc-y := core.o \
-	 udp.o
+	 udp.o \
+	 hop.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index 0f98132..80ed357 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -16,6 +16,7 @@
 
 #include "core.h"
 #include "udp.h"
+#include "hop.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -173,10 +174,25 @@ EXPORT_SYMBOL(lowpan_del_nhc);
 
 int lowpan_init_nhc(void)
 {
-	return lowpan_init_nhc_udp();
+	int ret;
+
+	ret = lowpan_init_nhc_udp();
+	if (ret < 0)
+		goto out;
+
+	ret = lowpan_init_nhc_hop();
+	if (ret < 0)
+		goto hop_fail;
+out:
+	return ret;
+
+hop_fail:
+	lowpan_cleanup_nhc_udp();
+	goto out;
 }
 
 void lowpan_cleanup_nhc(void)
 {
 	lowpan_cleanup_nhc_udp();
+	lowpan_cleanup_nhc_hop();
 }
diff --git a/net/6lowpan/nhc/hop.c b/net/6lowpan/nhc/hop.c
new file mode 100644
index 0000000..f74ac72
--- /dev/null
+++ b/net/6lowpan/nhc/hop.c
@@ -0,0 +1,48 @@
+/*	6LoWPAN IPv6 Hop-by-Hop Options Header compression
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
+#include "hop.h"
+
+static int hop_uncompress(struct sk_buff **skb)
+{
+	return -ENOTSUPP;
+}
+
+static int hop_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	return -ENOTSUPP;
+}
+
+static void hop_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_HOP_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_HOP_MASK_0;
+}
+
+LOWPAN_NHC(hop_nhc, "IPv6 Hop-by-Hop Options Header", NEXTHDR_HOP,
+	   hop_nhid_setup, LOWPAN_NHC_HOP_LEN, hop_uncompress, hop_compress);
+
+int lowpan_init_nhc_hop(void)
+{
+	return lowpan_add_nhc(&hop_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_hop);
+
+void lowpan_cleanup_nhc_hop(void)
+{
+	lowpan_del_nhc(&hop_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_hop);
diff --git a/net/6lowpan/nhc/hop.h b/net/6lowpan/nhc/hop.h
new file mode 100644
index 0000000..c03fc58
--- /dev/null
+++ b/net/6lowpan/nhc/hop.h
@@ -0,0 +1,11 @@
+#ifndef __6LOWPAN_NHC_HOP_H
+#define __6LOWPAN_NHC_HOP_H
+
+#define LOWPAN_NHC_HOP_LEN	1
+#define LOWPAN_NHC_HOP_ID_0	0xe0
+#define LOWPAN_NHC_HOP_MASK_0	0xfe
+
+int lowpan_init_nhc_hop(void);
+void lowpan_cleanup_nhc_hop(void);
+
+#endif /* __6LOWPAN_NHC_HOP_H */
-- 
2.0.3

