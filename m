Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32847 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030311AbbDWQsm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:42 -0400
Received: by wiax7 with SMTP id x7so16835886wia.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 11/15] at86rf230: set cca_modes supported flags
Date: Thu, 23 Apr 2015 18:47:50 +0200
Message-Id: <1429807674-24849-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch sets the at86rf230 supported cca modes. In case of at86rf212
it also can support listen before transmit.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 46fcdaa..2c0aa29 100644
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
+		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
 		break;
 	case 11:
 		chip = "at86rf233";
-- 
2.3.6

