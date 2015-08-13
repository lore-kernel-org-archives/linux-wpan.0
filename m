Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33024 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbHMMXb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:31 -0400
Received: by wijp15 with SMTP id p15so256374075wij.0
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:30 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 11/21] mrf24j40: change to frame delivery with crc
Date: Thu, 13 Aug 2015 14:22:38 +0200
Message-Id: <1439468568-22288-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch changes the frame delivery to mac802154 with crc. This is
useful for monitor interface types which deliver the crc to userspace.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 32de5d6..7e6a038 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -881,9 +881,6 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 		goto out;
 	}
 
-	/* Cut off the checksum */
-	skb_trim(skb, len-2);
-
 	/* TODO: Other drivers call ieee20154_rx_irqsafe() here (eg: cc2040,
 	 * also from a workqueue).  I think irqsafe is not necessary here.
 	 * Can someone confirm? */
@@ -1060,7 +1057,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw = hw;
 	devrec->hw->parent = &spi->dev;
 	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
-	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AFILT;
+	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
 
 	devrec->regmap_short = devm_regmap_init_spi(spi,
 						    &mrf24j40_short_regmap);
-- 
2.5.0

