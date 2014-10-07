Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42618 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGIjr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:47 -0400
Received: by mail-wi0-f182.google.com with SMTP id n3so7094555wiv.9
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/9] at86rf230: add missing error handling
Date: Tue,  7 Oct 2014 10:38:26 +0200
Message-Id: <1412671113-26675-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds an async error handling function if sync state change
runs into a timeout. The async error handling function tries to recover
the phy state machine into a valid state.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6857038..44d2f1d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -690,8 +690,10 @@ at86rf230_sync_state_change(struct at86rf230_local *lp, unsigned int state)
 
 	rc = wait_for_completion_timeout(&lp->state_complete,
 					 msecs_to_jiffies(100));
-	if (!rc)
+	if (!rc) {
+		at86rf230_async_error(lp, &lp->state, -ETIMEDOUT);
 		return -ETIMEDOUT;
+	}
 
 	return 0;
 }
-- 
2.1.2

