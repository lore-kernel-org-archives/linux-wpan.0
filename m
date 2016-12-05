Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55094 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcLENzC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Dec 2016 08:55:02 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 3/4] ieee802154: atusb: try to read permanent extended address from device
Date: Mon,  5 Dec 2016 14:47:19 +0100
Message-Id: <1480945640-3571-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

With version 0.3 the atusb firmware offers an interface to read a permanent
EUI64 address from the devices EEPROM. This patch checks if the firmware is
new enough and tries to read out and use the address. If this does not work
we fall back to the original randomly generated address.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 9fdea64..3ed34cc 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -679,6 +679,43 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
 	return -ENODEV;
 }
 
+static int atusb_set_extended_addr(struct atusb *atusb)
+{
+	struct usb_device *usb_dev = atusb->usb_dev;
+	unsigned char buffer[IEEE802154_EXTENDED_ADDR_LEN];
+	__le64 extended_addr;
+	u64 addr;
+	int ret;
+
+	/* Firmware versions before 0.3 do not support the EUI64_READ command.
+	 * Just use a random address and be done */
+	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 3) {
+		ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
+		return 0;
+	}
+
+	/* Firmware is new enough so we fetch the address from EEPROM */
+	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
+				ATUSB_EUI64_READ, ATUSB_REQ_FROM_DEV, 0, 0,
+				buffer, IEEE802154_EXTENDED_ADDR_LEN, 1000);
+	if (ret < 0)
+		dev_err(&usb_dev->dev, "failed to fetch extended address\n");
+
+	memcpy(&extended_addr, buffer, IEEE802154_EXTENDED_ADDR_LEN);
+	/* Check if read address is not empty and the unicast bit is set correctly */
+	if (!ieee802154_is_valid_extended_unicast_addr(extended_addr)) {
+		dev_info(&usb_dev->dev, "no permanent extended address found, random address set\n");
+		ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
+	} else {
+		atusb->hw->phy->perm_extended_addr = extended_addr;
+		addr = swab64((__force u64)atusb->hw->phy->perm_extended_addr);
+		dev_info(&usb_dev->dev, "Read permanent extended address %8phC from device\n",
+			&addr);
+	}
+
+	return ret;
+}
+
 /* ----- Setup ------------------------------------------------------------- */
 
 static int atusb_probe(struct usb_interface *interface,
@@ -738,13 +775,14 @@ static int atusb_probe(struct usb_interface *interface,
 	hw->phy->supported.tx_powers = atusb_powers;
 	hw->phy->supported.tx_powers_size = ARRAY_SIZE(atusb_powers);
 	hw->phy->transmit_power = hw->phy->supported.tx_powers[0];
-	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
 	hw->phy->cca_ed_level = hw->phy->supported.cca_ed_levels[7];
 
 	atusb_command(atusb, ATUSB_RF_RESET, 0);
 	atusb_get_and_show_chip(atusb);
 	atusb_get_and_show_revision(atusb);
 	atusb_get_and_show_build(atusb);
+	atusb_set_extended_addr(atusb);
+
 	ret = atusb_get_and_clear_error(atusb);
 	if (ret) {
 		dev_err(&atusb->usb_dev->dev,
-- 
2.5.5

