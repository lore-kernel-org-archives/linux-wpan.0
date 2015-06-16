Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33642 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058AbbFPJH7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 05:07:59 -0400
Received: by wiwd19 with SMTP id d19so97421656wiw.0
        for <linux-wpan@vger.kernel.org>; Tue, 16 Jun 2015 02:07:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 3/3] at86rf230: cleanup start and stop callbacks
Date: Tue, 16 Jun 2015 11:07:44 +0200
Message-Id: <1434445664-438-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
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
index 7e30a45..f7bd9f3 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -938,7 +938,7 @@ at86rf230_start(struct ieee802154_hw *hw)
 	at86rf230_awake(lp);
 	enable_irq(lp->spi->irq);
 
-	return at86rf230_sync_state_change(hw->priv, STATE_RX_AACK_ON);
+	return at86rf230_sync_state_change(lp, STATE_RX_AACK_ON);
 }
 
 static void
@@ -947,7 +947,7 @@ at86rf230_stop(struct ieee802154_hw *hw)
 	struct at86rf230_local *lp = hw->priv;
 	u8 csma_seed[2];
 
-	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
+	at86rf230_sync_state_change(lp, STATE_FORCE_TRX_OFF);
 
 	disable_irq(lp->spi->irq);
 
-- 
2.4.1

