Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7DC433FE
	for <linux-wpan@archiver.kernel.org>; Thu,  3 Mar 2022 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiCCS0T (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiCCS0N (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Mar 2022 13:26:13 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB981A41E8;
        Thu,  3 Mar 2022 10:25:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EEB7020007;
        Thu,  3 Mar 2022 18:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646331926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uhKeSJ5TdvqQx9rBcypmjG7Wuhjj3YD9ai0d1ExtG4=;
        b=mO3TVnTqxWTtGVsoBlWkZLBmRY3e0T8rjRSNAT7fdbjNgGGP/7Z2CxBNMJcPG67NkVtXSr
        ESmP9IATnJ4brMd6HA+Lmn2L7HdeNUFJ16UveDpglJPN4wRA4MhXHL/8W0id0Wyz/r/4Ay
        fZCo/Ada6ym8RI0N70PmwwpYF2UREAnGJqHzCPH62jc2n8S+bODqR6MN21O/bXk76eGt/1
        TkDAvf+UPtzQlhGNXuMmgq8uA+cxW8z6PBkGvH8GFaRZNuvP1ve245ZChTr2n9b0O0Rov7
        MDOSzQV402M4qLIIorpLDVYajSRom0Jzz9bLvhSRRiJ3Hycrj3PHZMevWYrOEg==
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
Subject: [PATCH wpan-next v3 11/11] net: ieee802154: ca8210: Call _xmit_error() when a transmission fails
Date:   Thu,  3 Mar 2022 19:25:08 +0100
Message-Id: <20220303182508.288136-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303182508.288136-1-miquel.raynal@bootlin.com>
References: <20220303182508.288136-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

ieee802154_xmit_error() is the right helper to call when a transmission
has failed. Let's use it instead of open-coding it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/ieee802154/ca8210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 116aece191cd..b1eb74200f23 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1729,11 +1729,11 @@ static int ca8210_async_xmit_complete(
 			status
 		);
 		if (status != IEEE802154_TRANSACTION_OVERFLOW) {
-			dev_kfree_skb_any(priv->tx_skb);
-			ieee802154_wake_queue(priv->hw);
+			ieee802154_xmit_error(priv->hw, priv->tx_skb, status);
 			return 0;
 		}
 	}
+
 	ieee802154_xmit_complete(priv->hw, priv->tx_skb, true);
 
 	return 0;
-- 
2.27.0

