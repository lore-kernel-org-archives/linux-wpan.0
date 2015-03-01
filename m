Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:40011 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbCAUz5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Mar 2015 15:55:57 -0500
Received: by wghl18 with SMTP id l18so29822222wgh.7
        for <linux-wpan@vger.kernel.org>; Sun, 01 Mar 2015 12:55:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/6] at86rf230: refactor receive handling
Date: Sun,  1 Mar 2015 21:55:30 +0100
Message-Id: <1425243333-8344-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
References: <1425243333-8344-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch refactor the receive handling into one function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 8501220..8e93ea4 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -781,13 +781,23 @@ at86rf230_tx_trac_status(void *context)
 }
 
 static void
-at86rf230_rx(struct at86rf230_local *lp,
-	     const u8 *data, const u8 len, const u8 lqi)
+at86rf230_rx_read_frame_complete(void *context)
 {
-	struct sk_buff *skb;
+	struct at86rf230_state_change *ctx = context;
+	struct at86rf230_local *lp = ctx->lp;
 	u8 rx_local_buf[AT86RF2XX_MAX_BUF];
+	const u8 *buf = lp->irq.buf;
+	struct sk_buff *skb;
+	u8 len, lqi;
 
-	memcpy(rx_local_buf, data, len);
+	len = buf[1];
+	if (!ieee802154_is_valid_psdu_len(len)) {
+		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
+		len = IEEE802154_MTU;
+	}
+	lqi = buf[2 + len];
+
+	memcpy(rx_local_buf, buf + 2, len);
 	enable_irq(lp->spi->irq);
 
 	skb = dev_alloc_skb(IEEE802154_MTU);
@@ -801,22 +811,6 @@ at86rf230_rx(struct at86rf230_local *lp,
 }
 
 static void
-at86rf230_rx_read_frame_complete(void *context)
-{
-	struct at86rf230_state_change *ctx = context;
-	struct at86rf230_local *lp = ctx->lp;
-	const u8 *buf = lp->irq.buf;
-	u8 len = buf[1];
-
-	if (!ieee802154_is_valid_psdu_len(len)) {
-		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
-		len = IEEE802154_MTU;
-	}
-
-	at86rf230_rx(lp, buf + 2, len, buf[2 + len]);
-}
-
-static void
 at86rf230_rx_read_frame(struct at86rf230_local *lp)
 {
 	int rc;
-- 
2.3.0

