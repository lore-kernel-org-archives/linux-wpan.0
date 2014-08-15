Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41587 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbaHOKaE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:04 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so2157283wgh.2
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:44 +0200
Message-Id: <1408098592-13412-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 04/12] mac802154: tx: remove kmalloc in xmit hotpath
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch removes the kmalloc allocation for workqueue data. This patch
replace the kmalloc and use the control block of skb. The control block
have enough space and isn't use by any other layer in this case.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index d99e4f5..b6776ee 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,7 +34,7 @@
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
  */
-struct xmit_work {
+struct wpan_xmit_cb {
 	struct sk_buff *skb;
 	struct work_struct work;
 	struct ieee802154_local *local;
@@ -42,43 +42,46 @@ struct xmit_work {
 	u8 page;
 };
 
+static struct wpan_xmit_cb *wpan_xmit_cb(struct sk_buff *skb)
+{
+	return (struct wpan_xmit_cb *)skb->cb;
+}
+
 static void mac802154_xmit_worker(struct work_struct *work)
 {
-	struct xmit_work *xw = container_of(work, struct xmit_work, work);
+	struct wpan_xmit_cb *cb = container_of(work, struct wpan_xmit_cb, work);
+	struct ieee802154_local *local = cb->local;
+	struct sk_buff *skb = cb->skb;
 	int res;
 
-	mutex_lock(&xw->local->phy->pib_lock);
-	if (xw->local->phy->current_channel != xw->chan ||
-	    xw->local->phy->current_page != xw->page) {
-		res = xw->local->ops->set_channel(&xw->local->hw,
-						  xw->page,
-						  xw->chan);
+	mutex_lock(&local->phy->pib_lock);
+	if (local->phy->current_channel != cb->chan ||
+	    local->phy->current_page != cb->page) {
+		res = local->ops->set_channel(&local->hw, cb->page, cb->chan);
 		if (res) {
 			pr_debug("set_channel failed\n");
 			goto out;
 		}
 
-		xw->local->phy->current_channel = xw->chan;
-		xw->local->phy->current_page = xw->page;
+		local->phy->current_channel = cb->chan;
+		local->phy->current_page = cb->page;
 	}
 
-	res = xw->local->ops->xmit(&xw->local->hw, xw->skb);
+	res = local->ops->xmit(&cb->local->hw, skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
 out:
-	mutex_unlock(&xw->local->phy->pib_lock);
+	mutex_unlock(&local->phy->pib_lock);
 
 	/* Restart the netif queue on each sub_if_data object. */
 	ieee802154_xmit_complete(&local->hw, skb);
-
-	kfree(xw);
 }
 
 static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 				struct sk_buff *skb, u8 page, u8 chan)
 {
-	struct xmit_work *work;
+	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
 
 	if (!(local->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
@@ -96,22 +99,16 @@ static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 	if (skb_cow_head(skb, local->hw.extra_tx_headroom))
 		goto err_tx;
 
-	work = kzalloc(sizeof(*work), GFP_ATOMIC);
-	if (!work) {
-		kfree_skb(skb);
-		return NETDEV_TX_BUSY;
-	}
-
 	/* Stop the netif queue on each sub_if_data object. */
 	ieee802154_stop_queue(&local->hw);
 
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
 
-	queue_work(local->dev_workqueue, &work->work);
+	queue_work(local->dev_workqueue, &cb->work);
 
 	return NETDEV_TX_OK;
 
-- 
2.0.3

