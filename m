Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36855 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbFXJiP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 05:38:15 -0400
Received: by wicnd19 with SMTP id nd19so129729071wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jun 2015 02:38:14 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/3] mac802154: util: add stop_device utility function
Date: Wed, 24 Jun 2015 11:36:34 +0200
Message-Id: <1435138596-25909-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, varkab@cdac.in, Alexander Aring <alex.aring@gmail.com>

This patch adds ieee802154_stop_device for preparing a utility function
to stop the ieee802154 device.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 1 +
 net/mac802154/iface.c        | 7 ++-----
 net/mac802154/util.c         | 8 ++++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index ed87463..0407783 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -176,5 +176,6 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		  unsigned char name_assign_type, enum nl802154_iftype type,
 		  __le64 extended_addr);
 void ieee802154_remove_interfaces(struct ieee802154_local *local);
+void ieee802154_stop_device(struct ieee802154_local *local);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 4760368..416de90 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -314,11 +314,8 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (!local->open_count) {
-		flush_workqueue(local->workqueue);
-		hrtimer_cancel(&local->ifs_timer);
-		drv_stop(local);
-	}
+	if (!local->open_count)
+		ieee802154_stop_device(local);
 
 	return 0;
 }
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 583435f..f9fd095 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -14,6 +14,7 @@
  */
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 /* privid for wpan_phys to determine whether they belong to us or not */
 const void *const mac802154_wpan_phy_privid = &mac802154_wpan_phy_privid;
@@ -92,3 +93,10 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 	dev_consume_skb_any(skb);
 }
 EXPORT_SYMBOL(ieee802154_xmit_complete);
+
+void ieee802154_stop_device(struct ieee802154_local *local)
+{
+	flush_workqueue(local->workqueue);
+	hrtimer_cancel(&local->ifs_timer);
+	drv_stop(local);
+}
-- 
2.4.4

