Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36087 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaJZIQ7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:16:59 -0400
Received: by mail-la0-f42.google.com with SMTP id gf13so4944899lab.29
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:16:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/15] at86rf230: asynchronous xmit handling
Date: Sun, 26 Oct 2014 09:15:52 +0100
Message-Id: <1414311352-908-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
References: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch converts the sync xmit handling into an async xmit handling. The
driver was already prepared for this step, all other drivers need more
work to implement a xmit_async function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 42 +++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 06a3e90..0669783 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -91,7 +91,6 @@ struct at86rf230_local {
 	bool is_tx;
 	/* spinlock for is_tx protection */
 	spinlock_t lock;
-	struct completion tx_complete;
 	struct sk_buff *tx_skb;
 	struct at86rf230_state_change tx;
 };
@@ -452,6 +451,7 @@ at86rf230_async_error_recover(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 
 	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL, false);
+	ieee802154_wake_queue(lp->hw);
 }
 
 static void
@@ -715,9 +715,23 @@ at86rf230_tx_complete(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
+	struct sk_buff *skb = lp->tx_skb;
 
 	enable_irq(lp->spi->irq);
-	complete(&lp->tx_complete);
+
+	if (lp->max_frame_retries <= 0) {
+		/* Interfame spacing time, which is phy depend.
+		 * TODO
+		 * Move this handling in MAC 802.15.4 layer.
+		 * This is currently a workaround to avoid fragmenation issues.
+		 */
+		if (skb->len > 18)
+			udelay(lp->data->t_lifs);
+		else
+			udelay(lp->data->t_sifs);
+	}
+
+	ieee802154_xmit_complete(lp->hw, skb);
 }
 
 static void
@@ -975,7 +989,6 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct at86rf230_state_change *ctx = &lp->tx;
 
 	void (*tx_complete)(void *context) = at86rf230_write_frame;
-	int rc;
 
 	lp->tx_skb = skb;
 
@@ -988,26 +1001,6 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	at86rf230_async_state_change(lp, ctx, STATE_TX_ON, tx_complete, false);
 
-	rc = wait_for_completion_interruptible_timeout(&lp->tx_complete,
-						       msecs_to_jiffies(lp->data->t_tx_timeout));
-	if (!rc) {
-		at86rf230_async_error(lp, ctx, -ETIMEDOUT);
-		return -ETIMEDOUT;
-	}
-
-	if (lp->max_frame_retries > 0)
-		return 0;
-
-	/* Interfame spacing time, which is phy depend.
-	 * TODO
-	 * Move this handling in MAC 802.15.4 layer.
-	 * This is currently a workaround to avoid fragmenation issues.
-	 */
-	if (skb->len > 18)
-		usleep_range(lp->data->t_lifs, lp->data->t_lifs + 10);
-	else
-		usleep_range(lp->data->t_sifs, lp->data->t_sifs + 10);
-
 	return 0;
 }
 
@@ -1237,7 +1230,7 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 
 static struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
-	.xmit_sync = at86rf230_xmit,
+	.xmit_async = at86rf230_xmit,
 	.ed = at86rf230_ed,
 	.set_channel = at86rf230_channel,
 	.start = at86rf230_start,
@@ -1541,7 +1534,6 @@ static int at86rf230_probe(struct spi_device *spi)
 		goto free_dev;
 
 	spin_lock_init(&lp->lock);
-	init_completion(&lp->tx_complete);
 	init_completion(&lp->state_complete);
 
 	spi_set_drvdata(spi, lp);
-- 
2.1.2

