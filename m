Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63282 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbaJGIjw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:52 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so8524722wgh.33
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:51 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 7/9] at86rf230: fix race condition
Date: Tue,  7 Oct 2014 10:38:31 +0200
Message-Id: <1412671113-26675-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

When the driver waits for a tx completion currently the driver direct
enables the irq. When we switching to RX_AACK_ON some steps afterwards
the driver could receive a new frame and request resources which are
already in use, for example irq state change resource.

To be sure there are no new interrupts when we switching to RX_AACK_ON,
we enable the irq when state change to RX_AACK_ON was completed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 8754f15..5dbec64 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -705,6 +705,7 @@ at86rf230_tx_complete(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
+	enable_irq(lp->spi->irq);
 	complete(&lp->tx_complete);
 }
 
@@ -860,7 +861,6 @@ at86rf230_irq_trx_end(struct at86rf230_local *lp)
 	if (lp->is_tx) {
 		lp->is_tx = 0;
 		spin_unlock(&lp->lock);
-		enable_irq(lp->spi->irq);
 
 		if (lp->tx_aret)
 			return at86rf230_async_state_change(lp, &lp->irq,
-- 
2.1.2

