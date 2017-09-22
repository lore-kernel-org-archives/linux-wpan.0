Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54677 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdIVIvO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 04:51:14 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH] ieee802154: atusb: fix firmware version check to enable frame retries
Date: Fri, 22 Sep 2017 10:44:57 +0200
Message-Id: <20170922084457.30497-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, Stefan Schmidt <stefan@osg.samsung.com>

Geert reported: as fw_ver_maj is unsigned char, gcc 4.1.2 complains:

warning: comparison is always true due to limited range of data type

Besides the warning the old check would also fail for firmware versions
like 1.x with x < 3. These would support frame retries, but the driver
would not enable the feature.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 115fa3f37a86..6b3cdf4bd667 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -1060,7 +1060,7 @@ static int atusb_probe(struct usb_interface *interface,
 	atusb_get_and_show_build(atusb);
 	atusb_set_extended_addr(atusb);
 
-	if (atusb->fw_ver_maj >= 0 && atusb->fw_ver_min >= 3)
+	if ((atusb->fw_ver_maj == 0 && atusb->fw_ver_min >= 3) || atusb->fw_ver_maj > 0)
 		hw->flags |= IEEE802154_HW_FRAME_RETRIES;
 
 	ret = atusb_get_and_clear_error(atusb);
-- 
2.13.5

