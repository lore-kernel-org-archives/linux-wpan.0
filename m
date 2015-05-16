Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34671 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbbEPP1M (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:12 -0400
Received: by wicmc15 with SMTP id mc15so59039901wic.1
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 11/13] fakelb: remove fakelb_hw_deliver
Date: Sat, 16 May 2015 17:26:15 +0200
Message-Id: <1431789977-31393-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the fakelb_hw_deliver function by removing them.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 8b3f65c..0deecc6 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -66,16 +66,6 @@ fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	return 0;
 }
 
-static void
-fakelb_hw_deliver(struct fakelb_phy *phy, struct sk_buff *skb)
-{
-	struct sk_buff *newskb;
-
-	newskb = pskb_copy(skb, GFP_ATOMIC);
-	if (newskb)
-		ieee802154_rx_irqsafe(phy->hw, newskb, 0xcc);
-}
-
 static int
 fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
@@ -88,8 +78,12 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 			continue;
 
 		if (current_phy->page == phy->page &&
-		    current_phy->channel == phy->channel)
-			fakelb_hw_deliver(phy, skb);
+		    current_phy->channel == phy->channel) {
+			struct sk_buff *newskb = pskb_copy(skb, GFP_ATOMIC);
+
+			if (newskb)
+				ieee802154_rx_irqsafe(phy->hw, newskb, 0xcc);
+		}
 	}
 	read_unlock_bh(&fakelb_ifup_phys_lock);
 
-- 
2.3.7

