Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:58120 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaJYTS2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:18:28 -0400
Received: by mail-lb0-f171.google.com with SMTP id z11so564623lbi.2
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:18:26 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/10] mac802154: rename dev_workqueue to workqueue
Date: Sat, 25 Oct 2014 17:16:41 +0200
Message-Id: <1414250202-32384-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Small rename to use the name workqueue than dev_workqueue. To bring the
same naming convention like wireless into 802.15.4.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  2 +-
 net/mac802154/main.c         | 10 +++++-----
 net/mac802154/mib.c          |  4 ++--
 net/mac802154/rx.c           |  2 +-
 net/mac802154/tx.c           |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 61885aa..7aae692 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -48,7 +48,7 @@ struct ieee802154_local {
 	/* This one is used for scanning and other jobs not to be interfered
 	 * with serial driver.
 	 */
-	struct workqueue_struct	*dev_workqueue;
+	struct workqueue_struct	*workqueue;
 
 	/* SoftMAC device is registered and running. One can add subinterfaces.
 	 * This flag should be modified under slaves_mtx and RTNL, so you can
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index a34006e..5ce3184 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -343,9 +343,9 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 		local->phy->set_frame_retries = mac802154_set_frame_retries;
 	}
 
-	local->dev_workqueue =
+	local->workqueue =
 		create_singlethread_workqueue(wpan_phy_name(local->phy));
-	if (!local->dev_workqueue) {
+	if (!local->workqueue) {
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -370,7 +370,7 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 	return 0;
 
 out_wq:
-	destroy_workqueue(local->dev_workqueue);
+	destroy_workqueue(local->workqueue);
 out:
 	return rc;
 }
@@ -381,8 +381,8 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 	struct ieee802154_local *local = hw_to_local(hw);
 	struct ieee802154_sub_if_data *sdata, *next;
 
-	flush_workqueue(local->dev_workqueue);
-	destroy_workqueue(local->dev_workqueue);
+	flush_workqueue(local->workqueue);
+	destroy_workqueue(local->workqueue);
 
 	rtnl_lock();
 
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index d7a2504..16baff1 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -72,7 +72,7 @@ static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 	INIT_WORK(&work->work, hw_addr_notify);
 	work->dev = dev;
 	work->changed = changed;
-	queue_work(sdata->local->dev_workqueue, &work->work);
+	queue_work(sdata->local->workqueue, &work->work);
 }
 
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
@@ -205,7 +205,7 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 
 		INIT_WORK(&work->work, phy_chan_notify);
 		work->dev = dev;
-		queue_work(sdata->local->dev_workqueue, &work->work);
+		queue_work(sdata->local->workqueue, &work->work);
 	} else {
 		mutex_unlock(&sdata->local->phy->pib_lock);
 	}
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 1b5e8e3..53c9e0c 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -105,6 +105,6 @@ ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 	work->hw = hw;
 	work->lqi = lqi;
 
-	queue_work(local->dev_workqueue, &work->work);
+	queue_work(local->workqueue, &work->work);
 }
 EXPORT_SYMBOL(ieee802154_rx_irqsafe);
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 3684426..2c40d9b 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -119,7 +119,7 @@ netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
 	work->page = page;
 	work->chan = chan;
 
-	queue_work(local->dev_workqueue, &work->work);
+	queue_work(local->workqueue, &work->work);
 
 	return NETDEV_TX_OK;
 
-- 
2.1.2

