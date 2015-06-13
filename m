Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35204 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbFMUQF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 13 Jun 2015 16:16:05 -0400
Received: by wiga1 with SMTP id a1so42796645wig.0
        for <linux-wpan@vger.kernel.org>; Sat, 13 Jun 2015 13:16:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/4] at86rf230: add support for sleep state
Date: Sat, 13 Jun 2015 22:15:54 +0200
Message-Id: <1434226554-1450-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for sleep state when between stop and start
period. In this period the transceiver isn't used by the subsystem, in
this time we disable the irq and going into the sleep state.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 25e1ede..6b31f47 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -47,6 +47,8 @@ struct at86rf2xx_chip_data {
 	u16 t_reset_to_off;
 	u16 t_off_to_aack;
 	u16 t_off_to_tx_on;
+	u16 t_off_to_sleep;
+	u16 t_sleep_to_off;
 	u16 t_frame;
 	u16 t_p_ack;
 	int rssi_base_val;
@@ -869,13 +871,33 @@ at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
 static int
 at86rf230_start(struct ieee802154_hw *hw)
 {
+	struct at86rf230_local *lp = hw->priv;
+
+	if (gpio_is_valid(lp->slp_tr)) {
+		gpio_set_value(lp->slp_tr, 0);
+		usleep_range(lp->data->t_sleep_to_off,
+			     lp->data->t_sleep_to_off + 100);
+	}
+
+	enable_irq(lp->spi->irq);
+
 	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
 }
 
 static void
 at86rf230_stop(struct ieee802154_hw *hw)
 {
+	struct at86rf230_local *lp = hw->priv;
+
 	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
+
+	disable_irq(lp->spi->irq);
+
+	if (gpio_is_valid(lp->slp_tr)) {
+		gpio_set_value(lp->slp_tr, 1);
+		usleep_range(lp->data->t_off_to_sleep,
+			     lp->data->t_off_to_sleep + 10);
+	}
 }
 
 static int
@@ -1241,6 +1263,8 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_reset_to_off = 26,
 	.t_off_to_aack = 80,
 	.t_off_to_tx_on = 80,
+	.t_off_to_sleep = 35,
+	.t_sleep_to_off = 210,
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
@@ -1254,6 +1278,8 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_reset_to_off = 37,
 	.t_off_to_aack = 110,
 	.t_off_to_tx_on = 110,
+	.t_off_to_sleep = 35,
+	.t_sleep_to_off = 380,
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.rssi_base_val = -91,
@@ -1267,6 +1293,8 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_reset_to_off = 26,
 	.t_off_to_aack = 200,
 	.t_off_to_tx_on = 200,
+	.t_off_to_sleep = 35,
+	.t_sleep_to_off = 380,
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.rssi_base_val = -100,
@@ -1640,6 +1668,16 @@ static int at86rf230_probe(struct spi_device *spi)
 	if (rc)
 		goto free_dev;
 
+	/* disable_irq by default and wait for starting hardware */
+	disable_irq(spi->irq);
+
+	/* going into sleep by default */
+	if (gpio_is_valid(slp_tr)) {
+		gpio_set_value(slp_tr, 1);
+		usleep_range(lp->data->t_off_to_sleep,
+			     lp->data->t_off_to_sleep + 10);
+	}
+
 	rc = ieee802154_register_hw(lp->hw);
 	if (rc)
 		goto free_dev;
-- 
2.4.1

