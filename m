Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36002 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbFOTEU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Jun 2015 15:04:20 -0400
Received: by wgzl5 with SMTP id l5so51414899wgz.3
        for <linux-wpan@vger.kernel.org>; Mon, 15 Jun 2015 12:04:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] at86rf230: cleanup start and stop callbacks
Date: Mon, 15 Jun 2015 21:03:46 +0200
Message-Id: <1434395026-4638-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434395026-4638-1-git-send-email-alex.aring@gmail.com>
References: <1434395026-4638-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This code cleanups the start and stop callbacks by removing hw->priv and
using the already dereferenced variable lp which is the same.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 428238d..9d42893 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -899,7 +899,7 @@ at86rf230_start(struct ieee802154_hw *hw)
 	at86rf230_awake(lp);
 	enable_irq(lp->spi->irq);
 
-	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
+	return at86rf230_sync_state_change(lp, STATE_RX_AACK_ON);
 }
 
 static void
@@ -907,7 +907,7 @@ at86rf230_stop(struct ieee802154_hw *hw)
 {
 	struct at86rf230_local *lp = hw->priv;
 
-	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
+	at86rf230_sync_state_change(lp, STATE_FORCE_TRX_OFF);
 
 	disable_irq(lp->spi->irq);
 	at86rf230_sleep(lp);
-- 
2.4.1

