Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35118 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbbG3KNR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 06:13:17 -0400
Received: by wibxm9 with SMTP id xm9so237593914wib.0
        for <linux-wpan@vger.kernel.org>; Thu, 30 Jul 2015 03:13:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: remove hrtimer on 1 usec delay
Date: Thu, 30 Jul 2015 12:13:29 +0200
Message-Id: <1438251209-13292-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

According Documentation/timers/timers-howto.txt the usually case for
setting up a hrtimer takes > ~10us. So we should use udelay in this
case so we are sure that the state change was done, before doing the
state change assert.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f7bd9f3..d0d5bf6 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -545,7 +545,9 @@ at86rf230_async_state_delay(void *context)
 	}
 
 	/* Default delay is 1us in the most cases */
-	tim = ktime_set(0, NSEC_PER_USEC);
+	udelay(1);
+	at86rf230_async_state_timer(&ctx->timer);
+	return;
 
 change:
 	hrtimer_start(&ctx->timer, tim, HRTIMER_MODE_REL);
-- 
2.5.0

