Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36433 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbE2F2x (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:28:53 -0400
Received: by pacux9 with SMTP id ux9so1593872pac.3
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:28:52 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 3/5] cc2520: add set transmit power setting support
Date: Fri, 29 May 2015 10:56:56 +0530
Message-Id: <1432877218-12537-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1432877218-12537-1-git-send-email-varkab@cdac.in>
References: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: bradjc5@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch adds support for seeting tx power values for cc2520
and also for the combination of CC2520-CC2591.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Cc: Brad Campbell <bradjc5@gmail.com>
---
 drivers/net/ieee802154/cc2520.c |  102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 0d93537..36a4f31 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -629,6 +629,97 @@ cc2520_filter(struct ieee802154_hw *hw,
 	return 0;
 }
 
+static inline int cc2520_set_tx_power(struct cc2520_private *priv, s32 mbm)
+{
+	u8 power;
+
+	switch (mbm) {
+	case 500:
+		power = 0xF7;
+		break;
+	case 300:
+		power = 0xF2;
+		break;
+	case 200:
+		power = 0xAB;
+		break;
+	case 100:
+		power = 0x13;
+		break;
+	case 0:
+		power = 0x32;
+		break;
+	case -200:
+		power = 0x81;
+		break;
+	case -400:
+		power = 0x88;
+		break;
+	case -700:
+		power = 0x2C;
+		break;
+	case -1800:
+		power = 0x03;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return cc2520_write_register(priv, CC2520_TXPOWER, power);
+}
+
+static inline int cc2520_cc2591_set_tx_power(struct cc2520_private *priv,
+					     s32 mbm)
+{
+	u8 power;
+
+	switch (mbm) {
+	case 1700:
+		power = 0xF9;
+		break;
+	case 1600:
+		power = 0xF0;
+		break;
+	case 1400:
+		power = 0xA0;
+		break;
+	case 1100:
+		power = 0x2C;
+		break;
+	case -100:
+		power = 0x03;
+		break;
+	case -800:
+		power = 0x01;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return cc2520_write_register(priv, CC2520_TXPOWER, power);
+}
+
+#define CC2520_MAX_TX_POWERS 0x8
+static const s32 cc2520_powers[CC2520_MAX_TX_POWERS + 1] = {
+	500, 300, 200, 100, 0, -200, -400, -700, -1800,
+};
+
+#define CC2520_CC2591_MAX_TX_POWERS 0x5
+static const s32 cc2520_cc2591_powers[CC2520_CC2591_MAX_TX_POWERS + 1] = {
+	1700, 1600, 1400, 1100, -100, -800,
+};
+
+static int
+cc2520_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct cc2520_private *priv = hw->priv;
+
+	if (!priv->amplified)
+		return cc2520_set_tx_power(priv, mbm);
+
+	return cc2520_cc2591_set_tx_power(priv, mbm);
+}
+
 static const struct ieee802154_ops cc2520_ops = {
 	.owner = THIS_MODULE,
 	.start = cc2520_start,
@@ -637,6 +728,7 @@ static const struct ieee802154_ops cc2520_ops = {
 	.ed = cc2520_ed,
 	.set_channel = cc2520_set_channel,
 	.set_hw_addr_filt = cc2520_filter,
+	.set_txpower = cc2520_set_txpower,
 };
 
 static int cc2520_register(struct cc2520_private *priv)
@@ -658,6 +750,16 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
 			  IEEE802154_HW_AFILT;
 
+	priv->hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
+
+	if (!priv->amplified) {
+		priv->hw->phy->supported.tx_powers = cc2520_powers;
+		priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_powers);
+	} else {
+		priv->hw->phy->supported.tx_powers = cc2520_cc2591_powers;
+		priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_cc2591_powers);
+	}
+
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
 	if (ret)
-- 
1.7.9.5

