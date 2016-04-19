Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44711 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbcDSOiJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Apr 2016 10:38:09 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 1/4] ieee802154: atusb: implement .set_csma_params ops callback
Date: Tue, 19 Apr 2016 16:28:52 +0200
Message-Id: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Catching up with the stack here and implement CSMA parameter setting.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index b1cd865..2d8de9f 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -473,6 +473,23 @@ atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 }
 
 static int
+atusb_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be, u8 retries)
+{
+	struct atusb *atusb = hw->priv;
+	int ret;
+
+	ret = atusb_write_subreg(atusb, SR_MIN_BE, min_be);
+	if (ret)
+		return ret;
+
+	ret = atusb_write_subreg(atusb, SR_MAX_BE, max_be);
+	if (ret)
+		return ret;
+
+	return atusb_write_subreg(atusb, SR_MAX_CSMA_RETRIES, retries);
+}
+
+static int
 atusb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
 {
 	struct atusb *atusb = hw->priv;
@@ -508,6 +525,7 @@ static struct ieee802154_ops atusb_ops = {
 	.stop			= atusb_stop,
 	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
 	.set_txpower		= atusb_set_txpower,
+	.set_csma_params	= atusb_set_csma_params,
 	.set_promiscuous_mode	= atusb_set_promiscuous_mode,
 };
 
@@ -636,7 +654,7 @@ static int atusb_probe(struct usb_interface *interface,
 
 	hw->parent = &usb_dev->dev;
 	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
-		    IEEE802154_HW_PROMISCUOUS;
+		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
 
 	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
 
-- 
2.5.0

