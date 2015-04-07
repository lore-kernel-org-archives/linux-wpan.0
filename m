Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35576 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbbDGLuJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 07:50:09 -0400
Received: by widdi4 with SMTP id di4so14167625wid.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 04:50:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 3/4] ieee802154: move mac pib defaults
Date: Tue,  7 Apr 2015 13:49:52 +0200
Message-Id: <1428407393-16005-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the mac pib defaults setting out of SoftMAC layer. This
will prepare for possible HardMAC drivers that these values are 802.15.4
defaults while netdev registration. Currently the SoftMAC layer is the wrong
place to do the settings of pib defaults.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c | 30 ++++++++++++++++++++++++++++++
 net/mac802154/iface.c | 15 ---------------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 2ee00e8..7a107b0 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -211,6 +211,35 @@ cfg802154_update_iface_num(struct cfg802154_registered_device *rdev,
 	rdev->num_running_ifaces += num;
 }
 
+static void
+cfg802154_reset_mac_pib(struct wpan_dev *wpan_dev)
+{
+	get_random_bytes(&wpan_dev->bsn, 1);
+	get_random_bytes(&wpan_dev->dsn, 1);
+
+	/* defaults per 802.15.4-2011 */
+	wpan_dev->min_be = 3;
+	wpan_dev->max_be = 5;
+	wpan_dev->csma_retries = 4;
+	/* for compatibility, actual default is 3 */
+	wpan_dev->frame_retries = -1;
+
+	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PAN_ID_BROADCAST);
+	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
+
+	/* normally false, but monitors are always in promiscuous_mode */
+	switch (wpan_dev->iftype) {
+	case NL802154_IFTYPE_NODE:
+		wpan_dev->promiscuous_mode = false;
+		break;
+	case NL802154_IFTYPE_MONITOR:
+		wpan_dev->promiscuous_mode = true;
+		break;
+	default:
+		BUG();
+	}
+}
+
 static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 					  unsigned long state, void *ptr)
 {
@@ -234,6 +263,7 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 		rdev->devlist_generation++;
 
 		wpan_dev->netdev = dev;
+		cfg802154_reset_mac_pib(wpan_dev);
 		break;
 	case NETDEV_DOWN:
 		cfg802154_update_iface_num(rdev, wpan_dev->iftype, -1);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 38b56f9..3f6a3fe 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -479,19 +479,6 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 	sdata->vif.type = type;
 	sdata->wpan_dev.iftype = type;
 
-	get_random_bytes(&wpan_dev->bsn, 1);
-	get_random_bytes(&wpan_dev->dsn, 1);
-
-	/* defaults per 802.15.4-2011 */
-	wpan_dev->min_be = 3;
-	wpan_dev->max_be = 5;
-	wpan_dev->csma_retries = 4;
-	/* for compatibility, actual default is 3 */
-	wpan_dev->frame_retries = -1;
-
-	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
-	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
-
 	switch (type) {
 	case NL802154_IFTYPE_NODE:
 		ieee802154_be64_to_le64(&wpan_dev->extended_addr,
@@ -501,7 +488,6 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->destructor = mac802154_wpan_free;
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
-		wpan_dev->promiscuous_mode = false;
 
 		spin_lock_init(&sdata->mib_lock);
 		mutex_init(&sdata->sec_mtx);
@@ -511,7 +497,6 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 	case NL802154_IFTYPE_MONITOR:
 		sdata->dev->destructor = free_netdev;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
-		wpan_dev->promiscuous_mode = true;
 		break;
 	default:
 		BUG();
-- 
2.3.5

