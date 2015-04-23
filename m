Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33294 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbbDWQsn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:43 -0400
Received: by wgin8 with SMTP id n8so24789820wgi.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:42 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 12/15] at86rf230: add reset states of tx power level
Date: Thu, 23 Apr 2015 18:47:51 +0200
Message-Id: <1429807674-24849-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch adds the reset states for tx power levels after running reset
procedure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 2c0aa29..04a4e8e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1564,6 +1564,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 11;
 		lp->hw->phy->symbol_duration = 16;
+		lp->hw->phy->transmit_power = 3;
 		break;
 	case 7:
 		chip = "at86rf212";
@@ -1574,6 +1575,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
 		lp->hw->phy->supported.lbt = NL802154_SUPPORTED_BOOL_BOTH;
+		lp->hw->phy->transmit_power = 5;
 		break;
 	case 11:
 		chip = "at86rf233";
@@ -1581,6 +1583,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 13;
 		lp->hw->phy->symbol_duration = 16;
+		lp->hw->phy->transmit_power = 4;
 		break;
 	default:
 		chip = "unknown";
-- 
2.3.6

