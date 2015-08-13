Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35023 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbHMMX2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:28 -0400
Received: by wicne3 with SMTP id ne3so137297739wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:27 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 08/21] mrf24j40: add more register defines
Date: Thu, 13 Aug 2015 14:22:35 +0200
Message-Id: <1439468568-22288-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

For supporting regmap, this patch will add more register defines to
prepare a full register dump by regmap debugfs.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index e92b29a..883f2c9 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -29,21 +29,56 @@
 #define REG_SADRL	0x03  /* Short address (low) */
 #define REG_SADRH	0x04  /* Short address (high) */
 #define REG_EADR0	0x05  /* Long address (low) (high is EADR7) */
+#define REG_EADR1	0x06
+#define REG_EADR2	0x07
+#define REG_EADR3	0x08
+#define REG_EADR4	0x09
+#define REG_EADR5	0x0A
+#define REG_EADR6	0x0B
+#define REG_EADR7	0x0C
+#define REG_RXFLUSH	0x0D
+#define REG_ORDER	0x10
 #define REG_TXMCR	0x11  /* Transmit MAC control */
+#define REG_ACKTMOUT	0x12
+#define REG_ESLOTG1	0x13
+#define REG_SYMTICKL	0x14
+#define REG_SYMTICKH	0x15
 #define REG_PACON0	0x16  /* Power Amplifier Control */
 #define REG_PACON1	0x17  /* Power Amplifier Control */
 #define REG_PACON2	0x18  /* Power Amplifier Control */
+#define REG_TXBCON0	0x1A
 #define REG_TXNCON	0x1B  /* Transmit Normal FIFO Control */
+#define REG_TXG1CON	0x1C
+#define REG_TXG2CON	0x1D
+#define REG_ESLOTG23	0x1E
+#define REG_ESLOTG45	0x1F
+#define REG_ESLOTG67	0x20
+#define REG_TXPEND	0x21
+#define REG_WAKECON	0x22
+#define REG_FROMOFFSET	0x23
 #define REG_TXSTAT	0x24  /* TX MAC Status Register */
+#define REG_TXBCON1	0x25
+#define REG_GATECLK	0x26
+#define REG_TXTIME	0x27
+#define REG_HSYMTMRL	0x28
+#define REG_HSYMTMRH	0x29
 #define REG_SOFTRST	0x2A  /* Soft Reset */
+#define REG_SECCON0	0x2C
+#define REG_SECCON1	0x2D
 #define REG_TXSTBL	0x2E  /* TX Stabilization */
+#define REG_RXSR	0x30
 #define REG_INTSTAT	0x31  /* Interrupt Status */
 #define REG_INTCON	0x32  /* Interrupt Control */
 #define REG_GPIO	0x33  /* GPIO */
 #define REG_TRISGPIO	0x34  /* GPIO direction */
+#define REG_SLPACK	0x35
 #define REG_RFCTL	0x36  /* RF Control Mode Register */
+#define REG_SECCR2	0x37
+#define REG_BBREG0	0x38
 #define REG_BBREG1	0x39  /* Baseband Registers */
 #define REG_BBREG2	0x3A  /* */
+#define REG_BBREG3	0x3B
+#define REG_BBREG4	0x3C
 #define REG_BBREG6	0x3E  /* */
 #define REG_CCAEDTH	0x3F  /* Energy Detection Threshold */
 
@@ -56,12 +91,45 @@
 #define REG_RFCON6	0x206
 #define REG_RFCON7	0x207
 #define REG_RFCON8	0x208
+#define REG_SLPCAL0	0x209
+#define REG_SLPCAL1	0x20A
+#define REG_SLPCAL2	0x20B
+#define REG_RFSTATE	0x20F
 #define REG_RSSI	0x210
 #define REG_SLPCON0	0x211  /* Sleep Clock Control Registers */
 #define REG_SLPCON1	0x220
 #define REG_WAKETIMEL	0x222  /* Wake-up Time Match Value Low */
 #define REG_WAKETIMEH	0x223  /* Wake-up Time Match Value High */
+#define REG_REMCNTL	0x224
+#define REG_REMCNTH	0x225
+#define REG_MAINCNT0	0x226
+#define REG_MAINCNT1	0x227
+#define REG_MAINCNT2	0x228
+#define REG_MAINCNT3	0x229
 #define REG_TESTMODE	0x22F  /* Test mode */
+#define REG_ASSOEAR0	0x230
+#define REG_ASSOEAR1	0x231
+#define REG_ASSOEAR2	0x232
+#define REG_ASSOEAR3	0x233
+#define REG_ASSOEAR4	0x234
+#define REG_ASSOEAR5	0x235
+#define REG_ASSOEAR6	0x236
+#define REG_ASSOEAR7	0x237
+#define REG_ASSOSAR0	0x238
+#define REG_ASSOSAR1	0x239
+#define REG_UNONCE0	0x240
+#define REG_UNONCE1	0x241
+#define REG_UNONCE2	0x242
+#define REG_UNONCE3	0x243
+#define REG_UNONCE4	0x244
+#define REG_UNONCE5	0x245
+#define REG_UNONCE6	0x246
+#define REG_UNONCE7	0x247
+#define REG_UNONCE8	0x248
+#define REG_UNONCE9	0x249
+#define REG_UNONCE10	0x24A
+#define REG_UNONCE11	0x24B
+#define REG_UNONCE12	0x24C
 #define REG_RX_FIFO	0x300  /* Receive FIFO */
 
 /* Device configuration: Only channels 11-26 on page 0 are supported. */
-- 
2.5.0

