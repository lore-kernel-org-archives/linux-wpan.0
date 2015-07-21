Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:48260 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbbGUOos (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Jul 2015 10:44:48 -0400
Date: Tue, 21 Jul 2015 17:44:47 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH bluetooth-next] mac802154: Fix memory corruption with global
 deferred transmit state.
Message-ID: <20150721144447.GH20876@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

When transmitting a packet via a mac802154 driver that can sleep in
its transmit function, mac802154 defers the call to the driver's
transmit function to a per-device workqueue.

However, mac802154 uses a single global work_struct for this, which
means that if you have more than one registered mac802154 interface
in the system, and you transmit on more than one of them at the same
time, you'll very easily cause memory corruption.

This patch moves the deferred transmit processing state from global
variables to struct ieee802154_local, and this seems to fix the memory
corruption issue.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
There were patches for this issue on the mailing list, but it
doesn't seem that a fix for this issue has been applied yet -- how
about this?

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 6810d7a..56ccffa 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -60,6 +60,9 @@ struct ieee802154_local {
 
 	struct tasklet_struct tasklet;
 	struct sk_buff_head skb_queue;
+
+	struct sk_buff *tx_skb;
+	struct work_struct tx_work;
 };
 
 enum {
@@ -125,6 +128,7 @@ ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
 void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
+void ieee802154_xmit_worker(struct work_struct *work);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
 netdev_tx_t
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 91f1208..9e55431 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -105,6 +105,8 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 
 	skb_queue_head_init(&local->skb_queue);
 
+	INIT_WORK(&local->tx_work, ieee802154_xmit_worker);
+
 	/* init supported flags with 802.15.4 default ranges */
 	phy->supported.max_minbe = 8;
 	phy->supported.min_maxbe = 3;
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index c62e956..7ed4391 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -30,23 +30,11 @@
 #include "ieee802154_i.h"
 #include "driver-ops.h"
 
-/* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
- * packets through the workqueue.
- */
-struct ieee802154_xmit_cb {
-	struct sk_buff *skb;
-	struct work_struct work;
-	struct ieee802154_local *local;
-};
-
-static struct ieee802154_xmit_cb ieee802154_xmit_cb;
-
-static void ieee802154_xmit_worker(struct work_struct *work)
+void ieee802154_xmit_worker(struct work_struct *work)
 {
-	struct ieee802154_xmit_cb *cb =
-		container_of(work, struct ieee802154_xmit_cb, work);
-	struct ieee802154_local *local = cb->local;
-	struct sk_buff *skb = cb->skb;
+	struct ieee802154_local *local =
+		container_of(work, struct ieee802154_local, tx_work);
+	struct sk_buff *skb = local->tx_skb;
 	struct net_device *dev = skb->dev;
 	int res;
 
@@ -106,11 +94,8 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		dev->stats.tx_packets++;
 		dev->stats.tx_bytes += skb->len;
 	} else {
-		INIT_WORK(&ieee802154_xmit_cb.work, ieee802154_xmit_worker);
-		ieee802154_xmit_cb.skb = skb;
-		ieee802154_xmit_cb.local = local;
-
-		queue_work(local->workqueue, &ieee802154_xmit_cb.work);
+		local->tx_skb = skb;
+		queue_work(local->workqueue, &local->tx_work);
 	}
 
 	return NETDEV_TX_OK;
