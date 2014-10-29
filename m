Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:37559 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbaJ2UgI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:08 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so2192400wgh.11
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/17] at86rf230: deliver with checksum
Date: Wed, 29 Oct 2014 21:34:43 +0100
Message-Id: <1414614884-20243-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch indicates that the at86rf230 driver deliver with checksum
instead drop the crc before delivering.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 98c9437..9ad2d43 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -819,7 +819,7 @@ at86rf230_rx_read_frame_complete(void *context)
 		len = IEEE802154_MTU;
 	}
 
-	at86rf230_rx(lp, buf + 2, len - 2, buf[2 + len]);
+	at86rf230_rx(lp, buf + 2, len, buf[2 + len]);
 }
 
 static void
@@ -1414,7 +1414,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	}
 
 	lp->hw->extra_tx_headroom = 0;
-	lp->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
+	lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
 			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
 			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
 
-- 
2.1.2

