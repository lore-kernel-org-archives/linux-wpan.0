Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36327 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030787AbbD1VXf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Apr 2015 17:23:35 -0400
Received: by wgen6 with SMTP id n6so8230354wge.3
        for <linux-wpan@vger.kernel.org>; Tue, 28 Apr 2015 14:23:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-next 6/6] at86rf230: add slp_tr support to start tx
Date: Tue, 28 Apr 2015 23:22:34 +0200
Message-Id: <1430256154-1813-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430256154-1813-1-git-send-email-alex.aring@gmail.com>
References: <1430256154-1813-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for one of the slp_tr gpio use cases which
indicates the TX_START command without doing some spi bus traffic.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6c3cf79..de2636c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -85,6 +85,7 @@ struct at86rf230_local {
 	struct ieee802154_hw *hw;
 	struct at86rf2xx_chip_data *data;
 	struct regmap *regmap;
+	int slp_tr;
 
 	struct completion state_complete;
 	struct at86rf230_state_change state;
@@ -338,6 +339,14 @@ at86rf230_write_subreg(struct at86rf230_local *lp,
 	return regmap_update_bits(lp->regmap, addr, mask, data << shift);
 }
 
+static inline void
+at86rf230_slp_tr_rising_edge(struct at86rf230_local *lp)
+{
+	gpio_set_value(lp->slp_tr, 1);
+	udelay(1);
+	gpio_set_value(lp->slp_tr, 0);
+}
+
 static bool
 at86rf230_reg_writeable(struct device *dev, unsigned int reg)
 {
@@ -939,13 +948,18 @@ at86rf230_write_frame_complete(void *context)
 	u8 *buf = ctx->buf;
 	int rc;
 
-	buf[0] = (RG_TRX_STATE & CMD_REG_MASK) | CMD_REG | CMD_WRITE;
-	buf[1] = STATE_BUSY_TX;
 	ctx->trx.len = 2;
-	ctx->msg.complete = NULL;
-	rc = spi_async(lp->spi, &ctx->msg);
-	if (rc)
-		at86rf230_async_error(lp, ctx, rc);
+
+	if (gpio_is_valid(lp->slp_tr)) {
+		at86rf230_slp_tr_rising_edge(lp);
+	} else {
+		buf[0] = (RG_TRX_STATE & CMD_REG_MASK) | CMD_REG | CMD_WRITE;
+		buf[1] = STATE_BUSY_TX;
+		ctx->msg.complete = NULL;
+		rc = spi_async(lp->spi, &ctx->msg);
+		if (rc)
+			at86rf230_async_error(lp, ctx, rc);
+	}
 }
 
 static void
@@ -1679,6 +1693,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	lp = hw->priv;
 	lp->hw = hw;
 	lp->spi = spi;
+	lp->slp_tr = slp_tr;
 	hw->parent = &spi->dev;
 	hw->vif_data_size = sizeof(*lp);
 	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
-- 
2.3.6

