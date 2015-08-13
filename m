Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36695 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbHMMXe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:34 -0400
Received: by wicja10 with SMTP id ja10so149303651wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:33 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 14/21] mrf24j40: rework rx handling to async rx handling
Date: Thu, 13 Aug 2015 14:22:41 +0200
Message-Id: <1439468568-22288-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch prepares that we can do the receive handling inside interrupt
context by using spi_async. This is necessary for introduce a
non-threaded irq handling.

Also we drop the bit setting for "RXDECINV" at register "BBREG1", we do
a driectly full write of register "BBREG1", because it contains the bit
RXDECINV only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 275 +++++++++++++++-----------------------
 1 file changed, 111 insertions(+), 164 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 8851475..044d6c6 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -167,6 +167,20 @@ struct mrf24j40 {
 	u8 tx_post_buf[2];
 	struct spi_transfer tx_post_trx;
 
+	/* for protect/unprotect/read length rxfifo */
+	struct spi_message rx_msg;
+	u8 rx_buf[3];
+	struct spi_transfer rx_trx;
+
+	/* receive handling */
+	struct spi_message rx_buf_msg;
+	u8 rx_addr_buf[2];
+	struct spi_transfer rx_addr_trx;
+	u8 rx_lqi_buf[2];
+	struct spi_transfer rx_lqi_trx;
+	u8 rx_fifo_buf[RX_FIFO_SIZE];
+	struct spi_transfer rx_fifo_buf_trx;
+
 	struct mutex buffer_mutex; /* only used to protect buf */
 	u8 *buf; /* 3 bytes. Used for SPI single-register transfers. */
 };
@@ -472,32 +486,6 @@ static const struct regmap_bus mrf24j40_long_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
-static int write_short_reg(struct mrf24j40 *devrec, u8 reg, u8 value)
-{
-	int ret;
-	struct spi_message msg;
-	struct spi_transfer xfer = {
-		.len = 2,
-		.tx_buf = devrec->buf,
-		.rx_buf = devrec->buf,
-	};
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-
-	mutex_lock(&devrec->buffer_mutex);
-	devrec->buf[0] = MRF24J40_WRITESHORT(reg);
-	devrec->buf[1] = value;
-
-	ret = spi_sync(devrec->spi, &msg);
-	if (ret)
-		dev_err(printdev(devrec),
-			"SPI write Failed for short register 0x%hhx\n", reg);
-
-	mutex_unlock(&devrec->buffer_mutex);
-	return ret;
-}
-
 static int read_short_reg(struct mrf24j40 *devrec, u8 reg, u8 *val)
 {
 	int ret = -1;
@@ -526,37 +514,6 @@ static int read_short_reg(struct mrf24j40 *devrec, u8 reg, u8 *val)
 	return ret;
 }
 
-static int read_long_reg(struct mrf24j40 *devrec, u16 reg, u8 *value)
-{
-	int ret;
-	u16 cmd;
-	struct spi_message msg;
-	struct spi_transfer xfer = {
-		.len = 3,
-		.tx_buf = devrec->buf,
-		.rx_buf = devrec->buf,
-	};
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-
-	cmd = MRF24J40_READLONG(reg);
-	mutex_lock(&devrec->buffer_mutex);
-	devrec->buf[0] = cmd >> 8 & 0xff;
-	devrec->buf[1] = cmd & 0xff;
-	devrec->buf[2] = 0;
-
-	ret = spi_sync(devrec->spi, &msg);
-	if (ret)
-		dev_err(printdev(devrec),
-			"SPI read Failed for long register 0x%hx\n", reg);
-	else
-		*value = devrec->buf[2];
-
-	mutex_unlock(&devrec->buffer_mutex);
-	return ret;
-}
-
 static void write_tx_buf_complete(void *context)
 {
 	struct mrf24j40 *devrec = context;
@@ -616,78 +573,6 @@ static int mrf24j40_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	return write_tx_buf(devrec, 0x000, skb->data, skb->len);
 }
 
