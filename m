Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46315 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLZEsE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Dec 2014 23:48:04 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so12600794pac.36
        for <linux-wpan@vger.kernel.org>; Thu, 25 Dec 2014 20:48:03 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/3] cc2520: use devm_kzalloc(.., sizeof(*pointer), ..) pattern
Date: Fri, 26 Dec 2014 10:13:38 +0530
Message-Id: <1419569020-5410-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1419569020-5410-1-git-send-email-varkab@cdac.in>
References: <1419569020-5410-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index c2b7da3..c2e725e 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -845,8 +845,7 @@ static int cc2520_probe(struct spi_device *spi)
 	struct cc2520_platform_data *pdata;
 	int ret;
 
-	priv = devm_kzalloc(&spi->dev,
-			    sizeof(struct cc2520_private), GFP_KERNEL);
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
 		goto err_ret;
-- 
1.7.9.5

