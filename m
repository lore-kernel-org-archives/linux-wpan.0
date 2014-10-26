Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50280 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaJZIhd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:33 -0400
Received: by mail-lb0-f171.google.com with SMTP id z11so910568lbi.30
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:32 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 06/15] mac802154: tx: use queue helpers in xmit worker
Date: Sun, 26 Oct 2014 09:37:06 +0100
Message-Id: <1414312635-19396-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch uses the queue utility helpers inside the xmit worker of
mac802154 subsystem.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index be8deae..8e2f429 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -47,7 +47,6 @@ static void mac802154_xmit_worker(struct work_struct *work)
 {
 	struct wpan_xmit_cb *cb = container_of(work, struct wpan_xmit_cb, work);
 	struct ieee802154_local *local = cb->local;
-	struct ieee802154_sub_if_data *sdata;
 	struct sk_buff *skb = cb->skb;
 	int res;
 
@@ -56,18 +55,12 @@ static void mac802154_xmit_worker(struct work_struct *work)
 		pr_debug("transmission failed\n");
 
 	/* Restart the netif queue on each sub_if_data object. */
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		netif_wake_queue(sdata->dev);
-	rcu_read_unlock();
-
-	dev_kfree_skb(skb);
+	ieee802154_xmit_complete(&local->hw, skb);
 }
 
 static netdev_tx_t
 mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
-	struct ieee802154_sub_if_data *sdata;
 	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
 
 	mac802154_monitors_rx(local, skb);
@@ -84,10 +77,7 @@ mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		goto err_tx;
 
 	/* Stop the netif queue on each sub_if_data object. */
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		netif_stop_queue(sdata->dev);
-	rcu_read_unlock();
+	ieee802154_stop_queue(&local->hw);
 
 	INIT_WORK(&cb->work, mac802154_xmit_worker);
 	cb->skb = skb;
-- 
2.1.2

