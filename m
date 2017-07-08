Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:28345 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdGHILu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Jul 2017 04:11:50 -0400
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mrf24j40: Fix en error handling path in 'mrf24j40_probe()'
Date: Sat,  8 Jul 2017 09:57:10 +0200
Message-Id: <20170708075710.18478-1-christophe.jaillet@wanadoo.fr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alan@signal11.us, alex.aring@gmail.com, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If this check fails, we must release some resources as done everywhere
else in this function before returning an error code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ieee802154/mrf24j40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 7d334963dc08..da8683782ffc 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -1330,7 +1330,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ) {
 		dev_warn(&spi->dev, "spi clock above possible maximum: %d",
 			 MAX_SPI_SPEED_HZ);
-		return -EINVAL;
+		goto err_register_device;
 	}
 
 	ret = mrf24j40_hw_init(devrec);
-- 
2.11.0

