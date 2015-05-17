Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36474 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbbEQTpu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:50 -0400
Received: by wgbhc8 with SMTP id hc8so132754511wgb.3
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:49 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/34] at86rf230: add cca ed level reset value
Date: Sun, 17 May 2015 21:44:51 +0200
Message-Id: <1431891910-32231-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch adds reset values for cca ed level values after running reset
procedure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 833c426..3aa7bc9 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1661,7 +1661,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	case 2:
 		chip = "at86rf230";
 		rc = -ENOTSUPP;
-		break;
+		goto not_supp;
 	case 3:
 		chip = "at86rf231";
 		lp->data = &at86rf231_data;
@@ -1697,9 +1697,12 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	default:
 		chip = "unknown";
 		rc = -ENOTSUPP;
-		break;
+		goto not_supp;
 	}
 
+	lp->hw->phy->cca_ed_level = lp->hw->phy->supported.cca_ed_levels[7];
+
+not_supp:
 	dev_info(&lp->spi->dev, "Detected %s chip version %d\n", chip, version);
 
 	return rc;
-- 
2.3.7

