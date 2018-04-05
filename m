Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.51]:34235 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbeDEQk7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Apr 2018 12:40:59 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4EC0C589D9D
        for <linux-wpan@vger.kernel.org>; Thu,  5 Apr 2018 11:20:08 -0500 (CDT)
Date: Thu, 5 Apr 2018 11:20:06 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ieee802154: mcr20a: Fix memory leak in mcr20a_probe
Message-ID: <20180405162006.GA2199@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Free allocated memory for pdata before return.

Addresses-Coverity-ID: 1466096 ("Resource leak")
Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ieee802154/mcr20a.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 55a22c7..944470d 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1267,7 +1267,7 @@ mcr20a_probe(struct spi_device *spi)
 	ret = mcr20a_get_platform_data(spi, pdata);
 	if (ret < 0) {
 		dev_crit(&spi->dev, "mcr20a_get_platform_data failed.\n");
-		return ret;
+		goto free_pdata;
 	}
 
 	/* init reset gpio */
@@ -1275,7 +1275,7 @@ mcr20a_probe(struct spi_device *spi)
 		ret = devm_gpio_request_one(&spi->dev, pdata->rst_gpio,
 					    GPIOF_OUT_INIT_HIGH, "reset");
 		if (ret)
-			return ret;
+			goto free_pdata;
 	}
 
 	/* reset mcr20a */
@@ -1291,7 +1291,8 @@ mcr20a_probe(struct spi_device *spi)
 	hw = ieee802154_alloc_hw(sizeof(*lp), &mcr20a_hw_ops);
 	if (!hw) {
 		dev_crit(&spi->dev, "ieee802154_alloc_hw failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto free_pdata;
 	}
 
 	/* init mcr20a local data */
@@ -1366,6 +1367,8 @@ mcr20a_probe(struct spi_device *spi)
 
 free_dev:
 	ieee802154_free_hw(lp->hw);
+free_pdata:
+	kfree(pdata);
 
 	return ret;
 }
-- 
2.7.4

