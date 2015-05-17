Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35861 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbEQTqG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:46:06 -0400
Received: by wizk4 with SMTP id k4so54332353wiz.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:46:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 29/34] fakelb: introduce fakelb ifup phys list
Date: Sun, 17 May 2015 21:45:05 +0200
Message-Id: <1431891910-32231-30-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch introduce a fakelb ifup phys list, which stores all
registered phys which are in an operated mode. This will reduce the
iterations of non-operated phys while transmit frames. There exists two
locks now, one rwlock for the operated interfaces and the spinlock for
protecting the list for all registered virtual phys.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 58 ++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index e1c0195..83957de 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -28,16 +28,18 @@
 #include <net/cfg802154.h>
 
 static int numlbs = 2;
-static DEFINE_RWLOCK(fakelb_lock);
+
 static LIST_HEAD(fakelb_phys);
+static DEFINE_SPINLOCK(fakelb_phys_lock);
+
+static LIST_HEAD(fakelb_ifup_phys);
+static DEFINE_RWLOCK(fakelb_ifup_phys_lock);
 
 struct fakelb_phy {
 	struct ieee802154_hw *hw;
 
 	struct list_head list;
-
-	spinlock_t lock;
-	bool working;
+	struct list_head list_ifup;
 };
 
 static int
@@ -62,13 +64,9 @@ fakelb_hw_deliver(struct fakelb_phy *phy, struct sk_buff *skb)
 {
 	struct sk_buff *newskb;
 
-	spin_lock(&phy->lock);
-	if (phy->working) {
-		newskb = pskb_copy(skb, GFP_ATOMIC);
-		if (newskb)
-			ieee802154_rx_irqsafe(phy->hw, newskb, 0xcc);
-	}
-	spin_unlock(&phy->lock);
+	newskb = pskb_copy(skb, GFP_ATOMIC);
+	if (newskb)
+		ieee802154_rx_irqsafe(phy->hw, newskb, 0xcc);
 }
 
 static int
@@ -77,8 +75,8 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct fakelb_phy *current_phy = hw->priv;
 	struct fakelb_phy *phy;
 
-	read_lock_bh(&fakelb_lock);
-	list_for_each_entry(phy, &fakelb_phys, list) {
+	read_lock_bh(&fakelb_ifup_phys_lock);
+	list_for_each_entry(phy, &fakelb_ifup_phys, list_ifup) {
 		if (current_phy == phy)
 			continue;
 
@@ -86,7 +84,7 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 		    current_phy->hw->phy->current_channel)
 			fakelb_hw_deliver(phy, skb);
 	}
-	read_unlock_bh(&fakelb_lock);
+	read_unlock_bh(&fakelb_ifup_phys_lock);
 
 	return 0;
 }
@@ -94,25 +92,21 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 static int
 fakelb_hw_start(struct ieee802154_hw *hw) {
 	struct fakelb_phy *phy = hw->priv;
-	int ret = 0;
 
-	spin_lock(&phy->lock);
-	if (phy->working)
-		ret = -EBUSY;
-	else
-		phy->working = 1;
-	spin_unlock(&phy->lock);
+	write_lock_bh(&fakelb_ifup_phys_lock);
+	list_add(&phy->list_ifup, &fakelb_ifup_phys);
+	write_unlock_bh(&fakelb_ifup_phys_lock);
 
-	return ret;
+	return 0;
 }
 
 static void
 fakelb_hw_stop(struct ieee802154_hw *hw) {
 	struct fakelb_phy *phy = hw->priv;
 
-	spin_lock(&phy->lock);
-	phy->working = 0;
-	spin_unlock(&phy->lock);
+	write_lock_bh(&fakelb_ifup_phys_lock);
+	list_del(&phy->list_ifup);
+	write_unlock_bh(&fakelb_ifup_phys_lock);
 }
 
 static const struct ieee802154_ops fakelb_ops = {
@@ -172,17 +166,15 @@ static int fakelb_add_one(struct device *dev)
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->supported.channels[6] |= 0x3ffc00;
 
-	spin_lock_init(&phy->lock);
-
 	hw->parent = dev;
 
 	err = ieee802154_register_hw(hw);
 	if (err)
 		goto err_reg;
 
-	write_lock_bh(&fakelb_lock);
+	spin_lock(&fakelb_phys_lock);
 	list_add_tail(&phy->list, &fakelb_phys);
-	write_unlock_bh(&fakelb_lock);
+	spin_unlock(&fakelb_phys_lock);
 
 	return 0;
 
@@ -215,10 +207,10 @@ static int fakelb_probe(struct platform_device *pdev)
 	return 0;
 
 err_slave:
-	write_lock_bh(&fakelb_lock);
+	spin_lock(&fakelb_phys_lock);
 	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
-	write_unlock_bh(&fakelb_lock);
+	spin_unlock(&fakelb_phys_lock);
 	return err;
 }
 
@@ -226,10 +218,10 @@ static int fakelb_remove(struct platform_device *pdev)
 {
 	struct fakelb_phy *phy, *temp;
 
-	write_lock_bh(&fakelb_lock);
+	spin_lock(&fakelb_phys_lock);
 	list_for_each_entry_safe(phy, temp, &fakelb_phys, list)
 		fakelb_del(phy);
-	write_unlock_bh(&fakelb_lock);
+	spin_unlock(&fakelb_phys_lock);
 	return 0;
 }
 
-- 
2.3.7

