Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031055AbeCAOkX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Mar 2018 09:40:23 -0500
From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ieee802154: remove unused variable 'val'
Date: Thu,  1 Mar 2018 14:40:19 +0000
Message-Id: <20180301144019.14321-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable 'val' is not being initialized and is later being logically
or'd with DAR_PHY_CTRL4_PROMISCUOUS. Considering this variable is never
being read anyway we may as well remove val altogether.

Cleans up error detected by cppcheck:
drivers/net/ieee802154/mcr20a.c:732: (error) Uninitialized variable: val

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ieee802154/mcr20a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index d9eb22a52551..55a22c761808 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -723,13 +723,11 @@ mcr20a_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
 	struct mcr20a_local *lp = hw->priv;
 	int ret;
 	u8 rx_frame_filter_reg = 0x0;
-	u8 val;
 
 	dev_dbg(printdev(lp), "%s(%d)\n", __func__, on);
 
 	if (on) {
 		/* All frame types accepted*/
-		val |= DAR_PHY_CTRL4_PROMISCUOUS;
 		rx_frame_filter_reg &= ~(IAR_RX_FRAME_FLT_FRM_VER);
 		rx_frame_filter_reg |= (IAR_RX_FRAME_FLT_ACK_FT |
 				  IAR_RX_FRAME_FLT_NS_FT);
-- 
2.15.1

