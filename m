Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49866 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756747AbcBSI7R (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 19 Feb 2016 03:59:17 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 4/5] at86rf230: fix state change handling on error
Date: Fri, 19 Feb 2016 09:59:13 +0100
Message-Id: <1455872354-26032-4-git-send-email-aar@pengutronix.de>
In-Reply-To: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
References: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

This patch force always to set "is_tx_from_off", when calibration
timeout was not occurred. In case of error handling the is_tx_from_off
can be inside in an invalid state.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 drivers/net/ieee802154/at86rf230.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index bf3cfe4..cb9e9fe 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -902,14 +902,12 @@ at86rf230_xmit_start(void *context)
 	struct at86rf230_local *lp = ctx->lp;
 
 	/* check if we change from off state */
-	if (lp->is_tx_from_off) {
-		lp->is_tx_from_off = false;
+	if (lp->is_tx_from_off)
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
 					     at86rf230_write_frame);
-	} else {
+	else
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
 					     at86rf230_xmit_tx_on);
-	}
 }
 
 static int
@@ -933,6 +931,7 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 		at86rf230_async_state_change(lp, ctx, STATE_TRX_OFF,
 					     at86rf230_xmit_start);
 	} else {
+		lp->is_tx_from_off = false;
 		at86rf230_xmit_start(ctx);
 	}
 
-- 
2.7.1

