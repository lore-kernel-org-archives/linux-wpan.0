Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37060 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371AbbIUJZX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:23 -0400
Received: by wicfx3 with SMTP id fx3so102115094wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 22/22] mrf24j40: replace magic numbers
Date: Mon, 21 Sep 2015 11:24:43 +0200
Message-Id: <1442827483-27975-23-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch replaces some magic numbers with defines for register bits,
mask and shifts.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 136 +++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 9a8d517..2770df1 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -26,6 +26,11 @@
 
 /* MRF24J40 Short Address Registers */
 #define REG_RXMCR	0x00  /* Receive MAC control */
+#define BIT_PROMI	BIT(0)
+#define BIT_ERRPKT	BIT(1)
+#define BIT_NOACKRSP	BIT(5)
+#define BIT_PANCOORD	BIT(3)
+
 #define REG_PANIDL	0x01  /* PAN ID (low) */
 #define REG_PANIDH	0x02  /* PAN ID (high) */
 #define REG_SADRL	0x03  /* Short address (low) */
@@ -41,6 +46,11 @@
 #define REG_RXFLUSH	0x0D
 #define REG_ORDER	0x10
 #define REG_TXMCR	0x11  /* Transmit MAC control */
+#define TXMCR_MIN_BE_SHIFT		3
+#define TXMCR_MIN_BE_MASK		0x18
+#define TXMCR_CSMA_RETRIES_SHIFT	0
+#define TXMCR_CSMA_RETRIES_MASK		0x07
+
 #define REG_ACKTMOUT	0x12
 #define REG_ESLOTG1	0x13
 #define REG_SYMTICKL	0x14
@@ -50,6 +60,9 @@
 #define REG_PACON2	0x18  /* Power Amplifier Control */
 #define REG_TXBCON0	0x1A
 #define REG_TXNCON	0x1B  /* Transmit Normal FIFO Control */
+#define BIT_TXNTRIG	BIT(0)
+#define BIT_TXNACKREQ	BIT(2)
+
 #define REG_TXG1CON	0x1C
 #define REG_TXG2CON	0x1D
 #define REG_ESLOTG23	0x1E
@@ -70,15 +83,28 @@
 #define REG_TXSTBL	0x2E  /* TX Stabilization */
 #define REG_RXSR	0x30
 #define REG_INTSTAT	0x31  /* Interrupt Status */
+#define BIT_TXNIF	BIT(0)
+#define BIT_RXIF	BIT(3)
+
 #define REG_INTCON	0x32  /* Interrupt Control */
+#define BIT_TXNIE	BIT(0)
+#define BIT_RXIE	BIT(3)
+
 #define REG_GPIO	0x33  /* GPIO */
 #define REG_TRISGPIO	0x34  /* GPIO direction */
 #define REG_SLPACK	0x35
 #define REG_RFCTL	0x36  /* RF Control Mode Register */
+#define BIT_RFRST	BIT(2)
+
 #define REG_SECCR2	0x37
 #define REG_BBREG0	0x38
 #define REG_BBREG1	0x39  /* Baseband Registers */
+#define BIT_RXDECINV	BIT(2)
+
 #define REG_BBREG2	0x3A  /* */
+#define BBREG2_CCA_MODE_SHIFT	6
+#define BBREG2_CCA_MODE_MASK	0xc0
+
 #define REG_BBREG3	0x3B
 #define REG_BBREG4	0x3C
 #define REG_BBREG6	0x3E  /* */
@@ -86,9 +112,32 @@
 
 /* MRF24J40 Long Address Registers */
 #define REG_RFCON0	0x200  /* RF Control Registers */
+#define RFCON0_CH_SHIFT	4
+#define RFCON0_CH_MASK	0xf0
+#define RFOPT_RECOMMEND	3
+
 #define REG_RFCON1	0x201
 #define REG_RFCON2	0x202
 #define REG_RFCON3	0x203
+
+#define TXPWRL_MASK	0xc0
+#define TXPWRL_SHIFT	6
+#define TXPWRL_30	0x3
+#define TXPWRL_20	0x2
+#define TXPWRL_10	0x1
+#define TXPWRL_0	0x0
+
+#define TXPWRS_MASK	0x38
+#define TXPWRS_SHIFT	3
+#define TXPWRS_6_3	0x7
+#define TXPWRS_4_9	0x6
+#define TXPWRS_3_7	0x5
+#define TXPWRS_2_8	0x4
+#define TXPWRS_1_9	0x3
+#define TXPWRS_1_2	0x2
+#define TXPWRS_0_5	0x1
+#define TXPWRS_0	0x0
+
 #define REG_RFCON5	0x205
 #define REG_RFCON6	0x206
 #define REG_RFCON7	0x207
