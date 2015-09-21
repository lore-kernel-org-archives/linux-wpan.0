Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37763 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333AbbIUJZJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:09 -0400
Received: by wicfx3 with SMTP id fx3so102107208wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/22] mrf24j40: change to frame delivery with crc
Date: Mon, 21 Sep 2015 11:24:32 +0200
Message-Id: <1442827483-27975-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch changes the frame delivery to mac802154 with crc. This is
useful for monitor interface types which deliver the crc to userspace.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index ca98b5c..788adb6 100644
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
2.5.2

