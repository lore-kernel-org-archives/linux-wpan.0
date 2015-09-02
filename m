Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38174 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbbIBMWF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:05 -0400
Received: by wiclp12 with SMTP id lp12so17176027wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/16] ieee802154: 6lowpan: register packet layer while open
Date: Wed,  2 Sep 2015 14:21:17 +0200
Message-Id: <1441196491-25013-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the open count handling while doing open of a lowpan
interface. We need the packet handler register at first when one lowpan
interface is up. There exists a small case when all lowpan interfaces
are down and the 802154 packet layer is still registered. To reduce some
overhead we will register the packet layer when the first lowpan
interface comes up and unregister when the last interface will become down.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index b0f0460..5b418ce 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -76,9 +76,27 @@ static int lowpan_dev_init(struct net_device *ldev)
 	return 0;
 }
 
+static int lowpan_open(struct net_device *dev)
+{
+	if (!open_count)
+		lowpan_rx_init();
+	open_count++;
+	return 0;
+}
+
+static int lowpan_stop(struct net_device *dev)
+{
+	open_count--;
+	if (!open_count)
+		lowpan_rx_exit();
+	return 0;
+}
+
 static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_init		= lowpan_dev_init,
 	.ndo_start_xmit		= lowpan_xmit,
+	.ndo_open		= lowpan_open,
+	.ndo_stop		= lowpan_stop,
 };
 
 static void lowpan_setup(struct net_device *ldev)
@@ -149,11 +167,6 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	}
 
 	wdev->ieee802154_ptr->lowpan_dev = ldev;
-	if (!open_count)
-		lowpan_rx_init();
-
-	open_count++;
-
 	return 0;
 }
 
@@ -163,11 +176,6 @@ static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
 
 	ASSERT_RTNL();
 
-	open_count--;
-
-	if (!open_count)
-		lowpan_rx_exit();
-
 	wdev->ieee802154_ptr->lowpan_dev = NULL;
 	unregister_netdevice(ldev);
 	dev_put(wdev);
-- 
2.5.1

