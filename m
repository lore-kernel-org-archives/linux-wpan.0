Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:57030 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936866AbdAGATL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2017 19:19:11 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth 3/5] ieee802154: atusb: do not use the stack for address fetching to make it DMA able
Date: Sat,  7 Jan 2017 01:18:55 +0100
Message-Id: <1483748337-4862-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
References: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

 From 4.9 we should really avoid using the stack here as this will not be DMA
able on various platforms. This changes a buffer that was introduced in the
4.10 merge window.

Fixes: 6cc33eba232c ("ieee802154: atusb: try to read permanent extended
address from device")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 67790f8..63cb679 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -721,7 +721,7 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
 static int atusb_set_extended_addr(struct atusb *atusb)
 {
 	struct usb_device *usb_dev = atusb->usb_dev;
-	unsigned char buffer[IEEE802154_EXTENDED_ADDR_LEN];
+	unsigned char *buffer;
 	__le64 extended_addr;
 	u64 addr;
 	int ret;
@@ -733,6 +733,10 @@ static int atusb_set_extended_addr(struct atusb *atusb)
 		return 0;
 	}
 
+	buffer = kmalloc(IEEE802154_EXTENDED_ADDR_LEN, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
 	/* Firmware is new enough so we fetch the address from EEPROM */
 	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
 				ATUSB_EUI64_READ, ATUSB_REQ_FROM_DEV, 0, 0,
@@ -740,6 +744,7 @@ static int atusb_set_extended_addr(struct atusb *atusb)
 	if (ret < 0) {
 		dev_err(&usb_dev->dev, "failed to fetch extended address, random address set\n");
 		ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
+		kfree(buffer);
 		return ret;
 	}
 
@@ -755,6 +760,7 @@ static int atusb_set_extended_addr(struct atusb *atusb)
 			&addr);
 	}
 
+	kfree(buffer);
 	return ret;
 }
 
-- 
2.5.5

