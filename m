Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:62067 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaJZIQv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:16:51 -0400
Received: by mail-la0-f47.google.com with SMTP id pv20so4366768lab.6
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:16:50 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/15] mac802154: tx: add support for xmit_async callback
Date: Sun, 26 Oct 2014 09:15:45 +0100
Message-Id: <1414311352-908-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
References: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

This patch renames the existsing xmit callback to xmit_sync and
introduces an asynchronous xmit_async function. If ieee802154_ops
doesn't provide the xmit_async callback, then we have a fallback to
the xmit_sync callback.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c |  2 +-
 drivers/net/ieee802154/cc2520.c    |  2 +-
 drivers/net/ieee802154/fakelb.c    |  2 +-
 drivers/net/ieee802154/mrf24j40.c  |  2 +-
 include/net/mac802154.h            | 17 ++++++++++++++---
 net/mac802154/main.c               |  4 ++--
 net/mac802154/tx.c                 | 20 +++++++++++++++-----
 7 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b0d68d7..06a3e90 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1237,7 +1237,7 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 
 static struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
-	.xmit = at86rf230_xmit,
+	.xmit_sync = at86rf230_xmit,
 	.ed = at86rf230_ed,
 	.set_channel = at86rf230_channel,
 	.start = at86rf230_start,
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index b827e04..f6f07f4 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -635,7 +635,7 @@ static struct ieee802154_ops cc2520_ops = {
 	.owner = THIS_MODULE,
 	.start = cc2520_start,
 	.stop = cc2520_stop,
-	.xmit = cc2520_tx,
+	.xmit_sync = cc2520_tx,
 	.ed = cc2520_ed,
 	.set_channel = cc2520_set_channel,
 	.set_hw_addr_filt = cc2520_filter,
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 51e3c58..db0703f 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -131,7 +131,7 @@ fakelb_hw_stop(struct ieee802154_hw *hw) {
 
 static struct ieee802154_ops fakelb_ops = {
 	.owner = THIS_MODULE,
-	.xmit = fakelb_hw_xmit,
+	.xmit_sync = fakelb_hw_xmit,
 	.ed = fakelb_hw_ed,
 	.set_channel = fakelb_hw_channel,
 	.start = fakelb_hw_start,
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 2e267c5..3d775af 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -581,7 +581,7 @@ out:
 
 static struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
-	.xmit = mrf24j40_tx,
+	.xmit_sync = mrf24j40_tx,
 	.ed = mrf24j40_ed,
 	.start = mrf24j40_start,
 	.stop = mrf24j40_stop,
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 29af5c3..57b1202 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -109,7 +109,16 @@ struct ieee802154_hw {
  * stop:  Handler that 802.15.4 module calls for device cleanup.
  *	  This function is called after the last interface is removed.
  *
- * xmit:  Handler that 802.15.4 module calls for each transmitted frame.
+ * xmit_sync:
+ *	  Handler that 802.15.4 module calls for each transmitted frame.
+ *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
+ *	  The low-level driver should send the frame based on available
+ *	  configuration. This is called by a workqueue and useful for
+ *	  synchronous 802.15.4 drivers.
+ *	  This function should return zero or negative errno.
+ *
+ * xmit_async:
+ *	  Handler that 802.15.4 module calls for each transmitted frame.
  *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
  *	  The low-level driver should send the frame based on available
  *	  configuration.
@@ -160,8 +169,10 @@ struct ieee802154_ops {
 	struct module	*owner;
 	int		(*start)(struct ieee802154_hw *hw);
 	void		(*stop)(struct ieee802154_hw *hw);
-	int		(*xmit)(struct ieee802154_hw *hw,
-				struct sk_buff *skb);
+	int		(*xmit_sync)(struct ieee802154_hw *hw,
+				     struct sk_buff *skb);
+	int		(*xmit_async)(struct ieee802154_hw *hw,
+				      struct sk_buff *skb);
 	int		(*ed)(struct ieee802154_hw *hw, u8 *level);
 	int		(*set_channel)(struct ieee802154_hw *hw,
 				       int page,
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 0e9a6a2..3c0a824 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -229,8 +229,8 @@ ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 	struct ieee802154_local *local;
 	size_t priv_size;
 
-	if (!ops || !ops->xmit || !ops->ed || !ops->start ||
-	    !ops->stop || !ops->set_channel) {
+	if (!ops || !(ops->xmit_async || ops->xmit_sync) || !ops->ed ||
+	    !ops->start || !ops->stop || !ops->set_channel) {
 		pr_err("undefined IEEE802.15.4 device operations\n");
 		return NULL;
 	}
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 23139ca..1a4f6d9 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -50,7 +50,7 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct sk_buff *skb = cb->skb;
 	int res;
 
-	res = local->ops->xmit(&local->hw, skb);
+	res = local->ops->xmit_sync(&local->hw, skb);
 	if (res) {
 		pr_debug("transmission failed\n");
 		/* Restart the netif queue on each sub_if_data object. */
@@ -66,6 +66,7 @@ static netdev_tx_t
 mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
+	int ret;
 
 	mac802154_monitors_rx(local, skb);
 
@@ -83,11 +84,20 @@ mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	/* Stop the netif queue on each sub_if_data object. */
 	ieee802154_stop_queue(&local->hw);
 
-	INIT_WORK(&cb->work, mac802154_xmit_worker);
-	cb->skb = skb;
-	cb->local = local;
+	/* async is priority, otherwise sync is fallback */
+	if (local->ops->xmit_async) {
+		ret = local->ops->xmit_async(&local->hw, skb);
+		if (ret) {
+			ieee802154_wake_queue(&local->hw);
+			goto err_tx;
+		}
+	} else {
+		INIT_WORK(&cb->work, mac802154_xmit_worker);
+		cb->skb = skb;
+		cb->local = local;
 
-	queue_work(local->workqueue, &cb->work);
+		queue_work(local->workqueue, &cb->work);
+	}
 
 	return NETDEV_TX_OK;
 
-- 
2.1.2

