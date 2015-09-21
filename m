Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36215 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375AbbIUJZU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:20 -0400
Received: by wicgb1 with SMTP id gb1so105780523wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 20/22] mrf24j40: add promiscuous mode support
Date: Mon, 21 Sep 2015 11:24:41 +0200
Message-Id: <1442827483-27975-21-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch adds support for promiscuous mode by setting promiscuous (no
frame filtering), disable automatic ack handling and not filtering
frames where the crc is invalid.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 91687c1..146ad57 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -923,6 +923,24 @@ static int mrf24j40_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 	return regmap_update_bits(devrec->regmap_long, REG_RFCON3, 0xf8, val);
 }
 
+static int mrf24j40_set_promiscuous_mode(struct ieee802154_hw *hw, bool on)
+{
+	struct mrf24j40 *devrec = hw->priv;
+	int ret;
+
+	if (on) {
+		/* set PROMI, ERRPKT and NOACKRSP */
+		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x23,
+					 0x23);
+	} else {
+		/* clear PROMI, ERRPKT and NOACKRSP */
+		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x23,
+					 0x00);
+	}
+
+	return ret;
+}
+
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = mrf24j40_tx,
@@ -935,6 +953,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
 	.set_cca_mode = mrf24j40_set_cca_mode,
 	.set_cca_ed_level = mrf24j40_set_cca_ed_level,
 	.set_txpower = mrf24j40_set_txpower,
+	.set_promiscuous_mode = mrf24j40_set_promiscuous_mode,
 };
 
 static void mrf24j40_intstat_complete(void *context)
@@ -1182,7 +1201,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->parent = &spi->dev;
 	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
 	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
-			    IEEE802154_HW_CSMA_PARAMS;
+			    IEEE802154_HW_CSMA_PARAMS |
+			    IEEE802154_HW_PROMISCUOUS;
 
 	devrec->hw->phy->flags = WPAN_PHY_FLAG_CCA_MODE |
 				 WPAN_PHY_FLAG_CCA_ED_LEVEL;
-- 
2.5.2

