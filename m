Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:35239 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbaJYT1Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:27:16 -0400
Received: by mail-la0-f43.google.com with SMTP id ge10so19845lab.16
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:27:15 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/10] ieee802154: rename ieee802154_dev to ieee802154_hw
Date: Sat, 25 Oct 2014 17:16:34 +0200
Message-Id: <1414250202-32384-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

The identical struct of the wireless stack implementation is named
ieee80211_hw. This is useful to name the variable hw instead of get
confusing with netdev dev variable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c | 90 +++++++++++++++++++-------------------
 drivers/net/ieee802154/cc2520.c    | 50 ++++++++++-----------
 drivers/net/ieee802154/fakelb.c    | 78 ++++++++++++++++-----------------
 drivers/net/ieee802154/mrf24j40.c  | 48 ++++++++++----------
 include/net/mac802154.h            | 44 +++++++++----------
 net/mac802154/ieee802154_i.h       |  2 +-
 net/mac802154/main.c               | 34 +++++++-------
 net/mac802154/rx.c                 | 12 ++---
 8 files changed, 179 insertions(+), 179 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index a433d20..b0d68d7 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -77,7 +77,7 @@ struct at86rf230_state_change {
 struct at86rf230_local {
 	struct spi_device *spi;
 
-	struct ieee802154_dev *dev;
+	struct ieee802154_hw *hw;
 	struct at86rf2xx_chip_data *data;
 	struct regmap *regmap;
 
@@ -808,7 +808,7 @@ at86rf230_rx(struct at86rf230_local *lp,
 	/* We do not put CRC into the frame */
 	skb_trim(skb, len - 2);
 
-	ieee802154_rx_irqsafe(lp->dev, skb, lqi);
+	ieee802154_rx_irqsafe(lp->hw, skb, lqi);
 }
 
 static void
@@ -969,9 +969,9 @@ at86rf230_xmit_tx_on(void *context)
 }
 
 static int
-at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
+at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 	struct at86rf230_state_change *ctx = &lp->tx;
 
 	void (*tx_complete)(void *context) = at86rf230_write_frame;
@@ -1012,7 +1012,7 @@ at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
 }
 
 static int
-at86rf230_ed(struct ieee802154_dev *dev, u8 *level)
+at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
 {
 	might_sleep();
 	BUG_ON(!level);
@@ -1021,15 +1021,15 @@ at86rf230_ed(struct ieee802154_dev *dev, u8 *level)
 }
 
 static int
-at86rf230_start(struct ieee802154_dev *dev)
+at86rf230_start(struct ieee802154_hw *hw)
 {
-	return at86rf230_sync_state_change(dev->priv, STATE_RX_AACK_ON);
+	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
 }
 
 static void
-at86rf230_stop(struct ieee802154_dev *dev)
+at86rf230_stop(struct ieee802154_hw *hw)
 {
-	at86rf230_sync_state_change(dev->priv, STATE_FORCE_TRX_OFF);
+	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
 }
 
 static int
@@ -1064,15 +1064,15 @@ at86rf212_set_channel(struct at86rf230_local *lp, int page, int channel)
 }
 
 static int
-at86rf230_channel(struct ieee802154_dev *dev, int page, int channel)
+at86rf230_channel(struct ieee802154_hw *hw, int page, int channel)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
 	might_sleep();
 
 	if (page < 0 || page > 31 ||
-	    !(lp->dev->phy->channels_supported[page] & BIT(channel))) {
+	    !(lp->hw->phy->channels_supported[page] & BIT(channel))) {
 		WARN_ON(1);
 		return -EINVAL;
 	}
@@ -1084,18 +1084,18 @@ at86rf230_channel(struct ieee802154_dev *dev, int page, int channel)
 	/* Wait for PLL */
 	usleep_range(lp->data->t_channel_switch,
 		     lp->data->t_channel_switch + 10);
-	dev->phy->current_channel = channel;
-	dev->phy->current_page = page;
+	hw->phy->current_channel = channel;
+	hw->phy->current_page = page;
 
 	return 0;
 }
 
 static int
-at86rf230_set_hw_addr_filt(struct ieee802154_dev *dev,
+at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 			   struct ieee802154_hw_addr_filt *filt,
 			   unsigned long changed)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 
 	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
@@ -1138,9 +1138,9 @@ at86rf230_set_hw_addr_filt(struct ieee802154_dev *dev,
 }
 
 static int
