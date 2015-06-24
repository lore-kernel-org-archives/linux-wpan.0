Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33093 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbFXJiS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 05:38:18 -0400
Received: by wgck11 with SMTP id k11so31256033wgc.0
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jun 2015 02:38:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] mac802154: cfg: add suspend and resume callbacks
Date: Wed, 24 Jun 2015 11:36:36 +0200
Message-Id: <1435138596-25909-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1435138596-25909-1-git-send-email-alex.aring@gmail.com>
References: <1435138596-25909-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, varkab@cdac.in, Alexander Aring <alex.aring@gmail.com>

This patch introduces suspend and resume callbacks to mac802154. When
doing suspend we calling the stop driver callback which should stop the
receiving of frames. A transceiver should go into low-power mode then.
Calling resume will call the start driver callback, which starts receiving
again and allow to transmit frames.

This was tested only with the fakelb driver and a qemu vm by doing the
following commands:

echo "devices" > /sys/power/pm_test
echo "freeze" > /sys/power/state

while doing some high traffic between two fakelb phys.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/cfg.c          | 45 ++++++++++++++++++++++++++++++++++++++++++++
 net/mac802154/ieee802154_i.h |  1 +
 net/mac802154/rx.c           | 10 ++++++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 44db861..f7ba51e 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -44,6 +44,49 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 	ieee802154_if_remove(sdata);
 }
 
+#ifdef CONFIG_PM
+static int ieee802154_suspend(struct wpan_phy *wpan_phy)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+
+	if (!local->open_count)
+		goto suspend;
+
+	ieee802154_stop_queue(&local->hw);
+	synchronize_net();
+
+	/* stop hardware - this must stop RX */
+	ieee802154_stop_device(local);
+
+suspend:
+	local->suspended = true;
+	return 0;
+}
+
+static int ieee802154_resume(struct wpan_phy *wpan_phy)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	/* nothing to do if HW shouldn't run */
+	if (!local->open_count)
+		goto wake_up;
+
+	/* restart hardware */
+	ret = drv_start(local);
+	if (ret)
+		return ret;
+
+wake_up:
+	ieee802154_wake_queue(&local->hw);
+	local->suspended = false;
+	return 0;
+}
+#else
+#define ieee802154_suspend NULL
+#define ieee802154_resume NULL
+#endif
+
 static int
 ieee802154_add_iface(struct wpan_phy *phy, const char *name,
 		     unsigned char name_assign_type,
@@ -232,6 +275,8 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
+	.suspend = ieee802154_suspend,
+	.resume = ieee802154_resume,
 	.add_virtual_intf = ieee802154_add_iface,
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 0407783..0054f39 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -56,6 +56,7 @@ struct ieee802154_local {
 	struct hrtimer ifs_timer;
 
 	bool started;
+	bool suspended;
 
 	struct tasklet_struct tasklet;
 	struct sk_buff_head skb_queue;
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index d93ad2d..5a258c1 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -253,6 +253,9 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
+	if (local->suspended)
+		goto drop;
+
 	/* TODO: When a transceiver omits the checksum here, we
 	 * add an own calculated one. This is currently an ugly
 	 * solution because the monitor needs a crc here.
@@ -273,8 +276,7 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 		crc = crc_ccitt(0, skb->data, skb->len);
 		if (crc) {
 			rcu_read_unlock();
-			kfree_skb(skb);
-			return;
+			goto drop;
 		}
 	}
 	/* remove crc */
@@ -283,6 +285,10 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	__ieee802154_rx_handle_packet(local, skb);
 
 	rcu_read_unlock();
+
+	return;
+drop:
+	kfree_skb(skb);
 }
 EXPORT_SYMBOL(ieee802154_rx);
 
-- 
2.4.4

