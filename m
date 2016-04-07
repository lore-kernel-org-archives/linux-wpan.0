Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45947 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757415AbcDGSyg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 14:54:36 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 10/21] 6lowpan: add lowpan_is_ll function
Date: Thu,  7 Apr 2016 20:54:11 +0200
Message-Id: <1460055262-4330-11-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
References: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch adds the lowpan_is_ll function, which can be used to make a
special 6lowpan linklayer handling for a specific 6lowpan linklayer
type.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/6lowpan_i.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/6lowpan/6lowpan_i.h b/net/6lowpan/6lowpan_i.h
index d16bb4b..97ecc27 100644
--- a/net/6lowpan/6lowpan_i.h
+++ b/net/6lowpan/6lowpan_i.h
@@ -3,6 +3,15 @@
 
 #include <linux/netdevice.h>
 
+#include <net/6lowpan.h>
+
+/* caller need to be sure it's dev->type is ARPHRD_6LOWPAN */
+static inline bool lowpan_is_ll(const struct net_device *dev,
+				enum lowpan_lltypes lltype)
+{
+	return lowpan_dev(dev)->lltype == lltype;
+}
+
 #ifdef CONFIG_6LOWPAN_DEBUGFS
 int lowpan_dev_debugfs_init(struct net_device *dev);
 void lowpan_dev_debugfs_exit(struct net_device *dev);
-- 
2.8.0

