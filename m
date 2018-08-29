Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:35022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeH2SrA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Aug 2018 14:47:00 -0400
Date: Wed, 29 Aug 2018 17:49:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ieee802154: mcr20a: read out of bounds in
 mcr20a_set_channel()
Message-ID: <20180829144923.6p2omsbe2s343wea@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

The "channel" variable can be any u8 value.  We need to make sure we
don't read outside of the PLL_INT[] or PLL_FRAC[] arrays.

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This patch is obviously harmless, but it's from static analysis.  I'm
pretty sure this is required, but I can't swear.

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index e428277781ac..4f41d1d3588e 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -512,6 +512,9 @@ mcr20a_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 
 	dev_dbg(printdev(lp), "%s\n", __func__);
 
+	if (channel < 11 || channel - 11 >= ARRAY_SIZE(PLL_INT))
+		return -EINVAL;
+
 	/* freqency = ((PLL_INT+64) + (PLL_FRAC/65536)) * 32 MHz */
 	ret = regmap_write(lp->regmap_dar, DAR_PLL_INT0, PLL_INT[channel - 11]);
 	if (ret)
