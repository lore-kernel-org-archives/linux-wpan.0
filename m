Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36563 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbEQTp7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:59 -0400
Received: by wgbhc8 with SMTP id hc8so132756800wgb.3
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 23/34] fakelb: use list_for_each_entry_safe
Date: Sun, 17 May 2015 21:44:59 +0200
Message-Id: <1431891910-32231-24-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

Iterate and removing items from a list, we should use
list_for_each_entry_safe instead list_for_each_entry to avoid accidents
by removing.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index cc1c7df..66f99c4 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -215,7 +215,7 @@ static void fakelb_del(struct fakelb_dev_priv *priv)
 static int fakelb_probe(struct platform_device *pdev)
 {
 	struct fakelb_priv *priv;
-	struct fakelb_dev_priv *dp;
+	struct fakelb_dev_priv *dp, *tmp;
 	int err = -ENOMEM;
 	int i;
 
@@ -238,7 +238,7 @@ static int fakelb_probe(struct platform_device *pdev)
 	return 0;
 
 err_slave:
-	list_for_each_entry(dp, &priv->list, list)
+	list_for_each_entry_safe(dp, tmp, &priv->list, list)
 		fakelb_del(dp);
 err_alloc:
 	return err;
-- 
2.3.7

