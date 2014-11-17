Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:39370 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHV0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:26 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so2523152wgg.41
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:25 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/13] at86rf230: fix commentation for symbol duration
Date: Mon, 17 Nov 2014 08:20:44 +0100
Message-Id: <1416208855-8623-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix an copy&paste issue in the comment of setting symbol
duration. These comments are more correct according the at86rf212 datasheet
now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7278e18..1c01356 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1043,10 +1043,10 @@ at86rf212_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 		}
 	} else {
 		if (page == 0)
-			/* SUB:0 and BPSK:1 -> BPSK-20 */
+			/* SUB:0 and BPSK:1 -> OQPSK-100/200/400 */
 			lp->hw->phy->symbol_duration = 40;
 		else
-			/* SUB:1 and BPSK:1 -> BPSK-20 */
+			/* SUB:1 and BPSK:1 -> OQPSK-250/500/1000 */
 			lp->hw->phy->symbol_duration = 16;
 	}
 
-- 
2.1.3

