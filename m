Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:42904 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaJZIQp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:16:45 -0400
Received: by mail-la0-f47.google.com with SMTP id pv20so4512527lab.34
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:16:42 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/15] mac802154: tx: move xmit callback to tx file
Date: Sun, 26 Oct 2014 09:15:38 +0100
Message-Id: <1414311352-908-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
References: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the netdev xmit callback functions into the tx.c file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  5 ++--
 net/mac802154/iface.c        | 35 --------------------------
 net/mac802154/monitor.c      | 27 --------------------
 net/mac802154/tx.c           | 59 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 59 insertions(+), 67 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 7aae692..a9a9d8e 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -121,12 +121,11 @@ int mac802154_slave_close(struct net_device *dev);
 
 void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_monitor_setup(struct net_device *dev);
+netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_wpan_setup(struct net_device *dev);
-
-netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
-			 u8 page, u8 chan);
+netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev);
 
 /* MIB callbacks */
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index cdd661f..f14e436 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -307,41 +307,6 @@ mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 	return sizeof(*addr);
 }
 
-static netdev_tx_t
-mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata;
-	u8 chan, page;
-	int rc;
-
-	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
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
-	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
-	if (rc) {
-		pr_warn("encryption failed: %i\n", rc);
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
-
-	skb->skb_iif = dev->ifindex;
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-
-	return mac802154_tx(sdata->local, skb, page, chan);
-}
-
 static struct header_ops mac802154_header_ops = {
 	.create		= mac802154_header_create,
 	.parse		= mac802154_header_parse,
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index f8ea6dc..cb9600bcc 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -30,33 +30,6 @@
 
 #include "ieee802154_i.h"
 
-static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
-					  struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata;
-	u8 chan, page;
-
-	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
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
-
-	skb->skb_iif = dev->ifindex;
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-
-	return mac802154_tx(sdata->local, skb, page, chan);
-}
-
-
 void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct sk_buff *skb2;
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 2c40d9b..2eb06c2 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -77,8 +77,8 @@ out:
 	kfree(xw);
 }
 
-netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
-			 u8 page, u8 chan)
+static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
+				struct sk_buff *skb, u8 page, u8 chan)
 {
 	struct xmit_work *work;
 	struct ieee802154_sub_if_data *sdata;
@@ -127,3 +127,58 @@ err_tx:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
+
+netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	u8 chan, page;
+
+	/* FIXME: locking */
+	chan = sdata->local->phy->current_channel;
+	page = sdata->local->phy->current_page;
+
+	if (chan == MAC802154_CHAN_NONE) /* not initialized */
+		return NETDEV_TX_OK;
+
+	if (WARN_ON(page >= WPAN_NUM_PAGES) ||
+	    WARN_ON(chan >= WPAN_NUM_CHANNELS))
+		return NETDEV_TX_OK;
+
+	skb->skb_iif = dev->ifindex;
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += skb->len;
+
+	return mac802154_tx(sdata->local, skb, page, chan);
+}
+
+netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	u8 chan, page;
+	int rc;
+
+	spin_lock_bh(&sdata->mib_lock);
+	chan = sdata->chan;
+	page = sdata->page;
+	spin_unlock_bh(&sdata->mib_lock);
+
+	if (chan == MAC802154_CHAN_NONE ||
+	    page >= WPAN_NUM_PAGES ||
+	    chan >= WPAN_NUM_CHANNELS) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
+	if (rc) {
+		pr_warn("encryption failed: %i\n", rc);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	skb->skb_iif = dev->ifindex;
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += skb->len;
+
+	return mac802154_tx(sdata->local, skb, page, chan);
+}
-- 
2.1.2

