Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38795 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbIUJZD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:03 -0400
Received: by wiclk2 with SMTP id lk2so102417038wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/22] mrf24j40: add default channel setting
Date: Mon, 21 Sep 2015 11:24:27 +0200
Message-Id: <1442827483-27975-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

Per default mrf24j40 has the channel 11 after reset. This patch adds the
right phy default value for the channel setting.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 89150bd..7c224cd 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -720,6 +720,11 @@ err_ret:
 	return ret;
 }
 
+static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
+{
+	devrec->hw->phy->current_channel = 11;
+}
+
 static int mrf24j40_probe(struct spi_device *spi)
 {
 	int ret = -ENOMEM;
@@ -759,6 +764,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	if (ret)
 		goto err_register_device;
 
+	mrf24j40_phy_setup(devrec);
+
 	ret = devm_request_threaded_irq(&spi->dev,
 					spi->irq,
 					NULL,
-- 
2.5.2

