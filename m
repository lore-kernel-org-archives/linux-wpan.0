Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34819 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbbFQNfo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Jun 2015 09:35:44 -0400
Received: by wiga1 with SMTP id a1so139916087wig.0
        for <linux-wpan@vger.kernel.org>; Wed, 17 Jun 2015 06:35:43 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] mac802154: iface: fix order while interface up
Date: Wed, 17 Jun 2015 15:35:17 +0200
Message-Id: <1434548118-25656-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the hardware setting before calling the driver start
callback which activates the receive handling. The hardware setup
contains settings like address filtering which should be setup before
activate the receive handling on the transceiver. These setting are
protected by ieee802154_check_concurrent_iface check. This means we
need to set these registers once before calling drv_start and can't
be overwritten by other interfaces.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 103 +++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 692731d..0b0cccb 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -135,6 +135,56 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 	return mac802154_wpan_update_llsec(dev);
 }
 
+static int ieee802154_setup_hw(struct ieee802154_sub_if_data *sdata)
+{
+	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	int ret;
+
+	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
+		ret = drv_set_promiscuous_mode(local,
+					       wpan_dev->promiscuous_mode);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		ret = drv_set_pan_id(local, wpan_dev->pan_id);
+		if (ret < 0)
+			return ret;
+
+		ret = drv_set_extended_addr(local, wpan_dev->extended_addr);
+		if (ret < 0)
+			return ret;
+
+		ret = drv_set_short_addr(local, wpan_dev->short_addr);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_LBT) {
+		ret = drv_set_lbt_mode(local, wpan_dev->lbt);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
+		ret = drv_set_csma_params(local, wpan_dev->min_be,
+					  wpan_dev->max_be,
+					  wpan_dev->csma_retries);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_FRAME_RETRIES) {
+		ret = drv_set_max_frame_retries(local, wpan_dev->frame_retries);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mac802154_slave_open(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
@@ -146,6 +196,10 @@ static int mac802154_slave_open(struct net_device *dev)
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	if (!local->open_count) {
+		res = ieee802154_setup_hw(sdata);
+		if (res)
+			goto err;
+
 		res = drv_start(local);
 		if (res)
 			goto err;
@@ -239,60 +293,13 @@ static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 
 	rc = ieee802154_check_concurrent_iface(sdata, wpan_dev->iftype);
 	if (rc < 0)
 		return rc;
 
-	rc = mac802154_slave_open(dev);
-	if (rc < 0)
-		return rc;
-
-	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
-		rc = drv_set_promiscuous_mode(local,
-					      wpan_dev->promiscuous_mode);
-		if (rc < 0)
-			goto out;
-	}
-
-	if (local->hw.flags & IEEE802154_HW_AFILT) {
-		rc = drv_set_pan_id(local, wpan_dev->pan_id);
-		if (rc < 0)
-			goto out;
-
-		rc = drv_set_extended_addr(local, wpan_dev->extended_addr);
-		if (rc < 0)
-			goto out;
-
-		rc = drv_set_short_addr(local, wpan_dev->short_addr);
-		if (rc < 0)
-			goto out;
-	}
-
-	if (local->hw.flags & IEEE802154_HW_LBT) {
-		rc = drv_set_lbt_mode(local, wpan_dev->lbt);
-		if (rc < 0)
-			goto out;
-	}
-
-	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
-		rc = drv_set_csma_params(local, wpan_dev->min_be,
-					 wpan_dev->max_be,
-					 wpan_dev->csma_retries);
-		if (rc < 0)
-			goto out;
-	}
-
-	if (local->hw.flags & IEEE802154_HW_FRAME_RETRIES) {
-		rc = drv_set_max_frame_retries(local, wpan_dev->frame_retries);
-		if (rc < 0)
-			goto out;
-	}
-
-out:
-	return rc;
+	return mac802154_slave_open(dev);
 }
 
 static int mac802154_slave_close(struct net_device *dev)
-- 
2.4.1

