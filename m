Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37740 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbbEHSZL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 14:25:11 -0400
Received: by widdi4 with SMTP id di4so36479876wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 11:25:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 16/17] at86rf230: add reset states of tx power level
Date: Fri,  8 May 2015 20:24:27 +0200
Message-Id: <1431109468-4891-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
References: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds the reset states for tx power levels after running reset
procedure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 3aa7bc9..5601c74 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1701,6 +1701,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	}
 
 	lp->hw->phy->cca_ed_level = lp->hw->phy->supported.cca_ed_levels[7];
+	lp->hw->phy->transmit_power = lp->hw->phy->supported.tx_powers[0];
 
 not_supp:
 	dev_info(&lp->spi->dev, "Detected %s chip version %d\n", chip, version);
-- 
2.3.7

