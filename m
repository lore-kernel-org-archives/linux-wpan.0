Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C7ACCA479
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiGAOgP (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiGAOfk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:35:40 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5C40E7E;
        Fri,  1 Jul 2022 07:31:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9CEF0FF817;
        Fri,  1 Jul 2022 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656685872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQXfgfI6hQAhjh7BemcJpl4err/IaRYZyRpPEnfIqks=;
        b=GtZJcs7bF7u69da2CnYLMOGCFPkDv2dAwSwT2ynTQNVEXFron6vScI7NfGEZ5wp/rVuk80
        OfmMoCyxHT51tLxgY2vBq6MVOwAqRzkfFysbEPIVxVIMGLvZoKdUymiGO6dIokWCLhITS1
        rqpRVKRiEdL+jl037v5faIOVvJhjjHpmPp7gZUzeXPaCqJcq4QvEHcAh0F4CmHK/K4uRf+
        7NYi91oMaxWhsVk4YccN96JU8GwFri3OcVa7LhIhlUtY9ixyDeSCZaqPpLmgmvRopS0hNr
        NafgEg0Lj7hNdaDkESHzW6vuxXo5PtZSmmOR+vnkzxP/9eVjsV1iH8/JIXVo6Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next 08/20] net: mac802154: Prepare forcing specific symbol duration
Date:   Fri,  1 Jul 2022 16:30:40 +0200
Message-Id: <20220701143052.1267509-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The scan logic will bypass the whole ->set_channel() logic from the top
by calling the driver hook to just switch between channels when
required.

We can no longer rely on the "current" page/channel settings to set the
right symbol duration. Let's add these as new parameters to allow
providing the page/channel couple that we want.

There is no functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h |  3 ++-
 net/mac802154/cfg.c     |  2 +-
 net/mac802154/main.c    | 20 +++++++++++---------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index d3354899b67c..f05ce3c45b5d 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -473,7 +473,8 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
 	return dev_name(&phy->dev);
 }
 
-void ieee802154_configure_durations(struct wpan_phy *phy);
+void ieee802154_configure_durations(struct wpan_phy *phy,
+				    unsigned int page, unsigned int channel);
 
 struct ieee802154_coord_desc *
 cfg802154_alloc_coordinator(struct ieee802154_addr *coord);
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 93df24f75572..4116a894c86e 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -118,7 +118,7 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 	if (!ret) {
 		wpan_phy->current_page = page;
 		wpan_phy->current_channel = channel;
-		ieee802154_configure_durations(wpan_phy);
+		ieee802154_configure_durations(wpan_phy, page, channel);
 	}
 
 	return ret;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 40fab08df24b..a2da9d4c5273 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -113,32 +113,33 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 }
 EXPORT_SYMBOL(ieee802154_alloc_hw);
 
-void ieee802154_configure_durations(struct wpan_phy *phy)
+void ieee802154_configure_durations(struct wpan_phy *phy,
+				    unsigned int page, unsigned int channel)
 {
 	u32 duration = 0;
 
-	switch (phy->current_page) {
+	switch (page) {
 	case 0:
-		if (BIT(phy->current_channel) & 0x1)
+		if (BIT(channel) & 0x1)
 			/* 868 MHz BPSK 802.15.4-2003: 20 ksym/s */
 			duration = 50 * NSEC_PER_USEC;
-		else if (BIT(phy->current_channel) & 0x7FE)
+		else if (BIT(channel) & 0x7FE)
 			/* 915 MHz BPSK	802.15.4-2003: 40 ksym/s */
 			duration = 25 * NSEC_PER_USEC;
-		else if (BIT(phy->current_channel) & 0x7FFF800)
+		else if (BIT(channel) & 0x7FFF800)
 			/* 2400 MHz O-QPSK 802.15.4-2006: 62.5 ksym/s */
 			duration = 16 * NSEC_PER_USEC;
 		break;
 	case 2:
-		if (BIT(phy->current_channel) & 0x1)
+		if (BIT(channel) & 0x1)
 			/* 868 MHz O-QPSK 802.15.4-2006: 25 ksym/s */
 			duration = 40 * NSEC_PER_USEC;
-		else if (BIT(phy->current_channel) & 0x7FE)
+		else if (BIT(channel) & 0x7FE)
 			/* 915 MHz O-QPSK 802.15.4-2006: 62.5 ksym/s */
 			duration = 16 * NSEC_PER_USEC;
 		break;
 	case 3:
-		if (BIT(phy->current_channel) & 0x3FFF)
+		if (BIT(channel) & 0x3FFF)
 			/* 2.4 GHz CSS 802.15.4a-2007: 1/6 Msym/s */
 			duration = 6 * NSEC_PER_USEC;
 		break;
@@ -201,7 +202,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	ieee802154_setup_wpan_phy_pib(local->phy);
 
-	ieee802154_configure_durations(local->phy);
+	ieee802154_configure_durations(local->phy, local->phy->current_page,
+				       local->phy->current_channel);
 
 	if (!(hw->flags & IEEE802154_HW_CSMA_PARAMS)) {
 		local->phy->supported.min_csma_backoffs = 4;
-- 
2.34.1

