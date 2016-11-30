Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:52081 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757305AbcK3ODk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 09:03:40 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 4/5] ieee802154: fakelb: print number of created fake devices during probe
Date: Wed, 30 Nov 2016 15:03:24 +0100
Message-Id: <1480514605-30926-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
References: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

When using fakelb with different network sizes it becomes handy to have the
number of created fake devices printed in the log as well.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/fakelb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index ec387ef..0d673f7 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -218,7 +218,7 @@ static int fakelb_probe(struct platform_device *pdev)
 			goto err_slave;
 	}
 
-	dev_info(&pdev->dev, "added ieee802154 hardware\n");
+	dev_info(&pdev->dev, "added %i fake ieee802154 hardware devices\n", numlbs);
 	return 0;
 
 err_slave:
-- 
2.5.5

