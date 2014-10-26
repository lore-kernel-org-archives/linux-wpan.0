Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48164 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaJZIha (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:30 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so4413801lbv.12
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:28 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 04/15] mac802154: tx: remove xmit channel context switch
Date: Sun, 26 Oct 2014 09:37:04 +0100
Message-Id: <1414312635-19396-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the channel hopping feature before xmit. There are
several issues to provide a real channel hopping (timing requirements,
etc...).

We don't have any known kernelspace protocol which really use this
feature. And I don't know an real user of this feature.
We simply drop this feature now.

This patch removes also the hold of pib lock which isn't needed by any
real driver xmit callback implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h |  3 +--
 net/mac802154/tx.c      | 58 ++++---------------------------------------------
 2 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index b07d431..ba8ddff 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -113,8 +113,7 @@ struct ieee802154_hw {
  *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
  *	  The low-level driver should send the frame based on available
  *	  configuration.
- *	  This function should return zero or negative errno. Called with
- *	  pib_lock held.
+ *	  This function should return zero or negative errno.
  *
  * ed:    Handler that 802.15.4 module calls for Energy Detection.
  *	  This function should place the value for detected energy
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index d0ceb46..be8deae 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -34,8 +34,6 @@ struct wpan_xmit_cb {
 	struct sk_buff *skb;
 	struct work_struct work;
 	struct ieee802154_local *local;
-	u8 chan;
-	u8 page;
 };
 
 static inline struct wpan_xmit_cb *wpan_xmit_cb(const struct sk_buff *skb)
@@ -53,26 +51,10 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct sk_buff *skb = cb->skb;
 	int res;
 
-	mutex_lock(&local->phy->pib_lock);
-	if (local->phy->current_channel != cb->chan ||
-	    local->phy->current_page != cb->page) {
-		res = local->ops->set_channel(&local->hw, cb->page, cb->chan);
-		if (res) {
-			pr_debug("set_channel failed\n");
-			goto out;
-		}
-
-		local->phy->current_channel = cb->chan;
-		local->phy->current_page = cb->page;
-	}
-
 	res = local->ops->xmit(&local->hw, skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
-out:
-	mutex_unlock(&local->phy->pib_lock);
-
 	/* Restart the netif queue on each sub_if_data object. */
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list)
@@ -82,17 +64,12 @@ out:
 	dev_kfree_skb(skb);
 }
 
-static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
-				struct sk_buff *skb, u8 page, u8 chan)
+static netdev_tx_t
+mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct ieee802154_sub_if_data *sdata;
 	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
 
-	if (!(local->phy->channels_supported[page] & (1 << chan))) {
-		WARN_ON(1);
-		goto err_tx;
-	}
-
 	mac802154_monitors_rx(local, skb);
 
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
@@ -115,8 +92,6 @@ static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 	INIT_WORK(&cb->work, mac802154_xmit_worker);
 	cb->skb = skb;
 	cb->local = local;
-	cb->page = page;
-	cb->chan = chan;
 
 	queue_work(local->workqueue, &cb->work);
 
@@ -130,44 +105,19 @@ err_tx:
 netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	u8 chan, page;
-
-	/* FIXME: locking */
-	chan = sdata->local->phy->current_channel;
-	page = sdata->local->phy->current_page;
-
-	if (chan == MAC802154_CHAN_NONE) /* not initialized */
-		return NETDEV_TX_OK;
-
-	if (WARN_ON(page >= WPAN_NUM_PAGES) ||
-	    WARN_ON(chan >= WPAN_NUM_CHANNELS))
-		return NETDEV_TX_OK;
 
 	skb->skb_iif = dev->ifindex;
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(sdata->local, skb, page, chan);
+	return mac802154_tx(sdata->local, skb);
 }
 
 netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	u8 chan, page;
 	int rc;
 
-	spin_lock_bh(&sdata->mib_lock);
-	chan = sdata->chan;
-	page = sdata->page;
-	spin_unlock_bh(&sdata->mib_lock);
-
-	if (chan == MAC802154_CHAN_NONE ||
-	    page >= WPAN_NUM_PAGES ||
-	    chan >= WPAN_NUM_CHANNELS) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
-
 	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
 	if (rc) {
 		pr_warn("encryption failed: %i\n", rc);
@@ -179,5 +129,5 @@ netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(sdata->local, skb, page, chan);
+	return mac802154_tx(sdata->local, skb);
 }
-- 
2.1.2

