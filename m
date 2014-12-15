Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56664 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaLOJ01 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 04:26:27 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so9827317wib.5
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 01:26:25 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 3/5] at86rf230: fix context pointer handling
Date: Mon, 15 Dec 2014 10:25:55 +0100
Message-Id: <1418635557-6670-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
References: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the context pointer to the parameter given one inside
function at86rf230_async_state_change_start. This could occur problem if
context isn't pointed to lp->state.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 8ca4ef6..c39466e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -655,7 +655,7 @@ at86rf230_async_state_change_start(void *context)
 		if (ctx->irq_enable)
 			enable_irq(lp->spi->irq);
 
-		at86rf230_async_error(lp, &lp->state, rc);
+		at86rf230_async_error(lp, ctx, rc);
 	}
 }
 
-- 
2.1.3

