Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55098 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbcLENzC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Dec 2016 08:55:02 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 2/4] ieee802154: atusb: store firmware version after retrieval for later use
Date: Mon,  5 Dec 2016 14:47:18 +0100
Message-Id: <1480945640-3571-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

The firmware versions will be used to enable selective features based on the
available firmware on the device. Make sure we do not need to fetch it for
every check but store it after the initial retrieval.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 322864a..9fdea64 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -58,6 +58,11 @@ struct atusb {
 	struct urb *tx_urb;
 	struct sk_buff *tx_skb;
 	uint8_t tx_ack_seq;		/* current TX ACK sequence number */
+
+	/* Firmware variable */
+	unsigned char fw_ver_maj;	/* Firmware major version number */
+	unsigned char fw_ver_min;	/* Firmware minor version number */
+	unsigned char fw_hw_type;	/* Firmware hardware type */
 };
 
 /* ----- USB commands without data ----------------------------------------- */
@@ -594,14 +599,19 @@ static int atusb_get_and_show_revision(struct atusb *atusb)
 	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
 				ATUSB_ID, ATUSB_REQ_FROM_DEV, 0, 0,
 				buffer, 3, 1000);
-	if (ret >= 0)
+	if (ret >= 0) {
+		atusb->fw_ver_maj = buffer[0];
+		atusb->fw_ver_min = buffer[1];
+		atusb->fw_hw_type = buffer[2];
+
 		dev_info(&usb_dev->dev,
 			 "Firmware: major: %u, minor: %u, hardware type: %u\n",
-			 buffer[0], buffer[1], buffer[2]);
-	if (buffer[0] == 0 && buffer[1] < 2) {
+			 atusb->fw_ver_maj, atusb->fw_ver_min, atusb->fw_hw_type);
+	}
+	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 2) {
 		dev_info(&usb_dev->dev,
-			 "Firmware version (%u.%u) is predates our first public release.",
-			 buffer[0], buffer[1]);
+			 "Firmware version (%u.%u) predates our first public release.",
+			 atusb->fw_ver_maj, atusb->fw_ver_min);
 		dev_info(&usb_dev->dev, "Please update to version 0.2 or newer");
 	}
 
-- 
2.5.5

