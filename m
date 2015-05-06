Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36734 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbEFLlS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:18 -0400
Received: by wgiu9 with SMTP id u9so8367818wgi.3
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 11/16] at86rf230: set cca_modes supported flags
Date: Wed,  6 May 2015 13:40:23 +0200
Message-Id: <1430912428-17284-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch sets the at86rf230 supported cca modes. In case of at86rf212
it also can support listen before transmit.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 151d57f..e2be571 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1569,6 +1569,11 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
 			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
 
+	lp->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
+		BIT(NL802154_CCA_CARRIER) | BIT(NL802154_CCA_ENERGY_CARRIER);
+	lp->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
+		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
+
 	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
 
 	switch (part) {
@@ -1591,6 +1596,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[2] = 0x00007FF;
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
+		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
 		break;
 	case 11:
 		chip = "at86rf233";
-- 
2.3.7

