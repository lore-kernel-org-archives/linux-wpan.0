Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:46069 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGIjz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:55 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so8669011wgg.30
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:54 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 9/9] at86rf230: remove unnecessary print of async error
Date: Tue,  7 Oct 2014 10:38:33 +0200
Message-Id: <1412671113-26675-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The async error function will already printout the errno over dev_err.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7a1a8e3..6ebd665 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -664,7 +664,6 @@ at86rf230_async_state_change_start(void *context)
 			enable_irq(lp->spi->irq);
 
 		at86rf230_async_error(lp, &lp->state, rc);
-		dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
 	}
 }
 
-- 
2.1.2

