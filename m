Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36191 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaKIHh0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:26 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so6734780wgg.8
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:25 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/15] mac802154: remove mac_params in sdata
Date: Sun,  9 Nov 2014 08:36:46 +0100
Message-Id: <1415518619-4370-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the mac_params from subif data struct. Instead we
manipulate the wpan attributes directly.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  2 --
 net/mac802154/iface.c        | 19 +++++++++----------
 net/mac802154/mac_cmd.c      | 26 ++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 803f529..e22f509 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -84,8 +84,6 @@ struct ieee802154_sub_if_data {
 
 	spinlock_t mib_lock;
 
-	struct ieee802154_mac_params mac_params;
-
 	/* protects sec from concurrent access by netlink. access by
 	 * encrypt/decrypt/header_create safe without additional protection.
 	 */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 6669da7..c0b96cf5 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -205,22 +205,21 @@ static int mac802154_wpan_open(struct net_device *dev)
 	}
 
 	if (local->hw.flags & IEEE802154_HW_LBT) {
-		rc = drv_set_lbt_mode(local, sdata->mac_params.lbt);
+		rc = drv_set_lbt_mode(local, wpan_dev->lbt);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
-		rc = drv_set_csma_params(local, sdata->mac_params.min_be,
-					 sdata->mac_params.max_be,
-					 sdata->mac_params.csma_retries);
+		rc = drv_set_csma_params(local, wpan_dev->min_be,
+					 wpan_dev->max_be,
+					 wpan_dev->csma_retries);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (local->hw.flags & IEEE802154_HW_FRAME_RETRIES) {
-		rc = drv_set_max_frame_retries(local,
-					       sdata->mac_params.frame_retries);
+		rc = drv_set_max_frame_retries(local, wpan_dev->frame_retries);
 		if (rc < 0)
 			goto out;
 	}
@@ -410,11 +409,11 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	get_random_bytes(&wpan_dev->dsn, 1);
 
 	/* defaults per 802.15.4-2011 */
-	sdata->mac_params.min_be = 3;
-	sdata->mac_params.max_be = 5;
-	sdata->mac_params.csma_retries = 4;
+	wpan_dev->min_be = 3;
+	wpan_dev->max_be = 5;
+	wpan_dev->csma_retries = 4;
 	/* for compatibility, actual default is 3 */
-	sdata->mac_params.frame_retries = -1;
+	wpan_dev->frame_retries = -1;
 
 	ieee802154_be64_to_le64(&wpan_dev->extended_addr, sdata->dev->dev_addr);
 	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 00b2b21..b8bd952 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -72,10 +72,21 @@ static int mac802154_set_mac_params(struct net_device *dev,
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	int ret;
 
 	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->mac_params = *params;
+	/* PHY */
+	wpan_dev->wpan_phy->transmit_power = params->transmit_power;
+	wpan_dev->wpan_phy->cca_mode = params->cca_mode;
+	wpan_dev->wpan_phy->cca_ed_level = params->cca_ed_level;
+
+	/* MAC */
+	wpan_dev->min_be = params->min_be;
+	wpan_dev->max_be = params->max_be;
+	wpan_dev->csma_retries = params->csma_retries;
+	wpan_dev->frame_retries = params->frame_retries;
+	wpan_dev->lbt = params->lbt;
 	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
@@ -103,9 +114,20 @@ static void mac802154_get_mac_params(struct net_device *dev,
 				     struct ieee802154_mac_params *params)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 
 	mutex_lock(&sdata->local->iflist_mtx);
-	*params = sdata->mac_params;
+	/* PHY */
+	params->transmit_power = wpan_dev->wpan_phy->transmit_power;
+	params->cca_mode = wpan_dev->wpan_phy->cca_mode;
+	params->cca_ed_level = wpan_dev->wpan_phy->cca_ed_level;
+
+	/* MAC */
+	params->min_be = wpan_dev->min_be;
+	params->max_be = wpan_dev->max_be;
+	params->csma_retries = wpan_dev->csma_retries;
+	params->frame_retries = wpan_dev->frame_retries;
+	params->lbt = wpan_dev->lbt;
 	mutex_unlock(&sdata->local->iflist_mtx);
 }
 
-- 
2.1.3

