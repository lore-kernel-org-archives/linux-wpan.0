Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:35611 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaJZIh1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:27 -0400
Received: by mail-la0-f42.google.com with SMTP id gf13so4987055lab.15
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:26 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 02/15] mac802154: tx: remove kmalloc in xmit hotpath
Date: Sun, 26 Oct 2014 09:37:02 +0100
Message-Id: <1414312635-19396-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the kmalloc allocation for workqueue data. This patch
replaces the kmalloc and uses the control block of skb. The control block
has enough space and isn't use by any other layer in this case.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 56 ++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 2eb06c2..513e760 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -30,7 +30,7 @@
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
  */
-struct xmit_work {
+struct wpan_xmit_cb {
 	struct sk_buff *skb;
 	struct work_struct work;
 	struct ieee802154_local *local;
@@ -38,50 +38,54 @@ struct xmit_work {
 	u8 page;
 };
 
+static inline struct wpan_xmit_cb *wpan_xmit_cb(const struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct wpan_xmit_cb));
+
+	return (struct wpan_xmit_cb *)skb->cb;
+}
+
 static void mac802154_xmit_worker(struct work_struct *work)
 {
-	struct xmit_work *xw = container_of(work, struct xmit_work, work);
+	struct wpan_xmit_cb *cb = container_of(work, struct wpan_xmit_cb, work);
 	struct ieee802154_sub_if_data *sdata;
 	int res;
 
-	mutex_lock(&xw->local->phy->pib_lock);
-	if (xw->local->phy->current_channel != xw->chan ||
-	    xw->local->phy->current_page != xw->page) {
-		res = xw->local->ops->set_channel(&xw->local->hw,
-						  xw->page,
-						  xw->chan);
+	mutex_lock(&cb->local->phy->pib_lock);
+	if (cb->local->phy->current_channel != cb->chan ||
+	    cb->local->phy->current_page != cb->page) {
+		res = cb->local->ops->set_channel(&cb->local->hw, cb->page,
+						  cb->chan);
 		if (res) {
 			pr_debug("set_channel failed\n");
 			goto out;
 		}
 
-		xw->local->phy->current_channel = xw->chan;
-		xw->local->phy->current_page = xw->page;
+		cb->local->phy->current_channel = cb->chan;
+		cb->local->phy->current_page = cb->page;
 	}
 
-	res = xw->local->ops->xmit(&xw->local->hw, xw->skb);
+	res = cb->local->ops->xmit(&cb->local->hw, cb->skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
 out:
-	mutex_unlock(&xw->local->phy->pib_lock);
+	mutex_unlock(&cb->local->phy->pib_lock);
 
 	/* Restart the netif queue on each sub_if_data object. */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &xw->local->interfaces, list)
+	list_for_each_entry_rcu(sdata, &cb->local->interfaces, list)
 		netif_wake_queue(sdata->dev);
 	rcu_read_unlock();
 
-	dev_kfree_skb(xw->skb);
-
-	kfree(xw);
+	dev_kfree_skb(cb->skb);
 }
 
 static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 				struct sk_buff *skb, u8 page, u8 chan)
 {
-	struct xmit_work *work;
 	struct ieee802154_sub_if_data *sdata;
+	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
 
 	if (!(local->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
@@ -101,25 +105,19 @@ static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 	if (skb_cow_head(skb, local->hw.extra_tx_headroom))
 		goto err_tx;
 
-	work = kzalloc(sizeof(*work), GFP_ATOMIC);
-	if (!work) {
-		kfree_skb(skb);
-		return NETDEV_TX_BUSY;
-	}
-
 	/* Stop the netif queue on each sub_if_data object. */
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list)
 		netif_stop_queue(sdata->dev);
 	rcu_read_unlock();
 
-	INIT_WORK(&work->work, mac802154_xmit_worker);
-	work->skb = skb;
-	work->local = local;
-	work->page = page;
-	work->chan = chan;
+	INIT_WORK(&cb->work, mac802154_xmit_worker);
+	cb->skb = skb;
+	cb->local = local;
+	cb->page = page;
+	cb->chan = chan;
 
-	queue_work(local->workqueue, &work->work);
+	queue_work(local->workqueue, &cb->work);
 
 	return NETDEV_TX_OK;
 
-- 
2.1.2

