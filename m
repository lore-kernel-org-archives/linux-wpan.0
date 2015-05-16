Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36088 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbbEPP1G (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:06 -0400
Received: by wizk4 with SMTP id k4so26391696wiz.1
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 05/13] fakelb: declare rwlock static
Date: Sat, 16 May 2015 17:26:09 +0200
Message-Id: <1431789977-31393-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch moves the rwlock declarition into a static variable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index e10eb85..2dcc209 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -28,6 +28,7 @@
 #include <net/cfg802154.h>
 
 static int numlbs = 2;
+static DEFINE_RWLOCK(fakelb_lock);
 
 struct fakelb_phy {
 	struct ieee802154_hw *hw;
@@ -41,7 +42,6 @@ struct fakelb_phy {
 
 struct fakelb_priv {
 	struct list_head list;
-	rwlock_t lock;
 };
 
 static int
@@ -79,10 +79,9 @@ static int
 fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
 	struct fakelb_phy *current_phy = hw->priv;
-	struct fakelb_priv *fake = current_phy->fake;
 	struct fakelb_phy *phy;
 
-	read_lock_bh(&fake->lock);
+	read_lock_bh(&fakelb_lock);
 	list_for_each_entry(phy, &current_phy->fake->list, list) {
 		if (current_phy == phy)
 			continue;
@@ -91,7 +90,7 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 		    current_phy->hw->phy->current_channel)
 			fakelb_hw_deliver(phy, skb);
 	}
-	read_unlock_bh(&fake->lock);
+	read_unlock_bh(&fakelb_lock);
 
 	return 0;
 }
@@ -188,9 +187,9 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 	if (err)
 		goto err_reg;
 
-	write_lock_bh(&fake->lock);
+	write_lock_bh(&fakelb_lock);
 	list_add_tail(&phy->list, &fake->list);
-	write_unlock_bh(&fake->lock);
+	write_unlock_bh(&fakelb_lock);
 
 	return 0;
 
@@ -201,9 +200,9 @@ err_reg:
 
 static void fakelb_del(struct fakelb_phy *phy)
 {
-	write_lock_bh(&phy->fake->lock);
+	write_lock_bh(&fakelb_lock);
 	list_del(&phy->list);
-	write_unlock_bh(&phy->fake->lock);
+	write_unlock_bh(&fakelb_lock);
 
 	ieee802154_unregister_hw(phy->hw);
 	ieee802154_free_hw(phy->hw);
@@ -222,7 +221,6 @@ static int fakelb_probe(struct platform_device *pdev)
 		goto err_alloc;
 
 	INIT_LIST_HEAD(&priv->list);
-	rwlock_init(&priv->lock);
 
 	for (i = 0; i < numlbs; i++) {
 		err = fakelb_add_one(&pdev->dev, priv);
-- 
2.3.7