-at86rf230_set_txpower(struct ieee802154_dev *dev, int db)
+at86rf230_set_txpower(struct ieee802154_hw *hw, int db)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 
 	/* typical maximum output is 5dBm with RG_PHY_TX_PWR 0x60, lower five
 	 * bits decrease power in 1dB steps. 0x60 represents extra PA gain of
@@ -1157,17 +1157,17 @@ at86rf230_set_txpower(struct ieee802154_dev *dev, int db)
 }
 
 static int
-at86rf230_set_lbt(struct ieee802154_dev *dev, bool on)
+at86rf230_set_lbt(struct ieee802154_hw *hw, bool on)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 
 	return at86rf230_write_subreg(lp, SR_CSMA_LBT_MODE, on);
 }
 
 static int
-at86rf230_set_cca_mode(struct ieee802154_dev *dev, u8 mode)
+at86rf230_set_cca_mode(struct ieee802154_hw *hw, u8 mode)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 
 	return at86rf230_write_subreg(lp, SR_CCA_MODE, mode);
 }
@@ -1185,9 +1185,9 @@ at86rf23x_get_desens_steps(struct at86rf230_local *lp, s32 level)
 }
 
 static int
-at86rf230_set_cca_ed_level(struct ieee802154_dev *dev, s32 level)
+at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 level)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 
 	if (level < lp->data->rssi_base_val || level > 30)
 		return -EINVAL;
@@ -1197,10 +1197,10 @@ at86rf230_set_cca_ed_level(struct ieee802154_dev *dev, s32 level)
 }
 
 static int
-at86rf230_set_csma_params(struct ieee802154_dev *dev, u8 min_be, u8 max_be,
+at86rf230_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
 			  u8 retries)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
 	if (min_be > max_be || max_be > 8 || retries > 5)
@@ -1218,9 +1218,9 @@ at86rf230_set_csma_params(struct ieee802154_dev *dev, u8 min_be, u8 max_be,
 }
 
 static int
-at86rf230_set_frame_retries(struct ieee802154_dev *dev, s8 retries)
+at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 {
-	struct at86rf230_local *lp = dev->priv;
+	struct at86rf230_local *lp = hw->priv;
 	int rc = 0;
 
 	if (retries < -1 || retries > 15)
@@ -1409,8 +1409,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		return -EINVAL;
 	}
 
-	lp->dev->extra_tx_headroom = 0;
-	lp->dev->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
+	lp->hw->extra_tx_headroom = 0;
+	lp->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
 			 IEEE802154_HW_TXPOWER | IEEE802154_HW_CSMA;
 
 	switch (part) {
@@ -1421,15 +1421,15 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	case 3:
 		chip = "at86rf231";
 		lp->data = &at86rf231_data;
-		lp->dev->phy->channels_supported[0] = 0x7FFF800;
+		lp->hw->phy->channels_supported[0] = 0x7FFF800;
 		break;
 	case 7:
 		chip = "at86rf212";
 		if (version == 1) {
 			lp->data = &at86rf212_data;
-			lp->dev->flags |= IEEE802154_HW_LBT;
-			lp->dev->phy->channels_supported[0] = 0x00007FF;
-			lp->dev->phy->channels_supported[2] = 0x00007FF;
+			lp->hw->flags |= IEEE802154_HW_LBT;
+			lp->hw->phy->channels_supported[0] = 0x00007FF;
+			lp->hw->phy->channels_supported[2] = 0x00007FF;
 		} else {
 			rc = -ENOTSUPP;
 		}
@@ -1437,7 +1437,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	case 11:
 		chip = "at86rf233";
 		lp->data = &at86rf233_data;
-		lp->dev->phy->channels_supported[0] = 0x7FFF800;
+		lp->hw->phy->channels_supported[0] = 0x7FFF800;
 		break;
 	default:
 		chip = "unkown";
@@ -1478,7 +1478,7 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
 static int at86rf230_probe(struct spi_device *spi)
 {
 	struct at86rf230_platform_data *pdata;
-	struct ieee802154_dev *dev;
+	struct ieee802154_hw *hw;
 	struct at86rf230_local *lp;
 	unsigned int status;
 	int rc, irq_type;
@@ -1517,14 +1517,14 @@ static int at86rf230_probe(struct spi_device *spi)
 		usleep_range(120, 240);
 	}
 
-	dev = ieee802154_alloc_device(sizeof(*lp), &at86rf230_ops);
-	if (!dev)
+	hw = ieee802154_alloc_hw(sizeof(*lp), &at86rf230_ops);
+	if (!hw)
 		return -ENOMEM;
 
-	lp = dev->priv;
-	lp->dev = dev;
+	lp = hw->priv;
+	lp->hw = hw;
 	lp->spi = spi;
-	dev->parent = &spi->dev;
+	hw->parent = &spi->dev;
 
 	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
 	if (IS_ERR(lp->regmap)) {
@@ -1564,14 +1564,14 @@ static int at86rf230_probe(struct spi_device *spi)
 	if (rc)
 		goto free_dev;
 
-	rc = ieee802154_register_device(lp->dev);
+	rc = ieee802154_register_hw(lp->hw);
 	if (rc)
 		goto free_dev;
 
 	return rc;
 
 free_dev:
-	ieee802154_free_device(lp->dev);
+	ieee802154_free_hw(lp->hw);
 
 	return rc;
 }
@@ -1582,8 +1582,8 @@ static int at86rf230_remove(struct spi_device *spi)
 
 	/* mask all at86rf230 irq's */
 	at86rf230_write_subreg(lp, SR_IRQ_MASK, 0);
