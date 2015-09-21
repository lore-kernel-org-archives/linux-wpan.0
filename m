Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33889 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbIUJZB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:01 -0400
Received: by wicfx3 with SMTP id fx3so136436784wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/22] mrf24j40: remove spi settings overwrite
Date: Mon, 21 Sep 2015 11:24:25 +0200
Message-Id: <1442827483-27975-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch removes spi settings while mrf24j40 probing. These settings
cannot be overwrite while device probing where spi controller should be
already configured. These settings need to be setup by device tree or
platform data.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index de63cba..41d9f57 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -746,9 +746,11 @@ static int mrf24j40_probe(struct spi_device *spi)
 	if (!devrec->buf)
 		goto err_register_device;
 
-	spi->mode = SPI_MODE_0; /* TODO: Is this appropriate for right here? */
-	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ)
-		spi->max_speed_hz = MAX_SPI_SPEED_HZ;
+	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ) {
+		dev_warn(&spi->dev, "spi clock above possible maximum: %d",
+			 MAX_SPI_SPEED_HZ);
+		return -EINVAL;
+	}
 
 	mutex_init(&devrec->buffer_mutex);
 	init_completion(&devrec->tx_complete);
-- 
2.5.2

