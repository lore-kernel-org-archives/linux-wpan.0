Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:35839 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbaHOKaJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:09 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so2152361wes.6
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:49 +0200
Message-Id: <1408098592-13412-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 09/12] at86rf230: asynchrous xmit handling
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch change the sync xmit handling to an async xmit handling. The
driver was mostly prepared to do this step, all other drivers needs an
async spi handling to provide that.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 8886325..b245e57 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -92,7 +92,6 @@ struct at86rf230_local {
 	bool is_tx;
 	/* spinlock for is_tx protection */
 	spinlock_t lock;
-	struct completion tx_complete;
 	struct sk_buff *tx_skb;
 	struct at86rf230_state_change tx;
 };
@@ -452,6 +451,7 @@ at86rf230_async_error_recover(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 
 	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL);
+	ieee802154_wake_queue(lp->hw);
 }
 
 static void
@@ -701,8 +701,19 @@ at86rf230_tx_complete(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
+	struct sk_buff *skb = lp->tx_skb;
+
+	/* Interfame spacing time, which is phy depend.
+	 * TODO
+	 * Move this handling in MAC 802.15.4 layer.
+	 * This is currently a workaround to avoid fragmenation issues.
+	 */
+	if (skb->len > 18)
+		usleep_range(lp->data->t_lifs, lp->data->t_lifs + 10);
+	else
+		usleep_range(lp->data->t_sifs, lp->data->t_sifs + 10);
 
-	complete(&lp->tx_complete);
+	ieee802154_xmit_complete(lp->hw, skb);
 }
 
 static void
@@ -992,22 +1003,6 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 		at86rf230_async_error(lp, ctx, rc);
 		return rc;
 	}
-	rc = wait_for_completion_interruptible_timeout(&lp->tx_complete,
-						       msecs_to_jiffies(lp->data->t_tx_timeout));
-	if (!rc) {
-		at86rf230_async_error(lp, ctx, rc);
-		return -ETIMEDOUT;
-	}
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
 
 	return 0;
 }
@@ -1237,7 +1232,7 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 
 static const struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
-	.xmit_sync = at86rf230_xmit,
+	.xmit = at86rf230_xmit,
 	.ed = at86rf230_ed,
 	.set_channel = at86rf230_channel,
 	.start = at86rf230_start,
@@ -1541,7 +1536,6 @@ static int at86rf230_probe(struct spi_device *spi)
 		goto free_dev;
 
 	spin_lock_init(&lp->lock);
-	init_completion(&lp->tx_complete);
 	init_completion(&lp->state_complete);
 
 	spi_set_drvdata(spi, lp);
-- 
2.0.3

