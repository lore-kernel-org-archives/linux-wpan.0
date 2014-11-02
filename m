Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:46665 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaKBUn3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:29 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so9801673wgh.14
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:28 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/6] ieee802154: remove unnecessary functions
Date: Sun,  2 Nov 2014 21:43:06 +0100
Message-Id: <1414960986-7051-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixes commit c7420c367d63a7e1414e010afb52c3837fd9134e
("mac802154: move mac_params functions into mac_cmd"). The mac_params
functions wasn't deleted by this commit.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/mac802154/iface.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ceedf3e..0c9d00c 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -127,28 +127,6 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 	return mac802154_wpan_update_llsec(dev);
 }
 
-int mac802154_set_mac_params(struct net_device *dev,
-			     const struct ieee802154_mac_params *params)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	mutex_lock(&sdata->local->iflist_mtx);
-	sdata->mac_params = *params;
-	mutex_unlock(&sdata->local->iflist_mtx);
-
-	return 0;
-}
-
-void mac802154_get_mac_params(struct net_device *dev,
-			      struct ieee802154_mac_params *params)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	mutex_lock(&sdata->local->iflist_mtx);
-	*params = sdata->mac_params;
-	mutex_unlock(&sdata->local->iflist_mtx);
-}
-
 static int mac802154_slave_open(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-- 
2.1.3

