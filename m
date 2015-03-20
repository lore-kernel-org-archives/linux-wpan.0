Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35513 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbCTHXC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 03:23:02 -0400
Received: by pagj4 with SMTP id j4so9426674pag.2
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 00:23:01 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 2/3] cc2520: add set transmit power support
Date: Fri, 20 Mar 2015 12:52:19 +0530
Message-Id: <1426836141-21528-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1426836141-21528-1-git-send-email-varkab@cdac.in>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |   56 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index f833b8b..f96cc50 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -53,6 +53,17 @@
 #define	CC2520_MAXCHANNEL		26
 #define	CC2520_CHANNEL_SPACING		5
 
+/* Tx power values */
+#define CC2520_TXPOWER_0		0x03 /* -18dbm */
+#define CC2520_TXPOWER_1		0x2c /* -7dbm */
+#define CC2520_TXPOWER_2		0x88 /* -4dbm */
+#define CC2520_TXPOWER_3		0x81 /* -2dbm */
+#define CC2520_TXPOWER_4		0x32 /* 0dbm */
+#define CC2520_TXPOWER_5		0x13 /* 1dbm */
+#define CC2520_TXPOWER_6		0xab /* 2dbm */
+#define CC2520_TXPOWER_7		0xf2 /* 3dbm */
+#define CC2520_TXPOWER_8		0xf7 /* 5dbm */
+
 /* command strobes */
 #define	CC2520_CMD_SNOP			0x00
 #define	CC2520_CMD_IBUFLD		0x02
@@ -628,6 +639,48 @@ cc2520_filter(struct ieee802154_hw *hw,
 	return 0;
 }
 
+static int
+cc2520_set_txpower(struct ieee802154_hw *hw, int db)
+{
+	struct cc2520_private *priv = hw->priv;
+	u8 power;
+
+	switch (db) {
+	case 5:
+		power = CC2520_TXPOWER_8;
+		break;
+	case 3:
+		power = CC2520_TXPOWER_7;
+		break;
+	case 2:
+		power = CC2520_TXPOWER_6;
+		break;
+	case 1:
+		power = CC2520_TXPOWER_5;
+		break;
+	case 0:
+		power = CC2520_TXPOWER_4;
+		break;
+	case -2:
+		power = CC2520_TXPOWER_3;
+		break;
+	case -4:
+		power = CC2520_TXPOWER_2;
+		break;
+	case -7:
+		power = CC2520_TXPOWER_1;
+		break;
+	case -18:
+		power = CC2520_TXPOWER_0;
+		break;
+	default:
+		dev_err(&priv->spi->dev, "invalid tx power setting\n");
+		return -EINVAL;
+	}
+
+	return cc2520_write_register(priv, CC2520_TXPOWER, power);
+}
+
 static const struct ieee802154_ops cc2520_ops = {
 	.owner = THIS_MODULE,
 	.start = cc2520_start,
@@ -636,6 +689,7 @@ static const struct ieee802154_ops cc2520_ops = {
 	.ed = cc2520_ed,
 	.set_channel = cc2520_set_channel,
 	.set_hw_addr_filt = cc2520_filter,
+	.set_txpower = cc2520_set_txpower,
 };
 
 static int cc2520_register(struct cc2520_private *priv)
@@ -655,7 +709,7 @@ static int cc2520_register(struct cc2520_private *priv)
 	/* We do support only 2.4 Ghz */
 	priv->hw->phy->channels_supported[0] = 0x7FFF800;
 	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
-			  IEEE802154_HW_AFILT;
+			  IEEE802154_HW_AFILT | IEEE802154_HW_TXPOWER;
 
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
-- 
1.7.9.5

