Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33128 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbcDGLQQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 07:16:16 -0400
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ieee802154/adf7242: fix memory leak of firmware
Date: Thu,  7 Apr 2016 16:46:04 +0530
Message-Id: <1460027764-27428-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <aar@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

If the firmware upload or the firmware verification fails then we
printed the error message and exited but we missed releasing the
firmware.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/net/ieee802154/adf7242.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 89154c0..91d4531 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1030,6 +1030,7 @@ static int adf7242_hw_init(struct adf7242_local *lp)
 	if (ret) {
 		dev_err(&lp->spi->dev,
 			"upload firmware failed with %d\n", ret);
+		release_firmware(fw);
 		return ret;
 	}
 
@@ -1037,6 +1038,7 @@ static int adf7242_hw_init(struct adf7242_local *lp)
 	if (ret) {
 		dev_err(&lp->spi->dev,
 			"verify firmware failed with %d\n", ret);
+		release_firmware(fw);
 		return ret;
 	}
 
-- 
1.9.1

