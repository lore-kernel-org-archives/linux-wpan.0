Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35073 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbbCZLqx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 07:46:53 -0400
Received: by wgdm6 with SMTP id m6so61234504wgd.2
        for <linux-wpan@vger.kernel.org>; Thu, 26 Mar 2015 04:46:52 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] at86rf230: fix is_tx while error handling
Date: Thu, 26 Mar 2015 12:46:30 +0100
Message-Id: <1427370390-31302-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
References: <1427370390-31302-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the error handling when is_tx is true. The error handling
tries to get the transceiver into RX_AACK_ON mode then we need to be
sure that is_tx is false.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1278dd5..5ad46f7 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -457,6 +457,7 @@ at86rf230_async_error_recover(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
+	lp->is_tx = 0;
 	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON, NULL, false);
 	ieee802154_wake_queue(lp->hw);
 }
-- 
2.3.4

