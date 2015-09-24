Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35041 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580AbbIXRkm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Sep 2015 13:40:42 -0400
Received: by wicge5 with SMTP id ge5so262418271wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 24 Sep 2015 10:40:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mrf24j40: remove trailing semicolon
Date: Thu, 24 Sep 2015 19:40:33 +0200
Message-Id: <1443116433-27396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes a trailing semicolon which was introduced by commit
d3f1bc3 ("mrf24j40: add cca mode support") and reported by kbuild test
robot.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 2770df1..aca0fb3 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -1239,7 +1239,7 @@ static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 	devrec->hw->phy->supported.min_maxbe = 5;
 	devrec->hw->phy->supported.max_maxbe = 5;
 
-	devrec->hw->phy->cca.mode = NL802154_CCA_CARRIER;;
+	devrec->hw->phy->cca.mode = NL802154_CCA_CARRIER;
 	devrec->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
 					       BIT(NL802154_CCA_CARRIER) |
 					       BIT(NL802154_CCA_ENERGY_CARRIER);
-- 
2.5.2

