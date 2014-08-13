Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:40260 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNrE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:04 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so8392917lbd.28
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:47:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:32 +0200
Message-Id: <1407937595-16415-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 09/12] mac802154: remove useless -EBUSY if sdata running
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

The slave_open function is only called by ndo_open callback. This
callback is already protected to do a ip link set wpan0 up twice.
This patch removing also a unnecessary for each loop to find the right
entry which is already known.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ae774d3..ab23246 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -35,24 +35,11 @@
 static int mac802154_slave_open(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_sub_if_data *subif;
 	struct ieee802154_local *local = sdata->local;
 	int res = 0;
 
 	ASSERT_RTNL();
 
-	if (sdata->type == NL802154_IFTYPE_NODE) {
-		mutex_lock(&sdata->local->iflist_mtx);
-		list_for_each_entry(subif, &sdata->local->interfaces, list) {
-			if (subif != sdata && subif->type == sdata->type &&
-			    subif->running) {
-				mutex_unlock(&sdata->local->iflist_mtx);
-				return -EBUSY;
-			}
-		}
-		mutex_unlock(&sdata->local->iflist_mtx);
-	}
-
 	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->running = true;
 	mutex_unlock(&sdata->local->iflist_mtx);
-- 
2.0.3

