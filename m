Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:63588 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaHOKaC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:02 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so2142102wev.26
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:41 +0200
Message-Id: <1408098592-13412-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 01/12] mac802154: tx: move xmit callback to tx file
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch moves the mac802154_wpan_xmit function into the tx.c file.
Currently this callback is named wpan inidcates that this callback is
for WPAN (NODE) virtual interfaces.

In future this should be a generic function, we do a switch case over
interface type variable to make different interface type handling.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  4 +---
 net/mac802154/iface.c        | 33 ---------------------------------
 net/mac802154/tx.c           | 36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index fcb00a0..d6b961a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -136,9 +136,7 @@ extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
 void mac802154_wpan_setup(struct net_device *dev);
-
-netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
-			 u8 page, u8 chan);
+netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev);
 
 /* MIB callbacks */
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 61fa188..59c5226 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -377,39 +377,6 @@ mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 	return sizeof(*addr);
 }
 
-static netdev_tx_t
-mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	u8 chan, page;
-	int rc;
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
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 277ccd1..5f165ec 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -81,8 +81,8 @@ out:
 	kfree(xw);
 }
 
-netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
-			 u8 page, u8 chan)
+static netdev_tx_t mac802154_tx(struct ieee802154_local *local,
+				struct sk_buff *skb, u8 page, u8 chan)
 {
 	struct xmit_work *work;
 	struct ieee802154_sub_if_data *sdata;
@@ -129,3 +129,35 @@ err_tx:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
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
2.0.3

