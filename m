Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:62188 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaJYTAl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:00:41 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so4150370lab.35
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:00:40 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/10] mac802154: introduce hw_to_local function
Date: Sat, 25 Oct 2014 17:16:39 +0200
Message-Id: <1414250202-32384-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replace the mac802154_to_priv macro with a static inline
function named hw_to_local. This brings a similar naming convention like
mac80211 stack.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 8 ++++++--
 net/mac802154/main.c         | 6 +++---
 net/mac802154/rx.c           | 4 ++--
 net/mac802154/tx.c           | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index b7cf41c..41e29b0 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -99,10 +99,14 @@ struct ieee802154_sub_if_data {
 	struct mac802154_llsec sec;
 };
 
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
index 34e7e61..c7799fa 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL(ieee802154_alloc_hw);
 
 void ieee802154_free_hw(struct ieee802154_hw *hw)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 
 	BUG_ON(!list_empty(&local->interfaces));
 
@@ -301,7 +301,7 @@ EXPORT_SYMBOL(ieee802154_free_hw);
 
 int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 	int rc = -ENOSYS;
 
 	if (hw->flags & IEEE802154_HW_TXPOWER) {
@@ -381,7 +381,7 @@ EXPORT_SYMBOL(ieee802154_register_hw);
 
 void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 	struct ieee802154_sub_if_data *sdata, *next;
 
 	flush_workqueue(local->dev_workqueue);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index dc01817..1b5e8e3 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -49,7 +49,7 @@ struct rx_work {
 static void
 mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 
 	mac_cb(skb)->lqi = lqi;
 	skb->protocol = htons(ETH_P_IEEE802154);
@@ -90,7 +90,7 @@ static void mac802154_rx_worker(struct work_struct *work)
 void
 ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct ieee802154_local *local = mac802154_to_priv(hw);
+	struct ieee802154_local *local = hw_to_local(hw);
 	struct rx_work *work;
 
 	if (!skb)
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index b6039c7..3684426 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -88,7 +88,7 @@ netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
 		goto err_tx;
 	}
 
-	mac802154_monitors_rx(mac802154_to_priv(&local->hw), skb);
+	mac802154_monitors_rx(local, skb);
 
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
-- 
2.1.2

