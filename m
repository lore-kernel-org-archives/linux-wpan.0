Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:57217 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbaJ0QOW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:22 -0400
Received: by mail-wi0-f169.google.com with SMTP id q5so6494072wiv.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:21 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 12/16] mac802154: rx: move rcu locking
Date: Mon, 27 Oct 2014 17:13:39 +0100
Message-Id: <1414426423-24856-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Instead of twice lock and unlock mechanism this patch hold these locks
only once at one position.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index c299980..689bb7f 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -205,7 +205,6 @@ mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		return;
 	}
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (sdata->type != IEEE802154_DEV_WPAN ||
 		    !netif_running(sdata->dev))
@@ -215,7 +214,6 @@ mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		skb = NULL;
 		break;
 	}
-	rcu_read_unlock();
 
 	if (skb)
 		kfree_skb(skb);
@@ -234,7 +232,6 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	skb->pkt_type = PACKET_OTHERHOST;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (sdata->type != IEEE802154_DEV_MONITOR ||
 		    !netif_running(sdata->dev))
@@ -249,7 +246,6 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 
 		netif_rx_ni(skb2);
 	}
-	rcu_read_unlock();
 }
 
 void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
@@ -273,9 +269,13 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 		skb_trim(skb, skb->len - 2); /* CRC */
 	}
 
+	rcu_read_lock();
+
 	mac802154_monitors_rx(local, skb);
 	mac802154_wpans_rx(local, skb);
 
+	rcu_read_unlock();
+
 	return;
 
 fail:
-- 
2.1.2

