Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35494 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbEXMnf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 24 May 2015 08:43:35 -0400
Received: by wgfl8 with SMTP id l8so53228308wgf.2
        for <linux-wpan@vger.kernel.org>; Sun, 24 May 2015 05:43:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next] atusb: add support for at86rf230
Date: Sun, 24 May 2015 14:43:03 +0200
Message-Id: <1432471383-5029-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This patch adds support for the at86rf230 version check which is used
by the rzusb stick.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 1e18774..5b6bb9a 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -515,7 +515,7 @@ static int atusb_get_and_show_chip(struct atusb *atusb)
 			man_id_1, man_id_0);
 		goto fail;
 	}
-	if (part_num != 3) {
+	if (part_num != 3 && part_num != 2) {
 		dev_err(&usb_dev->dev,
 			"unexpected transceiver, part 0x%02x version 0x%02x\n",
 			part_num, version_num);
-- 
2.4.1

