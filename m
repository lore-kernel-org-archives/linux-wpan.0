Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54879 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbdIVMO2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:28 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 12/14] ieee802154: cc2520: use __func__ macro for debug messages
Date: Fri, 22 Sep 2017 14:14:03 +0200
Message-Id: <20170922121405.31789-13-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Instead of having the function name hard-coded (it might change and we
forgot to update them in the debug output) we can use __func__ instead
and also shorter the line so we do not need to break it.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/cc2520.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 9c1d1768a36f..735b9f5f9754 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -663,15 +663,14 @@ cc2520_filter(struct ieee802154_hw *hw,
 	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 panid = le16_to_cpu(filt->pan_id);
 
-		dev_vdbg(&priv->spi->dev,
-			 "cc2520_filter called for pan id\n");
+		dev_vdbg(&priv->spi->dev, "%s called for pan id\n", __func__);
 		ret = cc2520_write_ram(priv, CC2520RAM_PANID,
 				       sizeof(panid), (u8 *)&panid);
 	}
 
 	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
 		dev_vdbg(&priv->spi->dev,
-			 "cc2520_filter called for IEEE addr\n");
+			 "%s called for IEEE addr\n", __func__);
 		ret = cc2520_write_ram(priv, CC2520RAM_IEEEADDR,
 				       sizeof(filt->ieee_addr),
 				       (u8 *)&filt->ieee_addr);
@@ -680,8 +679,7 @@ cc2520_filter(struct ieee802154_hw *hw,
 	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
 
-		dev_vdbg(&priv->spi->dev,
-			 "cc2520_filter called for saddr\n");
+		dev_vdbg(&priv->spi->dev, "%s called for saddr\n", __func__);
 		ret = cc2520_write_ram(priv, CC2520RAM_SHORTADDR,
 				       sizeof(addr), (u8 *)&addr);
 	}
@@ -690,7 +688,7 @@ cc2520_filter(struct ieee802154_hw *hw,
 		u8 frmfilt0;
 
 		dev_vdbg(&priv->spi->dev,
-			 "cc2520_filter called for panc change\n");
+			 "%s called for panc change\n", __func__);
 
 		cc2520_read_register(priv, CC2520_FRMFILT0, &frmfilt0);
 
-- 
2.13.5

