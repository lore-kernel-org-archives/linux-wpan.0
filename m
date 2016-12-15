Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:60652 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbcLORlF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 12:41:05 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 2/3] ieee802154: atusb: make sure we set a randaom extended address if fetching fails
Date: Thu, 15 Dec 2016 18:40:15 +0100
Message-Id: <1481823616-13402-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1481823616-13402-1-git-send-email-stefan@osg.samsung.com>
References: <1481823616-13402-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, marcel@holtmann.org, dan.carpenter@oracle.com, Stefan Schmidt <stefan@osg.samsung.com>

In the unlikely case were the firmware is new enough but the actual USB command
still fails make sure we set a random address and return.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index fa3e8c3..67790f8 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -737,8 +737,11 @@ static int atusb_set_extended_addr(struct atusb *atusb)
 	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
 				ATUSB_EUI64_READ, ATUSB_REQ_FROM_DEV, 0, 0,
 				buffer, IEEE802154_EXTENDED_ADDR_LEN, 1000);
-	if (ret < 0)
-		dev_err(&usb_dev->dev, "failed to fetch extended address\n");
+	if (ret < 0) {
+		dev_err(&usb_dev->dev, "failed to fetch extended address, random address set\n");
+		ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
+		return ret;
+	}
 
 	memcpy(&extended_addr, buffer, IEEE802154_EXTENDED_ADDR_LEN);
 	/* Check if read address is not empty and the unicast bit is set correctly */
-- 
2.5.5

