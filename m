Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:55180 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaKETw0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:26 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so1756029wgg.22
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:25 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 18/18] mac802154: fix typo promisuous to promiscuous
Date: Wed,  5 Nov 2014 20:51:29 +0100
Message-Id: <1415217089-24919-19-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 2 +-
 net/mac802154/iface.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 931f851..4acacea 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -87,7 +87,7 @@ struct ieee802154_sub_if_data {
 	__le16 pan_id;
 	__le16 short_addr;
 	__le64 extended_addr;
-	bool promisuous_mode;
+	bool promiscuous_mode;
 
 	struct ieee802154_mac_params mac_params;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 51abe05..384f4bb 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -181,7 +181,7 @@ static int mac802154_wpan_open(struct net_device *dev)
 	mutex_lock(&phy->pib_lock);
 
 	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
-		rc = drv_set_promiscuous_mode(local, sdata->promisuous_mode);
+		rc = drv_set_promiscuous_mode(local, sdata->promiscuous_mode);
 		if (rc < 0)
 			goto out;
 	}
@@ -419,7 +419,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 		sdata->dev->destructor = mac802154_wpan_free;
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
-		sdata->promisuous_mode = false;
+		sdata->promiscuous_mode = false;
 
 		spin_lock_init(&sdata->mib_lock);
 		mutex_init(&sdata->sec_mtx);
@@ -429,7 +429,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	case IEEE802154_DEV_MONITOR:
 		sdata->dev->destructor = free_netdev;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
-		sdata->promisuous_mode = true;
+		sdata->promiscuous_mode = true;
 		break;
 	default:
 		BUG();
-- 
2.1.3

