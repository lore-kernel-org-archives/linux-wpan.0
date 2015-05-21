Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38204 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbbEUO6W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 10:58:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK enabled in hardware.
Date: Thu, 21 May 2015 16:51:36 +0200
Message-Id: <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Since firmware version 0.2 we use AACK handling directly in the firmware.
Inform the stack that the hardware supports and uses it.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 9d07dd7..eef1d8a 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -568,7 +568,8 @@ static int atusb_probe(struct usb_interface *interface,
 		goto fail;
 
 	hw->parent = &usb_dev->dev;
-	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
+	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
+		    IEEE802154_HW_AACK;
 
 	hw->phy->current_page = 0;
 	hw->phy->current_channel = 11;	/* reset default */
-- 
2.1.0

