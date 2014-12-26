Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38512 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLZEsH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Dec 2014 23:48:07 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so12391580pdb.5
        for <linux-wpan@vger.kernel.org>; Thu, 25 Dec 2014 20:48:06 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 2/3] cc2520: remove 'ret' goto label
Date: Fri, 26 Dec 2014 10:13:39 +0530
Message-Id: <1419569020-5410-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1419569020-5410-1-git-send-email-varkab@cdac.in>
References: <1419569020-5410-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

If allocation of memory fails instead of going to ret goto label
and returning from there, we can directly return -ENOMEM on failure.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index c2e725e..8344260 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -846,10 +846,8 @@ static int cc2520_probe(struct spi_device *spi)
 	int ret;
 
 	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto err_ret;
-	}
+	if (!priv)
+		return -ENOMEM;
 
 	spi_set_drvdata(spi, priv);
 
@@ -868,10 +866,8 @@ static int cc2520_probe(struct spi_device *spi)
 
 	priv->buf = devm_kzalloc(&spi->dev,
 				 SPI_COMMAND_BUFFER, GFP_KERNEL);
-	if (!priv->buf) {
-		ret = -ENOMEM;
-		goto err_ret;
-	}
+	if (!priv->buf)
+		return -ENOMEM;
 
 	mutex_init(&priv->buffer_mutex);
 	INIT_WORK(&priv->fifop_irqwork, cc2520_fifop_irqwork);
@@ -988,8 +984,6 @@ static int cc2520_probe(struct spi_device *spi)
 err_hw_init:
 	mutex_destroy(&priv->buffer_mutex);
 	flush_work(&priv->fifop_irqwork);
-
-err_ret:
 	return ret;
 }
 
-- 
1.7.9.5

