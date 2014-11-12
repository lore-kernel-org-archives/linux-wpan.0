Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40002 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbaKLChr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:47 -0500
Received: by mail-wi0-f171.google.com with SMTP id r20so3500724wiv.4
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:46 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/18] mac820154: move mutex locks out of loop
Date: Wed, 12 Nov 2014 03:36:50 +0100
Message-Id: <1415759825-8309-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Instead of always re-lock the iflist_mtx at multiple interfaces we lock
the complete for each loop at start and at the end.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 8b21d20..85d2155 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -540,11 +540,11 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 {
 	struct ieee802154_sub_if_data *sdata, *tmp;
 
+	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		mutex_lock(&sdata->local->iflist_mtx);
 		list_del(&sdata->list);
-		mutex_unlock(&sdata->local->iflist_mtx);
 
 		unregister_netdevice(sdata->dev);
 	}
+	mutex_unlock(&local->iflist_mtx);
 }
-- 
2.1.3

