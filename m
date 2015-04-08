Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35793 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbDHLTD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 07:19:03 -0400
Received: by widdi4 with SMTP id di4so50790035wid.0
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 04:19:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 4/4] at86rf230: set cca_modes supported flags
Date: Wed,  8 Apr 2015 13:18:32 +0200
Message-Id: <1428491912-14027-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The at86rf2xx doesn't support every 802.15.4 cca mode. This patch
overwrites the default behaviour with values what the at86rf2xx
supports.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1e8c532..cfc4178 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1546,6 +1546,11 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
 			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
 
+	lp->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
+		BIT(NL802154_CCA_CARRIER) | BIT(NL802154_CCA_ENERGY_CARRIER);
+	lp->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
+		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
+
 	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
 
 	switch (part) {
@@ -1568,6 +1573,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[2] = 0x00007FF;
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
+		lp->hw->phy->supported.lbt = true;
 		break;
 	case 11:
 		chip = "at86rf233";
-- 
2.3.5

