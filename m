Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:61963 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaJZIhi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:38 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so4293713lbv.21
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:37 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 13/15] mac802154: tx: change naming convention
Date: Sun, 26 Oct 2014 09:37:13 +0100
Message-Id: <1414312635-19396-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the naming convention of the tx functions like
mac80211. Just with an 802154 instead 80211 inside the name.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  6 ++++--
 net/mac802154/iface.c        |  2 +-
 net/mac802154/monitor.c      |  2 +-
 net/mac802154/tx.c           | 30 +++++++++++++++++-------------
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index a9a9d8e..ef29c10 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -121,11 +121,13 @@ int mac802154_slave_close(struct net_device *dev);
 
 void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_monitor_setup(struct net_device *dev);
-netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb, struct net_device *dev);
+netdev_tx_t
+ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_wpan_setup(struct net_device *dev);
-netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev);
+netdev_tx_t
+ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev);
 
 /* MIB callbacks */
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index f14e436..be45dc9 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -315,7 +315,7 @@ static struct header_ops mac802154_header_ops = {
 static const struct net_device_ops mac802154_wpan_ops = {
 	.ndo_open		= mac802154_wpan_open,
 	.ndo_stop		= mac802154_slave_close,
-	.ndo_start_xmit		= mac802154_wpan_xmit,
+	.ndo_start_xmit		= ieee802154_subif_start_xmit,
 	.ndo_do_ioctl		= mac802154_wpan_ioctl,
 	.ndo_set_mac_address	= mac802154_wpan_mac_addr,
 };
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index cb9600bcc..5758322 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -58,7 +58,7 @@ void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 static const struct net_device_ops mac802154_monitor_ops = {
 	.ndo_open		= mac802154_slave_open,
 	.ndo_stop		= mac802154_slave_close,
-	.ndo_start_xmit		= mac802154_monitor_xmit,
+	.ndo_start_xmit		= ieee802154_monitor_start_xmit,
 };
 
 void mac802154_monitor_setup(struct net_device *dev)
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index fe105d4..74882c7 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -31,22 +31,24 @@
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
  */
-struct wpan_xmit_cb {
+struct ieee802154_xmit_cb {
 	struct sk_buff *skb;
 	struct work_struct work;
 	struct ieee802154_local *local;
 };
 
-static inline struct wpan_xmit_cb *wpan_xmit_cb(const struct sk_buff *skb)
+static inline struct ieee802154_xmit_cb *
+ieee802154_xmit_cb(const struct sk_buff *skb)
 {
-	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct wpan_xmit_cb));
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct ieee802154_xmit_cb));
 
-	return (struct wpan_xmit_cb *)skb->cb;
+	return (struct ieee802154_xmit_cb *)skb->cb;
 }
 
-static void mac802154_xmit_worker(struct work_struct *work)
+static void ieee802154_xmit_worker(struct work_struct *work)
 {
-	struct wpan_xmit_cb *cb = container_of(work, struct wpan_xmit_cb, work);
+	struct ieee802154_xmit_cb *cb =
+		container_of(work, struct ieee802154_xmit_cb, work);
 	struct ieee802154_local *local = cb->local;
 	struct sk_buff *skb = cb->skb;
 	struct net_device *dev = skb->dev;
@@ -80,9 +82,9 @@ err_tx:
 }
 
 static netdev_tx_t
-mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
+ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 {
-	struct wpan_xmit_cb *cb = wpan_xmit_cb(skb);
+	struct ieee802154_xmit_cb *cb = ieee802154_xmit_cb(skb);
 	struct net_device *dev = skb->dev;
 	int ret;
 
@@ -111,7 +113,7 @@ mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		dev->stats.tx_packets++;
 		dev->stats.tx_bytes += skb->len;
 	} else {
-		INIT_WORK(&cb->work, mac802154_xmit_worker);
+		INIT_WORK(&cb->work, ieee802154_xmit_worker);
 		cb->skb = skb;
 		cb->local = local;
 
@@ -125,16 +127,18 @@ err_tx:
 	return NETDEV_TX_OK;
 }
 
-netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t
+ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	skb->skb_iif = dev->ifindex;
 
-	return mac802154_tx(sdata->local, skb);
+	return ieee802154_tx(sdata->local, skb);
 }
 
-netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t
+ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int rc;
@@ -148,5 +152,5 @@ netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb->skb_iif = dev->ifindex;
 
-	return mac802154_tx(sdata->local, skb);
+	return ieee802154_tx(sdata->local, skb);
 }
-- 
2.1.2

