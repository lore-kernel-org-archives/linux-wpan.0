Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB4C433EF
	for <linux-wpan@archiver.kernel.org>; Fri, 18 Mar 2022 18:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiCRS6Y (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 18 Mar 2022 14:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbiCRS6W (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Mar 2022 14:58:22 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFB238D38;
        Fri, 18 Mar 2022 11:57:00 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F39C1C0005;
        Fri, 18 Mar 2022 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647629819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLbWLpzoW3sOuaBthcHsYwAnIdgb2hpdjv4R8hxcLuM=;
        b=WZrlc/Z503MMv3au6EU0aiyZpvM7FMsMwEykZmROu395rtuHbtUOV0FPOgyRoDQw+X21GP
        dj/Bqj1D4sJMtP5zzWNg5VTfye9zdzyaLQXhWvsk6anwSDLcHpNos+FLXWuEe9gIUyzT3F
        DNs+enM1KfwQ9wF0O+WB/Ty4/1U3+0k/UvPzsfdp+KAvRgFs4JWVSRGVVtNAERozkPdc46
        Tkym5f9Y6M9R6drmHWq1Ch7bWhh9QJcsiGBrUNX4aPdF7Ny+5IqE7rRcLZYohUo+PpqLRV
        dxO2UhelmDROo9kOKQf+q9rh3pizKyiRKkrcvZpIdMyQPbBt36orw5KM7SzS5Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v4 08/11] net: ieee802154: at86rf230: Call _xmit_error() when a transmission fails
Date:   Fri, 18 Mar 2022 19:56:41 +0100
Message-Id: <20220318185644.517164-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220318185644.517164-1-miquel.raynal@bootlin.com>
References: <20220318185644.517164-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

ieee802154_xmit_error() is the right helper to call when a transmission
has failed. Let's use it instead of open-coding it.

As the error helper also requires an error code, save the error from the
previous helper in order to give this value to the core when
opportunate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/ieee802154/at86rf230.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 34d199f597c9..2e6d09b3372a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -73,6 +73,7 @@ struct at86rf230_state_change {
 	u8 to_state;
 
 	bool free;
+	int reason;
 };
 
 struct at86rf230_local {
@@ -334,8 +335,7 @@ at86rf230_async_error_recover_complete(void *context)
 
 	if (lp->was_tx) {
 		lp->was_tx = 0;
-		dev_kfree_skb_any(lp->tx_skb);
-		ieee802154_wake_queue(lp->hw);
+		ieee802154_xmit_error(lp->hw, lp->tx_skb, ctx->reason);
 	}
 }
 
@@ -358,23 +358,21 @@ static inline void
 at86rf230_async_error(struct at86rf230_local *lp,
 		      struct at86rf230_state_change *ctx, int rc)
 {
-	int reason;
-
 	switch (rc) {
 	case TRAC_CHANNEL_ACCESS_FAILURE:
-		reason = IEEE802154_CHANNEL_ACCESS_FAILURE;
+		ctx->reason = IEEE802154_CHANNEL_ACCESS_FAILURE;
 		break;
 	case TRAC_NO_ACK:
-		reason = IEEE802154_NO_ACK;
+		ctx->reason = IEEE802154_NO_ACK;
 		break;
 	default:
-		reason = IEEE802154_SYSTEM_ERROR;
+		ctx->reason = IEEE802154_SYSTEM_ERROR;
 	}
 
 	if (rc < 0)
 		dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
 	else
-		dev_err(&lp->spi->dev, "xceiver error %d\n", reason);
+		dev_err(&lp->spi->dev, "xceiver error %d\n", ctx->reason);
 
 	at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
 				     at86rf230_async_error_recover);
-- 
2.27.0

