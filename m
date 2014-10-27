Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:52952 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbaJ0QOM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:12 -0400
Received: by mail-wg0-f52.google.com with SMTP id y10so3511886wgg.23
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 03/16] mac802154: rx: use tasklet instead workqueue
Date: Mon, 27 Oct 2014 17:13:30 +0100
Message-Id: <1414426423-24856-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Tasklets have much less overhead than workqueues. This patch also
removes the heap allocation for the worker on receiving path.
Like mac80211 we should prefer use a tasklet here instead a workqueue to
getting fast out of interrupt context when ieee802154_rx_irqsafe is
called by driver. Like wireless inside the tasklet context we should
call netif_receive_skb instead netif_rx_ni anymore.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h      |  1 +
 net/mac802154/ieee802154_i.h |  7 +++++++
 net/mac802154/iface.c        |  2 +-
 net/mac802154/main.c         | 30 +++++++++++++++++++++++++++
 net/mac802154/rx.c           | 48 ++++++++------------------------------------
 5 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 942dd53..4c4642e 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -202,6 +202,7 @@ void ieee802154_free_hw(struct ieee802154_hw *hw);
 int ieee802154_register_hw(struct ieee802154_hw *hw);
 void ieee802154_unregister_hw(struct ieee802154_hw *hw);
 
+void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
 void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
 			   u8 lqi);
 
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index ef29c10..603509a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -55,11 +55,18 @@ struct ieee802154_local {
 	 * read them using any of protection methods.
 	 */
 	bool running;
+
+	struct tasklet_struct tasklet;
+	struct sk_buff_head skb_queue;
 };
 
 #define	MAC802154_DEVICE_STOPPED	0x00
 #define MAC802154_DEVICE_RUN		0x01
 
+enum {
+	IEEE802154_RX_MSG        = 1,
+};
+
 /* Slave interface definition.
  *
  * Slaves represent typical network interfaces available from userspace.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index be45dc9..311f60c 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -376,7 +376,7 @@ void mac802154_wpan_setup(struct net_device *dev)
 
 static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
 {
-	return netif_rx_ni(skb);
+	return netif_receive_skb(skb);
 }
 
 static int
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 3c0a824..ff0de0f 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -222,6 +222,29 @@ static int mac802154_set_frame_retries(struct wpan_phy *phy, s8 retries)
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
+			WARN(1, "mac802154: Packet is of unknown type %d\n",
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
@@ -270,6 +293,12 @@ ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 	INIT_LIST_HEAD(&local->interfaces);
 	mutex_init(&local->iflist_mtx);
 
+	tasklet_init(&local->tasklet,
+		     ieee802154_tasklet_handler,
+		     (unsigned long)local);
+
+	skb_queue_head_init(&local->skb_queue);
+
 	return &local->hw;
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
@@ -371,6 +400,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 	struct ieee802154_local *local = hw_to_local(hw);
 	struct ieee802154_sub_if_data *sdata, *next;
 
+	tasklet_kill(&local->tasklet);
 	flush_workqueue(local->workqueue);
 	destroy_workqueue(local->workqueue);
 
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 53c9e0c..2851a3f 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -19,7 +19,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/workqueue.h>
 #include <linux/netdevice.h>
 #include <linux/crc-ccitt.h>
 
@@ -28,30 +27,11 @@
 
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
 
@@ -79,32 +59,20 @@ fail:
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
-	queue_work(local->workqueue, &work->work);
+	mac_cb(skb)->lqi = lqi;
+	skb->pkt_type = IEEE802154_RX_MSG;
+	skb_queue_tail(&local->skb_queue, skb);
+	tasklet_schedule(&local->tasklet);
 }
 EXPORT_SYMBOL(ieee802154_rx_irqsafe);
-- 
2.1.2

