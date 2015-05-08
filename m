Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35669 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbbEHSZE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 14:25:04 -0400
Received: by widdi4 with SMTP id di4so39438849wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 11:25:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 12/17] at86rf230: set cca_modes supported flags
Date: Fri,  8 May 2015 20:24:23 +0200
Message-Id: <1431109468-4891-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
References: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
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
index b0ffd1c..fabde3a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1574,6 +1574,11 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 			     WPAN_PHY_FLAG_CCA_ED_LEVEL |
 			     WPAN_PHY_FLAG_CCA_MODE;
 
+	lp->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
+		BIT(NL802154_CCA_CARRIER) | BIT(NL802154_CCA_ENERGY_CARRIER);
+	lp->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND) |
+		BIT(NL802154_CCA_OPT_ENERGY_CARRIER_OR);
+
 	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
 
 	switch (part) {
@@ -1596,6 +1601,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[2] = 0x00007FF;
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
+		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
 		break;
 	case 11:
 		chip = "at86rf233";
-- 
2.3.7

