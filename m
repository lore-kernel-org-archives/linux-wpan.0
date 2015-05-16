Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35239 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbbEPP1H (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:07 -0400
Received: by wgkx2 with SMTP id x2so24286806wgk.2
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 06/13] fakelb: declare fakelb list static
Date: Sat, 16 May 2015 17:26:10 +0200
Message-Id: <1431789977-31393-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch moves the fakelb list of all registered phy's in a static
declaration in the fakelb driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 2dcc209..850d5b3 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -29,21 +29,17 @@
 
 static int numlbs = 2;
 static DEFINE_RWLOCK(fakelb_lock);
+static LIST_HEAD(fakelb_phys);
 
 struct fakelb_phy {
 	struct ieee802154_hw *hw;
 
 	struct list_head list;
-	struct fakelb_priv *fake;
 
 	spinlock_t lock;
 	bool working;
 };
 
-struct fakelb_priv {
-	struct list_head list;
-};
-
 static int
 fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 {
@@ -82,7 +78,7 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct fakelb_phy *phy;
 
 	read_lock_bh(&fakelb_lock);
-	list_for_each_entry(phy, &current_phy->fake->list, list) {
+	list_for_each_entry(phy, &fakelb_phys, list) {
 		if (current_phy == phy)
 			continue;
 
@@ -132,7 +128,7 @@ static const struct ieee802154_ops fakelb_ops = {
 module_param(numlbs, int, 0);
 MODULE_PARM_DESC(numlbs, " number of pseudo devices");
 
-static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
+static int fakelb_add_one(struct device *dev)
 {
 	struct fakelb_phy *phy;
 	int err;
@@ -176,9 +172,6 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->channels_supported[6] |= 0x3ffc00;
 
-	INIT_LIST_HEAD(&phy->list);
-	phy->fake = fake;
-
 	spin_lock_init(&phy->lock);
 
 	hw->parent = dev;
@@ -188,7 +181,7 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 		goto err_reg;
 
 	write_lock_bh(&fakelb_lock);
-	list_add_tail(&phy->list, &fake->list);
+	list_add_tail(&phy->list, &fakelb_phys);
 	write_unlock_bh(&fakelb_lock);
 
 	return 0;
@@ -210,41 +203,30 @@ static void fakelb_del(struct fakelb_phy *phy)
 
 static int fakelb_probe(struct platform_device *pdev)
 {
-	struct fakelb_priv *priv;
 	struct fakelb_phy *phy, *tmp;
 	int err = -ENOMEM;
 	int i;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct fakelb_priv),
-			    GFP_KERNEL);
-	if (!priv)
-		goto err_alloc;
-
-	INIT_LIST_HEAD(&priv->list);
-
 	for (i = 0; i < numlbs; i++) {
-		err = fakelb_add_one(&pdev->dev, priv);
+		err = fakelb_add_one(&pdev->dev);
 		if (err < 0)
 			goto err_slave;
 	}
 
-	platform_set_drvdata(pdev, priv);
 	dev_info(&pdev->dev, "added ieee802154 hardware\n");
 	return 0;
 
 err_slave:
-	list_for_each_entry_safe(phy, tmp, &priv->list, list)
+	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
-err_alloc:
 	return err;
 }
 
 static int fakelb_remove(struct platform_device *pdev)
 {
-	struct fakelb_priv *priv = platform_get_drvdata(pdev);
 	struct fakelb_phy *phy, *temp;
 
-	list_for_each_entry_safe(phy, temp, &priv->list, list)
+	list_for_each_entry_safe(phy, temp, &fakelb_phys, list)
 		fakelb_del(phy);
 
 	return 0;
-- 
2.3.7

