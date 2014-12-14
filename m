Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:39093 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbaLNXUt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Dec 2014 18:20:49 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so8967909wib.3
        for <linux-wpan@vger.kernel.org>; Sun, 14 Dec 2014 15:20:48 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/5] at86rf230: fix context pointer handling
Date: Mon, 15 Dec 2014 00:20:30 +0100
Message-Id: <1418599232-6267-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the context pointer to the parameter given one inside
function at86rf230_async_state_change_start. This could occur problem if
context isn't pointed to lp->state.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 430d3bd..08b2f9f 100644
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

