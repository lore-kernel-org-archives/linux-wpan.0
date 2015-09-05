Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35263 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbIEK2i (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 5 Sep 2015 06:28:38 -0400
Received: by wicge5 with SMTP id ge5so38902417wic.0
        for <linux-wpan@vger.kernel.org>; Sat, 05 Sep 2015 03:28:37 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] atusb: add handling for different chipnames
Date: Sat,  5 Sep 2015 12:27:59 +0200
Message-Id: <1441448879-16511-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This patch supports handling for printout different chipnames between
atusb and rzusb. The rzusb contains an at86rf230 and atusb an at86rf231
transceiver.

Cc: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/atusb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 80dfc72..199a94a 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -559,6 +559,7 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
 {
 	struct usb_device *usb_dev = atusb->usb_dev;
 	uint8_t man_id_0, man_id_1, part_num, version_num;
+	const char *chip;
 
 	man_id_0 = atusb_read_reg(atusb, RG_MAN_ID_0);
 	man_id_1 = atusb_read_reg(atusb, RG_MAN_ID_1);
@@ -574,14 +575,22 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
 			man_id_1, man_id_0);
 		goto fail;
 	}
-	if (part_num != 3 && part_num != 2) {
+
+	switch (part_num) {
+	case 2:
+		chip = "AT86RF230";
+		break;
+	case 3:
+		chip = "AT86RF231";
+		break;
+	default:
 		dev_err(&usb_dev->dev,
 			"unexpected transceiver, part 0x%02x version 0x%02x\n",
 			part_num, version_num);
 		goto fail;
 	}
 
-	dev_info(&usb_dev->dev, "ATUSB: AT86RF231 version %d\n", version_num);
+	dev_info(&usb_dev->dev, "ATUSB: %s version %d\n", chip, version_num);
 
 	return 0;
 
-- 
2.5.1

