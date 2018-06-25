Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:59520
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755500AbeFYNu1 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 25 Jun 2018 09:50:27 -0400
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] net: ieee802154: adf7242: Fix erroneous RX enable
Date: Mon, 25 Jun 2018 16:49:51 +0300
Message-ID: <20180625134951.14227-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, Michael.Hennerich@analog.com, stefan@osg.samsung.com
Cc: Michael Hennerich <michael.hennerich@analog.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Only enable RX mode if the netdev is opened.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/net/ieee802154/adf7242.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 3e85e9500233..0a240a3f7817 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -739,7 +739,10 @@ static int adf7242_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	adf7242_write_reg(lp, REG_CH_FREQ1, freq >> 8);
 	adf7242_write_reg(lp, REG_CH_FREQ2, freq >> 16);
 
-	return adf7242_cmd(lp, CMD_RC_RX);
+	if (test_bit(FLAG_START, &lp->flags))
+		return adf7242_cmd_rx(lp);
+	else
+		return adf7242_cmd(lp, CMD_RC_PHY_RDY);
 }
 
 static int adf7242_set_hw_addr_filt(struct ieee802154_hw *hw,
-- 
2.17.1

