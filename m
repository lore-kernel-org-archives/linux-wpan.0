Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:51344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726890AbeINK3o (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 14 Sep 2018 06:29:44 -0400
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] ieee802154: ca8210: remove redundant condition check before debugfs_remove
Date: Fri, 14 Sep 2018 13:04:37 +0800
Message-ID: <1536901477-28375-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org, h.morris@cascoda.com, alex.aring@gmail.com, davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

debugfs_remove has taken the IS_ERR into account. Just
remove the unnecessary condition.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ieee802154/ca8210.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 58299fb..46b4818 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3044,8 +3044,7 @@ static void ca8210_test_interface_clear(struct ca8210_priv *priv)
 {
 	struct ca8210_test *test = &priv->test;
 
-	if (!IS_ERR(test->ca8210_dfs_spi_int))
-		debugfs_remove(test->ca8210_dfs_spi_int);
+	debugfs_remove(test->ca8210_dfs_spi_int);
 	kfifo_free(&test->up_fifo);
 	dev_info(&priv->spi->dev, "Test interface removed\n");
 }
-- 
1.7.12.4
