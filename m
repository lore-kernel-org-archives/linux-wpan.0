Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48582 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621AbbE2Ivl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:51:41 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCHv2 bluetooth-next 3/4] ieee802154/atusb: Add .set_promiscuous_mode driver operation
Date: Fri, 29 May 2015 10:51:27 +0200
Message-Id: <1432889488-28420-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Allow monitor mode operation with disabled AACK in hardware.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 9805ebe..3d25678 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -473,6 +473,33 @@ atusb_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 	return -EINVAL;
 }
 
+static int
+atusb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
+{
+	struct atusb *atusb = hw->priv;
+	int ret;
+
+	if (on) {
+		ret = atusb_write_subreg(atusb, SR_AACK_DIS_ACK, 1);
+		if (ret < 0)
+			return ret;
+
+		ret = atusb_write_subreg(atusb, SR_AACK_PROM_MODE, 1);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = atusb_write_subreg(atusb, SR_AACK_PROM_MODE, 0);
+		if (ret < 0)
+			return ret;
+
+		ret = atusb_write_subreg(atusb, SR_AACK_DIS_ACK, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static struct ieee802154_ops atusb_ops = {
 	.owner			= THIS_MODULE,
 	.xmit_async		= atusb_xmit,
@@ -482,6 +509,7 @@ static struct ieee802154_ops atusb_ops = {
 	.stop			= atusb_stop,
 	.set_hw_addr_filt	= atusb_set_hw_addr_filt,
 	.set_txpower		= atusb_set_txpower,
+	.set_promiscuous_mode	= atusb_set_promiscuous_mode,
 };
 
 /* ----- Firmware and chip version information ----------------------------- */
@@ -600,7 +628,7 @@ static int atusb_probe(struct usb_interface *interface,
 
 	hw->parent = &usb_dev->dev;
 	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
-		    IEEE802154_HW_AACK;
+		    IEEE802154_HW_AACK | IEEE802154_HW_PROMISCUOUS;
 
 	hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
 
-- 
2.1.0

