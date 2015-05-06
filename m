Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:32986 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbEFLlT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:19 -0400
Received: by wgin8 with SMTP id n8so8440391wgi.0
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 12/16] at86rf230: add reset states of tx power level
Date: Wed,  6 May 2015 13:40:24 +0200
Message-Id: <1430912428-17284-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds the reset states for tx power levels after running reset
procedure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index e2be571..14e743c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1587,6 +1587,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 11;
 		lp->hw->phy->symbol_duration = 16;
+		lp->hw->phy->transmit_power = 300;
 		break;
 	case 7:
 		chip = "at86rf212";
@@ -1597,6 +1598,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
 		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
+		lp->hw->phy->transmit_power = 500;
 		break;
 	case 11:
 		chip = "at86rf233";
@@ -1604,6 +1606,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 13;
 		lp->hw->phy->symbol_duration = 16;
+		lp->hw->phy->transmit_power = 400;
 		break;
 	default:
 		chip = "unknown";
-- 
2.3.7

