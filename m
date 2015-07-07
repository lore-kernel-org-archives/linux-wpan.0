Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33162 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbGGFVY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Jul 2015 01:21:24 -0400
Received: by pacws9 with SMTP id ws9so108398523pac.0
        for <linux-wpan@vger.kernel.org>; Mon, 06 Jul 2015 22:21:24 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 2/2] mac802154: fix ieee802154_rx handling
Date: Tue,  7 Jul 2015 10:50:43 +0530
Message-Id: <1436246443-8243-2-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
References: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

Instead of passing ieee802154_hw pointer to ieee802154_rx,
we can directly pass the ieee802154_local pointer.

Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
---
 net/mac802154/ieee802154_i.h |    2 +-
 net/mac802154/main.c         |    2 +-
 net/mac802154/rx.c           |    3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index eb8502a..6810d7a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -124,7 +124,7 @@ ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
 
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
-void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
+void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
 netdev_tx_t
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 4caf04b..91f1208 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -40,7 +40,7 @@ static void ieee802154_tasklet_handler(unsigned long data)
 			 * netstack.
 			 */
 			skb->pkt_type = 0;
-			ieee802154_rx(&local->hw, skb);
+			ieee802154_rx(local, skb);
 			break;
 		default:
 			WARN(1, "mac802154: Packet is of unknown type %d\n",
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 7791c9b..d1c33c1 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -246,9 +246,8 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	}
 }
 
-void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
+void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
-	struct ieee802154_local *local = hw_to_local(hw);
 	u16 crc;
 
 	WARN_ON_ONCE(softirq_count() == 0);
-- 
1.7.9.5

