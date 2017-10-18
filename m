Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43071 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933908AbdJRMGS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Oct 2017 08:06:18 -0400
From: Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: [RFC 2/3] 6lowpan: Factor out lowpan device context initialization
Date: Wed, 18 Oct 2017 15:06:14 +0300
Message-Id: <20171018120615.24126-3-patrik.flykt@linux.intel.com>
In-Reply-To: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
References: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: luiz.von.dentz@intel.com

6lowpan context initialization will be used in other places,
factor it out without any changes in functionality.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 include/net/6lowpan.h |  2 ++
 net/6lowpan/core.c    | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 7f21e156c9d6..1df9ecf22a57 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -289,6 +289,8 @@ int lowpan_register_netdev(struct net_device *dev,
 void lowpan_unregister_netdevice(struct net_device *dev);
 void lowpan_unregister_netdev(struct net_device *dev);
 
+int lowpan_initialize_ctx(struct lowpan_dev *ldev, enum lowpan_lltypes lltype);
+
 /**
  * lowpan_header_decompress - replace 6LoWPAN header with IPv6 header
  *
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 40d3d72beb53..29150a2c5e04 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -18,10 +18,24 @@
 
 #include "6lowpan_i.h"
 
+int lowpan_initialize_ctx(struct lowpan_dev *ldev, enum lowpan_lltypes lltype)
+{
+	int i;
+
+	ldev->lltype = lltype;
+
+	spin_lock_init(&ldev->ctx.lock);
+	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
+		ldev->ctx.table[i].id = i;
+
+	return 0;
+}
+EXPORT_SYMBOL(lowpan_initialize_ctx);
+
 int lowpan_register_netdevice(struct net_device *dev,
 			      enum lowpan_lltypes lltype)
 {
-	int i, ret;
+	int ret;
 
 	switch (lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
@@ -36,11 +50,7 @@ int lowpan_register_netdevice(struct net_device *dev,
 	dev->type = ARPHRD_6LOWPAN;
 	dev->mtu = IPV6_MIN_MTU;
 
-	lowpan_dev(dev)->lltype = lltype;
-
-	spin_lock_init(&lowpan_dev(dev)->ctx.lock);
-	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
-		lowpan_dev(dev)->ctx.table[i].id = i;
+	lowpan_initialize_ctx(lowpan_dev(dev), lltype);
 
 	dev->ndisc_ops = &lowpan_ndisc_ops;
 
-- 
2.11.0

