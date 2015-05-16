Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34607 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbbEPP1C (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:02 -0400
Received: by wicmc15 with SMTP id mc15so59038449wic.1
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 02/13] fakelb: use list_for_each_entry_safe
Date: Sat, 16 May 2015 17:26:06 +0200
Message-Id: <1431789977-31393-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

Iterate and removing items from a list, we should use
list_for_each_entry_safe instead list_for_each_entry to avoid accidents
by removing.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 0fe42b0..43b0336 100644
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