-	ieee802154_unregister_device(lp->dev);
-	ieee802154_free_device(lp->dev);
+	ieee802154_unregister_hw(lp->hw);
+	ieee802154_free_hw(lp->hw);
 	dev_dbg(&spi->dev, "unregistered at86rf230\n");
 
 	return 0;
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 32b3c88..b827e04 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -193,7 +193,7 @@
 /* Driver private information */
 struct cc2520_private {
 	struct spi_device *spi;		/* SPI device structure */
-	struct ieee802154_dev *dev;	/* IEEE-802.15.4 device */
+	struct ieee802154_hw *hw;	/* IEEE-802.15.4 device */
 	u8 *buf;			/* SPI TX/Rx data buffer */
 	struct mutex buffer_mutex;	/* SPI buffer mutex */
 	bool is_tx;			/* Flag for sync b/w Tx and Rx */
@@ -453,20 +453,20 @@ cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len, u8 *lqi)
 	return status;
 }
 
-static int cc2520_start(struct ieee802154_dev *dev)
+static int cc2520_start(struct ieee802154_hw *hw)
 {
-	return cc2520_cmd_strobe(dev->priv, CC2520_CMD_SRXON);
+	return cc2520_cmd_strobe(hw->priv, CC2520_CMD_SRXON);
 }
 
-static void cc2520_stop(struct ieee802154_dev *dev)
+static void cc2520_stop(struct ieee802154_hw *hw)
 {
-	cc2520_cmd_strobe(dev->priv, CC2520_CMD_SRFOFF);
+	cc2520_cmd_strobe(hw->priv, CC2520_CMD_SRFOFF);
 }
 
 static int
-cc2520_tx(struct ieee802154_dev *dev, struct sk_buff *skb)
+cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct cc2520_private *priv = dev->priv;
+	struct cc2520_private *priv = hw->priv;
 	unsigned long flags;
 	int rc;
 	u8 status = 0;
@@ -536,7 +536,7 @@ static int cc2520_rx(struct cc2520_private *priv)
 
 	skb_trim(skb, skb->len - 2);
 
-	ieee802154_rx_irqsafe(priv->dev, skb, lqi);
+	ieee802154_rx_irqsafe(priv->hw, skb, lqi);
 
 	dev_vdbg(&priv->spi->dev, "RXFIFO: %x %x\n", len, lqi);
 
@@ -544,9 +544,9 @@ static int cc2520_rx(struct cc2520_private *priv)
 }
 
 static int
-cc2520_ed(struct ieee802154_dev *dev, u8 *level)
+cc2520_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	struct cc2520_private *priv = dev->priv;
+	struct cc2520_private *priv = hw->priv;
 	u8 status = 0xff;
 	u8 rssi;
 	int ret;
@@ -569,9 +569,9 @@ cc2520_ed(struct ieee802154_dev *dev, u8 *level)
 }
 
 static int
-cc2520_set_channel(struct ieee802154_dev *dev, int page, int channel)
+cc2520_set_channel(struct ieee802154_hw *hw, int page, int channel)
 {
-	struct cc2520_private *priv = dev->priv;
+	struct cc2520_private *priv = hw->priv;
 	int ret;
 
 	might_sleep();
@@ -588,10 +588,10 @@ cc2520_set_channel(struct ieee802154_dev *dev, int page, int channel)
 }
 
 static int
