Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41394 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbaKLSwH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Nov 2014 13:52:07 -0500
Received: by mail-wi0-f180.google.com with SMTP id hi2so5865081wib.13
        for <linux-wpan@vger.kernel.org>; Wed, 12 Nov 2014 10:52:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] mac802154: add interframe spacing time handling
Date: Wed, 12 Nov 2014 19:51:56 +0100
Message-Id: <1415818317-26487-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
References: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new interframe spacing time handling into mac802154
layer. Interframe spacing time is a time period between each transmit.
This patch adds a high resolution timer into mac802154 and starts on
xmit complete with corresponding interframe spacing expire time if
ifs_handling is true. We make it variable because it depends if
interframe spacing time is handled by transceiver or mac802154. At the
timer complete function we wake the netdev queue again. This avoids
new frame transmit in range of interframe spacing time.

For synced driver we add no handling of interframe spacing time. This
is currently a lack of support in all synced xmit drivers. I suppose
it's working because the latency of workqueue which is needed to call
spi_sync.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c |  2 +-
 include/linux/ieee802154.h         |  3 +++
 include/net/cfg802154.h            |  8 ++++++++
 include/net/mac802154.h            |  3 ++-
 net/mac802154/ieee802154_i.h       |  4 ++++
 net/mac802154/iface.c              |  2 ++
 net/mac802154/main.c               | 17 +++++++++++++++++
 net/mac802154/tx.c                 |  2 +-
 net/mac802154/util.c               | 32 +++++++++++++++++++++++++++++---
 9 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 31d62f9..46e5029 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -731,7 +731,7 @@ at86rf230_tx_complete(void *context)
 			udelay(lp->data->t_sifs);
 	}
 
-	ieee802154_xmit_complete(lp->hw, skb);
+	ieee802154_xmit_complete(lp->hw, skb, false);
 }
 
 static void
diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index ce0f96a..5a40c04 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -36,6 +36,9 @@
 
 #define IEEE802154_EXTENDED_ADDR_LEN	8
 
+#define IEEE802154_LIFS_PERIOD		40
+#define IEEE802154_SIFS_PERIOD		12
+
 #define IEEE802154_FC_TYPE_BEACON	0x0	/* Frame is beacon */
 #define	IEEE802154_FC_TYPE_DATA		0x1	/* Frame is data */
 #define IEEE802154_FC_TYPE_ACK		0x2	/* Frame is acknowledgment */
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index fa0a9e5..17b4fc0 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -81,6 +81,14 @@ struct wpan_phy {
 
 	s32 cca_ed_level;
 
+	/* PHY depended MAC PIB values */
+
+	/* 802.15.4 acronym: Tdsym in usec */
+	u8 symbol_duration;
+	/* lifs and sifs periods timing */
+	u16 lifs_period;
+	u16 sifs_period;
+
 	struct device dev;
 
 	char priv[0] __aligned(NETDEV_ALIGN);
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 632f656..c823d91 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -260,6 +260,7 @@ void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
 
 void ieee802154_wake_queue(struct ieee802154_hw *hw);
 void ieee802154_stop_queue(struct ieee802154_hw *hw);
-void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb);
+void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
+			      bool ifs_handling);
 
 #endif /* NET_MAC802154_H */
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 69cb585..c5b2310 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -20,6 +20,7 @@
 #define __IEEE802154_I_H
 
 #include <linux/mutex.h>
+#include <linux/hrtimer.h>
 #include <net/cfg802154.h>
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
@@ -51,6 +52,8 @@ struct ieee802154_local {
 	 */
 	struct workqueue_struct	*workqueue;
 
+	struct hrtimer ifs_timer;
+
 	bool started;
 
 	struct tasklet_struct tasklet;
@@ -127,6 +130,7 @@ ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void mac802154_wpan_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev);
+enum hrtimer_restart ieee802154_xmit_ifs_timer(struct hrtimer *timer);
 
 /* MIB callbacks */
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ec92b48..feb0647 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -246,6 +246,8 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+	hrtimer_cancel(&local->ifs_timer);
+
 	netif_stop_queue(dev);
 	local->open_count--;
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 46c76e0..0af1be6 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -125,6 +125,18 @@ void ieee802154_free_hw(struct ieee802154_hw *hw)
 }
 EXPORT_SYMBOL(ieee802154_free_hw);
 
+static void ieee802154_setup_wpan_phy_pib(struct wpan_phy *wpan_phy)
+{
+	/* TODO warn on empty symbol_duration
+	 * Should be done when all drivers sets this value.
+	 */
+
+	wpan_phy->lifs_period = IEEE802154_LIFS_PERIOD *
+				wpan_phy->symbol_duration;
+	wpan_phy->sifs_period = IEEE802154_SIFS_PERIOD *
+				wpan_phy->symbol_duration;
+}
+
 int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
@@ -138,8 +150,13 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 		goto out;
 	}
 
+	hrtimer_init(&local->ifs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	local->ifs_timer.function = ieee802154_xmit_ifs_timer;
+
 	wpan_phy_set_dev(local->phy, local->hw.parent);
 
+	ieee802154_setup_wpan_phy_pib(local->phy);
+
 	rc = wpan_phy_register(local->phy);
 	if (rc < 0)
 		goto out_wq;
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index cc37b77..c62e956 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -60,7 +60,7 @@ static void ieee802154_xmit_worker(struct work_struct *work)
 	if (res)
 		goto err_tx;
 
-	ieee802154_xmit_complete(&local->hw, skb);
+	ieee802154_xmit_complete(&local->hw, skb, false);
 
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 9a04e4a..5fc9790 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -50,9 +50,35 @@ void ieee802154_stop_queue(struct ieee802154_hw *hw)
 }
 EXPORT_SYMBOL(ieee802154_stop_queue);
 
-void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb)
+enum hrtimer_restart ieee802154_xmit_ifs_timer(struct hrtimer *timer)
 {
-	ieee802154_wake_queue(hw);
-	consume_skb(skb);
+	struct ieee802154_local *local =
+		container_of(timer, struct ieee802154_local, ifs_timer);
+
+	ieee802154_wake_queue(&local->hw);
+
+	return HRTIMER_NORESTART;
+}
+
+void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
+			      bool ifs_handling)
+{
+	if (ifs_handling) {
+		struct ieee802154_local *local = hw_to_local(hw);
+
+		if (skb->len > 18)
+			hrtimer_start(&local->ifs_timer,
+				      ktime_set(0, hw->phy->lifs_period * NSEC_PER_USEC),
+				      HRTIMER_MODE_REL);
+		else
+			hrtimer_start(&local->ifs_timer,
+				      ktime_set(0, hw->phy->sifs_period * NSEC_PER_USEC),
+				      HRTIMER_MODE_REL);
+
+		consume_skb(skb);
+	} else {
+		ieee802154_wake_queue(hw);
+		consume_skb(skb);
+	}
 }
 EXPORT_SYMBOL(ieee802154_xmit_complete);
-- 
2.1.3

