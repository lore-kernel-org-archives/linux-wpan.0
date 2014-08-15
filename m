Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:39810 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbaHOKaF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:05 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so645185wib.15
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:45 +0200
Message-Id: <1408098592-13412-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 05/12] mac802154: tx: remove xmit channel context switch
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch removes the channel hoping feature before xmit. There are
several issues to provide a real channel hoping (timing requirements,
etc.). It's not very useful at the moment. In my opinion this was added
for support RF4CE and doing some userspace magic to do some channel hoping.

We don't have any known kernelspace protocol which really use this
featyre. We simply drop this feature now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 44 +++-----------------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index b6776ee..c748080 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -38,8 +38,6 @@ struct wpan_xmit_cb {
 	struct sk_buff *skb;
 	struct work_struct work;
 	struct ieee802154_local *local;
-	u8 chan;
-	u8 page;
 };
 
 static struct wpan_xmit_cb *wpan_xmit_cb(struct sk_buff *skb)
@@ -54,40 +52,19 @@ static void mac802154_xmit_worker(struct work_struct *work)
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
 	res = local->ops->xmit(&cb->local->hw, skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
-out:
-	mutex_unlock(&local->phy->pib_lock);
-
 	/* Restart the netif queue on each sub_if_data object. */
 	ieee802154_xmit_complete(&local->hw, skb);
 }
 
-static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
-				struct sk_buff *skb, u8 page, u8 chan)
+static netdev_tx_t
+mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
 
-	if (!(local->phy->channels_supported[page] & (1 << chan))) {
-		WARN_ON(1);
-		goto err_tx;
-	}
-
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 		u8 *data = skb_put(skb, 2);
@@ -105,8 +82,6 @@ static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
 	INIT_WORK(&cb->work, mac802154_xmit_worker);
 	cb->skb = skb;
 	cb->local = local;
-	cb->page = page;
-	cb->chan = chan;
 
 	queue_work(local->dev_workqueue, &cb->work);
 
@@ -120,21 +95,8 @@ err_tx:
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
@@ -146,5 +108,5 @@ netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(sdata->local, skb, page, chan);
+	return mac802154_tx(sdata->local, skb);
 }
-- 
2.0.3

