Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41036 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbaJ0QOY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:24 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so6078995wgh.22
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 14/16] at86rf230: use ieee802154_is_valid_psdu_len helper
Date: Mon, 27 Oct 2014 17:13:41 +0100
Message-Id: <1414426423-24856-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds the ieee802154_is_valid_psdu_len function to validate
the psdu length. If the psdu length is invalid we use the maximum
payload to receive also corrupted frames in monitor mode.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index e4fbcaa..368791b 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -788,26 +788,11 @@ at86rf230_tx_trac_status(void *context)
 
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
 
@@ -822,7 +807,7 @@ at86rf230_rx(struct at86rf230_local *lp,
 	/* We do not put CRC into the frame */
 	skb_trim(skb, len - 2);
 
-	ieee802154_rx_irqsafe(lp->hw, skb, lqi);
+	ieee802154_rx_irqsafe(lp->hw, skb, rx_local_buf[len]);
 }
 
 static void
@@ -831,7 +816,12 @@ at86rf230_rx_read_frame_complete(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	const u8 *buf = lp->irq.buf;
-	const u8 len = buf[1];
+	u8 len = buf[1];
+
+	if (!ieee802154_is_valid_psdu_len(len)) {
+		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
+		len = IEEE802154_MTU;
+	}
 
 	at86rf230_rx(lp, buf + 2, len);
 }
-- 
2.1.2

