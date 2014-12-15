Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:55814 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaLOJ02 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 04:26:28 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so13893890wgh.6
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 01:26:26 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 5/5] at86rf230: remove unnecessary assign
Date: Mon, 15 Dec 2014 10:25:57 +0100
Message-Id: <1418635557-6670-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
References: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The attribute extra_tx_headroom should already be zero.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9f61748..577b24e 100644
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

