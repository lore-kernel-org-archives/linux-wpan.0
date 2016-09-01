Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50335 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751063AbcIAJZG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Sep 2016 05:25:06 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next] fakelb: fix schedule while atomic
Date: Thu,  1 Sep 2016 11:24:57 +0200
Message-Id: <20160901092457.26010-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch changes the spinlock to mutex for the available fakelb phy
list. When holding the spinlock the ieee802154_unregister_hw is called
which holding the rtnl_mutex, in that case we get a "BUG: sleeping function
called from invalid context" error. We simple change the spinlock to
mutex which allows to hold the rtnl lock there.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
I think for the current use case, we don't need any locking anyway, but when
we add support for runtime add/del phy's then we need it... so I let the lock
there.

 drivers/net/ieee802154/fakelb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 0becf0a..ec387ef 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -30,7 +30,7 @@
 static int numlbs = 2;
 
 static LIST_HEAD(fakelb_phys);
-static DEFINE_SPINLOCK(fakelb_phys_lock);
+static DEFINE_MUTEX(fakelb_phys_lock);
 
 static LIST_HEAD(fakelb_ifup_phys);
 static DEFINE_RWLOCK(fakelb_ifup_phys_lock);
@@ -188,9 +188,9 @@ static int fakelb_add_one(struct device *dev)
 	if (err)
 		goto err_reg;
 
-	spin_lock(&fakelb_phys_lock);
+	mutex_lock(&fakelb_phys_lock);
 	list_add_tail(&phy->list, &fakelb_phys);
-	spin_unlock(&fakelb_phys_lock);
+	mutex_unlock(&fakelb_phys_lock);
 
 	return 0;
 
@@ -222,10 +222,10 @@ static int fakelb_probe(struct platform_device *pdev)
 	return 0;
 
 err_slave:
-	spin_lock(&fakelb_phys_lock);
+	mutex_lock(&fakelb_phys_lock);
 	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
-	spin_unlock(&fakelb_phys_lock);
+	mutex_unlock(&fakelb_phys_lock);
 	return err;
 }
 
@@ -233,10 +233,10 @@ static int fakelb_remove(struct platform_device *pdev)
 {
 	struct fakelb_phy *phy, *tmp;
 
-	spin_lock(&fakelb_phys_lock);
+	mutex_lock(&fakelb_phys_lock);
 	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
-	spin_unlock(&fakelb_phys_lock);
+	mutex_unlock(&fakelb_phys_lock);
 	return 0;
 }
 
-- 
2.9.3

