Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38136 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbbIUJZR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:17 -0400
Received: by wiclk2 with SMTP id lk2so102426344wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 17/22] mrf24j40: add cca mode support
Date: Mon, 21 Sep 2015 11:24:38 +0200
Message-Id: <1442827483-27975-18-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch supports cca mode handling for mrf24j40.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index fe7991d..086eee0 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -791,6 +791,37 @@ mrf24j40_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
 	return regmap_update_bits(devrec->regmap_short, REG_TXMCR, 0x1f, val);
 }
 
+static int mrf24j40_set_cca_mode(struct ieee802154_hw *hw,
+				 const struct wpan_phy_cca *cca)
+{
+	struct mrf24j40 *devrec = hw->priv;
+	u8 val;
+
+	/* mapping 802.15.4 to driver spec */
+	switch (cca->mode) {
+	case NL802154_CCA_ENERGY:
+		val = 2;
+		break;
+	case NL802154_CCA_CARRIER:
+		val = 1;
+		break;
+	case NL802154_CCA_ENERGY_CARRIER:
+		switch (cca->opt) {
+		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+			val = 3;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(devrec->regmap_short, REG_BBREG2, 0xc0,
+				  val << 6);
+}
+
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = mrf24j40_tx,
@@ -800,6 +831,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
 	.set_channel = mrf24j40_set_channel,
 	.set_hw_addr_filt = mrf24j40_filter,
 	.set_csma_params = mrf24j40_csma_params,
+	.set_cca_mode = mrf24j40_set_cca_mode,
 };
 
 static void mrf24j40_intstat_complete(void *context)
@@ -1003,6 +1035,12 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 	 */
 	devrec->hw->phy->supported.min_maxbe = 5;
 	devrec->hw->phy->supported.max_maxbe = 5;
+
+	devrec->hw->phy->cca.mode = NL802154_CCA_CARRIER;;
+	devrec->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
+					       BIT(NL802154_CCA_CARRIER) |
+					       BIT(NL802154_CCA_ENERGY_CARRIER);
+	devrec->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND);
 }
 
 static int mrf24j40_probe(struct spi_device *spi)
@@ -1028,6 +1066,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
 			    IEEE802154_HW_CSMA_PARAMS;
 
+	devrec->hw->phy->flags = WPAN_PHY_FLAG_CCA_MODE;
+
 	mrf24j40_setup_tx_spi_messages(devrec);
 	mrf24j40_setup_rx_spi_messages(devrec);
 	mrf24j40_setup_irq_spi_messages(devrec);
-- 
2.5.2

