Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50534 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753674AbeGFIMh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jul 2018 04:12:37 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/3] ieee802154: at86rf230: use __func__ macro for debug messages
Date: Fri,  6 Jul 2018 10:12:11 +0200
Message-Id: <20180706081212.4776-3-stefan@datenfreihafen.org>
In-Reply-To: <20180706081212.4776-1-stefan@datenfreihafen.org>
References: <20180706081212.4776-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

Instead of having the function name hard-coded (it might change and we
forgot to update them in the debug output) we can use __func__ instead
and also shorter the line so we do not need to break it. Also fix an
extra blank line while being here.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 drivers/net/ieee802154/at86rf230.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7b3a381d198a..3d9e91579866 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1121,8 +1121,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
 
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for saddr\n");
+		dev_vdbg(&lp->spi->dev, "%s called for saddr\n", __func__);
 		__at86rf230_write(lp, RG_SHORT_ADDR_0, addr);
 		__at86rf230_write(lp, RG_SHORT_ADDR_1, addr >> 8);
 	}
@@ -1130,8 +1129,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 pan = le16_to_cpu(filt->pan_id);
 
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for pan id\n");
+		dev_vdbg(&lp->spi->dev, "%s called for pan id\n", __func__);
 		__at86rf230_write(lp, RG_PAN_ID_0, pan);
 		__at86rf230_write(lp, RG_PAN_ID_1, pan >> 8);
 	}
@@ -1140,15 +1138,13 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 		u8 i, addr[8];
 
 		memcpy(addr, &filt->ieee_addr, 8);
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for IEEE addr\n");
+		dev_vdbg(&lp->spi->dev, "%s called for IEEE addr\n", __func__);
 		for (i = 0; i < 8; i++)
 			__at86rf230_write(lp, RG_IEEE_ADDR_0 + i, addr[i]);
 	}
 
 	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for panc change\n");
+		dev_vdbg(&lp->spi->dev, "%s called for panc change\n", __func__);
 		if (filt->pan_coord)
 			at86rf230_write_subreg(lp, SR_AACK_I_AM_COORD, 1);
 		else
@@ -1252,7 +1248,6 @@ at86rf230_set_cca_mode(struct ieee802154_hw *hw,
 	return at86rf230_write_subreg(lp, SR_CCA_MODE, val);
 }
 
-
 static int
 at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {
-- 
2.14.4

