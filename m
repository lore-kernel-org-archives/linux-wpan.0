Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:15669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeLJLgo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 10 Dec 2018 06:36:44 -0500
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ieee802154: ca8210: remove a dead branch
Date: Mon, 10 Dec 2018 19:34:43 +0800
Message-ID: <20181210113443.22796-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, h.morris@cascoda.com, alex.aring@gmail.com, stefan@datenfreihafen.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

Fix follwing gcc warning:

drivers/net/ieee802154/ca8210.c:730:10: warning:
 comparison is always false due to limited range of data type [-Wtype-limits]

the variable 'len' is of type u8 and cannot greater than
CA8210_SPI_BUF_SIZE , which is 256.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ieee802154/ca8210.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 0ff5a40..0fe204f 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -727,14 +727,6 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 
 	buf = cas_ctl->tx_in_buf;
 	len = buf[1] + 2;
-	if (len > CA8210_SPI_BUF_SIZE) {
-		dev_crit(
-			&priv->spi->dev,
-			"Received packet len (%d) erroneously long\n",
-			len
-		);
-		goto finish;
-	}
 
 	if (buf[0] & SPI_SYN) {
 		if (priv->sync_command_response) {
-- 
2.7.0
