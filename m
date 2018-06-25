Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-sn1nam02on0048.outbound.protection.outlook.com ([104.47.36.48]:12358
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933144AbeFYN54 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 25 Jun 2018 09:57:56 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V2] net: ieee802154: adf7242: Fix OCL calibration runs
Date: Mon, 25 Jun 2018 16:57:37 +0300
Message-ID: <20180625135737.18238-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, Michael.Hennerich@analog.com, stefan@osg.samsung.com
Cc: Michael Hennerich <michael.hennerich@analog.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Reissuing RC_RX every 400ms - to adjust for offset drift in
receiver see datasheet page 61, OCL section.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

v1 -> v2:
* fixed checkpatch.pl reported issues
  * 1 line too long: `lp->wqueue = alloc_ordered_workqueue(dev_name(&s`
  * 1 comment was adjusted: `/* Reissuing RC_RX every 400ms - `

 drivers/net/ieee802154/adf7242.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 64f1b1e77bc0..4e87dd041c02 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -275,6 +275,8 @@ struct adf7242_local {
 	struct spi_message stat_msg;
 	struct spi_transfer stat_xfer;
 	struct dentry *debugfs_root;
+	struct delayed_work work;
+	struct workqueue_struct *wqueue;
 	unsigned long flags;
 	int tx_stat;
 	bool promiscuous;
@@ -575,10 +577,26 @@ static int adf7242_cmd_rx(struct adf7242_local *lp)
 	/* Wait until the ACK is sent */
 	adf7242_wait_status(lp, RC_STATUS_PHY_RDY, RC_STATUS_MASK, __LINE__);
 	adf7242_clear_irqstat(lp);
+	mod_delayed_work(lp->wqueue, &lp->work, msecs_to_jiffies(400));
 
 	return adf7242_cmd(lp, CMD_RC_RX);
 }
 
+static void adf7242_rx_cal_work(struct work_struct *work)
+{
+	struct adf7242_local *lp =
+	container_of(work, struct adf7242_local, work.work);
+
+	/* Reissuing RC_RX every 400ms - to adjust for offset
+	 * drift in receiver (datasheet page 61, OCL section)
+	 */
+
+	if (!test_bit(FLAG_XMIT, &lp->flags)) {
+		adf7242_cmd(lp, CMD_RC_PHY_RDY);
+		adf7242_cmd_rx(lp);
+	}
+}
+
 static int adf7242_set_txpower(struct ieee802154_hw *hw, int mbm)
 {
 	struct adf7242_local *lp = hw->priv;
@@ -686,7 +704,7 @@ static int adf7242_start(struct ieee802154_hw *hw)
 	enable_irq(lp->spi->irq);
 	set_bit(FLAG_START, &lp->flags);
 
-	return adf7242_cmd(lp, CMD_RC_RX);
+	return adf7242_cmd_rx(lp);
 }
 
 static void adf7242_stop(struct ieee802154_hw *hw)
@@ -694,6 +712,7 @@ static void adf7242_stop(struct ieee802154_hw *hw)
 	struct adf7242_local *lp = hw->priv;
 
 	disable_irq(lp->spi->irq);
+	cancel_delayed_work_sync(&lp->work);
 	adf7242_cmd(lp, CMD_RC_IDLE);
 	clear_bit(FLAG_START, &lp->flags);
 	adf7242_clear_irqstat(lp);
@@ -814,6 +833,7 @@ static int adf7242_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	/* ensure existing instances of the IRQ handler have completed */
 	disable_irq(lp->spi->irq);
 	set_bit(FLAG_XMIT, &lp->flags);
+	cancel_delayed_work_sync(&lp->work);
 	reinit_completion(&lp->tx_complete);
 	adf7242_cmd(lp, CMD_RC_PHY_RDY);
 	adf7242_clear_irqstat(lp);
@@ -952,6 +972,7 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 	unsigned int xmit;
 	u8 irq1;
 
+	mod_delayed_work(lp->wqueue, &lp->work, msecs_to_jiffies(400));
 	adf7242_read_reg(lp, REG_IRQ1_SRC1, &irq1);
 
 	if (!(irq1 & (IRQ_RX_PKT_RCVD | IRQ_CSMA_CA)))
@@ -1241,6 +1262,9 @@ static int adf7242_probe(struct spi_device *spi)
 	spi_message_add_tail(&lp->stat_xfer, &lp->stat_msg);
 
 	spi_set_drvdata(spi, lp);
+	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
+	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
+					     WQ_MEM_RECLAIM);
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
@@ -1284,6 +1308,9 @@ static int adf7242_remove(struct spi_device *spi)
 	if (!IS_ERR_OR_NULL(lp->debugfs_root))
 		debugfs_remove_recursive(lp->debugfs_root);
 
+	cancel_delayed_work_sync(&lp->work);
+	destroy_workqueue(lp->wqueue);
+
 	ieee802154_unregister_hw(lp->hw);
 	mutex_destroy(&lp->bmux);
 	ieee802154_free_hw(lp->hw);
-- 
2.17.1