@@ -99,6 +148,8 @@
 #define REG_RFSTATE	0x20F
 #define REG_RSSI	0x210
 #define REG_SLPCON0	0x211  /* Sleep Clock Control Registers */
+#define BIT_INTEDGE	BIT(1)
+
 #define REG_SLPCON1	0x220
 #define REG_WAKETIMEL	0x222  /* Wake-up Time Match Value Low */
 #define REG_WAKETIMEH	0x223  /* Wake-up Time Match Value High */
@@ -493,11 +544,11 @@ static void write_tx_buf_complete(void *context)
 {
 	struct mrf24j40 *devrec = context;
 	__le16 fc = ieee802154_get_fc_from_skb(devrec->tx_skb);
-	u8 val = 0x01;
+	u8 val = BIT_TXNTRIG;
 	int ret;
 
 	if (ieee802154_is_ackreq(fc))
-		val |= 0x04;
+		val |= BIT_TXNACKREQ;
 
 	devrec->tx_post_msg.complete = NULL;
 	devrec->tx_post_buf[0] = MRF24J40_WRITESHORT(REG_TXNCON);
@@ -564,7 +615,7 @@ static int mrf24j40_start(struct ieee802154_hw *hw)
 
 	/* Clear TXNIE and RXIE. Enable interrupts */
 	return regmap_update_bits(devrec->regmap_short, REG_INTCON,
-				  0x01 | 0x08, 0x00);
+				  BIT_TXNIE | BIT_RXIE, 0);
 }
 
 static void mrf24j40_stop(struct ieee802154_hw *hw)
@@ -574,8 +625,8 @@ static void mrf24j40_stop(struct ieee802154_hw *hw)
 	dev_dbg(printdev(devrec), "stop\n");
 
 	/* Set TXNIE and RXIE. Disable Interrupts */
-	regmap_update_bits(devrec->regmap_short, REG_INTCON, 0x01 | 0x08,
-			   0x01 | 0x08);
+	regmap_update_bits(devrec->regmap_short, REG_INTCON,
+			   BIT_TXNIE | BIT_TXNIE, BIT_TXNIE | BIT_TXNIE);
 }
 
 static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
@@ -591,17 +642,19 @@ static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	WARN_ON(channel > MRF24J40_CHAN_MAX);
 
 	/* Set Channel TODO */
-	val = (channel-11) << 4 | 0x03;
-	ret = regmap_update_bits(devrec->regmap_long, REG_RFCON0, 0xf0, val);
+	val = (channel - 11) << RFCON0_CH_SHIFT | RFOPT_RECOMMEND;
+	ret = regmap_update_bits(devrec->regmap_long, REG_RFCON0,
+				 RFCON0_CH_MASK, val);
 	if (ret)
 		return ret;
 
 	/* RF Reset */
-	ret = regmap_update_bits(devrec->regmap_short, REG_RFCTL, 0x04, 0x04);
+	ret = regmap_update_bits(devrec->regmap_short, REG_RFCTL, BIT_RFRST,
+				 BIT_RFRST);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(devrec->regmap_short, REG_RFCTL, 0x04, 0x00);
+	ret = regmap_update_bits(devrec->regmap_short, REG_RFCTL, BIT_RFRST, 0);
 	if (!ret)
 		udelay(SET_CHANNEL_DELAY_US); /* per datasheet */
 
@@ -664,11 +717,11 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
 		int ret;
 
 		if (filt->pan_coord)
-			val = 0x8;
+			val = BIT_PANCOORD;
 		else
-			val = 0x0;
-		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x8,
-					 val);
+			val = 0;
+		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR,
+					 BIT_PANCOORD, val);
 		if (ret)
 			return ret;
 
@@ -772,7 +825,7 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 	devrec->rx_msg.complete = mrf24j40_handle_rx_read_len;
 	devrec->rx_trx.len = 2;
 	devrec->rx_buf[0] = MRF24J40_WRITESHORT(REG_BBREG1);
-	devrec->rx_buf[1] = 0x04; /* SET RXDECINV */
+	devrec->rx_buf[1] = BIT_RXDECINV; /* SET RXDECINV */
 
 	return spi_async(devrec->spi, &devrec->rx_msg);
 }
@@ -785,11 +838,13 @@ mrf24j40_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
 	u8 val;
 
 	/* min_be */
-	val = min_be << 3;
+	val = min_be << TXMCR_MIN_BE_SHIFT;
 	/* csma backoffs */
-	val |= retries;
+	val |= retries << TXMCR_CSMA_RETRIES_SHIFT;
 
