Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33261 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097AbbIUJY6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:24:58 -0400
Received: by wiclk2 with SMTP id lk2so136946158wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:24:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/22] mrf24j40: use ieee802154_alloc_hw for private data
Date: Mon, 21 Sep 2015 11:24:23 +0200
Message-Id: <1442827483-27975-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch removes the own private dataroom allocation by calling
devm_kzalloc for devrec and assign this pointer to "devrec->hw->priv".
Instead we using like all other drivers ieee802154_alloc_hw and give the
size for the private driver dataroom at the first argument.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 2b7fc00..1023cd2 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -723,16 +723,28 @@ err_ret:
 static int mrf24j40_probe(struct spi_device *spi)
 {
 	int ret = -ENOMEM;
+	struct ieee802154_hw *hw;
 	struct mrf24j40 *devrec;
 
 	dev_info(&spi->dev, "probe(). IRQ: %d\n", spi->irq);
 
-	devrec = devm_kzalloc(&spi->dev, sizeof(struct mrf24j40), GFP_KERNEL);
-	if (!devrec)
+	/* Register with the 802154 subsystem */
+
+	hw = ieee802154_alloc_hw(sizeof(*devrec), &mrf24j40_ops);
+	if (!hw)
 		goto err_ret;
+
+	devrec = hw->priv;
+	devrec->spi = spi;
+	spi_set_drvdata(spi, devrec);
+	devrec->hw = hw;
+	devrec->hw->parent = &spi->dev;
+	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
+	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
+
 	devrec->buf = devm_kzalloc(&spi->dev, 3, GFP_KERNEL);
 	if (!devrec->buf)
-		goto err_ret;
+		goto err_register_device;
 
 	spi->mode = SPI_MODE_0; /* TODO: Is this appropriate for right here? */
 	if (spi->max_speed_hz > MAX_SPI_SPEED_HZ)
@@ -740,19 +752,6 @@ static int mrf24j40_probe(struct spi_device *spi)
 
 	mutex_init(&devrec->buffer_mutex);
 	init_completion(&devrec->tx_complete);
-	devrec->spi = spi;
-	spi_set_drvdata(spi, devrec);
-
-	/* Register with the 802154 subsystem */
-
-	devrec->hw = ieee802154_alloc_hw(0, &mrf24j40_ops);
-	if (!devrec->hw)
-		goto err_ret;
-
-	devrec->hw->priv = devrec;
-	devrec->hw->parent = &devrec->spi->dev;
-	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
-	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
 
 	dev_dbg(printdev(devrec), "registered mrf24j40\n");
 	ret = ieee802154_register_hw(devrec->hw);
-- 
2.5.2

