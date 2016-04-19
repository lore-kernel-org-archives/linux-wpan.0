Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44712 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbcDSOiI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Apr 2016 10:38:08 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 3/4] ieee802154: atusb: implement .set_cca_mode ops callback
Date: Tue, 19 Apr 2016 16:28:54 +0200
Message-Id: <1461076135-31540-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
References: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Catching up with the stack here and implement CCA mode setting.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 94f8457..72128b3 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -479,6 +479,39 @@ static const s32 atusb_ed_levels[ATUSB_MAX_ED_LEVELS + 1] = {
 };
 
 static int
+atusb_set_cca_mode(struct ieee802154_hw *hw, const struct wpan_phy_cca *cca)
+{
+	struct atusb *atusb = hw->priv;
+	u8 val;
+
+	/* mapping 802.15.4 to driver spec */
+	switch (cca->mode) {
+	case NL802154_CCA_ENERGY:
+		val = 1;
+		break;
+	case NL802154_CCA_CARRIER:
+		val = 2;
+		break;
+	case NL802154_CCA_ENERGY_CARRIER:
+		switch (cca->opt) {
+		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+			val = 3;
+			break;
+		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return atusb_write_subreg(atusb, SR_CCA_MODE, val);
+}
+
+static int
 atusb_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct atusb *atusb = hw->priv;
@@ -545,6 +578,7 @@ static struct ieee802154_ops atusb_ops = {
 	.stop			= atusb_stop,
 	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
 	.set_txpower		= atusb_set_txpower,
+	.set_cca_mode		= atusb_set_cca_mode,
 	.set_cca_ed_level	= atusb_set_cca_ed_level,
 	.set_csma_params	= atusb_set_csma_params,
 	.set_promiscuous_mode	= atusb_set_promiscuous_mode,
@@ -677,11 +711,19 @@ static int atusb_probe(struct usb_interface *interface,
 	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
 		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
 
-	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL;
+	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL |
+			 WPAN_PHY_FLAG_CCA_MODE;
+
+	hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
+		BIT(NL802154_CCA_CARRIER) | BIT(NL802154_CCA_ENERGY_CARRIER);
+	hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
+		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
 
 	hw->phy->supported.cca_ed_levels = atusb_ed_levels;
 	hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(atusb_ed_levels);
 
+	hw->phy->cca.mode = NL802154_CCA_ENERGY;
+
 	hw->phy->current_page = 0;
 	hw->phy->current_channel = 11;	/* reset default */
 	hw->phy->supported.channels[0] = 0x7FFF800;
-- 
2.5.0

