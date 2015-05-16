Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36056 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbEPP1E (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:04 -0400
Received: by wizk4 with SMTP id k4so26390964wiz.1
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 03/13] fakelb: rename fakelb_dev_priv to fakelb_phy
Date: Sat, 16 May 2015 17:26:07 +0200
Message-Id: <1431789977-31393-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch renames fakelb_dev_priv to fakelb_phy. We don't faking
devices here, we fake wpan phys. This avoids also confusing with the
variable priv, which is used several times in this driver to represent
this structure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 93 +++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 43b0336..084208d 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -29,7 +29,7 @@
 
 static int numlbs = 2;
 
-struct fakelb_dev_priv {
+struct fakelb_phy {
 	struct ieee802154_hw *hw;
 
 	struct list_head list;
@@ -62,36 +62,37 @@ fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 }
 
 static void
-fakelb_hw_deliver(struct fakelb_dev_priv *priv, struct sk_buff *skb)
+fakelb_hw_deliver(struct fakelb_phy *phy, struct sk_buff *skb)
 {
 	struct sk_buff *newskb;
 
-	spin_lock(&priv->lock);
-	if (priv->working) {
+	spin_lock(&phy->lock);
+	if (phy->working) {
 		newskb = pskb_copy(skb, GFP_ATOMIC);
 		if (newskb)
-			ieee802154_rx_irqsafe(priv->hw, newskb, 0xcc);
+			ieee802154_rx_irqsafe(phy->hw, newskb, 0xcc);
 	}
-	spin_unlock(&priv->lock);
+	spin_unlock(&phy->lock);
 }
 
 static int
 fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct fakelb_dev_priv *priv = hw->priv;
-	struct fakelb_priv *fake = priv->fake;
+	struct fakelb_phy *current_phy = hw->priv;
+	struct fakelb_priv *fake = current_phy->fake;
 
 	read_lock_bh(&fake->lock);
-	if (priv->list.next == priv->list.prev) {
+	if (current_phy->list.next == current_phy->list.prev) {
 		/* we are the only one device */
-		fakelb_hw_deliver(priv, skb);
+		fakelb_hw_deliver(current_phy, skb);
 	} else {
-		struct fakelb_dev_priv *dp;
-		list_for_each_entry(dp, &priv->fake->list, list) {
-			if (dp != priv &&
-			    (dp->hw->phy->current_channel ==
-			     priv->hw->phy->current_channel))
-				fakelb_hw_deliver(dp, skb);
+		struct fakelb_phy *phy;
+
+		list_for_each_entry(phy, &current_phy->fake->list, list) {
+			if (current_phy != phy &&
+			    (phy->hw->phy->current_channel ==
+			     current_phy->hw->phy->current_channel))
+				fakelb_hw_deliver(phy, skb);
 		}
 	}
 	read_unlock_bh(&fake->lock);
@@ -101,26 +102,26 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 static int
 fakelb_hw_start(struct ieee802154_hw *hw) {
-	struct fakelb_dev_priv *priv = hw->priv;
+	struct fakelb_phy *phy = hw->priv;
 	int ret = 0;
 
-	spin_lock(&priv->lock);
-	if (priv->working)
+	spin_lock(&phy->lock);
+	if (phy->working)
 		ret = -EBUSY;
 	else
-		priv->working = 1;
-	spin_unlock(&priv->lock);
+		phy->working = 1;
+	spin_unlock(&phy->lock);
 
 	return ret;
 }
 
 static void
 fakelb_hw_stop(struct ieee802154_hw *hw) {
-	struct fakelb_dev_priv *priv = hw->priv;
+	struct fakelb_phy *phy = hw->priv;
 
-	spin_lock(&priv->lock);
-	priv->working = 0;
-	spin_unlock(&priv->lock);
+	spin_lock(&phy->lock);
+	phy->working = 0;
+	spin_unlock(&phy->lock);
 }
 
 static const struct ieee802154_ops fakelb_ops = {
@@ -138,16 +139,16 @@ MODULE_PARM_DESC(numlbs, " number of pseudo devices");
 
 static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 {
-	struct fakelb_dev_priv *priv;
+	struct fakelb_phy *phy;
 	int err;
 	struct ieee802154_hw *hw;
 
-	hw = ieee802154_alloc_hw(sizeof(*priv), &fakelb_ops);
+	hw = ieee802154_alloc_hw(sizeof(*phy), &fakelb_ops);
 	if (!hw)
 		return -ENOMEM;
 
-	priv = hw->priv;
-	priv->hw = hw;
+	phy = hw->priv;
+	phy->hw = hw;
 
 	/* 868 MHz BPSK	802.15.4-2003 */
 	hw->phy->channels_supported[0] |= 1;
@@ -180,10 +181,10 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->channels_supported[6] |= 0x3ffc00;
 
-	INIT_LIST_HEAD(&priv->list);
-	priv->fake = fake;
+	INIT_LIST_HEAD(&phy->list);
+	phy->fake = fake;
 
-	spin_lock_init(&priv->lock);
+	spin_lock_init(&phy->lock);
 
 	hw->parent = dev;
 
@@ -192,30 +193,30 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 		goto err_reg;
 
 	write_lock_bh(&fake->lock);
-	list_add_tail(&priv->list, &fake->list);
+	list_add_tail(&phy->list, &fake->list);
 	write_unlock_bh(&fake->lock);
 
 	return 0;
 
 err_reg:
-	ieee802154_free_hw(priv->hw);
+	ieee802154_free_hw(phy->hw);
 	return err;
 }
 
-static void fakelb_del(struct fakelb_dev_priv *priv)
+static void fakelb_del(struct fakelb_phy *phy)
 {
-	write_lock_bh(&priv->fake->lock);
-	list_del(&priv->list);
-	write_unlock_bh(&priv->fake->lock);
+	write_lock_bh(&phy->fake->lock);
+	list_del(&phy->list);
+	write_unlock_bh(&phy->fake->lock);
 
-	ieee802154_unregister_hw(priv->hw);
-	ieee802154_free_hw(priv->hw);
+	ieee802154_unregister_hw(phy->hw);
+	ieee802154_free_hw(phy->hw);
 }
 
 static int fakelb_probe(struct platform_device *pdev)
 {
 	struct fakelb_priv *priv;
-	struct fakelb_dev_priv *dp, *tmp;
+	struct fakelb_phy *phy, *tmp;
 	int err = -ENOMEM;
 	int i;
 
@@ -238,8 +239,8 @@ static int fakelb_probe(struct platform_device *pdev)
 	return 0;
 
 err_slave:
-	list_for_each_entry_safe(dp, tmp, &priv->list, list)
-		fakelb_del(dp);
+	list_for_each_entry_safe(phy, tmp, &priv->list, list)
+		fakelb_del(phy);
 err_alloc:
 	return err;
 }
@@ -247,10 +248,10 @@ err_alloc:
 static int fakelb_remove(struct platform_device *pdev)
 {
 	struct fakelb_priv *priv = platform_get_drvdata(pdev);
-	struct fakelb_dev_priv *dp, *temp;
+	struct fakelb_phy *phy, *temp;
 
-	list_for_each_entry_safe(dp, temp, &priv->list, list)
-		fakelb_del(dp);
+	list_for_each_entry_safe(phy, temp, &priv->list, list)
+		fakelb_del(phy);
 
 	return 0;
 }
-- 
2.3.7

