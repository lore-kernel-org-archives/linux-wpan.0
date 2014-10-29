Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61677 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2Uf5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:57 -0400
Received: by mail-wg0-f42.google.com with SMTP id k14so4193396wgh.1
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/17] mac802154: separate omit tx/rx flags
Date: Wed, 29 Oct 2014 21:34:34 +0100
Message-Id: <1414614884-20243-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch splits the IEEE802154_HW_OMIT_CKSUM hardware flag into
IEEE802154_HW_TX_OMIT_CKSUM and IEEE802154_HW_RX_OMIT_CKSUM. This is
useful to deliver the received crc from the driver layer to the monitor
interface. At the moment we can't do that without change the xmit
handling.

The received checksum should be visible in monitor mode only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 10 ++++++++--
 net/mac802154/rx.c      |  2 +-
 net/mac802154/tx.c      |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 166ef6c5..bc1d40c 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -73,8 +73,8 @@ struct ieee802154_hw {
  * however, so you are advised to review these flags carefully.
  */
 
-/* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
-#define IEEE802154_HW_OMIT_CKSUM	0x00000001
+/* Indicates that xmitter will add FCS on it's own. */
+#define IEEE802154_HW_TX_OMIT_CKSUM	0x00000001
 /* Indicates that receiver will autorespond with ACK frames. */
 #define IEEE802154_HW_AACK		0x00000002
 /* Indicates that transceiver will support transmit power setting. */
@@ -94,6 +94,12 @@ struct ieee802154_hw {
 #define IEEE802154_HW_AFILT		0x00000100
 /* Indicates that transceiver will support promiscuous mode setting. */
 #define IEEE802154_HW_PROMISCUOUS	0x00000200
+/* Indicates that receiver omits FCS. */
+#define IEEE802154_HW_RX_OMIT_CKSUM	0x00000400
+
+/* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
+#define IEEE802154_HW_OMIT_CKSUM	(IEEE802154_HW_TX_OMIT_CKSUM | \
+					 IEEE802154_HW_RX_OMIT_CKSUM)
 
 /* This groups the most common CSMA support fields into one. */
 #define IEEE802154_HW_CSMA		(IEEE802154_HW_CCA_MODE | \
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 86394be..2aa80bd 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -255,7 +255,7 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
-	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
+	if (!(local->hw.flags & IEEE802154_HW_RX_OMIT_CKSUM)) {
 		u16 crc;
 
 		if (skb->len < 2) {
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 77973a8..cc37b77 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -83,7 +83,7 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int ret;
 
-	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
+	if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
 		put_unaligned_le16(crc, skb_put(skb, 2));
-- 
2.1.2

