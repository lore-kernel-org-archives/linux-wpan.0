Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34785 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756632AbcBSI7Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 19 Feb 2016 03:59:16 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 3/5] at86rf230: fix race on error handling
Date: Fri, 19 Feb 2016 09:59:12 +0100
Message-Id: <1455872354-26032-3-git-send-email-aar@pengutronix.de>
In-Reply-To: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
References: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

The resource "ctx" can be still used by at86rf230_async_state_change, we
need to free it at the complete handler of the async state change to
avoid a use after free.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 drivers/net/ieee802154/at86rf230.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 0fbbba7..bf3cfe4 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -343,16 +343,26 @@ static const struct regmap_config at86rf230_regmap_spi_config = {
 };
 
 static void
-at86rf230_async_error_recover(void *context)
+at86rf230_async_error_recover_complete(void *context)
 {
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	lp->is_tx = 0;
-	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL);
-	ieee802154_wake_queue(lp->hw);
 	if (ctx->free)
 		kfree(ctx);
+
+	ieee802154_wake_queue(lp->hw);
+}
+
+static void
+at86rf230_async_error_recover(void *context)
+{
+	struct at86rf230_state_change *ctx = context;
+	struct at86rf230_local *lp = ctx->lp;
+
+	lp->is_tx = 0;
+	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON,
+				     at86rf230_async_error_recover_complete);
 }
 
 static inline void
-- 
2.7.1

