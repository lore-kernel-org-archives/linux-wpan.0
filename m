Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59395 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbaHITCt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:49 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:23 +0200
Message-Id: <1407610943-27701-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 8/8] 6lowpan: add ipv6 skeleton
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Currenlty not support. Received packets with this nhc id should be
dropped.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/nhc/Makefile |  3 ++-
 net/6lowpan/nhc/core.c   |  8 ++++++++
 net/6lowpan/nhc/ipv6.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/ipv6.h   | 11 +++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 net/6lowpan/nhc/ipv6.c
 create mode 100644 net/6lowpan/nhc/ipv6.h

diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index 9915c31..4d91480 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -6,4 +6,5 @@ nhc-y := core.o \
 	 route.o \
 	 frag.o \
 	 dest.o \
-	 mobil.o
+	 mobil.o \
+	 ipv6.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index 1ee9750..66907ff 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -21,6 +21,7 @@
 #include "frag.h"
 #include "dest.h"
 #include "mobil.h"
+#include "ipv6.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -203,9 +204,15 @@ int lowpan_init_nhc(void)
 	ret = lowpan_init_nhc_mobil();
 	if (ret < 0)
 		goto mobil_fail;
+
+	ret = lowpan_init_nhc_ipv6();
+	if (ret < 0)
+		goto ipv6_fail;
 out:
 	return ret;
 
+ipv6_fail:
+	lowpan_cleanup_nhc_mobil();
 mobil_fail:
 	lowpan_cleanup_nhc_dest();
 dest_fail:
@@ -227,4 +234,5 @@ void lowpan_cleanup_nhc(void)
 	lowpan_cleanup_nhc_frag();
 	lowpan_cleanup_nhc_dest();
 	lowpan_cleanup_nhc_mobil();
+	lowpan_cleanup_nhc_ipv6();
 }
diff --git a/net/6lowpan/nhc/ipv6.c b/net/6lowpan/nhc/ipv6.c
new file mode 100644
index 0000000..59202cf
--- /dev/null
+++ b/net/6lowpan/nhc/ipv6.c
@@ -0,0 +1,48 @@
+/*	6LoWPAN IPv6 Header compression
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
+#include "ipv6.h"
+
+static int ipv6_uncompress(struct sk_buff **skb)
+{
+	return -ENOTSUPP;
+}
+
+static int ipv6_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	return -ENOTSUPP;
+}
+
+static void ipv6_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_IPV6_ID_0;
+	nhc->idmask[0] = LOWPAN_NHC_IPV6_MASK_0;
+}
+
+LOWPAN_NHC(ipv6_nhc, "IPv6 Header", NEXTHDR_IPV6, ipv6_nhid_setup,
+	   LOWPAN_NHC_IPV6_LEN, ipv6_uncompress, ipv6_compress);
+
+int lowpan_init_nhc_ipv6(void)
+{
+	return lowpan_add_nhc(&ipv6_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_ipv6);
+
+void lowpan_cleanup_nhc_ipv6(void)
+{
+	lowpan_del_nhc(&ipv6_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_ipv6);
diff --git a/net/6lowpan/nhc/ipv6.h b/net/6lowpan/nhc/ipv6.h
new file mode 100644
index 0000000..defc183
--- /dev/null
+++ b/net/6lowpan/nhc/ipv6.h
@@ -0,0 +1,11 @@
+#ifndef __6LOWPAN_NHC_IPV6_H
+#define __6LOWPAN_NHC_IPV6_H
+
+#define LOWPAN_NHC_IPV6_LEN	1
+#define LOWPAN_NHC_IPV6_ID_0	0xee
+#define LOWPAN_NHC_IPV6_MASK_0	0xfe
+
+int lowpan_init_nhc_ipv6(void);
+void lowpan_cleanup_nhc_ipv6(void);
+
+#endif /* __6LOWPAN_NHC_IPV6_H */
-- 
2.0.3