-	return regmap_update_bits(devrec->regmap_short, REG_TXMCR, 0x1f, val);
+	return regmap_update_bits(devrec->regmap_short, REG_TXMCR,
+				  TXMCR_MIN_BE_MASK | TXMCR_CSMA_RETRIES_MASK,
+				  val);
 }
 
 static int mrf24j40_set_cca_mode(struct ieee802154_hw *hw,
@@ -819,8 +874,9 @@ static int mrf24j40_set_cca_mode(struct ieee802154_hw *hw,
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(devrec->regmap_short, REG_BBREG2, 0xc0,
-				  val << 6);
+	return regmap_update_bits(devrec->regmap_short, REG_BBREG2,
+				  BBREG2_CCA_MODE_MASK,
+				  val << BBREG2_CCA_MODE_SHIFT);
 }
 
 /* array for representing ed levels */
@@ -878,16 +934,16 @@ static int mrf24j40_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 	u8 val;
 
 	if (0 >= mbm && mbm > -1000) {
-		val = 0;
+		val = TXPWRL_0 << TXPWRL_SHIFT;
 		small_scale = mbm;
 	} else if (-1000 >= mbm && mbm > -2000) {
-		val = 0x40;
+		val = TXPWRL_10 << TXPWRL_SHIFT;
 		small_scale = mbm + 1000;
 	} else if (-2000 >= mbm && mbm > -3000) {
-		val = 0x80;
+		val = TXPWRL_20 << TXPWRL_SHIFT;
 		small_scale = mbm + 2000;
 	} else if (-3000 >= mbm && mbm > -4000) {
-		val = 0xc0;
+		val = TXPWRL_30 << TXPWRL_SHIFT;
 		small_scale = mbm + 3000;
 	} else {
 		return -EINVAL;
@@ -895,33 +951,35 @@ static int mrf24j40_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 
 	switch (small_scale) {
 	case 0:
+		val |= (TXPWRS_0 << TXPWRS_SHIFT);
 		break;
 	case -50:
-		val |= 0x08;
+		val |= (TXPWRS_0_5 << TXPWRS_SHIFT);
 		break;
 	case -120:
-		val |= 0x10;
+		val |= (TXPWRS_1_2 << TXPWRS_SHIFT);
 		break;
 	case -190:
-		val |= 0x18;
+		val |= (TXPWRS_1_9 << TXPWRS_SHIFT);
 		break;
 	case -280:
-		val |= 0x20;
+		val |= (TXPWRS_2_8 << TXPWRS_SHIFT);
 		break;
 	case -370:
-		val |= 0x28;
+		val |= (TXPWRS_3_7 << TXPWRS_SHIFT);
 		break;
 	case -490:
-		val |= 0x30;
+		val |= (TXPWRS_4_9 << TXPWRS_SHIFT);
 		break;
 	case -630:
-		val |= 0x38;
+		val |= (TXPWRS_6_3 << TXPWRS_SHIFT);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(devrec->regmap_long, REG_RFCON3, 0xf8, val);
+	return regmap_update_bits(devrec->regmap_long, REG_RFCON3,
+				  TXPWRL_MASK | TXPWRS_MASK, val);
 }
 
 static int mrf24j40_set_promiscuous_mode(struct ieee802154_hw *hw, bool on)
@@ -931,12 +989,14 @@ static int mrf24j40_set_promiscuous_mode(struct ieee802154_hw *hw, bool on)
 
 	if (on) {
 		/* set PROMI, ERRPKT and NOACKRSP */
-		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x23,
-					 0x23);
+		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR,
+					 BIT_PROMI | BIT_ERRPKT | BIT_NOACKRSP,
+					 BIT_PROMI | BIT_ERRPKT | BIT_NOACKRSP);
 	} else {
 		/* clear PROMI, ERRPKT and NOACKRSP */
-		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR, 0x23,
-					 0x00);
+		ret = regmap_update_bits(devrec->regmap_short, REG_RXMCR,
+					 BIT_PROMI | BIT_ERRPKT | BIT_NOACKRSP,
+					 0);
 	}
 
 	return ret;
@@ -965,11 +1025,11 @@ static void mrf24j40_intstat_complete(void *context)
 	enable_irq(devrec->spi->irq);
 
 	/* Check for TX complete */
-	if (intstat & 0x1)
+	if (intstat & BIT_TXNIF)
 		ieee802154_xmit_complete(devrec->hw, devrec->tx_skb, false);
 
 	/* Check for Rx */
-	if (intstat & 0x8)
+	if (intstat & BIT_RXIF)
 		mrf24j40_handle_rx(devrec);
 }
 
@@ -1095,7 +1155,7 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
 	case IRQ_TYPE_LEVEL_HIGH:
 		/* set interrupt polarity to rising */
 		ret = regmap_update_bits(devrec->regmap_long, REG_SLPCON0,
-					 0x02, 0x02);
+					 BIT_INTEDGE, BIT_INTEDGE);
 		if (ret)
 			goto err_ret;
 		break;
-- 
2.5.2

