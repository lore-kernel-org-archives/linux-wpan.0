Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40025 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbbCBOKc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 09:10:32 -0500
Received: by wghl18 with SMTP id l18so33630933wgh.7
        for <linux-wpan@vger.kernel.org>; Mon, 02 Mar 2015 06:10:30 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] ieee802154: change wpan-phy name to phy
Date: Mon,  2 Mar 2015 15:10:04 +0100
Message-Id: <1425305405-30706-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
References: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Currently the wpan_phy under /sys/class/ieee802154/ is named as
"wpan-phy#", this patch will change the name to phy. This will
introduce the same naming convention like wireless.

Note: wpan-tools users will not type "wpan-phy#" anymore, just a simple
      "phy#" is enough.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 888d099..2ee00e8 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -25,6 +25,9 @@
 #include "sysfs.h"
 #include "core.h"
 
+/* name for sysfs, %d is appended */
+#define PHY_NAME "phy"
+
 /* RCU-protected (and RTNL for writers) */
 LIST_HEAD(cfg802154_rdev_list);
 int cfg802154_rdev_list_generation;
@@ -122,7 +125,7 @@ wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
 
 	INIT_LIST_HEAD(&rdev->wpan_dev_list);
 	device_initialize(&rdev->wpan_phy.dev);
-	dev_set_name(&rdev->wpan_phy.dev, "wpan-phy%d", rdev->wpan_phy_idx);
+	dev_set_name(&rdev->wpan_phy.dev, PHY_NAME "%d", rdev->wpan_phy_idx);
 
 	rdev->wpan_phy.dev.class = &wpan_phy_class;
 	rdev->wpan_phy.dev.platform_data = rdev;
-- 
2.3.0

