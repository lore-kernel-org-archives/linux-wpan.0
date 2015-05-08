Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35755 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbbEHSZJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 14:25:09 -0400
Received: by widdi4 with SMTP id di4so39441187wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 11:25:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 15/17] at86rf230: add cca ed level reset value
Date: Fri,  8 May 2015 20:24:26 +0200
Message-Id: <1431109468-4891-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
References: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

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

