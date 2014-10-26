Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43110 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaJZIhh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:37 -0400
Received: by mail-lb0-f178.google.com with SMTP id f15so532543lbj.23
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:36 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 12/15] mac802154: tx: move stats tx increment
Date: Sun, 26 Oct 2014 09:37:12 +0100
Message-Id: <1414312635-19396-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the stats increment of successful transmitted packets
in the right place when the skb was really successful transmitted.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 70fd226..fe105d4 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -49,12 +49,13 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct wpan_xmit_cb *cb = container_of(work, struct wpan_xmit_cb, work);
 	struct ieee802154_local *local = cb->local;
 	struct sk_buff *skb = cb->skb;
+	struct net_device *dev = skb->dev;
 	int res;
 
 	rtnl_lock();
 
 	/* check if ifdown occurred while schedule */
-	if (!netif_running(skb->dev))
+	if (!netif_running(dev))
 		goto err_tx;
 
 	res = local->ops->xmit_sync(&local->hw, skb);
@@ -63,6 +64,9 @@ static void mac802154_xmit_worker(struct work_struct *work)
 
 	ieee802154_xmit_complete(&local->hw, skb);
 
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += skb->len;
+
 	rtnl_unlock();
 
 	return;
@@ -72,13 +76,14 @@ err_tx:
 	ieee802154_wake_queue(&local->hw);
 	rtnl_unlock();
 	kfree_skb(skb);
-	netdev_dbg(skb->dev, "transmission failed\n");
+	netdev_dbg(dev, "transmission failed\n");
 }
 
 static netdev_tx_t
 mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
+	struct net_device *dev = skb->dev;
 	int ret;
 
 	mac802154_monitors_rx(local, skb);
@@ -102,6 +107,9 @@ mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 			ieee802154_wake_queue(&local->hw);
 			goto err_tx;
 		}
+
+		dev->stats.tx_packets++;
+		dev->stats.tx_bytes += skb->len;
 	} else {
 		INIT_WORK(&cb->work, mac802154_xmit_worker);
 		cb->skb = skb;
@@ -122,8 +130,6 @@ netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	skb->skb_iif = dev->ifindex;
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
 
 	return mac802154_tx(sdata->local, skb);
 }
@@ -141,8 +147,6 @@ netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	skb->skb_iif = dev->ifindex;
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
 
 	return mac802154_tx(sdata->local, skb);
 }
-- 
2.1.2

