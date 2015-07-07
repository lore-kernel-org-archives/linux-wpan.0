Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35628 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbGGFVV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Jul 2015 01:21:21 -0400
Received: by pdbci14 with SMTP id ci14so118792796pdb.2
        for <linux-wpan@vger.kernel.org>; Mon, 06 Jul 2015 22:21:21 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/2] mac802154: do not export ieee802154_rx()
Date: Tue,  7 Jul 2015 10:50:42 +0530
Message-Id: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

Right now there are no other users for ieee802154_rx()
in kernel. So lets remove EXPORT_SYMBOL() for this.

Also it moves the function prototype from global header
file to local header file.

Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
---
 include/net/mac802154.h      |   17 -----------------
 net/mac802154/ieee802154_i.h |    1 +
 net/mac802154/rx.c           |    1 -
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index f534a46..b7f9961 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -321,23 +321,6 @@ int ieee802154_register_hw(struct ieee802154_hw *hw);
 void ieee802154_unregister_hw(struct ieee802154_hw *hw);
 
 /**
- * ieee802154_rx - receive frame
- *
- * Use this function to hand received frames to mac802154. The receive
- * buffer in @skb must start with an IEEE 802.15.4 header. In case of a
- * paged @skb is used, the driver is recommended to put the ieee802154
- * header of the frame on the linear part of the @skb to avoid memory
- * allocation and/or memcpy by the stack.
- *
- * This function may not be called in IRQ context. Calls to this function
- * for a single hardware must be synchronized against each other.
- *
- * @hw: the hardware this frame came in on
- * @skb: the buffer to receive, owned by mac802154 after this call
- */
-void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
-
-/**
  * ieee802154_rx_irqsafe - receive frame
  *
  * Like ieee802154_rx() but can be called in IRQ context
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 0054f39..eb8502a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -124,6 +124,7 @@ ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
 
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
+void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
 netdev_tx_t
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 5a258c1..7791c9b 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -290,7 +290,6 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 drop:
 	kfree_skb(skb);
 }
-EXPORT_SYMBOL(ieee802154_rx);
 
 void
 ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
-- 
1.7.9.5

