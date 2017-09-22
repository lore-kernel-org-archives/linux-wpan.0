Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54859 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbdIVMOW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 06/14] ieee802154: atusb: fix some kernel coding style errors
Date: Fri, 22 Sep 2017 14:13:57 +0200
Message-Id: <20170922121405.31789-7-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Fix a long line, wrong comment format and misaligned indent.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index bb02e37257cf..13d8ee5df094 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -841,7 +841,8 @@ static int atusb_get_and_show_revision(struct atusb *atusb)
 
 		dev_info(&usb_dev->dev,
 			 "Firmware: major: %u, minor: %u, hardware type: %s (%d)\n",
-			 atusb->fw_ver_maj, atusb->fw_ver_min, hw_name, atusb->fw_hw_type);
+			 atusb->fw_ver_maj, atusb->fw_ver_min, hw_name,
+			 atusb->fw_hw_type);
 	}
 	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 2) {
 		dev_info(&usb_dev->dev,
@@ -976,7 +977,8 @@ static int atusb_set_extended_addr(struct atusb *atusb)
 	int ret;
 
 	/* Firmware versions before 0.3 do not support the EUI64_READ command.
-	 * Just use a random address and be done */
+	 * Just use a random address and be done.
+	 */
 	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 3) {
 		ieee802154_random_extended_addr(&atusb->hw->phy->perm_extended_addr);
 		return 0;
@@ -1006,7 +1008,7 @@ static int atusb_set_extended_addr(struct atusb *atusb)
 		atusb->hw->phy->perm_extended_addr = extended_addr;
 		addr = swab64((__force u64)atusb->hw->phy->perm_extended_addr);
 		dev_info(&usb_dev->dev, "Read permanent extended address %8phC from device\n",
-			&addr);
+			 &addr);
 	}
 
 	kfree(buffer);
-- 
2.13.5

