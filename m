Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56404 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751758AbcHGOdF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:05 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 13/19] 6lowpan: move dev_init to generic
Date: Sun,  7 Aug 2016 16:30:50 +0200
Message-Id: <20160807143056.3116-14-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This functionality need to be implemented on all 6LoWPAN interfaces so
we move this to generic 6LoWPAN.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h         | 2 ++
 net/6lowpan/core.c            | 8 ++++++++
 net/ieee802154/6lowpan/core.c | 7 -------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 9a6282b..6a60df9 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -286,6 +286,8 @@ int lowpan_register_netdev(struct net_device *dev,
 void lowpan_unregister_netdevice(struct net_device *dev);
 void lowpan_unregister_netdev(struct net_device *dev);
 
+int lowpan_dev_init(struct net_device *dev);
+
 /**
  * lowpan_header_decompress - replace 6LoWPAN header with IPv6 header
  *
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index b01effd..a978000 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -45,6 +45,14 @@ static struct header_ops header_ops = {
 	.create	= lowpan_header_create,
 };
 
+int lowpan_dev_init(struct net_device *dev)
+{
+	netdev_lockdep_set_classes(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(lowpan_dev_init);
+
 int lowpan_register_netdevice(struct net_device *dev,
 			      enum lowpan_lltypes lltype)
 {
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 096a194..228a711 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -54,13 +54,6 @@
 
 static int open_count;
 
-static int lowpan_dev_init(struct net_device *ldev)
-{
-	netdev_lockdep_set_classes(ldev);
-
-	return 0;
-}
-
 static int lowpan_open(struct net_device *dev)
 {
 	if (!open_count)
-- 
2.9.2

