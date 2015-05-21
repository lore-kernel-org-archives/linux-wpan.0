Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38206 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbbEUO6W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 10:58:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154/atusb: Warn about outdated device firmware.
Date: Thu, 21 May 2015 16:51:35 +0200
Message-Id: <1432219897-29528-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Together with mainlining the driver we released a first public binary version
of the device firmware. This is version 0.2. With this change we warn users
who run outdated versions of the firmware. While we have not seen problems
with it yet (thus no error, but a warning only) it would be better to run the
released and tested firmware. You can find released versions here:

http://downloads.qi-hardware.com/people/werner/wpan/web/
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index ea1259e..9d07dd7 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -469,6 +469,12 @@ static int atusb_get_and_show_revision(struct atusb *atusb)
 		dev_info(&usb_dev->dev,
 			 "Firmware: major: %u, minor: %u, hardware type: %u\n",
 			 buffer[0], buffer[1], buffer[2]);
+	if (buffer[0] == 0 && buffer[1] < 2) {
+		dev_info(&usb_dev->dev,
+			 "Firmware version (%u.%u) is predates our first public release.",
+			 buffer[0], buffer[1]);
+		dev_info(&usb_dev->dev, "Please update to version 0.2 or newer");
+	}
 
 	return ret;
 }
-- 
2.1.0

