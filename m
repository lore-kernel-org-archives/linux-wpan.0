Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:21936 "EHLO
	ironport01.nordicsemi.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbGMLuo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jul 2015 07:50:44 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [RFC v2 1/4] 6lowpan: Introduce debugfs entry for 6lowpan module
Date: Mon, 13 Jul 2015 13:50:30 +0200
Message-ID: <1436788233-13960-2-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Creating "6lowpan" debugfs entry (/sys/kernel/debugfs/6lowpan) for usage
by 6lowpan module.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 include/net/6lowpan.h |  2 ++
 net/6lowpan/iphc.c    | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index dc03d77..37ddbdf 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -197,6 +197,8 @@
 #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
 #define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
 
+extern struct dentry *lowpan_debugfs;
+
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 9055d7b..c845a8a 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -50,12 +50,16 @@
 #include <linux/if_arp.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/debugfs.h>
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
 #include <net/af_ieee802154.h>
 
 #include "nhc.h"
 
+struct dentry *lowpan_debugfs;
+EXPORT_SYMBOL_GPL(lowpan_debugfs);
+
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
@@ -613,6 +617,8 @@ EXPORT_SYMBOL_GPL(lowpan_header_compress);
 
 static int __init lowpan_module_init(void)
 {
+	lowpan_debugfs = debugfs_create_dir("6lowpan", NULL);
+
 	request_module_nowait("ipv6");
 
 	request_module_nowait("nhc_dest");
@@ -625,6 +631,13 @@ static int __init lowpan_module_init(void)
 
 	return 0;
 }
+
+static void __exit lowpan_module_exit(void)
+{
+	debugfs_remove(lowpan_debugfs);
+}
+
 module_init(lowpan_module_init);
+module_exit(lowpan_module_exit);
 
 MODULE_LICENSE("GPL");
-- 
2.1.4

