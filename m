Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36482 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbbHMMXY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:24 -0400
Received: by wicja10 with SMTP id ja10so149297924wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 04/21] mrf24j40: remove spi settings overwrite
Date: Thu, 13 Aug 2015 14:22:31 +0200
Message-Id: <1439468568-22288-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch removes spi settings while mrf24j40 probing. These settings
cannot be overwrite while device probing where spi controller should be
already configured. These settings need to be setup by device tree or
platform data.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index de63cba..d16bef3 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -746,10 +746,6 @@ static int mrf24j40_probe(struct spi_device *spi)
 	if (!devrec->buf)
 		goto err_register_device;
 
-	spi->mode = SPI_MODE_0; /* TODO: Is this appropriate for right here? */
-	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ)
-		spi->max_speed_hz = MAX_SPI_SPEED_HZ;
-
 	mutex_init(&devrec->buffer_mutex);
 	init_completion(&devrec->tx_complete);
 
-- 
2.5.0

