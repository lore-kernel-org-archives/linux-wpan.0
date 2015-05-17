Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34645 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbEQTpy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:54 -0400
Received: by wicmc15 with SMTP id mc15so74553733wic.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:53 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 19/34] at86rf230: fix callback for aret handling
Date: Sun, 17 May 2015 21:44:55 +0200
Message-Id: <1431891910-32231-20-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch fix the complete callback for going into aret on. Currently
we starting after a state change into aret on again a state change into
aret on which is not necessary.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 5601c74..8d5ed6e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1013,7 +1013,7 @@ at86rf230_xmit_start(void *context)
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

