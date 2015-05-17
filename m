Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34765 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbEQTqL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:46:11 -0400
Received: by wicmc15 with SMTP id mc15so74556812wic.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:46:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 34/34] fakelb: cleanup code
Date: Sun, 17 May 2015 21:45:10 +0200
Message-Id: <1431891910-32231-35-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch just cleanups the code at several places.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 8f37ea0..9d0da4e 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -45,8 +45,7 @@ struct fakelb_phy {
 	struct list_head list_ifup;
 };
 
-static int
-fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
+static int fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 {
 	BUG_ON(!level);
 	*level = 0xbe;
@@ -54,8 +53,7 @@ fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 	return 0;
 }
 
-static int
-fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
+static int fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	struct fakelb_phy *phy = hw->priv;
 
@@ -66,11 +64,9 @@ fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	return 0;
 }
 
-static int
-fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
+static int fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct fakelb_phy *current_phy = hw->priv;
-	struct fakelb_phy *phy;
+	struct fakelb_phy *current_phy = hw->priv, *phy;
 
 	read_lock_bh(&fakelb_ifup_phys_lock);
 	list_for_each_entry(phy, &fakelb_ifup_phys, list_ifup) {
@@ -91,8 +87,8 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	return 0;
 }
 
-static int
-fakelb_hw_start(struct ieee802154_hw *hw) {
+static int fakelb_hw_start(struct ieee802154_hw *hw)
+{
 	struct fakelb_phy *phy = hw->priv;
 
 	write_lock_bh(&fakelb_ifup_phys_lock);
@@ -102,8 +98,8 @@ fakelb_hw_start(struct ieee802154_hw *hw) {
 	return 0;
 }
 
-static void
-fakelb_hw_stop(struct ieee802154_hw *hw) {
+static void fakelb_hw_stop(struct ieee802154_hw *hw)
+{
 	struct fakelb_phy *phy = hw->priv;
 
 	write_lock_bh(&fakelb_ifup_phys_lock);
@@ -126,9 +122,9 @@ MODULE_PARM_DESC(numlbs, " number of pseudo devices");
 
 static int fakelb_add_one(struct device *dev)
 {
+	struct ieee802154_hw *hw;
 	struct fakelb_phy *phy;
 	int err;
-	struct ieee802154_hw *hw;
 
 	hw = ieee802154_alloc_hw(sizeof(*phy), &fakelb_ops);
 	if (!hw)
@@ -201,8 +197,7 @@ static void fakelb_del(struct fakelb_phy *phy)
 static int fakelb_probe(struct platform_device *pdev)
 {
 	struct fakelb_phy *phy, *tmp;
-	int err = -ENOMEM;
-	int i;
+	int err, i;
 
 	for (i = 0; i < numlbs; i++) {
 		err = fakelb_add_one(&pdev->dev);
@@ -223,10 +218,10 @@ err_slave:
 
 static int fakelb_remove(struct platform_device *pdev)
 {
-	struct fakelb_phy *phy, *temp;
+	struct fakelb_phy *phy, *tmp;
 
 	spin_lock(&fakelb_phys_lock);
-	list_for_each_entry_safe(phy, temp, &fakelb_phys, list)
+	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
 	spin_unlock(&fakelb_phys_lock);
 	return 0;
-- 
2.3.7

