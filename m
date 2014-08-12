Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59941 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbaHLNOn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:43 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so6966965lbi.38
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:14 +0200
Message-Id: <1407849255-11500-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 10/11] mac802154: use hw_to_local
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch replace the mac802154_to_priv macro with a static inline
function named hw_to_local.

This patch is part of getting wireless feeling into the ieee802154
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 8 ++++++--
 net/mac802154/main.c         | 6 +++---
 net/mac802154/rx.c           | 4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 2f0d995..1a344ab 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -101,10 +101,14 @@ struct ieee802154_local {
 #define	MAC802154_DEVICE_STOPPED	0x00
 #define MAC802154_DEVICE_RUN		0x01
 
-#define mac802154_to_priv(_hw)	container_of(_hw, struct ieee802154_local, hw)
-
 #define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
 
+static inline struct ieee802154_local *
+hw_to_local(struct ieee802154_hw *hw)
+{
+	return container_of(hw, struct ieee802154_local, hw);
+}
+
 extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 6641707..685d5bd 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL(ieee802154_alloc_hw);
 
 void ieee802154_free_hw(struct ieee802154_hw *hw)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 
 	BUG_ON(!list_empty(&local->slaves));
 
@@ -296,7 +296,7 @@ EXPORT_SYMBOL(ieee802154_free_hw);
 
 int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 	int rc = -ENOSYS;
 
 	if (hw->flags & IEEE802154_HW_TXPOWER) {
@@ -376,7 +376,7 @@ EXPORT_SYMBOL(ieee802154_register_hw);
 
 void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 	struct ieee802154_sub_if_data *sdata, *next;
 
 	flush_workqueue(local->dev_workqueue);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 730e56d..7bd3c85 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -53,7 +53,7 @@ struct rx_work {
 static void
 mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 
 	mac_cb(skb)->lqi = lqi;
 	skb->protocol = htons(ETH_P_IEEE802154);
@@ -93,7 +93,7 @@ static void mac802154_rx_worker(struct work_struct *work)
 void
 ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 	struct rx_work *work;
 
 	if (!skb)
-- 
2.0.3

