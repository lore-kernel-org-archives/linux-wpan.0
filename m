Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48662 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaJZIh2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so4413560lbv.33
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:27 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 03/15] mac802154: tx: squash multiple dereferencing
Date: Sun, 26 Oct 2014 09:37:03 +0100
Message-Id: <1414312635-19396-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce some new stack variables to avoid multiple
dereferencing inside the xmit worker function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 513e760..d0ceb46 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -48,37 +48,38 @@ static inline struct wpan_xmit_cb *wpan_xmit_cb(const struct sk_buff *skb)
 static void mac802154_xmit_worker(struct work_struct *work)
 {
 	struct wpan_xmit_cb *cb = container_of(work, struct wpan_xmit_cb, work);
+	struct ieee802154_local *local = cb->local;
 	struct ieee802154_sub_if_data *sdata;
+	struct sk_buff *skb = cb->skb;
 	int res;
 
-	mutex_lock(&cb->local->phy->pib_lock);
-	if (cb->local->phy->current_channel != cb->chan ||
-	    cb->local->phy->current_page != cb->page) {
-		res = cb->local->ops->set_channel(&cb->local->hw, cb->page,
-						  cb->chan);
+	mutex_lock(&local->phy->pib_lock);
+	if (local->phy->current_channel != cb->chan ||
+	    local->phy->current_page != cb->page) {
+		res = local->ops->set_channel(&local->hw, cb->page, cb->chan);
 		if (res) {
 			pr_debug("set_channel failed\n");
 			goto out;
 		}
 
-		cb->local->phy->current_channel = cb->chan;
-		cb->local->phy->current_page = cb->page;
+		local->phy->current_channel = cb->chan;
+		local->phy->current_page = cb->page;
 	}
 
-	res = cb->local->ops->xmit(&cb->local->hw, cb->skb);
+	res = local->ops->xmit(&local->hw, skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
 out:
-	mutex_unlock(&cb->local->phy->pib_lock);
+	mutex_unlock(&local->phy->pib_lock);
 
 	/* Restart the netif queue on each sub_if_data object. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &cb->local->interfaces, list)
+	list_for_each_entry_rcu(sdata, &local->interfaces, list)
 		netif_wake_queue(sdata->dev);
 	rcu_read_unlock();
 
-	dev_kfree_skb(cb->skb);
+	dev_kfree_skb(skb);
 }
 
 static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
-- 
2.1.2