-cc2520_filter(struct ieee802154_dev *dev,
+cc2520_filter(struct ieee802154_hw *hw,
 	      struct ieee802154_hw_addr_filt *filt, unsigned long changed)
 {
-	struct cc2520_private *priv = dev->priv;
+	struct cc2520_private *priv = hw->priv;
 
 	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 panid = le16_to_cpu(filt->pan_id);
@@ -645,27 +645,27 @@ static int cc2520_register(struct cc2520_private *priv)
 {
 	int ret = -ENOMEM;
 
-	priv->dev = ieee802154_alloc_device(sizeof(*priv), &cc2520_ops);
-	if (!priv->dev)
+	priv->hw = ieee802154_alloc_hw(sizeof(*priv), &cc2520_ops);
+	if (!priv->hw)
 		goto err_ret;
 
-	priv->dev->priv = priv;
-	priv->dev->parent = &priv->spi->dev;
-	priv->dev->extra_tx_headroom = 0;
+	priv->hw->priv = priv;
+	priv->hw->parent = &priv->spi->dev;
+	priv->hw->extra_tx_headroom = 0;
 
 	/* We do support only 2.4 Ghz */
-	priv->dev->phy->channels_supported[0] = 0x7FFF800;
-	priv->dev->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK;
+	priv->hw->phy->channels_supported[0] = 0x7FFF800;
+	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK;
 
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
-	ret = ieee802154_register_device(priv->dev);
+	ret = ieee802154_register_hw(priv->hw);
 	if (ret)
 		goto err_free_device;
 
 	return 0;
 
 err_free_device:
-	ieee802154_free_device(priv->dev);
+	ieee802154_free_hw(priv->hw);
 err_ret:
 	return ret;
 }
@@ -1002,8 +1002,8 @@ static int cc2520_remove(struct spi_device *spi)
 	mutex_destroy(&priv->buffer_mutex);
 	flush_work(&priv->fifop_irqwork);
 
-	ieee802154_unregister_device(priv->dev);
-	ieee802154_free_device(priv->dev);
+	ieee802154_unregister_hw(priv->hw);
+	ieee802154_free_hw(priv->hw);
 
 	return 0;
 }
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index e6e2993..51e3c58 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -30,7 +30,7 @@
 static int numlbs = 1;
 
 struct fakelb_dev_priv {
-	struct ieee802154_dev *dev;
+	struct ieee802154_hw *hw;
 
 	struct list_head list;
 	struct fakelb_priv *fake;
@@ -45,7 +45,7 @@ struct fakelb_priv {
 };
 
 static int
-fakelb_hw_ed(struct ieee802154_dev *dev, u8 *level)
+fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 {
 	might_sleep();
 	BUG_ON(!level);
@@ -55,13 +55,13 @@ fakelb_hw_ed(struct ieee802154_dev *dev, u8 *level)
 }
 
 static int
-fakelb_hw_channel(struct ieee802154_dev *dev, int page, int channel)
+fakelb_hw_channel(struct ieee802154_hw *hw, int page, int channel)
 {
 	pr_debug("set channel to %d\n", channel);
 
 	might_sleep();
-	dev->phy->current_page = page;
-	dev->phy->current_channel = channel;
+	hw->phy->current_page = page;
+	hw->phy->current_channel = channel;
 
 	return 0;
 }
@@ -74,15 +74,15 @@ fakelb_hw_deliver(struct fakelb_dev_priv *priv, struct sk_buff *skb)
 	spin_lock(&priv->lock);
 	if (priv->working) {
 		newskb = pskb_copy(skb, GFP_ATOMIC);
-		ieee802154_rx_irqsafe(priv->dev, newskb, 0xcc);
+		ieee802154_rx_irqsafe(priv->hw, newskb, 0xcc);
 	}
 	spin_unlock(&priv->lock);
 }
 
 static int
-fakelb_hw_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
+fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct fakelb_dev_priv *priv = dev->priv;
+	struct fakelb_dev_priv *priv = hw->priv;
 	struct fakelb_priv *fake = priv->fake;
 
 	might_sleep();
@@ -95,8 +95,8 @@ fakelb_hw_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
 		struct fakelb_dev_priv *dp;
 		list_for_each_entry(dp, &priv->fake->list, list) {
 			if (dp != priv &&
-			    (dp->dev->phy->current_channel ==
-			     priv->dev->phy->current_channel))
+			    (dp->hw->phy->current_channel ==
+			     priv->hw->phy->current_channel))
 				fakelb_hw_deliver(dp, skb);
 		}
 	}
@@ -106,8 +106,8 @@ fakelb_hw_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
 }
 
 static int
