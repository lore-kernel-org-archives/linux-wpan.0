Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:39562 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbaHOKaL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:11 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so2140547wes.23
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:52 +0200
Message-Id: <1408098592-13412-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 12/12] at86rf230: improve receive handling
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Current behaviour is copy frame inklusive CRC into skb, then remove the
CRC from the skb. This patch provide that we doesn't copy the CRC into
the skb. It's a slighty improving of this handling.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index d4f31d9..016a920 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -782,7 +782,7 @@ at86rf230_tx_trac_status(void *context)
 
 static void
 at86rf230_rx(struct at86rf230_local *lp,
-	     const u8 *data, const u8 len)
+	     const u8 *data, const u8 len, const u8 lqi)
 {
 	struct sk_buff *skb;
 	u8 rx_local_buf[AT86RF2XX_MAX_BUF];
@@ -797,11 +797,7 @@ at86rf230_rx(struct at86rf230_local *lp,
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
@@ -817,7 +813,7 @@ at86rf230_rx_read_frame_complete(void *context)
 		len = IEEE802154_MTU;
 	}
 
-	at86rf230_rx(lp, buf + 2, len);
+	at86rf230_rx(lp, buf + 2, len - 2, buf[2 + len]);
 }
 
 static int
-- 
2.0.3

