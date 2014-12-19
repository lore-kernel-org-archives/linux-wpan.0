Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:50493 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaLSW2w (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 17:28:52 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so3209899wiv.2
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 14:28:51 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] ieee802154: iface: move multiple node type check
Date: Fri, 19 Dec 2014 23:28:43 +0100
Message-Id: <1419028123-21367-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419028123-21367-1-git-send-email-alex.aring@gmail.com>
References: <1419028123-21367-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the handling for checking on multiple node type
interface to the corresponding concurrent iface check function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 509621a..b5aab5a 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -137,25 +137,11 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 static int mac802154_slave_open(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_sub_if_data *subif;
 	struct ieee802154_local *local = sdata->local;
 	int res = 0;
 
 	ASSERT_RTNL();
 
-	if (sdata->vif.type == NL802154_IFTYPE_NODE) {
-		mutex_lock(&sdata->local->iflist_mtx);
-		list_for_each_entry(subif, &sdata->local->interfaces, list) {
-			if (subif != sdata &&
-			    subif->vif.type == sdata->vif.type &&
-			    ieee802154_sdata_running(subif)) {
-				mutex_unlock(&sdata->local->iflist_mtx);
-				return -EBUSY;
-			}
-		}
-		mutex_unlock(&sdata->local->iflist_mtx);
-	}
-
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	if (!local->open_count) {
@@ -234,6 +220,16 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
 	list_for_each_entry(nsdata, &local->interfaces, list) {
 		if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
 			int ret;
+
+			/* TODO currently we don't support multiple node types
+			 * we need to run skb_clone at rx path. Check if there
+			 * exist really an use case if we need to support
+			 * multiple node types at the same time.
+			 */
+			if (sdata->vif.type == NL802154_IFTYPE_NODE &&
+			    nsdata->vif.type == NL802154_IFTYPE_NODE)
+				return -EBUSY;
+
 			/* check all phy mac sublayer settings are the same.
 			 * We have only one phy, different values makes trouble.
 			 */
-- 
2.2.0

