Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:39484
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750829AbdK1Mut (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 28 Nov 2017 07:50:49 -0500
From: <michael.hennerich@analog.com>
Subject: [PATCH 5/5] net: ieee802154: adf7242: Rework IRQ and packet handling
Date: Tue, 28 Nov 2017 13:53:15 +0100
Message-ID: <1511873595-29238-5-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
References: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

 * Stop unconditionally polling for RC_STATUS_PHY_RDY at the entry of
the threaded IRQ handler. Once IRQ_RX_PKT_RCVD is received we can
read immediately the packet from the buffer. However we still need
to wait afterwards for RC_STATUS_PHY_RDY, to make sure that the
ACK (in case requested) was processed and send out by the
Radio Controller, before we issue the next CMD_RC_RX.
This significantly reduces the overall time spend in the threaded
IRQ handler.

 * Avoid raise condition between xmit and coincident packet reception,
by disabling the IRQ and clearing the IRQ status upon xmit entry.

 * Introduce helper functions adf7242_clear_irqstat() and adf7242_cmd_rx()

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/net/ieee802154/adf7242.c | 54 +++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 548bec1..64f1b1e 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -563,6 +563,22 @@ static int adf7242_verify_firmware(struct adf7242_local *lp,
 	return 0;
 }
 
+static void adf7242_clear_irqstat(struct adf7242_local *lp)
+{
+	adf7242_write_reg(lp, REG_IRQ1_SRC1, IRQ_CCA_COMPLETE | IRQ_SFD_RX |
+			  IRQ_SFD_TX | IRQ_RX_PKT_RCVD | IRQ_TX_PKT_SENT |
+			  IRQ_FRAME_VALID | IRQ_ADDRESS_VALID | IRQ_CSMA_CA);
+}
+
+static int adf7242_cmd_rx(struct adf7242_local *lp)
+{
+	/* Wait until the ACK is sent */
+	adf7242_wait_status(lp, RC_STATUS_PHY_RDY, RC_STATUS_MASK, __LINE__);
+	adf7242_clear_irqstat(lp);
+
+	return adf7242_cmd(lp, CMD_RC_RX);
+}
+
 static int adf7242_set_txpower(struct ieee802154_hw *hw, int mbm)
 {
 	struct adf7242_local *lp = hw->priv;
@@ -666,7 +682,7 @@ static int adf7242_start(struct ieee802154_hw *hw)
 	struct adf7242_local *lp = hw->priv;
 
 	adf7242_cmd(lp, CMD_RC_PHY_RDY);
-	adf7242_write_reg(lp, REG_IRQ1_SRC1, 0xFF);
+	adf7242_clear_irqstat(lp);
 	enable_irq(lp->spi->irq);
 	set_bit(FLAG_START, &lp->flags);
 
@@ -677,10 +693,10 @@ static void adf7242_stop(struct ieee802154_hw *hw)
 {
 	struct adf7242_local *lp = hw->priv;
 
+	disable_irq(lp->spi->irq);
 	adf7242_cmd(lp, CMD_RC_IDLE);
 	clear_bit(FLAG_START, &lp->flags);
-	disable_irq(lp->spi->irq);
-	adf7242_write_reg(lp, REG_IRQ1_SRC1, 0xFF);
+	adf7242_clear_irqstat(lp);
 }
 
 static int adf7242_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
@@ -795,9 +811,12 @@ static int adf7242_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct adf7242_local *lp = hw->priv;
 	int ret;
 
+	/* ensure existing instances of the IRQ handler have completed */
+	disable_irq(lp->spi->irq);
 	set_bit(FLAG_XMIT, &lp->flags);
 	reinit_completion(&lp->tx_complete);
 	adf7242_cmd(lp, CMD_RC_PHY_RDY);
+	adf7242_clear_irqstat(lp);
 
 	ret = adf7242_write_fbuf(lp, skb->data, skb->len);
 	if (ret)
@@ -806,6 +825,7 @@ static int adf7242_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	ret = adf7242_cmd(lp, CMD_RC_CSMACA);
 	if (ret)
 		goto err;
+	enable_irq(lp->spi->irq);
 
 	ret = wait_for_completion_interruptible_timeout(&lp->tx_complete,
 							HZ / 10);
@@ -828,7 +848,7 @@ static int adf7242_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 err:
 	clear_bit(FLAG_XMIT, &lp->flags);
-	adf7242_cmd(lp, CMD_RC_RX);
+	adf7242_cmd_rx(lp);
 
 	return ret;
 }
@@ -852,7 +872,7 @@ static int adf7242_rx(struct adf7242_local *lp)
 
 	skb = dev_alloc_skb(len);
 	if (!skb) {
-		adf7242_cmd(lp, CMD_RC_RX);
+		adf7242_cmd_rx(lp);
 		return -ENOMEM;
 	}
 
@@ -860,14 +880,14 @@ static int adf7242_rx(struct adf7242_local *lp)
 	ret = adf7242_read_fbuf(lp, data, len, true);
 	if (ret < 0) {
 		kfree_skb(skb);
-		adf7242_cmd(lp, CMD_RC_RX);
+		adf7242_cmd_rx(lp);
 		return ret;
 	}
 
 	lqi = data[len - 2];
 	lp->rssi = data[len - 1];
 
-	adf7242_cmd(lp, CMD_RC_RX);
+	ret = adf7242_cmd_rx(lp);
 
 	skb_trim(skb, len - 2);	/* Don't put RSSI/LQI or CRC into the frame */
 
@@ -876,7 +896,7 @@ static int adf7242_rx(struct adf7242_local *lp)
 	dev_dbg(&lp->spi->dev, "%s: ret=%d len=%d lqi=%d rssi=%d\n",
 		__func__, ret, (int)len, (int)lqi, lp->rssi);
 
-	return 0;
+	return ret;
 }
 
 static const struct ieee802154_ops adf7242_ops = {
@@ -932,10 +952,7 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 	unsigned int xmit;
 	u8 irq1;
 
-	adf7242_wait_status(lp, RC_STATUS_PHY_RDY, RC_STATUS_MASK, __LINE__);
-
 	adf7242_read_reg(lp, REG_IRQ1_SRC1, &irq1);
-	adf7242_write_reg(lp, REG_IRQ1_SRC1, irq1);
 
 	if (!(irq1 & (IRQ_RX_PKT_RCVD | IRQ_CSMA_CA)))
 		dev_err(&lp->spi->dev, "%s :ERROR IRQ1 = 0x%X\n",
@@ -946,6 +963,9 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 	xmit = test_bit(FLAG_XMIT, &lp->flags);
 
 	if (xmit && (irq1 & IRQ_CSMA_CA)) {
+		adf7242_wait_status(lp, RC_STATUS_PHY_RDY,
+				    RC_STATUS_MASK, __LINE__);
+
 		if (ADF7242_REPORT_CSMA_CA_STAT) {
 			u8 astat;
 
@@ -966,6 +986,7 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 			lp->tx_stat = SUCCESS;
 		}
 		complete(&lp->tx_complete);
+		adf7242_clear_irqstat(lp);
 	} else if (!xmit && (irq1 & IRQ_RX_PKT_RCVD) &&
 		   (irq1 & IRQ_FRAME_VALID)) {
 		adf7242_rx(lp);
@@ -974,16 +995,19 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 		dev_dbg(&lp->spi->dev, "%s:%d : ERROR IRQ1 = 0x%X\n",
 			__func__, __LINE__, irq1);
 		adf7242_cmd(lp, CMD_RC_PHY_RDY);
-		adf7242_write_reg(lp, REG_IRQ1_SRC1, 0xFF);
-		adf7242_cmd(lp, CMD_RC_RX);
+		adf7242_cmd_rx(lp);
 	} else {
 		/* This can only be xmit without IRQ, likely a RX packet.
 		 * we get an TX IRQ shortly - do nothing or let the xmit
 		 * timeout handle this
 		 */
+
 		dev_dbg(&lp->spi->dev, "%s:%d : ERROR IRQ1 = 0x%X, xmit %d\n",
 			__func__, __LINE__, irq1, xmit);
+		adf7242_wait_status(lp, RC_STATUS_PHY_RDY,
+				    RC_STATUS_MASK, __LINE__);
 		complete(&lp->tx_complete);
+		adf7242_clear_irqstat(lp);
 	}
 
 	return IRQ_HANDLED;
@@ -1003,7 +1027,7 @@ static int adf7242_soft_reset(struct adf7242_local *lp, int line)
 	adf7242_set_promiscuous_mode(lp->hw, lp->promiscuous);
 	adf7242_set_csma_params(lp->hw, lp->min_be, lp->max_be,
 				lp->max_cca_retries);
-	adf7242_write_reg(lp, REG_IRQ1_SRC1, 0xFF);
+	adf7242_clear_irqstat(lp);
 
 	if (test_bit(FLAG_START, &lp->flags)) {
 		enable_irq(lp->spi->irq);
@@ -1069,7 +1093,7 @@ static int adf7242_hw_init(struct adf7242_local *lp)
 	adf7242_write_reg(lp, REG_IRQ1_EN0, 0);
 	adf7242_write_reg(lp, REG_IRQ1_EN1, IRQ_RX_PKT_RCVD | IRQ_CSMA_CA);
 
-	adf7242_write_reg(lp, REG_IRQ1_SRC1, 0xFF);
+	adf7242_clear_irqstat(lp);
 	adf7242_write_reg(lp, REG_IRQ1_SRC0, 0xFF);
 
 	adf7242_cmd(lp, CMD_RC_IDLE);
-- 
2.7.4

