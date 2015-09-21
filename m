Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34281 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352AbbIUJZQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:16 -0400
Received: by wicfx3 with SMTP id fx3so136446715wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:15 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/22] mrf24j40: add csma params support
Date: Mon, 21 Sep 2015 11:24:37 +0200
Message-Id: <1442827483-27975-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch adds supports to change the CSMA parameters. The datasheet
doesn't say anything about max_be value. Seems not configurable and we
assume the 802.15.4 default. But this value must exists because there is
a min_be value.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 940fc0a..fe7991d 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -776,6 +776,21 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 	return spi_async(devrec->spi, &devrec->rx_msg);
 }
 
+static int
+mrf24j40_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
+		     u8 retries)
+{
+	struct mrf24j40 *devrec = hw->priv;
+	u8 val;
+
+	/* min_be */
+	val = min_be << 3;
+	/* csma backoffs */
+	val |= retries;
+
+	return regmap_update_bits(devrec->regmap_short, REG_TXMCR, 0x1f, val);
+}
+
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = mrf24j40_tx,
@@ -784,6 +799,7 @@ static const struct ieee802154_ops mrf24j40_ops = {
 	.stop = mrf24j40_stop,
 	.set_channel = mrf24j40_set_channel,
 	.set_hw_addr_filt = mrf24j40_filter,
+	.set_csma_params = mrf24j40_csma_params,
 };
 
 static void mrf24j40_intstat_complete(void *context)
@@ -979,6 +995,14 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 {
 	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
 	devrec->hw->phy->current_channel = 11;
+
+	/* mrf24j40 supports max_minbe 0 - 3 */
+	devrec->hw->phy->supported.max_minbe = 3;
+	/* datasheet doesn't say anything about max_be, but we have min_be
+	 * So we assume the max_be default.
+	 */
+	devrec->hw->phy->supported.min_maxbe = 5;
+	devrec->hw->phy->supported.max_maxbe = 5;
 }
 
 static int mrf24j40_probe(struct spi_device *spi)
@@ -1001,7 +1025,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw = hw;
 	devrec->hw->parent = &spi->dev;
 	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
-	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
+	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
+			    IEEE802154_HW_CSMA_PARAMS;
 
 	mrf24j40_setup_tx_spi_messages(devrec);
 	mrf24j40_setup_rx_spi_messages(devrec);
-- 
2.5.2

