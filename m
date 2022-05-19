Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286FC433FE
	for <linux-wpan@archiver.kernel.org>; Thu, 19 May 2022 15:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiESPGu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 19 May 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiESPFk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 19 May 2022 11:05:40 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA93BF96;
        Thu, 19 May 2022 08:05:31 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1EBC1BF219;
        Thu, 19 May 2022 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652972730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhsSapQcLOfazHdevIFCG6NZdz32krCwn0hXNB/sLRM=;
        b=PDxyX8KK9ADQf0KbjP/kni52QJ7asm7q9M1KsdwRRYx45zMmBbw4VV/+iDZlva2IlNGDhz
        S0JiotDgcpkhGWIoB9vsLOchoh4xhD+Eb5xYsf2o14TGXAuJNaaExLonvzl5CMXd+rARb+
        9iCn6jiyzLd4DE5CDDQXePOJjU0temQJ9ykkpmnzSfqQlhjvqvWggfg9kaybM+BKfl5Ay6
        +PbsVIGgxZuqAvVFTwqYlsGUe75jbfhZ27wcxi27pUNE+pfvQ2L5PU4REdQJvdmYxXS6fc
        CGrjU4E1FV2/tFWwNqeKGYRMGKWGDuCQ8XkNbs1G5KQQbpOQVopJQOJiLo2rFg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v4 06/11] net: mac802154: Create a hot tx path
Date:   Thu, 19 May 2022 17:05:11 +0200
Message-Id: <20220519150516.443078-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519150516.443078-1-miquel.raynal@bootlin.com>
References: <20220519150516.443078-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Let's rename the current Tx path to show that this is the "hot" Tx
path. We will soon introduce a slower Tx path for MLME commands.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/tx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 6a53c83cf039..607019b8f8ab 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -106,6 +106,12 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	return NETDEV_TX_OK;
 }
 
+static netdev_tx_t
+ieee802154_hot_tx(struct ieee802154_local *local, struct sk_buff *skb)
+{
+	return ieee802154_tx(local, skb);
+}
+
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
@@ -113,7 +119,7 @@ ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb->skb_iif = dev->ifindex;
 
-	return ieee802154_tx(sdata->local, skb);
+	return ieee802154_hot_tx(sdata->local, skb);
 }
 
 netdev_tx_t
@@ -135,5 +141,5 @@ ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb->skb_iif = dev->ifindex;
 
-	return ieee802154_tx(sdata->local, skb);
+	return ieee802154_hot_tx(sdata->local, skb);
 }
-- 
2.34.1

