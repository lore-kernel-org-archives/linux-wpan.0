Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D0C433FE
	for <linux-wpan@archiver.kernel.org>; Fri, 18 Mar 2022 18:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiCRS60 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 18 Mar 2022 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbiCRS6W (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Mar 2022 14:58:22 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9E2234574;
        Fri, 18 Mar 2022 11:56:59 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B9A7C0007;
        Fri, 18 Mar 2022 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647629817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELjyb7lKL1uYu4MFcTREKc/GLttvlsuO2ZSUwZP1ZF0=;
        b=gQSQ93m8k1xGNHa186GCRpuMsCeXRaOe/LhOmcEnturwLKHj9MJCgikSOmOQrdsFcJBHEd
        AJZb8Ru6EILu0GgtEQe+S5Yez/Bjgay98SNxOINAYib8bp1nZongO7PJ5zW4HKHVuv8cpp
        NrFcf/4MEfNtCFHcGceFLw0o0RMQ1MKh7JE2L0czgBbB8OJzyewQ7QQmkZqXyAEUg5xLBz
        d3xzuBODWV/YZoylRwU9noph59cOxD9NdUAxXTbjZmCzFDi01HH5biKbVjF+nr0NHq7e2i
        +IDukXUh7gR5X2ZK/cUmQ2iAtA5jEWpbnqpDXqrYKF6GjxnlCTKwSVP9bkrtNg==
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
Subject: [PATCH wpan-next v4 07/11] net: ieee802154: at86rf230: Provide meaningful error codes when possible
Date:   Fri, 18 Mar 2022 19:56:40 +0100
Message-Id: <20220318185644.517164-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220318185644.517164-1-miquel.raynal@bootlin.com>
References: <20220318185644.517164-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Either the spi operation failed, or the offloaded transmit operation
failed and returned a TRAC value. Use this value when available or use
the default "SYSTEM_ERROR" otherwise, in order to propagate one step
above the error.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/ieee802154/at86rf230.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index d3cf6d23b57e..34d199f597c9 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -358,7 +358,23 @@ static inline void
 at86rf230_async_error(struct at86rf230_local *lp,
 		      struct at86rf230_state_change *ctx, int rc)
 {
-	dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
+	int reason;
+
+	switch (rc) {
+	case TRAC_CHANNEL_ACCESS_FAILURE:
+		reason = IEEE802154_CHANNEL_ACCESS_FAILURE;
+		break;
+	case TRAC_NO_ACK:
+		reason = IEEE802154_NO_ACK;
+		break;
+	default:
+		reason = IEEE802154_SYSTEM_ERROR;
+	}
+
+	if (rc < 0)
+		dev_err(&lp->spi->dev, "spi_async error %d\n", rc);
+	else
+		dev_err(&lp->spi->dev, "xceiver error %d\n", reason);
 
 	at86rf230_async_state_change(lp, ctx, STATE_FORCE_TRX_OFF,
 				     at86rf230_async_error_recover);
@@ -666,10 +682,15 @@ at86rf230_tx_trac_check(void *context)
 	case TRAC_SUCCESS:
 	case TRAC_SUCCESS_DATA_PENDING:
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ON, at86rf230_tx_on);
+		return;
+	case TRAC_CHANNEL_ACCESS_FAILURE:
+	case TRAC_NO_ACK:
 		break;
 	default:
-		at86rf230_async_error(lp, ctx, -EIO);
+		trac = TRAC_INVALID;
 	}
+
+	at86rf230_async_error(lp, ctx, trac);
 }
 
 static void
-- 
2.27.0

