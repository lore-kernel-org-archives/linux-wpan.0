Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:57248 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbaHLNOo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:44 -0400
Received: by mail-lb0-f171.google.com with SMTP id l4so6985635lbv.2
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:42 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:15 +0200
Message-Id: <1407849255-11500-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 11/11] mac802154: rx: use tasklet instead workqueue
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Tasklets have much less overhead than workqueues and we save the heap
allocation on this hot path.

This patch is part of getting wireless feeling into the ieee802154
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h      |  2 ++
 net/mac802154/ieee802154_i.h |  7 +++++++
 net/mac802154/main.c         | 29 +++++++++++++++++++++++++++
 net/mac802154/rx.c           | 47 ++++++++------------------------------------
 4 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index ffc8cee..9e9d8fa 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -195,4 +195,6 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw);
 void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
 			   u8 lqi);
 
+void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
+
 #endif /* NET_MAC802154_H */
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 1a344ab..6bad21f 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -27,6 +27,10 @@
 
 struct ieee802154_local;
 
+enum {
+	IEEE802154_RX_MSG        = 1,
+};
+
 /* Slave interface definition.
  *
  * Slaves represent typical network interfaces available from userspace.
@@ -96,6 +100,9 @@ struct ieee802154_local {
 	 * read them using any of protection methods.
 	 */
 	bool running;
+
+	struct tasklet_struct tasklet;
+	struct sk_buff_head skb_queue;
 };
 
 #define	MAC802154_DEVICE_STOPPED	0x00
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 685d5bd..1f8c968 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -230,6 +230,29 @@ static int mac802154_set_frame_retries(struct wpan_phy *phy, s8 retries)
 	return local->ops->set_frame_retries(&local->hw, retries);
 }
 
+static void ieee802154_tasklet_handler(unsigned long data)
+{
+	struct ieee802154_local *local = (struct ieee802154_local *)data;
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&local->skb_queue))) {
+		switch (skb->pkt_type) {
+		case IEEE802154_RX_MSG:
+			/* Clear skb->pkt_type in order to not confuse kernel
+			 * netstack.
+			 */
+			skb->pkt_type = 0;
+			ieee802154_rx(&local->hw, skb);
+			break;
+		default:
+			WARN(1, "mac80211: Packet is of unknown type %d\n",
+			     skb->pkt_type);
+			kfree_skb(skb);
+			break;
+		}
+	}
+}
+
 struct ieee802154_hw *
 ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 {
@@ -278,6 +301,12 @@ ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 	INIT_LIST_HEAD(&local->slaves);
 	mutex_init(&local->slaves_mtx);
 
+	tasklet_init(&local->tasklet,
+		     ieee802154_tasklet_handler,
+		     (unsigned long)local);
+
+	skb_queue_head_init(&local->skb_queue);
+
 	return &local->hw;
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 7bd3c85..fe16754 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -32,30 +32,11 @@
 
 #include "ieee802154_i.h"
 
-/* The IEEE 802.15.4 standard defines 4 MAC packet types:
- * - beacon frame
- * - MAC command frame
- * - acknowledgement frame
- * - data frame
- *
- * and only the data frame should be pushed to the upper layers, other types
- * are just internal MAC layer management information. So only data packets
- * are going to be sent to the networking queue, all other will be processed
- * right here by using the device workqueue.
- */
-struct rx_work {
-	struct sk_buff *skb;
-	struct work_struct work;
-	struct ieee802154_hw *hw;
-	u8 lqi;
-};
-
 static void
-mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
+mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
 
-	mac_cb(skb)->lqi = lqi;
 	skb->protocol = htons(ETH_P_IEEE802154);
 	skb_reset_mac_header(skb);
 
@@ -82,32 +63,20 @@ fail:
 	kfree_skb(skb);
 }
 
-static void mac802154_rx_worker(struct work_struct *work)
+void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct rx_work *rw = container_of(work, struct rx_work, work);
-
-	mac802154_subif_rx(rw->hw, rw->skb, rw->lqi);
-	kfree(rw);
+	mac802154_subif_rx(hw, skb);
 }
+EXPORT_SYMBOL(ieee802154_rx);
 
 void
 ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
-	struct rx_work *work;
 
-	if (!skb)
-		return;
-
-	work = kzalloc(sizeof(*work), GFP_ATOMIC);
-	if (!work)
-		return;
-
-	INIT_WORK(&work->work, mac802154_rx_worker);
-	work->skb = skb;
-	work->hw = hw;
-	work->lqi = lqi;
-
-	queue_work(local->dev_workqueue, &work->work);
+	mac_cb(skb)->lqi = lqi;
+	skb->pkt_type = IEEE802154_RX_MSG;
+	skb_queue_tail(&local->skb_queue, skb);
+	tasklet_schedule(&local->tasklet);
 }
 EXPORT_SYMBOL(ieee802154_rx_irqsafe);
-- 
2.0.3

