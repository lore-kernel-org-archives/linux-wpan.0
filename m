Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:47906 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2UgA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:00 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so2764914wgh.35
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:59 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/17] mac802154: rx: simplify crc receive handling
Date: Wed, 29 Oct 2014 21:34:36 +0100
Message-Id: <1414614884-20243-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch change the actual crc handling while receive. Currently the
IEEE802154_HW_RX_OMIT_CKSUM flag is used to filter a frame with a bad crc.
This patch changes the behaviour of IEEE802154_HW_RX_OMIT_CKSUM to add a
crc while receiving for the monitor interface. After monitor receiving
we remove the crc for frame parsing. This affect the driver layer
because all drivers sets IEEE802154_HW_RX_OMIT_CKSUM and deliver without
checksum.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 51a55d9..b6a4bbf 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/crc-ccitt.h>
+#include <asm/unaligned.h>
 
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
@@ -225,8 +226,6 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct sk_buff *skb2;
 	struct ieee802154_sub_if_data *sdata;
-	u16 crc = crc_ccitt(0, skb->data, skb->len);
-	u8 *data;
 
 	skb_reset_mac_header(skb);
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -241,9 +240,6 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		skb2 = skb_clone(skb, GFP_ATOMIC);
 		skb2->dev = sdata->dev;
 		skb2->pkt_type = PACKET_HOST;
-		data = skb_put(skb2, 2);
-		data[0] = crc & 0xff;
-		data[1] = crc >> 8;
 
 		netif_rx_ni(skb2);
 	}
@@ -255,32 +251,26 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
-	if (!(local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM)) {
-		u16 crc;
+	/* TODO: When a transceiver omits the checksum here, we
+	 * add an own calculated one. This is currently an ugly
+	 * solution because the monitor needs a crc here.
+	 */
+	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
+		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
-		if (skb->len < 2) {
-			pr_debug("got invalid frame\n");
-			goto fail;
-		}
-		crc = crc_ccitt(0, skb->data, skb->len);
-		if (crc) {
-			pr_debug("CRC mismatch\n");
-			goto fail;
-		}
-		skb_trim(skb, skb->len - 2); /* CRC */
+		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
 	rcu_read_lock();
 
 	ieee802154_monitors_rx(local, skb);
-	__ieee802154_rx_handle_packet(local, skb);
 
-	rcu_read_unlock();
+	/* remove crc */
+	skb_trim(skb, skb->len - 2);
 
-	return;
+	__ieee802154_rx_handle_packet(local, skb);
 
-fail:
-	kfree_skb(skb);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee802154_rx);
 
-- 
2.1.2

