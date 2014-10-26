Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:54206 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaJZRQY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 13:16:24 -0400
Received: by mail-la0-f44.google.com with SMTP id hs14so4728951lab.31
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 10:16:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: tx: make worker information static
Date: Sun, 26 Oct 2014 18:15:34 +0100
Message-Id: <1414343734-7367-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the worker information struct out of skb control block.
Instead control block we declare it static inside of tx.c file. We can do
that, because the worker can't be used twice at the same time. It's
protected by stop and wake netdev queue.

This patch fix an issue that the "struct ieee802154_xmit_cb" doesn't fit
into the skb control block on some kernel configuartion reported by
kbuild test robot.

It was introduced by commit fe24371d6645b766c59ec664c59d0a9c310ad455
("mac802154: tx: remove kmalloc in xmit hotpath").

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 74882c7..fe2e17e 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -37,13 +37,7 @@ struct ieee802154_xmit_cb {
 	struct ieee802154_local *local;
 };
 
-static inline struct ieee802154_xmit_cb *
-ieee802154_xmit_cb(const struct sk_buff *skb)
-{
-	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct ieee802154_xmit_cb));
-
-	return (struct ieee802154_xmit_cb *)skb->cb;
-}
+static struct ieee802154_xmit_cb ieee802154_xmit_cb;
 
 static void ieee802154_xmit_worker(struct work_struct *work)
 {
@@ -84,7 +78,6 @@ err_tx:
 static netdev_tx_t
 ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
-	struct ieee802154_xmit_cb *cb = ieee802154_xmit_cb(skb);
 	struct net_device *dev = skb->dev;
 	int ret;
 
@@ -113,11 +106,11 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		dev->stats.tx_packets++;
 		dev->stats.tx_bytes += skb->len;
 	} else {
-		INIT_WORK(&cb->work, ieee802154_xmit_worker);
-		cb->skb = skb;
-		cb->local = local;
+		INIT_WORK(&ieee802154_xmit_cb.work, ieee802154_xmit_worker);
+		ieee802154_xmit_cb.skb = skb;
+		ieee802154_xmit_cb.local = local;
 
-		queue_work(local->workqueue, &cb->work);
+		queue_work(local->workqueue, &ieee802154_xmit_cb.work);
 	}
 
 	return NETDEV_TX_OK;
-- 
2.1.2