-fakelb_hw_start(struct ieee802154_dev *dev) {
-	struct fakelb_dev_priv *priv = dev->priv;
+fakelb_hw_start(struct ieee802154_hw *hw) {
+	struct fakelb_dev_priv *priv = hw->priv;
 	int ret = 0;
 
 	spin_lock(&priv->lock);
@@ -121,8 +121,8 @@ fakelb_hw_start(struct ieee802154_dev *dev) {
 }
 
 static void
-fakelb_hw_stop(struct ieee802154_dev *dev) {
-	struct fakelb_dev_priv *priv = dev->priv;
+fakelb_hw_stop(struct ieee802154_hw *hw) {
+	struct fakelb_dev_priv *priv = hw->priv;
 
 	spin_lock(&priv->lock);
 	priv->working = 0;
@@ -146,54 +146,54 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 {
 	struct fakelb_dev_priv *priv;
 	int err;
-	struct ieee802154_dev *ieee;
+	struct ieee802154_hw *hw;
 
-	ieee = ieee802154_alloc_device(sizeof(*priv), &fakelb_ops);
-	if (!ieee)
+	hw = ieee802154_alloc_hw(sizeof(*priv), &fakelb_ops);
+	if (!hw)
 		return -ENOMEM;
 
-	priv = ieee->priv;
-	priv->dev = ieee;
+	priv = hw->priv;
+	priv->hw = hw;
 
 	/* 868 MHz BPSK	802.15.4-2003 */
-	ieee->phy->channels_supported[0] |= 1;
+	hw->phy->channels_supported[0] |= 1;
 	/* 915 MHz BPSK	802.15.4-2003 */
-	ieee->phy->channels_supported[0] |= 0x7fe;
+	hw->phy->channels_supported[0] |= 0x7fe;
 	/* 2.4 GHz O-QPSK 802.15.4-2003 */
-	ieee->phy->channels_supported[0] |= 0x7FFF800;
+	hw->phy->channels_supported[0] |= 0x7FFF800;
 	/* 868 MHz ASK 802.15.4-2006 */
-	ieee->phy->channels_supported[1] |= 1;
+	hw->phy->channels_supported[1] |= 1;
 	/* 915 MHz ASK 802.15.4-2006 */
-	ieee->phy->channels_supported[1] |= 0x7fe;
+	hw->phy->channels_supported[1] |= 0x7fe;
 	/* 868 MHz O-QPSK 802.15.4-2006 */
-	ieee->phy->channels_supported[2] |= 1;
+	hw->phy->channels_supported[2] |= 1;
 	/* 915 MHz O-QPSK 802.15.4-2006 */
-	ieee->phy->channels_supported[2] |= 0x7fe;
+	hw->phy->channels_supported[2] |= 0x7fe;
 	/* 2.4 GHz CSS 802.15.4a-2007 */
-	ieee->phy->channels_supported[3] |= 0x3fff;
+	hw->phy->channels_supported[3] |= 0x3fff;
 	/* UWB Sub-gigahertz 802.15.4a-2007 */
-	ieee->phy->channels_supported[4] |= 1;
+	hw->phy->channels_supported[4] |= 1;
 	/* UWB Low band 802.15.4a-2007 */
-	ieee->phy->channels_supported[4] |= 0x1e;
+	hw->phy->channels_supported[4] |= 0x1e;
 	/* UWB High band 802.15.4a-2007 */
-	ieee->phy->channels_supported[4] |= 0xffe0;
+	hw->phy->channels_supported[4] |= 0xffe0;
 	/* 750 MHz O-QPSK 802.15.4c-2009 */
-	ieee->phy->channels_supported[5] |= 0xf;
+	hw->phy->channels_supported[5] |= 0xf;
 	/* 750 MHz MPSK 802.15.4c-2009 */
-	ieee->phy->channels_supported[5] |= 0xf0;
+	hw->phy->channels_supported[5] |= 0xf0;
 	/* 950 MHz BPSK 802.15.4d-2009 */
-	ieee->phy->channels_supported[6] |= 0x3ff;
+	hw->phy->channels_supported[6] |= 0x3ff;
 	/* 950 MHz GFSK 802.15.4d-2009 */
-	ieee->phy->channels_supported[6] |= 0x3ffc00;
+	hw->phy->channels_supported[6] |= 0x3ffc00;
 
 	INIT_LIST_HEAD(&priv->list);
 	priv->fake = fake;
 
 	spin_lock_init(&priv->lock);
 
-	ieee->parent = dev;
+	hw->parent = dev;
 
-	err = ieee802154_register_device(ieee);
+	err = ieee802154_register_hw(hw);
 	if (err)
 		goto err_reg;
 
@@ -204,7 +204,7 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 	return 0;
 
 err_reg:
-	ieee802154_free_device(priv->dev);
+	ieee802154_free_hw(priv->hw);
 	return err;
 }
 
@@ -214,8 +214,8 @@ static void fakelb_del(struct fakelb_dev_priv *priv)
 	list_del(&priv->list);
 	write_unlock_bh(&priv->fake->lock);
 
-	ieee802154_unregister_device(priv->dev);
-	ieee802154_free_device(priv->dev);
+	ieee802154_unregister_hw(priv->hw);
+	ieee802154_free_hw(priv->hw);
 }
 
 static int fakelb_probe(struct platform_device *pdev)
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 56a6959..2e267c5 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -79,7 +79,7 @@ enum mrf24j40_modules { MRF24J40, MRF24J40MA, MRF24J40MC };
 /* Device Private Data */
 struct mrf24j40 {
 	struct spi_device *spi;
-	struct ieee802154_dev *dev;
+	struct ieee802154_hw *hw;
 
 	struct mutex buffer_mutex; /* only used to protect buf */
 	struct completion tx_complete;
@@ -332,9 +332,9 @@ out:
 	return ret;
 }
 
-static int mrf24j40_tx(struct ieee802154_dev *dev, struct sk_buff *skb)
+static int mrf24j40_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-	struct mrf24j40 *devrec = dev->priv;
+	struct mrf24j40 *devrec = hw->priv;
 	u8 val;
 	int ret = 0;
 
@@ -383,7 +383,7 @@ err:
 	return ret;
 }
 
-static int mrf24j40_ed(struct ieee802154_dev *dev, u8 *level)
+static int mrf24j40_ed(struct ieee802154_hw *hw, u8 *level)
 {
 	/* TODO: */
 	pr_warn("mrf24j40: ed not implemented\n");
@@ -391,9 +391,9 @@ static int mrf24j40_ed(struct ieee802154_dev *dev, u8 *level)
 	return 0;
 }
 
-static int mrf24j40_start(struct ieee802154_dev *dev)
+static int mrf24j40_start(struct ieee802154_hw *hw)
 {
-	struct mrf24j40 *devrec = dev->priv;
+	struct mrf24j40 *devrec = hw->priv;
 	u8 val;
 	int ret;
 
@@ -408,9 +408,9 @@ static int mrf24j40_start(struct ieee802154_dev *dev)
 	return 0;
 }
 
-static void mrf24j40_stop(struct ieee802154_dev *dev)
+static void mrf24j40_stop(struct ieee802154_hw *hw)
 {
-	struct mrf24j40 *devrec = dev->priv;
+	struct mrf24j40 *devrec = hw->priv;
 	u8 val;
 	int ret;
 
@@ -423,10 +423,10 @@ static void mrf24j40_stop(struct ieee802154_dev *dev)
 	write_short_reg(devrec, REG_INTCON, val);
 }
 
-static int mrf24j40_set_channel(struct ieee802154_dev *dev,
+static int mrf24j40_set_channel(struct ieee802154_hw *hw,
 				int page, int channel)
 {
-	struct mrf24j40 *devrec = dev->priv;
+	struct mrf24j40 *devrec = hw->priv;
 	u8 val;
 	int ret;
 
@@ -454,11 +454,11 @@ static int mrf24j40_set_channel(struct ieee802154_dev *dev,
 	return 0;
 }
 
-static int mrf24j40_filter(struct ieee802154_dev *dev,
+static int mrf24j40_filter(struct ieee802154_hw *hw,
 			   struct ieee802154_hw_addr_filt *filt,
 			   unsigned long changed)
 {
-	struct mrf24j40 *devrec = dev->priv;
+	struct mrf24j40 *devrec = hw->priv;
 
 	dev_dbg(printdev(devrec), "filter\n");
 
@@ -564,7 +564,7 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 	/* TODO: Other drivers call ieee20154_rx_irqsafe() here (eg: cc2040,
 	 * also from a workqueue).  I think irqsafe is not necessary here.
 	 * Can someone confirm? */
-	ieee802154_rx_irqsafe(devrec->dev, skb, lqi);
+	ieee802154_rx_irqsafe(devrec->hw, skb, lqi);
 
 	dev_dbg(printdev(devrec), "RX Handled\n");
 
@@ -745,17 +745,17 @@ static int mrf24j40_probe(struct spi_device *spi)
 
 	/* Register with the 802154 subsystem */
 
-	devrec->dev = ieee802154_alloc_device(0, &mrf24j40_ops);
-	if (!devrec->dev)
+	devrec->hw = ieee802154_alloc_hw(0, &mrf24j40_ops);
+	if (!devrec->hw)
 		goto err_ret;
 
-	devrec->dev->priv = devrec;
-	devrec->dev->parent = &devrec->spi->dev;
-	devrec->dev->phy->channels_supported[0] = CHANNEL_MASK;
-	devrec->dev->flags = IEEE802154_HW_OMIT_CKSUM|IEEE802154_HW_AACK;
+	devrec->hw->priv = devrec;
+	devrec->hw->parent = &devrec->spi->dev;
+	devrec->hw->phy->channels_supported[0] = CHANNEL_MASK;
+	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM|IEEE802154_HW_AACK;
 
 	dev_dbg(printdev(devrec), "registered mrf24j40\n");
-	ret = ieee802154_register_device(devrec->dev);
+	ret = ieee802154_register_hw(devrec->hw);
 	if (ret)
 		goto err_register_device;
 
@@ -780,9 +780,9 @@ static int mrf24j40_probe(struct spi_device *spi)
 
 err_irq:
 err_hw_init:
-	ieee802154_unregister_device(devrec->dev);
+	ieee802154_unregister_hw(devrec->hw);
 err_register_device:
-	ieee802154_free_device(devrec->dev);
+	ieee802154_free_hw(devrec->hw);
 err_ret:
 	return ret;
 }
@@ -793,8 +793,8 @@ static int mrf24j40_remove(struct spi_device *spi)
 
 	dev_dbg(printdev(devrec), "remove\n");
 
-	ieee802154_unregister_device(devrec->dev);
-	ieee802154_free_device(devrec->dev);
+	ieee802154_unregister_hw(devrec->hw);
+	ieee802154_free_hw(devrec->hw);
 	/* TODO: Will ieee802154_free_device() wait until ->xmit() is
 	 * complete? */
 
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 70351de..eb0e1cb 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -52,7 +52,7 @@ struct ieee802154_hw_addr_filt {
 	u8	pan_coord;
 };
 
-struct ieee802154_dev {
+struct ieee802154_hw {
 	/* filled by the driver */
 	int	extra_tx_headroom;
 	u32	flags;
@@ -159,37 +159,37 @@ struct ieee802154_dev {
  */
 struct ieee802154_ops {
 	struct module	*owner;
-	int		(*start)(struct ieee802154_dev *dev);
-	void		(*stop)(struct ieee802154_dev *dev);
-	int		(*xmit)(struct ieee802154_dev *dev,
+	int		(*start)(struct ieee802154_hw *hw);
+	void		(*stop)(struct ieee802154_hw *hw);
+	int		(*xmit)(struct ieee802154_hw *hw,
 				struct sk_buff *skb);
-	int		(*ed)(struct ieee802154_dev *dev, u8 *level);
-	int		(*set_channel)(struct ieee802154_dev *dev,
+	int		(*ed)(struct ieee802154_hw *hw, u8 *level);
+	int		(*set_channel)(struct ieee802154_hw *hw,
 				       int page,
 				       int channel);
-	int		(*set_hw_addr_filt)(struct ieee802154_dev *dev,
-					  struct ieee802154_hw_addr_filt *filt,
+	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
+					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
-	int		(*ieee_addr)(struct ieee802154_dev *dev, __le64 addr);
-	int		(*set_txpower)(struct ieee802154_dev *dev, int db);
-	int		(*set_lbt)(struct ieee802154_dev *dev, bool on);
-	int		(*set_cca_mode)(struct ieee802154_dev *dev, u8 mode);
-	int		(*set_cca_ed_level)(struct ieee802154_dev *dev,
+	int		(*ieee_addr)(struct ieee802154_hw *hw, __le64 addr);
+	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
+	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
+	int		(*set_cca_mode)(struct ieee802154_hw *hw, u8 mode);
+	int		(*set_cca_ed_level)(struct ieee802154_hw *hw,
 					    s32 level);
-	int		(*set_csma_params)(struct ieee802154_dev *dev,
+	int		(*set_csma_params)(struct ieee802154_hw *hw,
 					   u8 min_be, u8 max_be, u8 retries);
-	int		(*set_frame_retries)(struct ieee802154_dev *dev,
+	int		(*set_frame_retries)(struct ieee802154_hw *hw,
 					     s8 retries);
 };
 
-/* Basic interface to register ieee802154 device */
-struct ieee802154_dev *
-ieee802154_alloc_device(size_t priv_data_len, struct ieee802154_ops *ops);
-void ieee802154_free_device(struct ieee802154_dev *dev);
-int ieee802154_register_device(struct ieee802154_dev *dev);
-void ieee802154_unregister_device(struct ieee802154_dev *dev);
+/* Basic interface to register ieee802154 hwice */
+struct ieee802154_hw *
+ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops);
+void ieee802154_free_hw(struct ieee802154_hw *hw);
+int ieee802154_register_hw(struct ieee802154_hw *hw);
+void ieee802154_unregister_hw(struct ieee802154_hw *hw);
 
-void ieee802154_rx_irqsafe(struct ieee802154_dev *dev, struct sk_buff *skb,
+void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
 			   u8 lqi);
 
 #endif /* NET_MAC802154_H */
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 970b621..0cb98e8 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -27,7 +27,7 @@
 
 /* mac802154 device private data */
 struct mac802154_priv {
-	struct ieee802154_dev hw;
+	struct ieee802154_hw hw;
 	struct ieee802154_ops *ops;
 
 	/* ieee802154 phy */
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 9798c74..b0bcc06 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -235,8 +235,8 @@ static int mac802154_set_frame_retries(struct wpan_phy *phy, s8 retries)
 	return priv->ops->set_frame_retries(&priv->hw, retries);
 }
 
-struct ieee802154_dev *
-ieee802154_alloc_device(size_t priv_data_len, struct ieee802154_ops *ops)
+struct ieee802154_hw *
+ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
 {
 	struct wpan_phy *phy;
 	struct mac802154_priv *priv;
@@ -285,9 +285,9 @@ ieee802154_alloc_device(size_t priv_data_len, struct ieee802154_ops *ops)
 
 	return &priv->hw;
 }
-EXPORT_SYMBOL(ieee802154_alloc_device);
+EXPORT_SYMBOL(ieee802154_alloc_hw);
 
-void ieee802154_free_device(struct ieee802154_dev *hw)
+void ieee802154_free_hw(struct ieee802154_hw *hw)
 {
 	struct mac802154_priv *priv = mac802154_to_priv(hw);
 
@@ -297,49 +297,49 @@ void ieee802154_free_device(struct ieee802154_dev *hw)
 
 	wpan_phy_free(priv->phy);
 }
-EXPORT_SYMBOL(ieee802154_free_device);
+EXPORT_SYMBOL(ieee802154_free_hw);
 
-int ieee802154_register_device(struct ieee802154_dev *dev)
+int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(dev);
+	struct mac802154_priv *priv = mac802154_to_priv(hw);
 	int rc = -ENOSYS;
 
-	if (dev->flags & IEEE802154_HW_TXPOWER) {
+	if (hw->flags & IEEE802154_HW_TXPOWER) {
 		if (!priv->ops->set_txpower)
 			goto out;
 
 		priv->phy->set_txpower = mac802154_set_txpower;
 	}
 
-	if (dev->flags & IEEE802154_HW_LBT) {
+	if (hw->flags & IEEE802154_HW_LBT) {
 		if (!priv->ops->set_lbt)
 			goto out;
 
 		priv->phy->set_lbt = mac802154_set_lbt;
 	}
 
-	if (dev->flags & IEEE802154_HW_CCA_MODE) {
+	if (hw->flags & IEEE802154_HW_CCA_MODE) {
 		if (!priv->ops->set_cca_mode)
 			goto out;
 
 		priv->phy->set_cca_mode = mac802154_set_cca_mode;
 	}
 
-	if (dev->flags & IEEE802154_HW_CCA_ED_LEVEL) {
+	if (hw->flags & IEEE802154_HW_CCA_ED_LEVEL) {
 		if (!priv->ops->set_cca_ed_level)
 			goto out;
 
 		priv->phy->set_cca_ed_level = mac802154_set_cca_ed_level;
 	}
 
-	if (dev->flags & IEEE802154_HW_CSMA_PARAMS) {
+	if (hw->flags & IEEE802154_HW_CSMA_PARAMS) {
 		if (!priv->ops->set_csma_params)
 			goto out;
 
 		priv->phy->set_csma_params = mac802154_set_csma_params;
 	}
 
-	if (dev->flags & IEEE802154_HW_FRAME_RETRIES) {
+	if (hw->flags & IEEE802154_HW_FRAME_RETRIES) {
 		if (!priv->ops->set_frame_retries)
 			goto out;
 
@@ -377,11 +377,11 @@ out_wq:
 out:
 	return rc;
 }
-EXPORT_SYMBOL(ieee802154_register_device);
+EXPORT_SYMBOL(ieee802154_register_hw);
 
-void ieee802154_unregister_device(struct ieee802154_dev *dev)
+void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(dev);
+	struct mac802154_priv *priv = mac802154_to_priv(hw);
 	struct mac802154_sub_if_data *sdata, *next;
 
 	flush_workqueue(priv->dev_workqueue);
@@ -405,7 +405,7 @@ void ieee802154_unregister_device(struct ieee802154_dev *dev)
 
 	wpan_phy_unregister(priv->phy);
 }
-EXPORT_SYMBOL(ieee802154_unregister_device);
+EXPORT_SYMBOL(ieee802154_unregister_hw);
 
 MODULE_DESCRIPTION("IEEE 802.15.4 implementation");
 MODULE_LICENSE("GPL v2");
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index bc6cffd5..62b5c7d 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -42,12 +42,12 @@
 struct rx_work {
 	struct sk_buff *skb;
 	struct work_struct work;
-	struct ieee802154_dev *dev;
+	struct ieee802154_hw *hw;
 	u8 lqi;
 };
 
 static void
-mac802154_subif_rx(struct ieee802154_dev *hw, struct sk_buff *skb, u8 lqi)
+mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
 	struct mac802154_priv *priv = mac802154_to_priv(hw);
 
@@ -83,14 +83,14 @@ static void mac802154_rx_worker(struct work_struct *work)
 {
 	struct rx_work *rw = container_of(work, struct rx_work, work);
 
-	mac802154_subif_rx(rw->dev, rw->skb, rw->lqi);
+	mac802154_subif_rx(rw->hw, rw->skb, rw->lqi);
 	kfree(rw);
 }
 
 void
-ieee802154_rx_irqsafe(struct ieee802154_dev *dev, struct sk_buff *skb, u8 lqi)
+ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 {
-	struct mac802154_priv *priv = mac802154_to_priv(dev);
+	struct mac802154_priv *priv = mac802154_to_priv(hw);
 	struct rx_work *work;
 
 	if (!skb)
@@ -102,7 +102,7 @@ ieee802154_rx_irqsafe(struct ieee802154_dev *dev, struct sk_buff *skb, u8 lqi)
 
 	INIT_WORK(&work->work, mac802154_rx_worker);
 	work->skb = skb;
-	work->dev = dev;
+	work->hw = hw;
 	work->lqi = lqi;
 
 	queue_work(priv->dev_workqueue, &work->work);
-- 
2.1.2

