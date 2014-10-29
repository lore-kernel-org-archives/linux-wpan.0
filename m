Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:55731 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2UgB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:01 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so2771976wgh.28
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/17] mac802154: rx: add software checksum filtering check
Date: Wed, 29 Oct 2014 21:34:37 +0100
Message-Id: <1414614884-20243-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new hardware flag which indicate that the transceiver
doesn't support check for bad checksum via hardware. Also add a handling of
this while receive.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h |  2 ++
 net/mac802154/rx.c      | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index bc1d40c..8f1de68 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -96,6 +96,8 @@ struct ieee802154_hw {
 #define IEEE802154_HW_PROMISCUOUS	0x00000200
 /* Indicates that receiver omits FCS. */
 #define IEEE802154_HW_RX_OMIT_CKSUM	0x00000400
+/* Indicates that receiver will not filter frames with bad checksum. */
+#define IEEE802154_HW_RX_DROP_BAD_CKSUM	0x00000800
 
 /* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
 #define IEEE802154_HW_OMIT_CKSUM	(IEEE802154_HW_TX_OMIT_CKSUM | \
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index b6a4bbf..c9f1c72 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -248,6 +248,7 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
+	u16 crc;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -256,8 +257,7 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	 * solution because the monitor needs a crc here.
 	 */
 	if (local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
-
+		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
@@ -265,6 +265,17 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	ieee802154_monitors_rx(local, skb);
 
+	/* Check if transceiver doesn't validate the checksum.
+	 * If not we validate the checksum here.
+	 */
+	if (local->hw.flags & IEEE802154_HW_RX_DROP_BAD_CKSUM) {
+		crc = crc_ccitt(0, skb->data, skb->len);
+		if (crc) {
+			rcu_read_unlock();
+			kfree_skb(skb);
+			return;
+		}
+	}
 	/* remove crc */
 	skb_trim(skb, skb->len - 2);
 
-- 
2.1.2

