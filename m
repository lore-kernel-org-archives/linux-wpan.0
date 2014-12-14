Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59009 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbaLNXUw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Dec 2014 18:20:52 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so13333316wgh.2
        for <linux-wpan@vger.kernel.org>; Sun, 14 Dec 2014 15:20:51 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/5] at86rf230: remove unnecessary assign
Date: Mon, 15 Dec 2014 00:20:32 +0100
Message-Id: <1418599232-6267-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The attribute extra_tx_headroom should already be zero.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7b0a17e..89589d8 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1405,7 +1405,6 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		return -EINVAL;
 	}
 
-	lp->hw->extra_tx_headroom = 0;
 	lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
 			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
 			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
-- 
2.1.3

