Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:61066 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbaHOKaI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:08 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so2157338wgh.2
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:48 +0200
Message-Id: <1408098592-13412-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 08/12] mac802154: tx: add support for async xmit callback
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch renames the existsing xmit callback to xmit_sync and
introduce a asynchronous xmit handling. If ieee802154_ops doesn't
provide the async xmit callback, then we have a fallback to the
xmit_sync callback.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c |  2 +-
 drivers/net/ieee802154/cc2520.c    |  2 +-
 drivers/net/ieee802154/mrf24j40.c  |  2 +-
 include/net/mac802154.h            |  9 +++++++++
 net/mac802154/driver-ops.h         |  6 ++++++
 net/mac802154/main.c               |  4 ++--
 net/mac802154/tx.c                 | 14 +++++++++++++-
 7 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9a77b16..8886325 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1237,7 +1237,7 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 
 static const struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
-	.xmit = at86rf230_xmit,
+	.xmit_sync = at86rf230_xmit,
 	.ed = at86rf230_ed,
 	.set_channel = at86rf230_channel,
 	.start = at86rf230_start,
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 86bed88..9662570 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -635,7 +635,7 @@ static const struct ieee802154_ops cc2520_ops = {
 	.owner = THIS_MODULE,
 	.start = cc2520_start,
 	.stop = cc2520_stop,
-	.xmit = cc2520_tx,
+	.xmit_sync = cc2520_tx,
 	.ed = cc2520_ed,
 	.set_channel = cc2520_set_channel,
 	.set_hw_addr_filt = cc2520_filter,
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index a391b85..c52f4f8 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -579,7 +579,7 @@ out:
 
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
-	.xmit = mrf24j40_tx,
+	.xmit_sync = mrf24j40_tx,
 	.ed = mrf24j40_ed,
 	.start = mrf24j40_start,
 	.stop = mrf24j40_stop,
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index fd3abbf..28c8921 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -112,6 +112,13 @@ struct ieee802154_hw {
  * stop:  Handler that 802.15.4 module calls for device cleanup.
  *	  This function is called after the last interface is removed.
  *
+ * xmit_sync:
+ *	  Handler that 802.15.4 module calls for each transmitted frame.
+ *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
+ *	  The low-level driver should send the frame based on available
+ *	  configuration. This is called by a workqueue and useful for
+ *	  synchronous 802.15.4 drivers.
+ *
  * xmit:  Handler that 802.15.4 module calls for each transmitted frame.
  *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
  *	  The low-level driver should send the frame based on available
@@ -164,6 +171,8 @@ struct ieee802154_ops {
 	struct module	*owner;
 	int		(*start)(struct ieee802154_hw *hw);
 	void		(*stop)(struct ieee802154_hw *hw);
+	int		(*xmit_sync)(struct ieee802154_hw *hw,
+				     struct sk_buff *skb);
 	int		(*xmit)(struct ieee802154_hw *hw,
 				struct sk_buff *skb);
 	int		(*ed)(struct ieee802154_hw *hw, u8 *level);
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 00298d6..3890da4 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -11,6 +11,12 @@ drv_xmit(struct ieee802154_local *local, struct sk_buff *skb)
 	return local->ops->xmit(&local->hw, skb);
 }
 
+static inline int
+drv_xmit_sync(struct ieee802154_local *local, struct sk_buff *skb)
+{
+	return local->ops->xmit_sync(&local->hw, skb);
+}
+
 static inline int drv_start(struct ieee802154_local *local)
 {
 	might_sleep();
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 0f4810f..2e5f39b 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -188,8 +188,8 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	struct ieee802154_local *local;
 	size_t priv_size;
 
-	if (!ops || !ops->xmit || !ops->ed || !ops->start ||
-	    !ops->stop || !ops->set_channel) {
+	if (!ops || !(ops->xmit || ops->xmit_sync) || !ops->ed ||
+	    !ops->start || !ops->stop || !ops->set_channel) {
 		pr_err("undefined IEEE802.15.4 device operations\n");
 		return NULL;
 	}
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index cae6fb5..45802a8 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -53,7 +53,7 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct sk_buff *skb = cb->skb;
 	int res;
 
-	res = drv_xmit(local, skb);
+	res = drv_xmit_sync(local, skb);
 	if (res) {
 		pr_debug("transmission failed\n");
 		ieee802154_wake_queue(&local->hw);
@@ -69,6 +69,7 @@ static netdev_tx_t
 mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
+	int ret;
 
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
@@ -84,6 +85,17 @@ mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	/* Stop the netif queue on each sub_if_data object. */
 	ieee802154_stop_queue(&local->hw);
 
+	/* async is priority, otherwise sync is fallback */
+	if (local->ops->xmit) {
+		ret = drv_xmit(local, skb);
+		if (ret) {
+			ieee802154_wake_queue(&local->hw);
+			goto err_tx;
+		}
+
+		return NETDEV_TX_OK;
+	}
+
 	INIT_WORK(&cb->work, mac802154_xmit_worker);
 	cb->skb = skb;
 	cb->local = local;
-- 
2.0.3

