Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35534 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbEQTqH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:46:07 -0400
Received: by wgfl8 with SMTP id l8so13367034wgf.2
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:46:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 30/34] fakelb: use own channel and page attributes
Date: Sun, 17 May 2015 21:45:06 +0200
Message-Id: <1431891910-32231-31-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch adds an own phy attribute for page and channel into
fakelb_phy. The current way is to use the internal mac802154 stored phy
pib values which can occur in locking issues while using it inside the
driver layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 83957de..c60837e 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -38,6 +38,9 @@ static DEFINE_RWLOCK(fakelb_ifup_phys_lock);
 struct fakelb_phy {
 	struct ieee802154_hw *hw;
 
+	u8 page;
+	u8 channel;
+
 	struct list_head list;
 	struct list_head list_ifup;
 };
@@ -54,8 +57,12 @@ fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 static int
 fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
-	pr_debug("set channel to %d\n", channel);
+	struct fakelb_phy *phy = hw->priv;
 
+	write_lock_bh(&fakelb_ifup_phys_lock);
+	phy->page = page;
+	phy->channel = channel;
+	write_unlock_bh(&fakelb_ifup_phys_lock);
 	return 0;
 }
 
@@ -80,8 +87,8 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 		if (current_phy == phy)
 			continue;
 
-		if (phy->hw->phy->current_channel ==
-		    current_phy->hw->phy->current_channel)
+		if (current_phy->page == phy->page &&
+		    current_phy->channel == phy->channel)
 			fakelb_hw_deliver(phy, skb);
 	}
 	read_unlock_bh(&fakelb_ifup_phys_lock);
-- 
2.3.7