-static int mrf24j40_read_rx_buf(struct mrf24j40 *devrec,
-				u8 *data, u8 *len, u8 *lqi)
-{
-	u8 rx_len;
-	u8 addr[2];
-	u8 lqi_rssi[2];
-	u16 cmd;
-	int ret;
-	struct spi_message msg;
-	struct spi_transfer addr_xfer = {
-		.len = 2,
-		.tx_buf = &addr,
-	};
-	struct spi_transfer data_xfer = {
-		.len = 0x0, /* set below */
-		.rx_buf = data,
-	};
-	struct spi_transfer status_xfer = {
-		.len = 2,
-		.rx_buf = &lqi_rssi,
-	};
-
-	/* Get the length of the data in the RX FIFO. The length in this
-	 * register exclues the 1-byte length field at the beginning. */
-	ret = read_long_reg(devrec, REG_RX_FIFO, &rx_len);
-	if (ret)
-		goto out;
-
-	/* Range check the RX FIFO length, accounting for the one-byte
-	 * length field at the beginning. */
-	if (rx_len > RX_FIFO_SIZE-1) {
-		dev_err(printdev(devrec), "Invalid length read from device. Performing short read.\n");
-		rx_len = RX_FIFO_SIZE-1;
-	}
-
-	if (rx_len > *len) {
-		/* Passed in buffer wasn't big enough. Should never happen. */
-		dev_err(printdev(devrec), "Buffer not big enough. Performing short read\n");
-		rx_len = *len;
-	}
-
-	/* Set up the commands to read the data. */
-	cmd = MRF24J40_READLONG(REG_RX_FIFO+1);
-	addr[0] = cmd >> 8 & 0xff;
-	addr[1] = cmd & 0xff;
-	data_xfer.len = rx_len;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&addr_xfer, &msg);
-	spi_message_add_tail(&data_xfer, &msg);
-	spi_message_add_tail(&status_xfer, &msg);
-
-	ret = spi_sync(devrec->spi, &msg);
-	if (ret) {
-		dev_err(printdev(devrec), "SPI RX Buffer Read Failed.\n");
-		goto out;
-	}
-
-	*lqi = lqi_rssi[0];
-	*len = rx_len;
-
-#ifdef DEBUG
-	print_hex_dump(KERN_DEBUG, "mrf24j40 rx: ",
-		       DUMP_PREFIX_OFFSET, 16, 1, data, *len, 0);
-	pr_debug("mrf24j40 rx: lqi: %02hhx rssi: %02hhx\n",
-		 lqi_rssi[0], lqi_rssi[1]);
-#endif
-
-out:
-	return ret;
-}
-
 static int mrf24j40_ed(struct ieee802154_hw *hw, u8 *level)
 {
 	/* TODO: */
@@ -823,53 +708,91 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
 	return 0;
 }
 
-static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
+static void mrf24j40_handle_rx_read_buf_unlock(struct mrf24j40 *devrec)
 {
-	u8 len = RX_FIFO_SIZE;
-	u8 lqi = 0;
-	u8 val;
-	int ret = 0;
-	int ret2;
-	struct sk_buff *skb;
+	int ret;
 
-	/* Turn off reception of packets off the air. This prevents the
-	 * device from overwriting the buffer while we're reading it. */
-	ret = read_short_reg(devrec, REG_BBREG1, &val);
+	/* Turn back on reception of packets off the air. */
+	devrec->rx_msg.complete = NULL;
+	devrec->rx_buf[0] = MRF24J40_WRITESHORT(REG_BBREG1);
+	devrec->rx_buf[1] = 0x00; /* CLR RXDECINV */
+	ret = spi_async(devrec->spi, &devrec->rx_msg);
 	if (ret)
-		goto out;
-	val |= 4; /* SET RXDECINV */
-	write_short_reg(devrec, REG_BBREG1, val);
+		dev_err(printdev(devrec), "failed to unlock rx buffer\n");
+}
 
