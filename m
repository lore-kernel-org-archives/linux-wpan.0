Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35871 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaJYDZi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:38 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so3452898lbv.10
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:36 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/6] mac802154: fix typo IEEE802515 to IEEE802154
Date: Sat, 25 Oct 2014 05:25:09 +0200
Message-Id: <1414207512-10281-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
References: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

This patch fixs a typo in address filter defines from IEEE802515 to
IEEE802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c | 8 ++++----
 drivers/net/ieee802154/cc2520.c    | 8 ++++----
 drivers/net/ieee802154/mrf24j40.c  | 8 ++++----
 include/net/mac802154.h            | 8 ++++----
 net/mac802154/mib.c                | 6 +++---
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b8b1e40..83a635f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1097,7 +1097,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_dev *dev,
 {
 	struct at86rf230_local *lp = dev->priv;
 
-	if (changed & IEEE802515_AFILT_SADDR_CHANGED) {
+	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
 
 		dev_vdbg(&lp->spi->dev,
@@ -1106,7 +1106,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_dev *dev,
 		__at86rf230_write(lp, RG_SHORT_ADDR_1, addr >> 8);
 	}
 
-	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
+	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 pan = le16_to_cpu(filt->pan_id);
 
 		dev_vdbg(&lp->spi->dev,
@@ -1115,7 +1115,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_dev *dev,
 		__at86rf230_write(lp, RG_PAN_ID_1, pan >> 8);
 	}
 
-	if (changed & IEEE802515_AFILT_IEEEADDR_CHANGED) {
+	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
 		u8 i, addr[8];
 
 		memcpy(addr, &filt->ieee_addr, 8);
@@ -1125,7 +1125,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_dev *dev,
 			__at86rf230_write(lp, RG_IEEE_ADDR_0 + i, addr[i]);
 	}
 
-	if (changed & IEEE802515_AFILT_PANC_CHANGED) {
+	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
 		dev_vdbg(&lp->spi->dev,
 			"at86rf230_set_hw_addr_filt called for panc change\n");
 		if (filt->pan_coord)
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 8a5ac7a..571f280 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -593,7 +593,7 @@ cc2520_filter(struct ieee802154_dev *dev,
 {
 	struct cc2520_private *priv = dev->priv;
 
-	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
+	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 panid = le16_to_cpu(filt->pan_id);
 
 		dev_vdbg(&priv->spi->dev,
@@ -602,7 +602,7 @@ cc2520_filter(struct ieee802154_dev *dev,
 				 sizeof(panid), (u8 *)&panid);
 	}
 
-	if (changed & IEEE802515_AFILT_IEEEADDR_CHANGED) {
+	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
 		dev_vdbg(&priv->spi->dev,
 			 "cc2520_filter called for IEEE addr\n");
 		cc2520_write_ram(priv, CC2520RAM_IEEEADDR,
@@ -610,7 +610,7 @@ cc2520_filter(struct ieee802154_dev *dev,
 				 (u8 *)&filt->ieee_addr);
 	}
 
-	if (changed & IEEE802515_AFILT_SADDR_CHANGED) {
+	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
 
 		dev_vdbg(&priv->spi->dev,
@@ -619,7 +619,7 @@ cc2520_filter(struct ieee802154_dev *dev,
 				 sizeof(addr), (u8 *)&addr);
 	}
 
-	if (changed & IEEE802515_AFILT_PANC_CHANGED) {
+	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
 		dev_vdbg(&priv->spi->dev,
 			 "cc2520_filter called for panc change\n");
 		if (filt->pan_coord)
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index ba9a396..0006b9a 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -462,7 +462,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 
 	dev_dbg(printdev(devrec), "filter\n");
 
-	if (changed & IEEE802515_AFILT_SADDR_CHANGED) {
+	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		/* Short Addr */
 		u8 addrh, addrl;
 
@@ -475,7 +475,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 			"Set short addr to %04hx\n", filt->short_addr);
 	}
 
-	if (changed & IEEE802515_AFILT_IEEEADDR_CHANGED) {
+	if (changed & IEEE802154_AFILT_IEEEADDR_CHANGED) {
 		/* Device Address */
 		u8 i, addr[8];
 
@@ -491,7 +491,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 #endif
 	}
 
-	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
+	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		/* PAN ID */
 		u8 panidl, panidh;
 
@@ -503,7 +503,7 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 		dev_dbg(printdev(devrec), "Set PANID to %04hx\n", filt->pan_id);
 	}
 
-	if (changed & IEEE802515_AFILT_PANC_CHANGED) {
+	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
 		/* Pan Coordinator */
 		u8 val;
 		int ret;
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index f95b98e..70351de 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -32,13 +32,13 @@
  */
 
 /* indicates that the Short Address changed */
-#define IEEE802515_AFILT_SADDR_CHANGED		0x00000001
+#define IEEE802154_AFILT_SADDR_CHANGED		0x00000001
 /* indicates that the IEEE Address changed */
-#define IEEE802515_AFILT_IEEEADDR_CHANGED	0x00000002
+#define IEEE802154_AFILT_IEEEADDR_CHANGED	0x00000002
 /* indicates that the PAN ID changed */
-#define IEEE802515_AFILT_PANID_CHANGED		0x00000004
+#define IEEE802154_AFILT_PANID_CHANGED		0x00000004
 /* indicates that PAN Coordinator status changed */
-#define	IEEE802515_AFILT_PANC_CHANGED		0x00000008
+#define IEEE802154_AFILT_PANC_CHANGED		0x00000008
 
 struct ieee802154_hw_addr_filt {
 	__le16	pan_id;		/* Each independent PAN selects a unique
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index d7e5df8..3ee6042 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -89,7 +89,7 @@ void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 	if ((priv->hw->ops->set_hw_addr_filt) &&
 	    (priv->hw->hw.hw_filt.short_addr != priv->short_addr)) {
 		priv->hw->hw.hw_filt.short_addr = priv->short_addr;
-		set_hw_addr_filt(dev, IEEE802515_AFILT_SADDR_CHANGED);
+		set_hw_addr_filt(dev, IEEE802154_AFILT_SADDR_CHANGED);
 	}
 }
 
@@ -117,7 +117,7 @@ void mac802154_dev_set_ieee_addr(struct net_device *dev)
 	if (mac->ops->set_hw_addr_filt &&
 	    mac->hw.hw_filt.ieee_addr != priv->extended_addr) {
 		mac->hw.hw_filt.ieee_addr = priv->extended_addr;
-		set_hw_addr_filt(dev, IEEE802515_AFILT_IEEEADDR_CHANGED);
+		set_hw_addr_filt(dev, IEEE802154_AFILT_IEEEADDR_CHANGED);
 	}
 }
 
@@ -148,7 +148,7 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 	if ((priv->hw->ops->set_hw_addr_filt) &&
 	    (priv->hw->hw.hw_filt.pan_id != priv->pan_id)) {
 		priv->hw->hw.hw_filt.pan_id = priv->pan_id;
-		set_hw_addr_filt(dev, IEEE802515_AFILT_PANID_CHANGED);
+		set_hw_addr_filt(dev, IEEE802154_AFILT_PANID_CHANGED);
 	}
 }
 
-- 
2.1.2

