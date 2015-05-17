Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37682 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbEQTpv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:51 -0400
Received: by wibt6 with SMTP id t6so47657409wib.0
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:50 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/34] at86rf230: add reset states of tx power level
Date: Sun, 17 May 2015 21:44:52 +0200
Message-Id: <1431891910-32231-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

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

