Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35848 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbaJ0QOQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:16 -0400
Received: by mail-wi0-f178.google.com with SMTP id q5so6926815wiv.11
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:15 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 07/16] mac802154: rx: rename remove mac802154_subif_rx
Date: Mon, 27 Oct 2014 17:13:34 +0100
Message-Id: <1414426423-24856-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the mac802154_subif_rx function and do the necessary
calls inside of ieee802154_rx function. The ieee802154_rx is small
enough to move the functionality inside this function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 04f3d61..246a60e 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -242,11 +242,12 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	rcu_read_unlock();
 }
 
-static void
-mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
+void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
 
+	WARN_ON_ONCE(softirq_count() == 0);
+
 	skb->protocol = htons(ETH_P_IEEE802154);
 	skb_reset_mac_header(skb);
 
@@ -273,13 +274,6 @@ mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 fail:
 	kfree_skb(skb);
 }
-
-void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
-{
-	WARN_ON_ONCE(softirq_count() == 0);
-
-	mac802154_subif_rx(hw, skb);
-}
 EXPORT_SYMBOL(ieee802154_rx);
 
 void
-- 
2.1.2

