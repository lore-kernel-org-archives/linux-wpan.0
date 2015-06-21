Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36894 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbFUOpw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Jun 2015 10:45:52 -0400
Received: by wicgi11 with SMTP id gi11so54307917wic.0
        for <linux-wpan@vger.kernel.org>; Sun, 21 Jun 2015 07:45:51 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: add llsec address update workaround
Date: Sun, 21 Jun 2015 16:45:20 +0200
Message-Id: <1434897920-28271-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, simon.vincent@xsilon.com, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a workaround for using the new nl802154 netlink
interface with the old ieee802154 netlink interface togehter. The
nl802154 currently supports no access for llsec layer, currently there
are users outside which are using both interfaces at the same time. This
patch adds a necessary call when addresses are updated.

Reported-by: Simon Vincent <simon.vincent@xsilon.com>
Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
There is surely a better way for getting/setting the address in llsec now,
this is a workaround for just let it work with the old interface. We will
see what we can do when nl802154 supports accessing llsec.

 net/mac802154/cfg.c          | 9 +++++++--
 net/mac802154/ieee802154_i.h | 2 ++
 net/mac802154/iface.c        | 7 ++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 317c466..44db861 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -145,13 +145,18 @@ static int
 ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		      __le16 pan_id)
 {
+	int ret;
+
 	ASSERT_RTNL();
 
 	if (wpan_dev->pan_id == pan_id)
 		return 0;
 
-	wpan_dev->pan_id = pan_id;
-	return 0;
+	ret = mac802154_wpan_update_llsec(wpan_dev->netdev);
+	if (!ret)
+		wpan_dev->pan_id = pan_id;
+
+	return ret;
 }
 
 static int
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 34755d5..6d4f3cc 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -167,6 +167,8 @@ void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t);
 void mac802154_unlock_table(struct net_device *dev);
 
+int mac802154_wpan_update_llsec(struct net_device *dev);
+
 /* interface handling */
 int ieee802154_iface_init(void);
 void ieee802154_iface_exit(void);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 8b69824..4760368 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -30,7 +30,7 @@
 #include "ieee802154_i.h"
 #include "driver-ops.h"
 
-static int mac802154_wpan_update_llsec(struct net_device *dev)
+int mac802154_wpan_update_llsec(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
@@ -471,6 +471,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		       enum nl802154_iftype type)
 {
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	int ret;
 	u8 tmp;
 
 	/* set some type-dependent values */
@@ -505,6 +506,10 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		mutex_init(&sdata->sec_mtx);
 
 		mac802154_llsec_init(&sdata->sec);
+		ret = mac802154_wpan_update_llsec(sdata->dev);
+		if (ret < 0)
+			return ret;
+
 		break;
 	case NL802154_IFTYPE_MONITOR:
 		sdata->dev->destructor = free_netdev;
-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
