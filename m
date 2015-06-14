Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36414 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbFNOs6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Jun 2015 10:48:58 -0400
Received: by wigg3 with SMTP id g3so54225742wig.1
        for <linux-wpan@vger.kernel.org>; Sun, 14 Jun 2015 07:48:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] fakelb: add xmit_async after stop testcase
Date: Sun, 14 Jun 2015 16:48:44 +0200
Message-Id: <1434293324-26049-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a suspended testcase into the xmit_async functionality.
In the hope that we can found race conditions when xmit_async is called
after an ieee802154_ops stop. This should never happen.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 9d0da4e..860d4ae 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -41,6 +41,8 @@ struct fakelb_phy {
 	u8 page;
 	u8 channel;
 
+	bool suspended;
+
 	struct list_head list;
 	struct list_head list_ifup;
 };
@@ -69,6 +71,7 @@ static int fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct fakelb_phy *current_phy = hw->priv, *phy;
 
 	read_lock_bh(&fakelb_ifup_phys_lock);
+	WARN_ON(current_phy->suspended);
 	list_for_each_entry(phy, &fakelb_ifup_phys, list_ifup) {
 		if (current_phy == phy)
 			continue;
@@ -92,6 +95,7 @@ static int fakelb_hw_start(struct ieee802154_hw *hw)
 	struct fakelb_phy *phy = hw->priv;
 
 	write_lock_bh(&fakelb_ifup_phys_lock);
+	phy->suspended = false;
 	list_add(&phy->list_ifup, &fakelb_ifup_phys);
 	write_unlock_bh(&fakelb_ifup_phys_lock);
 
@@ -103,6 +107,7 @@ static void fakelb_hw_stop(struct ieee802154_hw *hw)
 	struct fakelb_phy *phy = hw->priv;
 
 	write_lock_bh(&fakelb_ifup_phys_lock);
+	phy->suspended = true;
 	list_del(&phy->list_ifup);
 	write_unlock_bh(&fakelb_ifup_phys_lock);
 }
-- 
2.4.1

