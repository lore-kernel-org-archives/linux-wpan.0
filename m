Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44713 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbcDSOiN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Apr 2016 10:38:13 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 2/4] ieee802154: atusb: implement .set_cca_ed_level ops callback
Date: Tue, 19 Apr 2016 16:28:53 +0200
Message-Id: <1461076135-31540-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
References: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Catching up with the stack here and implement CCA ED level setting.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 2d8de9f..94f8457 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -472,6 +472,26 @@ atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 	return -EINVAL;
 }
 
+#define ATUSB_MAX_ED_LEVELS 0xF
+static const s32 atusb_ed_levels[ATUSB_MAX_ED_LEVELS + 1] = {
+	-9100, -8900, -8700, -8500, -8300, -8100, -7900, -7700, -7500, -7300,
+	-7100, -6900, -6700, -6500, -6300, -6100,
+};
+
+static int
+atusb_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct atusb *atusb = hw->priv;
+	u32 i;
+
+	for (i = 0; i < hw->phy->supported.cca_ed_levels_size; i++) {
+		if (hw->phy->supported.cca_ed_levels[i] == mbm)
+			return atusb_write_subreg(atusb, SR_CCA_ED_THRES, i);
+	}
+
+	return -EINVAL;
+}
+
 static int
 atusb_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be, u8 retries)
 {
@@ -525,6 +545,7 @@ static struct ieee802154_ops atusb_ops = {
 	.stop			= atusb_stop,
 	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
 	.set_txpower		= atusb_set_txpower,
+	.set_cca_ed_level	= atusb_set_cca_ed_level,
 	.set_csma_params	= atusb_set_csma_params,
 	.set_promiscuous_mode	= atusb_set_promiscuous_mode,
 };
@@ -656,7 +677,10 @@ static int atusb_probe(struct usb_interface *interface,
 	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
 		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
 
-	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
+	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL;
+
+	hw->phy->supported.cca_ed_levels = atusb_ed_levels;
+	hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(atusb_ed_levels);
 
 	hw->phy->current_page = 0;
 	hw->phy->current_channel = 11;	/* reset default */
@@ -665,6 +689,7 @@ static int atusb_probe(struct usb_interface *interface,
 	hw->phy->supported.tx_powers_size = ARRAY_SIZE(atusb_powers);
 	hw->phy->transmit_power = hw->phy->supported.tx_powers[0];
 	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
+	hw->phy->cca_ed_level = hw->phy->supported.cca_ed_levels[7];
 
 	atusb_command(atusb, ATUSB_RF_RESET, 0);
 	atusb_get_and_show_chip(atusb);
-- 
2.5.0

