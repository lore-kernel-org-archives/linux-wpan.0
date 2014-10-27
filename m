Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:58959 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbaJ0QOZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:25 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so6956168wiv.2
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 15/16] at86rf230: improve receive handling
Date: Mon, 27 Oct 2014 17:13:42 +0100
Message-Id: <1414426423-24856-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Current behaviour it to copy the frame inclusive CRC into a skb, then
remove the CRC from the skb. This patch optimizes this by not copying
the CRC at the first place.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 368791b..a155838 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -788,7 +788,7 @@ at86rf230_tx_trac_status(void *context)
 
 static void
 at86rf230_rx(struct at86rf230_local *lp,
-	     const u8 *data, const u8 len)
+	     const u8 *data, const u8 len, const u8 lqi)
 {
 	struct sk_buff *skb;
 	u8 rx_local_buf[AT86RF2XX_MAX_BUF];
@@ -803,11 +803,7 @@ at86rf230_rx(struct at86rf230_local *lp,
 	}
 
 	memcpy(skb_put(skb, len), rx_local_buf, len);
-
-	/* We do not put CRC into the frame */
-	skb_trim(skb, len - 2);
-
-	ieee802154_rx_irqsafe(lp->hw, skb, rx_local_buf[len]);
+	ieee802154_rx_irqsafe(lp->hw, skb, lqi);
 }
 
 static void
@@ -823,7 +819,7 @@ at86rf230_rx_read_frame_complete(void *context)
 		len = IEEE802154_MTU;
 	}
 
-	at86rf230_rx(lp, buf + 2, len);
+	at86rf230_rx(lp, buf + 2, len - 2, buf[2 + len]);
 }
 
 static void
-- 
2.1.2

