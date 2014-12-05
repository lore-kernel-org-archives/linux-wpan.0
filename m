Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57300 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaLELx3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 06:53:29 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so565085pab.19
        for <linux-wpan@vger.kernel.org>; Fri, 05 Dec 2014 03:53:29 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 2/2] cc2520: adds terminating newline
Date: Fri,  5 Dec 2014 17:19:10 +0530
Message-Id: <1417780150-4033-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1417780150-4033-1-git-send-email-varkab@cdac.in>
References: <1417780150-4033-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index ccbb082..f9df9fa 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -858,7 +858,7 @@ static int cc2520_probe(struct spi_device *spi)
 	pinctrl = devm_pinctrl_get_select_default(&spi->dev);
 	if (IS_ERR(pinctrl))
 		dev_warn(&spi->dev,
-			 "pinctrl pins are not configured");
+			 "pinctrl pins are not configured\n");
 
 	pdata = cc2520_get_platform_data(spi);
 	if (!pdata) {
-- 
1.7.9.5

