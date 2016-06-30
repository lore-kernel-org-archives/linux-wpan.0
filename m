Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55462 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752025AbcF3MPy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jun 2016 08:15:54 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv3 bluetooth-next 6/8] atusb: don't change csma settings while set channel
Date: Thu, 30 Jun 2016 13:55:54 +0200
Message-Id: <20160630115556.17515-7-aar@pengutronix.de>
In-Reply-To: <20160630115556.17515-1-aar@pengutronix.de>
References: <20160630115556.17515-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

This patch fixes the behaviour to not overwrite csma settings when
set channel afterwards.

Cc: Stefan Schmidt <stefan@osg.samsung.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 drivers/net/ieee802154/atusb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 52c9051..1056ed1 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -366,11 +366,7 @@ static int atusb_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	struct atusb *atusb = hw->priv;
 	int ret;
 
-	/* This implicitly sets the CCA (Clear Channel Assessment) mode to 0,
-	 * "Mode 3a, Carrier sense OR energy above threshold".
-	 * We should probably make this configurable. @@@
-	 */
-	ret = atusb_write_reg(atusb, RG_PHY_CC_CCA, channel);
+	ret = atusb_write_subreg(atusb, SR_CHANNEL, channel);
 	if (ret < 0)
 		return ret;
 	msleep(1);	/* @@@ ugly synchronization */
-- 
2.9.0