-	skb = dev_alloc_skb(len);
+static void mrf24j40_handle_rx_read_buf_complete(void *context)
+{
+	struct mrf24j40 *devrec = context;
+	u8 len = devrec->rx_buf[2];
+	u8 rx_local_buf[RX_FIFO_SIZE];
+	struct sk_buff *skb;
+
+	memcpy(rx_local_buf, devrec->rx_fifo_buf, len);
+	mrf24j40_handle_rx_read_buf_unlock(devrec);
+
+	skb = dev_alloc_skb(IEEE802154_MTU);
 	if (!skb) {
-		ret = -ENOMEM;
-		goto out;
+		dev_err(printdev(devrec), "failed to allocate skb\n");
+		return;
 	}
 
-	ret = mrf24j40_read_rx_buf(devrec, skb_put(skb, len), &len, &lqi);
-	if (ret < 0) {
-		dev_err(printdev(devrec), "Failure reading RX FIFO\n");
-		kfree_skb(skb);
-		ret = -EINVAL;
-		goto out;
+	memcpy(skb_put(skb, len), rx_local_buf, len);
+	ieee802154_rx_irqsafe(devrec->hw, skb, 0);
+}
+
+static void mrf24j40_handle_rx_read_buf(void *context)
+{
+	struct mrf24j40 *devrec = context;
+	u16 cmd;
+	int ret;
+
+	/* if length is invalid read the full MTU */
+	if (!ieee802154_is_valid_psdu_len(devrec->rx_buf[2]))
+		devrec->rx_buf[2] = IEEE802154_MTU;
+
+	cmd = MRF24J40_READLONG(REG_RX_FIFO + 1);
+	devrec->rx_addr_buf[0] = cmd >> 8 & 0xff;
+	devrec->rx_addr_buf[1] = cmd & 0xff;
+	devrec->rx_fifo_buf_trx.len = devrec->rx_buf[2];
+	ret = spi_async(devrec->spi, &devrec->rx_buf_msg);
+	if (ret) {
+		dev_err(printdev(devrec), "failed to read rx buffer\n");
+		mrf24j40_handle_rx_read_buf_unlock(devrec);
 	}
+}
+
+static void mrf24j40_handle_rx_read_len(void *context)
+{
+	struct mrf24j40 *devrec = context;
+	u16 cmd;
+	int ret;
 
-	/* TODO: Other drivers call ieee20154_rx_irqsafe() here (eg: cc2040,
-	 * also from a workqueue).  I think irqsafe is not necessary here.
-	 * Can someone confirm? */
-	ieee802154_rx_irqsafe(devrec->hw, skb, lqi);
+	/* read the length of received frame */
+	devrec->rx_msg.complete = mrf24j40_handle_rx_read_buf;
+	devrec->rx_trx.len = 3;
+	cmd = MRF24J40_READLONG(REG_RX_FIFO);
+	devrec->rx_buf[0] = cmd >> 8 & 0xff;
+	devrec->rx_buf[1] = cmd & 0xff;
 
-	dev_dbg(printdev(devrec), "RX Handled\n");
+	ret = spi_async(devrec->spi, &devrec->rx_msg);
+	if (ret) {
+		dev_err(printdev(devrec), "failed to read rx buffer length\n");
+		mrf24j40_handle_rx_read_buf_unlock(devrec);
+	}
+}
 
-out:
-	/* Turn back on reception of packets off the air. */
-	ret2 = read_short_reg(devrec, REG_BBREG1, &val);
-	if (ret2)
-		return ret2;
-	val &= ~0x4; /* Clear RXDECINV */
-	write_short_reg(devrec, REG_BBREG1, val);
+static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
+{
+	/* Turn off reception of packets off the air. This prevents the
+	 * device from overwriting the buffer while we're reading it.
+	 */
+	devrec->rx_msg.complete = mrf24j40_handle_rx_read_len;
+	devrec->rx_trx.len = 2;
+	devrec->rx_buf[0] = MRF24J40_WRITESHORT(REG_BBREG1);
+	devrec->rx_buf[1] = 0x04; /* SET RXDECINV */
 
-	return ret;
+	return spi_async(devrec->spi, &devrec->rx_msg);
 }
 
 static const struct ieee802154_ops mrf24j40_ops = {
@@ -1025,6 +948,29 @@ mrf24j40_setup_tx_spi_messages(struct mrf24j40 *devrec)
 	spi_message_add_tail(&devrec->tx_post_trx, &devrec->tx_post_msg);
 }
 
+static void
+mrf24j40_setup_rx_spi_messages(struct mrf24j40 *devrec)
+{
+	spi_message_init(&devrec->rx_msg);
+	devrec->rx_msg.context = devrec;
+	devrec->rx_trx.len = 2;
+	devrec->rx_trx.tx_buf = devrec->rx_buf;
+	devrec->rx_trx.rx_buf = devrec->rx_buf;
+	spi_message_add_tail(&devrec->rx_trx, &devrec->rx_msg);
+
+	spi_message_init(&devrec->rx_buf_msg);
+	devrec->rx_buf_msg.context = devrec;
+	devrec->rx_buf_msg.complete = mrf24j40_handle_rx_read_buf_complete;
+	devrec->rx_addr_trx.len = 2;
+	devrec->rx_addr_trx.tx_buf = devrec->rx_addr_buf;
+	spi_message_add_tail(&devrec->rx_addr_trx, &devrec->rx_buf_msg);
+	devrec->rx_fifo_buf_trx.rx_buf = devrec->rx_fifo_buf;
+	spi_message_add_tail(&devrec->rx_fifo_buf_trx, &devrec->rx_buf_msg);
+	devrec->rx_lqi_trx.len = 2;
+	devrec->rx_lqi_trx.rx_buf = devrec->rx_lqi_buf;
+	spi_message_add_tail(&devrec->rx_lqi_trx, &devrec->rx_buf_msg);
+}
+
 static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 {
 	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
@@ -1054,6 +1000,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
 
 	mrf24j40_setup_tx_spi_messages(devrec);
+	mrf24j40_setup_rx_spi_messages(devrec);
 
 	devrec->regmap_short = devm_regmap_init_spi(spi,
 						    &mrf24j40_short_regmap);
-- 
2.5.0

