Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33533 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbEJUtO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 10 May 2015 16:49:14 -0400
Received: by wgin8 with SMTP id n8so112023295wgi.0
        for <linux-wpan@vger.kernel.org>; Sun, 10 May 2015 13:49:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: fix callback for aret handling
Date: Sun, 10 May 2015 22:48:55 +0200
Message-Id: <1431290935-5400-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the complete callback for going into aret on. Currently
we starting after a state change into aret on again a state change into
aret on which is not necessary.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 67d00fb..63f7e6e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1010,7 +1010,7 @@ at86rf230_xmit_start(void *context)
 		if (lp->is_tx_from_off) {
 			lp->is_tx_from_off = false;
 			at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
-						     at86rf230_xmit_tx_on,
+						     at86rf230_write_frame,
 						     false);
 		} else {
 			at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-- 
2.3.7

