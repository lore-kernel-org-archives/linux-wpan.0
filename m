Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33360 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbHOJBH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2015 05:01:07 -0400
Received: by wijp15 with SMTP id p15so37961213wij.0
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2015 02:01:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] ieee802154: 6lowpan: fix packet layer registration
Date: Sat, 15 Aug 2015 11:00:32 +0200
Message-Id: <1439629233-4328-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
References: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixes 802.15.4 packet layer registration when mutliple
lowpan interfaces will be added. We need to register the packet layer at
the first lowpan interface and deregister it at the last interface. This
done by open_count variable which is protected by rtnl.

Additional do a quiet fix by adding dev_put(real_dev) when netdev
registration fails, which fix the refcount for the wpan dev.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 180e9f5..27c25ad 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -52,6 +52,8 @@
 
 #include "6lowpan_i.h"
 
+static int open_count;
+
 static struct header_ops lowpan_header_ops = {
 	.create	= lowpan_header_create,
 };
@@ -141,12 +143,18 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	lowpan_netdev_setup(dev, LOWPAN_LLTYPE_IEEE802154);
 
 	ret = register_netdevice(dev);
-	if (ret >= 0) {
-		real_dev->ieee802154_ptr->lowpan_dev = dev;
-		lowpan_rx_init();
+	if (ret < 0) {
+		dev_put(real_dev);
+		return ret;
 	}
 
-	return ret;
+	real_dev->ieee802154_ptr->lowpan_dev = dev;
+	if (!open_count)
+		lowpan_rx_init();
+
+	open_count++;
+
+	return 0;
 }
 
 static void lowpan_dellink(struct net_device *dev, struct list_head *head)
@@ -156,7 +164,11 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
 
 	ASSERT_RTNL();
 
-	lowpan_rx_exit();
+	open_count--;
+
+	if (!open_count)
+		lowpan_rx_exit();
+
 	real_dev->ieee802154_ptr->lowpan_dev = NULL;
 	unregister_netdevice(dev);
 	dev_put(real_dev);
-- 
2.5.0

