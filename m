Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:44833 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbbFIJL5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 05:11:57 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next] ieee802154/cc2520: check for return values in cc2520_filter()
Date: Tue,  9 Jun 2015 11:11:48 +0200
Message-Id: <1433841108-1122-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

neither ram nor register write return values have been checked here. Checking
both now. Assign ret with 0 as all other assignments are inside if blocks and
might not happen before we return ret.

CID: 1230469
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>
---
 drivers/net/ieee802154/cc2520.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 15f263c..54c15e0 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -590,22 +590,23 @@ cc2520_filter(struct ieee802154_hw *hw,
 	      struct ieee802154_hw_addr_filt *filt, unsigned long changed)
 {
 	struct cc2520_private *priv = hw->priv;
+	int ret = 0;
 
 	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 panid = le16_to_cpu(filt->pan_id);
 
 		dev_vdbg(&priv->spi->dev,
 			 "cc2520_filter called for pan id\n");
-		cc2520_write_ram(priv, CC2520RAM_PANID,
-				 sizeof(panid), (u8 *)&panid);
+		ret = cc2520_write_ram(priv, CC2520RAM_PANID,
+				       sizeof(panid), (u8 *)&panid);
 	}
 
 	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
 		dev_vdbg(&priv->spi->dev,
 			 "cc2520_filter called for IEEE addr\n");
-		cc2520_write_ram(priv, CC2520RAM_IEEEADDR,
-				 sizeof(filt->ieee_addr),
-				 (u8 *)&filt->ieee_addr);
+		ret = cc2520_write_ram(priv, CC2520RAM_IEEEADDR,
+				       sizeof(filt->ieee_addr),
+				       (u8 *)&filt->ieee_addr);
 	}
 
 	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
@@ -613,20 +614,20 @@ cc2520_filter(struct ieee802154_hw *hw,
 
 		dev_vdbg(&priv->spi->dev,
 			 "cc2520_filter called for saddr\n");
-		cc2520_write_ram(priv, CC2520RAM_SHORTADDR,
-				 sizeof(addr), (u8 *)&addr);
+		ret = cc2520_write_ram(priv, CC2520RAM_SHORTADDR,
+				       sizeof(addr), (u8 *)&addr);
 	}
 
 	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
 		dev_vdbg(&priv->spi->dev,
 			 "cc2520_filter called for panc change\n");
 		if (filt->pan_coord)
-			cc2520_write_register(priv, CC2520_FRMFILT0, 0x02);
+			ret = cc2520_write_register(priv, CC2520_FRMFILT0, 0x02);
 		else
-			cc2520_write_register(priv, CC2520_FRMFILT0, 0x00);
+			ret = cc2520_write_register(priv, CC2520_FRMFILT0, 0x00);
 	}
 
-	return 0;
+	return ret;
 }
 
 static inline int cc2520_set_tx_power(struct cc2520_private *priv, s32 mbm)
-- 
2.1.0

