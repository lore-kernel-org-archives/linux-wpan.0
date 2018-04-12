Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:33803 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDLM3I (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Apr 2018 08:29:08 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH] net: ieee802154: mcr20a: do not leak resources on error path
Date: Thu, 12 Apr 2018 14:28:49 +0200
Message-Id: <20180412122849.15329-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

We already allocated the device and platform  data at this
point. Instead of simply return from the probe function we
need to cleanup the resources first.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/mcr20a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 944470d69ba9..de0d7f28a181 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1309,8 +1309,10 @@ mcr20a_probe(struct spi_device *spi)
 	/* init buf */
 	lp->buf = devm_kzalloc(&spi->dev, SPI_COMMAND_BUFFER, GFP_KERNEL);
 
-	if (!lp->buf)
-		return -ENOMEM;
+	if (!lp->buf) {
+		ret = -ENOMEM;
+		goto free_dev;
+	}
 
 	mcr20a_setup_tx_spi_messages(lp);
 	mcr20a_setup_rx_spi_messages(lp);
-- 
2.14.3

