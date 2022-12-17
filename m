Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFAC3DA6E
	for <linux-wpan@archiver.kernel.org>; Sat, 17 Dec 2022 00:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLQACp (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 16 Dec 2022 19:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLQACh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Dec 2022 19:02:37 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03564F641;
        Fri, 16 Dec 2022 16:02:36 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C9FF060003;
        Sat, 17 Dec 2022 00:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671235355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vu4Si9y3tNY7FjmiZ5VVV7E55PoqjPEDjDJMaQiMh9M=;
        b=cZ9/qUIuQXi+WpqZGveqNb6ko5zOFBx4yBRKSCK48RtIZn2RGZfD2mbRayEmwHfwu3Bgax
        ETDdwBrByOKyM+wex70/pMtSMuAv5SBUpsFzzfe/BrQURnPbQuMuNzaUsn/XGTAoIybryu
        KuLvjaTgQwGiyUAeKrA6PHtLLvbcEzRVitIRof/Jf9LweuindfOuE90zZd/KetRm+jRs8s
        C4eE8bVAEjP7UtMMezkVdqt0/v/drMBpog5pfiJt9jO2vjoBZ8vESNreCiVBHnm1uWyrTq
        pk/2UqENOLSmslFjgJ9BCVbARdAtCiDO0qof7QzRnl/4jOujNtetMM+21ifJyw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v2 3/6] ieee802154: Introduce a helper to validate a channel
Date:   Sat, 17 Dec 2022 01:02:23 +0100
Message-Id: <20221217000226.646767-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221217000226.646767-1-miquel.raynal@bootlin.com>
References: <20221217000226.646767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This helper for now only checks if the page member and channel member
are valid (in the specification range) and supported (by checking the
device capabilities). Soon two new parameters will be introduced and
having this helper will let us only modify its content rather than
modifying the logic everywhere else in the subsystem.

There is not functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h   | 11 +++++++++++
 net/ieee802154/nl802154.c |  3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 76d4f95e9974..11bedfa96371 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -246,6 +246,17 @@ static inline void wpan_phy_net_set(struct wpan_phy *wpan_phy, struct net *net)
 	write_pnet(&wpan_phy->_net, net);
 }
 
+static inline bool ieee802154_chan_is_valid(struct wpan_phy *phy,
+                                            u8 page, u8 channel)
+{
+        if (page > IEEE802154_MAX_PAGE ||
+            channel > IEEE802154_MAX_CHANNEL ||
+            !(phy->supported.channels[page] & BIT(channel)))
+                return false;
+
+	return true;
+}
+
 /**
  * struct ieee802154_addr - IEEE802.15.4 device address
  * @mode: Address mode from frame header. Can be one of:
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 64c6c33b28a9..1d703251f74a 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -976,8 +976,7 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
 
 	/* check 802.15.4 constraints */
-	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL ||
-	    !(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
+	if (!ieee802154_chan_is_valid(&rdev->wpan_phy, page, channel))
 		return -EINVAL;
 
 	return rdev_set_channel(rdev, page, channel);
-- 
2.34.1

