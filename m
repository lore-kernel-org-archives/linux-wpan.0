Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33833 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbEQTqE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:46:04 -0400
Received: by wguv19 with SMTP id v19so104444981wgu.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:46:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 28/34] fakelb: move lock out of iteration
Date: Sun, 17 May 2015 21:45:04 +0200
Message-Id: <1431891910-32231-29-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

The list need to be protected while iteration which is need when other
list iterates at the same time over this list.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index c7e7d50..e1c0195 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -193,9 +193,7 @@ err_reg:
 
 static void fakelb_del(struct fakelb_phy *phy)
 {
-	write_lock_bh(&fakelb_lock);
 	list_del(&phy->list);
-	write_unlock_bh(&fakelb_lock);
 
 	ieee802154_unregister_hw(phy->hw);
 	ieee802154_free_hw(phy->hw);
@@ -217,8 +215,10 @@ static int fakelb_probe(struct platform_device *pdev)
 	return 0;
 
 err_slave:
+	write_lock_bh(&fakelb_lock);
 	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
+	write_unlock_bh(&fakelb_lock);
 	return err;
 }
 
@@ -226,9 +226,10 @@ static int fakelb_remove(struct platform_device *pdev)
 {
 	struct fakelb_phy *phy, *temp;
 
+	write_lock_bh(&fakelb_lock);
 	list_for_each_entry_safe(phy, temp, &fakelb_phys, list)
 		fakelb_del(phy);
-
+	write_unlock_bh(&fakelb_lock);
 	return 0;
 }
 
-- 
2.3.7

