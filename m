Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:11673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbeIHSmX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 8 Sep 2018 14:42:23 -0400
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] ieee802154: remove unecessary condition check before debugfs_remove_recursive
Date: Sat, 8 Sep 2018 21:44:08 +0800
Message-ID: <1536414248-32361-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, alex.aring@gmail.com, michael.hennerich@analog.com, stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

debugfs_remove_recursive has taken IS_ERR_OR_NULL into account. So just
remove the condition check before debugfs_remove_recursive.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ieee802154/adf7242.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 23a52b9..cd1d8fa 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1308,8 +1308,7 @@ static int adf7242_remove(struct spi_device *spi)
 {
 	struct adf7242_local *lp = spi_get_drvdata(spi);
 
-	if (!IS_ERR_OR_NULL(lp->debugfs_root))
-		debugfs_remove_recursive(lp->debugfs_root);
+	debugfs_remove_recursive(lp->debugfs_root);
 
 	cancel_delayed_work_sync(&lp->work);
 	destroy_workqueue(lp->wqueue);
-- 
1.7.12.4
