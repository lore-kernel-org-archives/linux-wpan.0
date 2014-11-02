Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:51103 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaKBDTO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:14 -0400
Received: by mail-wg0-f53.google.com with SMTP id b13so8852666wgh.40
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/16] at86rf230: add default channel settings
Date: Sun,  2 Nov 2014 04:18:34 +0100
Message-Id: <1414898327-20759-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch sets the reset state channels accoridng at86rf2xx datasheets.
We don't need to set the default page here which is zero on all chips.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 624080d..f68ebba 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1427,6 +1427,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		chip = "at86rf231";
 		lp->data = &at86rf231_data;
 		lp->hw->phy->channels_supported[0] = 0x7FFF800;
+		lp->hw->phy->current_channel = 11;
 		break;
 	case 7:
 		chip = "at86rf212";
@@ -1435,6 +1436,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 			lp->hw->flags |= IEEE802154_HW_LBT;
 			lp->hw->phy->channels_supported[0] = 0x00007FF;
 			lp->hw->phy->channels_supported[2] = 0x00007FF;
+			lp->hw->phy->current_channel = 5;
 		} else {
 			rc = -ENOTSUPP;
 		}
@@ -1443,6 +1445,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		chip = "at86rf233";
 		lp->data = &at86rf233_data;
 		lp->hw->phy->channels_supported[0] = 0x7FFF800;
+		lp->hw->phy->current_channel = 13;
 		break;
 	default:
 		chip = "unkown";
-- 
2.1.3

