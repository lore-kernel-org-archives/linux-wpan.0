Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37835 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbbIUJZM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:12 -0400
Received: by wicfx3 with SMTP id fx3so102108891wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/22] mrf24j40: rework tx handling to async tx handling
Date: Mon, 21 Sep 2015 11:24:34 +0200
Message-Id: <1442827483-27975-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch reworks the current transmit API to spi_async handling. We
removed the error handling check, because mac802154 has no chance to
report it. Also the transmit timeout handling can't be handled by xmit
async handling, for this usecase we need to implement the netdev
watchdog. These are all unlikely cases which we drop now and should be
provided by netdev watchdog.

We also drop the bit setting for TXNACKREQ at register TXNCON, this is
not necessary. The TXNCON register should set only once for each frame,
previous settings doesn't matter.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 161 ++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 788adb6..3cf0625 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -152,8 +152,22 @@ struct mrf24j40 {
 
 	struct regmap *regmap_short;
 	struct regmap *regmap_long;
+
+	/* for writing txfifo */
+	struct spi_message tx_msg;
+	u8 tx_hdr_buf[2];
+	struct spi_transfer tx_hdr_trx;
+	u8 tx_len_buf[2];
+	struct spi_transfer tx_len_trx;
+	struct spi_transfer tx_buf_trx;
+	struct sk_buff *tx_skb;
+
+	/* post transmit message to send frame out  */
+	struct spi_message tx_post_msg;
+	u8 tx_post_buf[2];
+	struct spi_transfer tx_post_trx;
+
 	struct mutex buffer_mutex; /* only used to protect buf */
-	struct completion tx_complete;
 	u8 *buf; /* 3 bytes. Used for SPI single-register transfers. */
 };
 
@@ -543,28 +557,33 @@ static int read_long_reg(struct mrf24j40 *devrec, u16 reg, u8 *value)
 	return ret;
 }
 
+static void write_tx_buf_complete(void *context)
+{
+	struct mrf24j40 *devrec = context;
+	__le16 fc = ieee802154_get_fc_from_skb(devrec->tx_skb);
+	u8 val = 0x01;
+	int ret;
+
+	if (ieee802154_is_ackreq(fc))
+		val |= 0x04;
+
+	devrec->tx_post_msg.complete = NULL;
+	devrec->tx_post_buf[0] = MRF24J40_WRITESHORT(REG_TXNCON);
+	devrec->tx_post_buf[1] = val;
+
+	ret = spi_async(devrec->spi, &devrec->tx_post_msg);
+	if (ret)
+		dev_err(printdev(devrec), "SPI write Failed for transmit buf\n");
+}
+
 /* This function relies on an undocumented write method. Once a write command
    and address is set, as many bytes of data as desired can be clocked into
    the device. The datasheet only shows setting one byte at a time. */
 static int write_tx_buf(struct mrf24j40 *devrec, u16 reg,
 			const u8 *data, size_t length)
 {
-	int ret;
 	u16 cmd;
-	u8 lengths[2];
-	struct spi_message msg;
-	struct spi_transfer addr_xfer = {
-		.len = 2,
-		.tx_buf = devrec->buf,
-	};
-	struct spi_transfer lengths_xfer = {
-		.len = 2,
-		.tx_buf = &lengths, /* TODO: Is DMA really required for SPI? */
-	};
-	struct spi_transfer data_xfer = {
-		.len = length,
-		.tx_buf = data,
-	};
+	int ret;
 
 	/* Range check the length. 2 bytes are used for the length fields.*/
 	if (length > TX_FIFO_SIZE-2) {
@@ -572,26 +591,31 @@ static int write_tx_buf(struct mrf24j40 *devrec, u16 reg,
 		length = TX_FIFO_SIZE-2;
 	}
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&addr_xfer, &msg);
-	spi_message_add_tail(&lengths_xfer, &msg);
-	spi_message_add_tail(&data_xfer, &msg);
-
 	cmd = MRF24J40_WRITELONG(reg);
-	mutex_lock(&devrec->buffer_mutex);
-	devrec->buf[0] = cmd >> 8 & 0xff;
-	devrec->buf[1] = cmd & 0xff;
-	lengths[0] = 0x0; /* Header Length. Set to 0 for now. TODO */
-	lengths[1] = length; /* Total length */
-
-	ret = spi_sync(devrec->spi, &msg);
+	devrec->tx_hdr_buf[0] = cmd >> 8 & 0xff;
+	devrec->tx_hdr_buf[1] = cmd & 0xff;
+	devrec->tx_len_buf[0] = 0x0; /* Header Length. Set to 0 for now. TODO */
+	devrec->tx_len_buf[1] = length; /* Total length */
+	devrec->tx_buf_trx.tx_buf = data;
+	devrec->tx_buf_trx.len = length;
+
+	ret = spi_async(devrec->spi, &devrec->tx_msg);
 	if (ret)
 		dev_err(printdev(devrec), "SPI write Failed for TX buf\n");
 
-	mutex_unlock(&devrec->buffer_mutex);
 	return ret;
 }
 
