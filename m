Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbfFCPvv (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:51 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 34/57] drivers: ieee802154: Use class_find_device_by_name() helper
Date: Mon,  3 Jun 2019 16:50:00 +0100
Message-Id: <1559577023-558-35-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, suzuki.poulose@arm.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org

Use the new class_find_device_by_name() helper.

Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 net/ieee802154/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 60b7ac5..26fe751 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -23,11 +23,6 @@
 LIST_HEAD(cfg802154_rdev_list);
 int cfg802154_rdev_list_generation;
 
-static int wpan_phy_match(struct device *dev, const void *data)
-{
-	return !strcmp(dev_name(dev), (const char *)data);
-}
-
 struct wpan_phy *wpan_phy_find(const char *str)
 {
 	struct device *dev;
@@ -35,7 +30,7 @@ struct wpan_phy *wpan_phy_find(const char *str)
 	if (WARN_ON(!str))
 		return NULL;
 
-	dev = class_find_device(&wpan_phy_class, NULL, str, wpan_phy_match);
+	dev = class_find_device_by_name(&wpan_phy_class, NULL, str);
 	if (!dev)
 		return NULL;
 
-- 
2.7.4
