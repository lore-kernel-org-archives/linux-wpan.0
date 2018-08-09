Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:59571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbeHIJLI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 9 Aug 2018 05:11:08 -0400
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ieee802154: Use kmemdup instead of duplicating it in ca8210_test_int_driver_write
Date: Thu, 9 Aug 2018 14:44:29 +0800
Message-ID: <20180809064429.13348-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, h.morris@cascoda.com, alex.aring@gmail.com, stefan@datenfreihafen.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

Replace calls to kmalloc followed by a memcpy with a direct call to
kmemdup.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ieee802154/ca8210.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 58299fb..e21279d 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -634,10 +634,9 @@ static int ca8210_test_int_driver_write(
 	for (i = 0; i < len; i++)
 		dev_dbg(&priv->spi->dev, "%#03x\n", buf[i]);
 
-	fifo_buffer = kmalloc(len, GFP_KERNEL);
+	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
 	if (!fifo_buffer)
 		return -ENOMEM;
-	memcpy(fifo_buffer, buf, len);
 	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
 	wake_up_interruptible(&priv->test.readq);
 
-- 
2.7.0


