Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2on0135.outbound.protection.outlook.com ([207.46.100.135]:52332
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889AbaLLAqM (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Dec 2014 19:46:12 -0500
From: Andrey Yurovsky <andrey@snupi.com>
Subject: [PATCH] at86rf230: remove version check for AT86RF212
Date: Thu, 11 Dec 2014 15:11:20 -0800
Message-ID: <1418339480-26681-1-git-send-email-andrey@snupi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Andrey Yurovsky <yurovsky@gmail.com>, alex.aring@gmail.com

From: Andrey Yurovsky <yurovsky@gmail.com>

This version check allows the driver to only work with v1 hardware
however there is no driver-facing difference with newer versions
(confirmed by Atmel FAEs) so this check needlessly prevents the driver
from being used with radios now in production.

Signed-off-by: Andrey Yurovsky <yurovsky@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1c01356..007470f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1429,16 +1429,12 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		break;
 	case 7:
 		chip = "at86rf212";
-		if (version == 1) {
-			lp->data = &at86rf212_data;
-			lp->hw->flags |= IEEE802154_HW_LBT;
-			lp->hw->phy->channels_supported[0] = 0x00007FF;
-			lp->hw->phy->channels_supported[2] = 0x00007FF;
-			lp->hw->phy->current_channel = 5;
-			lp->hw->phy->symbol_duration = 25;
-		} else {
-			rc = -ENOTSUPP;
-		}
+		lp->data = &at86rf212_data;
+		lp->hw->flags |= IEEE802154_HW_LBT;
+		lp->hw->phy->channels_supported[0] = 0x00007FF;
+		lp->hw->phy->channels_supported[2] = 0x00007FF;
+		lp->hw->phy->current_channel = 5;
+		lp->hw->phy->symbol_duration = 25;
 		break;
 	case 11:
 		chip = "at86rf233";
-- 
2.1.0

