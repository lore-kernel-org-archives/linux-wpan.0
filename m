Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37802 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964964AbbLOLZo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 15 Dec 2015 06:25:44 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] 6lowpan: fix debugfs interface entry name
Date: Tue, 15 Dec 2015 12:25:35 +0100
Message-Id: <1450178735-1572-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, lukasz.duda@nordicsemi.no, Alexander Aring <alex.aring@gmail.com>

This patches moves the debugfs interface related register after
netdevice register. The function lowpan_dev_debugfs_init will use
"dev->name" which can be before register_netdevice a format string.
The function register_netdevice will evaluate the format string if
necessary and replace "dev->name" to the real interface name.

Reported-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index c7f06f5..faf65ba 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -29,13 +29,13 @@ int lowpan_register_netdevice(struct net_device *dev,
 
 	lowpan_priv(dev)->lltype = lltype;
 
-	ret = lowpan_dev_debugfs_init(dev);
+	ret = register_netdevice(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = register_netdevice(dev);
+	ret = lowpan_dev_debugfs_init(dev);
 	if (ret < 0)
-		lowpan_dev_debugfs_exit(dev);
+		unregister_netdevice(dev);
 
 	return ret;
 }
-- 
2.6.1

