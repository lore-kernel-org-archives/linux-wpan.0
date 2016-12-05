Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55095 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbcLENzC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Dec 2016 08:55:02 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 4/4] ieee802154: atusb: implement .set_frame_retries ops callback
Date: Mon,  5 Dec 2016 14:47:20 +0100
Message-Id: <1480945640-3571-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

 From firmware version 0.3 onwards we use the TX_ARET mode allowing for automatic
frame retransmissions. To actually make use of this feature we need to implement
the callback for setting the frame retries.

If the firmware version is to old print a warning and return with invalid value.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 3ed34cc..1253f86 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -546,6 +546,21 @@ atusb_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be, u8 retries
 }
 
 static int
+atusb_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
+{
+	struct atusb *atusb = hw->priv;
+	struct device *dev = &atusb->usb_dev->dev;
+
+	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 3) {
+		dev_info(dev, "Automatic frame retransmission is only available from "
+			"firmware version 0.3. Please update if you want this feature.");
+		return -EINVAL;
+	}
+
+	return atusb_write_subreg(atusb, SR_MAX_FRAME_RETRIES, retries);
+}
+
+static int
 atusb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
 {
 	struct atusb *atusb = hw->priv;
@@ -584,6 +599,7 @@ static const struct ieee802154_ops atusb_ops = {
 	.set_cca_mode		= atusb_set_cca_mode,
 	.set_cca_ed_level	= atusb_set_cca_ed_level,
 	.set_csma_params	= atusb_set_csma_params,
+	.set_frame_retries	= atusb_set_frame_retries,
 	.set_promiscuous_mode	= atusb_set_promiscuous_mode,
 };
 
@@ -754,7 +770,8 @@ static int atusb_probe(struct usb_interface *interface,
 
 	hw->parent = &usb_dev->dev;
 	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
-		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
+		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS |
+		    IEEE802154_HW_FRAME_RETRIES;
 
 	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER | WPAN_PHY_FLAG_CCA_ED_LEVEL |
 			 WPAN_PHY_FLAG_CCA_MODE;
-- 
2.5.5

