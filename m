Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:54786 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbaKBDTY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:24 -0400
Received: by mail-wg0-f43.google.com with SMTP id y10so5964083wgg.2
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/16] mac802154: move phy settings into netlink receive
Date: Sun,  2 Nov 2014 04:18:44 +0100
Message-Id: <1414898327-20759-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

All PHY attributes should be directly set to the transceiver after netlink.
MAC attributes should be set by interface up. Currently the macparams
netlink cmd contains mixed attributes of phy and mac settings. This patch
moves all phy settings to the netlink receive function for setting macparams.
This is the only way which doesn't change the userspace API and keep the
deprecated netlink interface alive.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c   | 19 -------------------
 net/mac802154/mac_cmd.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 5f94c70..eaad665 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -218,31 +218,12 @@ static int mac802154_wpan_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
-		rc = drv_set_tx_power(local, sdata->mac_params.transmit_power);
-		if (rc < 0)
-			goto out;
-	}
-
 	if (local->hw.flags & IEEE802154_HW_LBT) {
 		rc = drv_set_lbt_mode(local, sdata->mac_params.lbt);
 		if (rc < 0)
 			goto out;
 	}
 
-	if (local->hw.flags & IEEE802154_HW_CCA_MODE) {
-		rc = drv_set_cca_mode(local, sdata->mac_params.cca_mode);
-		if (rc < 0)
-			goto out;
-	}
-
-	if (local->hw.flags & IEEE802154_HW_CCA_ED_LEVEL) {
-		rc = drv_set_cca_ed_level(local,
-					  sdata->mac_params.cca_ed_level);
-		if (rc < 0)
-			goto out;
-	}
-
 	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
 		rc = drv_set_csma_params(local, sdata->mac_params.min_be,
 					 sdata->mac_params.max_be,
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 90c1ad8..9c2d6f6 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -28,6 +28,7 @@
 #include <net/nl802154.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 static int mac802154_mlme_start_req(struct net_device *dev,
 				    struct ieee802154_addr *addr,
@@ -85,11 +86,31 @@ static int mac802154_set_mac_params(struct net_device *dev,
 				    const struct ieee802154_mac_params *params)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct ieee802154_local *local = sdata->local;
+	int ret;
 
 	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->mac_params = *params;
 	mutex_unlock(&sdata->local->iflist_mtx);
 
+	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
+		ret = drv_set_tx_power(local, params->transmit_power);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_CCA_MODE) {
+		ret = drv_set_cca_mode(local, params->cca_mode);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_CCA_ED_LEVEL) {
+		ret = drv_set_cca_ed_level(local, params->cca_ed_level);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.1.3

