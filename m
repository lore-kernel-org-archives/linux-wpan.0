Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33232 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194AbbIUJY5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:24:57 -0400
Received: by wiclk2 with SMTP id lk2so136945383wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:24:56 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/22] mrf24j40: cleanup define identation
Date: Mon, 21 Sep 2015 11:24:22 +0200
Message-Id: <1442827483-27975-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch replaces the spaces after define by a tab.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 76 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 997724b..2b7fc00 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -23,46 +23,46 @@
 #include <net/mac802154.h>
 
 /* MRF24J40 Short Address Registers */
-#define REG_RXMCR    0x00  /* Receive MAC control */
-#define REG_PANIDL   0x01  /* PAN ID (low) */
-#define REG_PANIDH   0x02  /* PAN ID (high) */
-#define REG_SADRL    0x03  /* Short address (low) */
-#define REG_SADRH    0x04  /* Short address (high) */
-#define REG_EADR0    0x05  /* Long address (low) (high is EADR7) */
-#define REG_TXMCR    0x11  /* Transmit MAC control */
-#define REG_PACON0   0x16  /* Power Amplifier Control */
-#define REG_PACON1   0x17  /* Power Amplifier Control */
-#define REG_PACON2   0x18  /* Power Amplifier Control */
-#define REG_TXNCON   0x1B  /* Transmit Normal FIFO Control */
-#define REG_TXSTAT   0x24  /* TX MAC Status Register */
-#define REG_SOFTRST  0x2A  /* Soft Reset */
-#define REG_TXSTBL   0x2E  /* TX Stabilization */
-#define REG_INTSTAT  0x31  /* Interrupt Status */
-#define REG_INTCON   0x32  /* Interrupt Control */
-#define REG_GPIO     0x33  /* GPIO */
-#define REG_TRISGPIO 0x34  /* GPIO direction */
-#define REG_RFCTL    0x36  /* RF Control Mode Register */
-#define REG_BBREG1   0x39  /* Baseband Registers */
-#define REG_BBREG2   0x3A  /* */
-#define REG_BBREG6   0x3E  /* */
-#define REG_CCAEDTH  0x3F  /* Energy Detection Threshold */
+#define REG_RXMCR	0x00  /* Receive MAC control */
+#define REG_PANIDL	0x01  /* PAN ID (low) */
+#define REG_PANIDH	0x02  /* PAN ID (high) */
+#define REG_SADRL	0x03  /* Short address (low) */
+#define REG_SADRH	0x04  /* Short address (high) */
+#define REG_EADR0	0x05  /* Long address (low) (high is EADR7) */
+#define REG_TXMCR	0x11  /* Transmit MAC control */
+#define REG_PACON0	0x16  /* Power Amplifier Control */
+#define REG_PACON1	0x17  /* Power Amplifier Control */
+#define REG_PACON2	0x18  /* Power Amplifier Control */
+#define REG_TXNCON	0x1B  /* Transmit Normal FIFO Control */
+#define REG_TXSTAT	0x24  /* TX MAC Status Register */
+#define REG_SOFTRST	0x2A  /* Soft Reset */
+#define REG_TXSTBL	0x2E  /* TX Stabilization */
+#define REG_INTSTAT	0x31  /* Interrupt Status */
+#define REG_INTCON	0x32  /* Interrupt Control */
+#define REG_GPIO	0x33  /* GPIO */
+#define REG_TRISGPIO	0x34  /* GPIO direction */
+#define REG_RFCTL	0x36  /* RF Control Mode Register */
+#define REG_BBREG1	0x39  /* Baseband Registers */
+#define REG_BBREG2	0x3A  /* */
+#define REG_BBREG6	0x3E  /* */
+#define REG_CCAEDTH	0x3F  /* Energy Detection Threshold */
 
 /* MRF24J40 Long Address Registers */
-#define REG_RFCON0     0x200  /* RF Control Registers */
-#define REG_RFCON1     0x201
-#define REG_RFCON2     0x202
-#define REG_RFCON3     0x203
-#define REG_RFCON5     0x205
-#define REG_RFCON6     0x206
-#define REG_RFCON7     0x207
-#define REG_RFCON8     0x208
-#define REG_RSSI       0x210
-#define REG_SLPCON0    0x211  /* Sleep Clock Control Registers */
-#define REG_SLPCON1    0x220
-#define REG_WAKETIMEL  0x222  /* Wake-up Time Match Value Low */
-#define REG_WAKETIMEH  0x223  /* Wake-up Time Match Value High */
-#define REG_TESTMODE   0x22F  /* Test mode */
-#define REG_RX_FIFO    0x300  /* Receive FIFO */
+#define REG_RFCON0	0x200  /* RF Control Registers */
+#define REG_RFCON1	0x201
+#define REG_RFCON2	0x202
+#define REG_RFCON3	0x203
+#define REG_RFCON5	0x205
+#define REG_RFCON6	0x206
+#define REG_RFCON7	0x207
+#define REG_RFCON8	0x208
+#define REG_RSSI	0x210
+#define REG_SLPCON0	0x211  /* Sleep Clock Control Registers */
+#define REG_SLPCON1	0x220
+#define REG_WAKETIMEL	0x222  /* Wake-up Time Match Value Low */
+#define REG_WAKETIMEH	0x223  /* Wake-up Time Match Value High */
+#define REG_TESTMODE	0x22F  /* Test mode */
+#define REG_RX_FIFO	0x300  /* Receive FIFO */
 
 /* Device configuration: Only channels 11-26 on page 0 are supported. */
 #define MRF24J40_CHAN_MIN 11
-- 
2.5.2

