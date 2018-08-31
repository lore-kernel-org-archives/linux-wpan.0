Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIAB4M (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 31 Aug 2018 21:56:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so12410126wre.10
        for <linux-wpan@vger.kernel.org>; Fri, 31 Aug 2018 14:46:47 -0700 (PDT)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCH 1/2] ieee802154: mcr20a: Replace magic number with constants
Date: Fri, 31 Aug 2018 23:46:41 +0200
Message-Id: <20180831214642.30711-2-liuxuenetmail@gmail.com>
In-Reply-To: <20180831214642.30711-1-liuxuenetmail@gmail.com>
References: <20180831214642.30711-1-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, stefan@datenfreihafen.org, alex.aring@gmail.com

The combination of defined constants are used to present the
state of IRQ so the magic numbers has been replaced.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
---
 drivers/net/ieee802154/mcr20a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index e428277781ac..04891429a554 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -903,19 +903,19 @@ mcr20a_irq_clean_complete(void *context)
 
 	switch (seq_state) {
 	/* TX IRQ, RX IRQ and SEQ IRQ */
-	case (0x03):
+	case (DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
 		if (lp->is_tx) {
 			lp->is_tx = 0;
 			dev_dbg(printdev(lp), "TX is done. No ACK\n");
 			mcr20a_handle_tx_complete(lp);
 		}
 		break;
-	case (0x05):
+	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_SEQIRQ):
 			/* rx is starting */
 			dev_dbg(printdev(lp), "RX is starting\n");
 			mcr20a_handle_rx(lp);
 		break;
-	case (0x07):
+	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
 		if (lp->is_tx) {
 			/* tx is done */
 			lp->is_tx = 0;
@@ -927,7 +927,7 @@ mcr20a_irq_clean_complete(void *context)
 			mcr20a_handle_rx(lp);
 		}
 		break;
-	case (0x01):
+	case (DAR_IRQSTS1_SEQIRQ):
 		if (lp->is_tx) {
 			dev_dbg(printdev(lp), "TX is starting\n");
 			mcr20a_handle_tx(lp);
-- 
2.17.0
