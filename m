Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264AbcGVRSX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 Jul 2016 13:18:23 -0400
From: Aristeu Rozanski <arozansk@redhat.com>
Subject: [PATCH 3/3] ieee802154: encrypt frame before ieee802154_subif_start_xmit is called
Date: Fri, 22 Jul 2016 13:18:16 -0400
Message-Id: <1469207896-26481-3-git-send-email-arozansk@redhat.com>
In-Reply-To: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
References: <1469207896-26481-1-git-send-email-arozansk@redhat.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Aristeu Rozanski <arozansk@redhat.com>

Move mac802154_llsec_encrypt() call to right before dev_queue_xmit()
call and out of ieee802154_subif_start_xmit(). This prevents packets
failing to send on raw sockets.

Signed-off-by: Aristeu Rozanski <arozansk@redhat.com>
---
 include/net/mac802154.h     | 14 ++++++++++++++
 net/ieee802154/6lowpan/tx.c |  4 ++--
 net/ieee802154/socket.c     |  4 +++-
 net/mac802154/tx.c          | 29 +++++++++++++++++------------
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index e465c85..ee24a0e 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -377,6 +377,20 @@ void ieee802154_wake_queue(struct ieee802154_hw *hw);
 void ieee802154_stop_queue(struct ieee802154_hw *hw);
 
 /**
+ * ieee802154_finish_frame - finish a frame before queueing for transmission
+ *
+ * @skb: the buffer to be finished
+ */
+#ifdef CONFIG_MAC802154
+int ieee802154_finish_frame(struct sk_buff *skb);
+#else	/* CONFIG_MAC802154 */
+static inline int ieee802154_finish_frame(struct sk_buff *skb)
+{
+	return dev_queue_xmit(skb);
+}
+#endif	/* !CONFIG_MAC802154 */
+
+/**
  * ieee802154_xmit_complete - frame transmission complete
  *
  * @hw: pointer as obtained from ieee802154_alloc_hw().
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index e459afd..113d3c8 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -135,7 +135,7 @@ lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 
 	raw_dump_table(__func__, " fragment dump", frag->data, frag->len);
 
-	return dev_queue_xmit(frag);
+	return ieee802154_finish_frame(frag);
 }
 
 static int
@@ -286,7 +286,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 		skb->dev = lowpan_802154_dev(ldev)->wdev;
 		ldev->stats.tx_packets++;
 		ldev->stats.tx_bytes += dgram_size;
-		return dev_queue_xmit(skb);
+		return ieee802154_finish_frame(skb);
 	} else {
 		netdev_tx_t rc;
 
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index e0bd013..8ef159a 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -33,6 +33,7 @@
 
 #include <net/af_ieee802154.h>
 #include <net/ieee802154_netdev.h>
+#include <net/mac802154.h>
 
 /* Utility function for families */
 static struct net_device*
@@ -306,6 +307,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	dev_put(dev);
 
+	/* For raw sockets we don't go through ieee802154_finish_frame() */
 	err = dev_queue_xmit(skb);
 	if (err > 0)
 		err = net_xmit_errno(err);
@@ -695,7 +697,7 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	dev_put(dev);
 
-	err = dev_queue_xmit(skb);
+	err = ieee802154_finish_frame(skb);
 	if (err > 0)
 		err = net_xmit_errno(err);
 
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 7e25345..82a996e 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -56,6 +56,23 @@ err_tx:
 	netdev_dbg(dev, "transmission failed\n");
 }
 
+int ieee802154_finish_frame(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	int rc;
+
+	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
+	if (rc) {
+		netdev_warn(dev, "encryption failed: %i\n", rc);
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
+	return dev_queue_xmit(skb);
+}
+EXPORT_SYMBOL_GPL(ieee802154_finish_frame);
+
 static netdev_tx_t
 ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
@@ -107,18 +124,6 @@ netdev_tx_t
 ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	int rc;
-
-	/* TODO we should move it to wpan_dev_hard_header and dev_hard_header
-	 * functions. The reason is wireshark will show a mac header which is
-	 * with security fields but the payload is not encrypted.
-	 */
-	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
-	if (rc) {
-		netdev_warn(dev, "encryption failed: %i\n", rc);
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
 
 	skb->skb_iif = dev->ifindex;
 
-- 
1.8.3.1

