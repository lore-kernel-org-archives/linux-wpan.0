Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36349 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbaHOKaL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:11 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so638666wiw.12
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:51 +0200
Message-Id: <1408098592-13412-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 11/12] at86rf230: use ieee802154_is_valid_frame_len
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch use the ieee802154_is_valid_frame_len function to validate
the frame length. If the frame length is invalid we use the maximum
payload to receive also corrupted frames in monitor mode.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b245e57..d4f31d9 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -782,26 +782,11 @@ at86rf230_tx_trac_status(void *context)
 
 static void
 at86rf230_rx(struct at86rf230_local *lp,
-	     const u8 *data, u8 len)
+	     const u8 *data, const u8 len)
 {
-	u8 lqi;
 	struct sk_buff *skb;
 	u8 rx_local_buf[AT86RF2XX_MAX_BUF];
 
-	if (len < 2)
-		return;
-
-	/* read full frame buffer and invalid lqi value to lowest
-	 * indicator if frame was is in a corrupted state.
-	 */
-	if (len > IEEE802154_MTU) {
-		lqi = 0;
-		len = IEEE802154_MTU;
-		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
-	} else {
-		lqi = data[len];
-	}
-
 	memcpy(rx_local_buf, data, len);
 	enable_irq(lp->spi->irq);
 
@@ -816,7 +801,7 @@ at86rf230_rx(struct at86rf230_local *lp,
 	/* We do not put CRC into the frame */
 	skb_trim(skb, len - 2);
 
-	ieee802154_rx_irqsafe(lp->hw, skb, lqi);
+	ieee802154_rx_irqsafe(lp->hw, skb, rx_local_buf[len]);
 }
 
 static void
@@ -825,7 +810,12 @@ at86rf230_rx_read_frame_complete(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	const u8 *buf = lp->irq.buf;
-	const u8 len = buf[1];
+	u8 len = buf[1];
+
+	if (!ieee802154_is_valid_frame_len(len)) {
+		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
+		len = IEEE802154_MTU;
+	}
 
 	at86rf230_rx(lp, buf + 2, len);
 }
-- 
2.0.3

