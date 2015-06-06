Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36695 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbFFPbK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:10 -0400
Received: by wgbgq6 with SMTP id gq6so75094912wgb.3
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/8] mac802154: cleanup ieee802154 hardware flags
Date: Sat,  6 Jun 2015 17:30:49 +0200
Message-Id: <1433604653-9585-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the ieee802154 hardware flags to enums and setting the
flag values with the BIT macro. Additional this patch changes the
commenting style for matching usual kernel style.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 56 +++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index a20ba28..c21a700 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -79,32 +79,48 @@ struct ieee802154_hw {
 	struct	wpan_phy *phy;
 };
 
-/* Checksum is in hardware and is omitted from a packet
+/**
+ * enum ieee802154_hw_flags - hardware flags
  *
- * These following flags are used to indicate hardware capabilities to
+ * These flags are used to indicate hardware capabilities to
  * the stack. Generally, flags here should have their meaning
  * done in a way that the simplest hardware doesn't need setting
  * any particular flags. There are some exceptions to this rule,
  * however, so you are advised to review these flags carefully.
+ *
+ * @IEEE802154_HW_TX_OMIT_CKSUM: Indicates that xmitter will add FCS on it's
+ *	own.
+ *
+ * @IEEE802154_HW_LBT: Indicates that transceiver will support listen before
+ *	transmit.
+ *
+ * @IEEE802154_HW_CSMA_PARAMS: Indicates that transceiver will support csma
+ *	parameters (max_be, min_be, backoff exponents).
+ *
+ * @IEEE802154_HW_FRAME_RETRIES: Indicates that transceiver will support ARET
+ *	frame retries setting.
+ *
+ * @IEEE802154_HW_AFILT: Indicates that transceiver will support hardware
+ *	address filter setting.
+ *
+ * @IEEE802154_HW_PROMISCUOUS: Indicates that transceiver will support
+ *	promiscuous mode setting.
+ *
+ * @IEEE802154_HW_RX_OMIT_CKSUM: Indicates that receiver omits FCS.
+ *
+ * @IEEE802154_HW_RX_DROP_BAD_CKSUM: Indicates that receiver will not filter
+ *	frames with bad checksum.
  */
-
-/* Indicates that xmitter will add FCS on it's own. */
-#define IEEE802154_HW_TX_OMIT_CKSUM	0x00000001
-/* Indicates that transceiver will support listen before transmit. */
-#define IEEE802154_HW_LBT		0x00000004
-/* Indicates that transceiver will support csma (max_be, min_be, csma retries)
- * settings. */
-#define IEEE802154_HW_CSMA_PARAMS	0x00000008
-/* Indicates that transceiver will support ARET frame retries setting. */
-#define IEEE802154_HW_FRAME_RETRIES	0x00000010
-/* Indicates that transceiver will support hardware address filter setting. */
-#define IEEE802154_HW_AFILT		0x00000020
-/* Indicates that transceiver will support promiscuous mode setting. */
-#define IEEE802154_HW_PROMISCUOUS	0x00000040
-/* Indicates that receiver omits FCS. */
-#define IEEE802154_HW_RX_OMIT_CKSUM	0x00000080
-/* Indicates that receiver will not filter frames with bad checksum. */
-#define IEEE802154_HW_RX_DROP_BAD_CKSUM	0x00000100
+enum ieee802154_hw_flags {
+	IEEE802154_HW_TX_OMIT_CKSUM	= BIT(1),
+	IEEE802154_HW_LBT		= BIT(2),
+	IEEE802154_HW_CSMA_PARAMS	= BIT(3),
+	IEEE802154_HW_FRAME_RETRIES	= BIT(4),
+	IEEE802154_HW_AFILT		= BIT(5),
+	IEEE802154_HW_PROMISCUOUS	= BIT(6),
+	IEEE802154_HW_RX_OMIT_CKSUM	= BIT(7),
+	IEEE802154_HW_RX_DROP_BAD_CKSUM	= BIT(8),
+};
 
 /* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
 #define IEEE802154_HW_OMIT_CKSUM	(IEEE802154_HW_TX_OMIT_CKSUM | \
-- 
2.4.1

