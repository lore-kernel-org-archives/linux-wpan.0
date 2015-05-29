Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48578 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbbE2Ivl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:51:41 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCHv2 bluetooth-next 2/4] ieee802154/atusb: Add .set_txpower operation to the driver
Date: Fri, 29 May 2015 10:51:26 +0200
Message-Id: <1432889488-28420-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Atusb uses the at86rf231 transceiver so we can use the same calculation
for txpower settings for it.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 95d4220..9805ebe 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -453,6 +453,26 @@ static void atusb_stop(struct ieee802154_hw *hw)
 	atusb_get_and_clear_error(atusb);
 }
 
+#define ATUSB_MAX_TX_POWERS 0xF
+static const s32 atusb_powers[ATUSB_MAX_TX_POWERS + 1] = {
+	300, 280, 230, 180, 130, 70, 0, -100, -200, -300, -400, -500, -700,
+	-900, -1200, -1700,
+};
+
+static int
+atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct atusb *atusb = hw->priv;
+	u32 i;
+
+	for (i = 0; i < hw->phy->supported.tx_powers_size; i++) {
+		if (hw->phy->supported.tx_powers[i] == mbm)
+			return atusb_write_subreg(atusb, SR_TX_PWR_23X, i);
+	}
+
+	return -EINVAL;
+}
+
 static struct ieee802154_ops atusb_ops = {
 	.owner			= THIS_MODULE,
 	.xmit_async		= atusb_xmit,
@@ -461,6 +481,7 @@ static struct ieee802154_ops atusb_ops = {
 	.start			= atusb_start,
 	.stop			= atusb_stop,
 	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
+	.set_txpower		= atusb_set_txpower,
 };
 
 /* ----- Firmware and chip version information ----------------------------- */
@@ -581,9 +602,14 @@ static int atusb_probe(struct usb_interface *interface,
 	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
 		    IEEE802154_HW_AACK;
 
+	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
+
 	hw->phy->current_page = 0;
 	hw->phy->current_channel = 11;	/* reset default */
 	hw->phy->supported.channels[0] = 0x7FFF800;
+	hw->phy->supported.tx_powers = atusb_powers;
+	hw->phy->supported.tx_powers_size = ARRAY_SIZE(atusb_powers);
+	hw->phy->transmit_power = hw->phy->supported.tx_powers[0];
 	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
 
 	atusb_command(atusb, ATUSB_RF_RESET, 0);
-- 
2.1.0

