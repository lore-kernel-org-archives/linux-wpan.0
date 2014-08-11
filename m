Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:56566 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaHKLae (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 07:30:34 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 13:25:10 +0200
Message-Id: <1407756310-26592-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH 4/4] mac802154: common tx error path
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkab@cdac.in>

This patch introduce the common error path on failure of Tx by
inserting the label 'err_tx'.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 8124353..fdf4c0e6 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -89,8 +89,7 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
 
 	if (!(priv->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
+		goto err_tx;
 	}
 
 	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
@@ -103,12 +102,10 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
 		data[1] = crc >> 8;
 	}
 
-	if (skb_cow_head(skb, priv->hw.extra_tx_headroom)) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
+	if (skb_cow_head(skb, priv->hw.extra_tx_headroom))
+		goto err_tx;
 
-	work = kzalloc(sizeof(struct xmit_work), GFP_ATOMIC);
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
 	if (!work) {
 		kfree_skb(skb);
 		return NETDEV_TX_BUSY;
@@ -129,4 +126,8 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
 	queue_work(priv->dev_workqueue, &work->work);
 
 	return NETDEV_TX_OK;
+
+err_tx:
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
 }
-- 
2.0.3

