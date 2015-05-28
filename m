Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34500 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbE1Gvb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 02:51:31 -0400
Received: by pabru16 with SMTP id ru16so16540511pab.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 23:51:31 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 1/3] cc2520: add set transmit power setting support
Date: Thu, 28 May 2015 12:20:58 +0530
Message-Id: <1432795860-16462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

This patch adds support for seeting tx power value.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |   51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 84b28a0..a20e6d4 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -628,6 +628,52 @@ cc2520_filter(struct ieee802154_hw *hw,
 	return 0;
 }
 
+#define CC2520_MAX_TX_POWERS 0x8
+static const s32 cc2520_powers[CC2520_MAX_TX_POWERS + 1] = {
+	500, 300, 200, 100, 0, -200, -400, -700, -1800,
+};
+
+static int
+cc2520_set_txpower(struct ieee802154_hw *hw, s32 mbm)
+{
+	struct cc2520_private *priv = hw->priv;
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
 static const struct ieee802154_ops cc2520_ops = {
 	.owner = THIS_MODULE,
 	.start = cc2520_start,
@@ -636,6 +682,7 @@ static const struct ieee802154_ops cc2520_ops = {
 	.ed = cc2520_ed,
 	.set_channel = cc2520_set_channel,
 	.set_hw_addr_filt = cc2520_filter,
+	.set_txpower = cc2520_set_txpower,
 };
 
 static int cc2520_register(struct cc2520_private *priv)
@@ -657,6 +704,10 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
 			  IEEE802154_HW_AFILT;
 
+	priv->hw->phy->flags = WPAN_PHY_FLAG_TXPOWER;
+	priv->hw->phy->supported.tx_powers = cc2520_powers;
+	priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_powers);
+
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
 	if (ret)
-- 
1.7.9.5