+static int mrf24j40_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
+{
+	struct mrf24j40 *devrec = hw->priv;
+
+	dev_dbg(printdev(devrec), "tx packet of %d bytes\n", skb->len);
+	devrec->tx_skb = skb;
+
+	return write_tx_buf(devrec, 0x000, skb->data, skb->len);
+}
+
 static int mrf24j40_read_rx_buf(struct mrf24j40 *devrec,
 				u8 *data, u8 *len, u8 *lqi)
 {
@@ -664,57 +688,6 @@ out:
 	return ret;
 }
 
-static int mrf24j40_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
-{
-	struct mrf24j40 *devrec = hw->priv;
-	u8 val;
-	int ret = 0;
-
-	dev_dbg(printdev(devrec), "tx packet of %d bytes\n", skb->len);
-
-	ret = write_tx_buf(devrec, 0x000, skb->data, skb->len);
-	if (ret)
-		goto err;
-
-	reinit_completion(&devrec->tx_complete);
-
-	/* Set TXNTRIG bit of TXNCON to send packet */
-	ret = read_short_reg(devrec, REG_TXNCON, &val);
-	if (ret)
-		goto err;
-	val |= 0x1;
-	/* Set TXNACKREQ if the ACK bit is set in the packet. */
-	if (skb->data[0] & IEEE802154_FC_ACK_REQ)
-		val |= 0x4;
-	write_short_reg(devrec, REG_TXNCON, val);
-
-	/* Wait for the device to send the TX complete interrupt. */
-	ret = wait_for_completion_interruptible_timeout(
-						&devrec->tx_complete,
-						5 * HZ);
-	if (ret == -ERESTARTSYS)
-		goto err;
-	if (ret == 0) {
-		dev_warn(printdev(devrec), "Timeout waiting for TX interrupt\n");
-		ret = -ETIMEDOUT;
-		goto err;
-	}
-
-	/* Check for send error from the device. */
-	ret = read_short_reg(devrec, REG_TXSTAT, &val);
-	if (ret)
-		goto err;
-	if (val & 0x1) {
-		dev_dbg(printdev(devrec), "Error Sending. Retry count exceeded\n");
-		ret = -ECOMM; /* TODO: Better error code ? */
-	} else
-		dev_dbg(printdev(devrec), "Packet Sent\n");
-
-err:
-
-	return ret;
-}
-
 static int mrf24j40_ed(struct ieee802154_hw *hw, u8 *level)
 {
 	/* TODO: */
@@ -901,7 +874,7 @@ out:
 
 static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
-	.xmit_sync = mrf24j40_tx,
+	.xmit_async = mrf24j40_tx,
 	.ed = mrf24j40_ed,
 	.start = mrf24j40_start,
 	.stop = mrf24j40_stop,
@@ -922,7 +895,7 @@ static irqreturn_t mrf24j40_isr(int irq, void *data)
 
 	/* Check for TX complete */
 	if (intstat & 0x1)
-		complete(&devrec->tx_complete);
+		ieee802154_xmit_complete(devrec->hw, devrec->tx_skb, false);
 
 	/* Check for Rx */
 	if (intstat & 0x8)
@@ -1031,6 +1004,27 @@ err_ret:
 	return ret;
 }
 
+static void
+mrf24j40_setup_tx_spi_messages(struct mrf24j40 *devrec)
+{
+	spi_message_init(&devrec->tx_msg);
+	devrec->tx_msg.context = devrec;
+	devrec->tx_msg.complete = write_tx_buf_complete;
+	devrec->tx_hdr_trx.len = 2;
+	devrec->tx_hdr_trx.tx_buf = devrec->tx_hdr_buf;
+	spi_message_add_tail(&devrec->tx_hdr_trx, &devrec->tx_msg);
+	devrec->tx_len_trx.len = 2;
+	devrec->tx_len_trx.tx_buf = devrec->tx_len_buf;
+	spi_message_add_tail(&devrec->tx_len_trx, &devrec->tx_msg);
+	spi_message_add_tail(&devrec->tx_buf_trx, &devrec->tx_msg);
+
+	spi_message_init(&devrec->tx_post_msg);
+	devrec->tx_post_msg.context = devrec;
+	devrec->tx_post_trx.len = 2;
+	devrec->tx_post_trx.tx_buf = devrec->tx_post_buf;
+	spi_message_add_tail(&devrec->tx_post_trx, &devrec->tx_post_msg);
+}
+
 static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 {
 	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
@@ -1059,6 +1053,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
 	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
 
+	mrf24j40_setup_tx_spi_messages(devrec);
+
 	devrec->regmap_short = devm_regmap_init_spi(spi,
 						    &mrf24j40_short_regmap);
 	if (IS_ERR(devrec->regmap_short)) {
@@ -1089,7 +1085,6 @@ static int mrf24j40_probe(struct spi_device *spi)
 	}
 
 	mutex_init(&devrec->buffer_mutex);
-	init_completion(&devrec->tx_complete);
 
 	ret = mrf24j40_hw_init(devrec);
 	if (ret)
-- 
2.5.2

