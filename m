Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.180.41]:43589 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbdJaHD7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 31 Oct 2017 03:03:59 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 5EE3932BFFA
        for <linux-wpan@vger.kernel.org>; Tue, 31 Oct 2017 01:31:33 -0500 (CDT)
Date: Tue, 31 Oct 2017 01:31:27 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ieee802154: mrf24j40: fix incorrect mask in mrf24j40_stop
Message-ID: <20171031063127.GA6032@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Ott <alan@signal11.us>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

It seems that this is a copy/paste error and the proper bit masking is:
BIT_TXNIE | BIT_RXIE

This issue was detected with the help of Coccinelle.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Fixes: 7d840545e5b9 ("mrf24j40: replace magic numbers")
---
 drivers/net/ieee802154/mrf24j40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index ee7084b..cf4788d 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -635,7 +635,7 @@ static void mrf24j40_stop(struct ieee802154_hw *hw)
 
 	/* Set TXNIE and RXIE. Disable Interrupts */
 	regmap_update_bits(devrec->regmap_short, REG_INTCON,
-			   BIT_TXNIE | BIT_TXNIE, BIT_TXNIE | BIT_TXNIE);
+			   BIT_TXNIE | BIT_RXIE, BIT_TXNIE | BIT_RXIE);
 }
 
 static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
-- 
2.7.4

