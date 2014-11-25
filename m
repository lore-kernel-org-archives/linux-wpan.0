Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35396 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbaKYLIi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Nov 2014 06:08:38 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so385106pac.11
        for <linux-wpan@vger.kernel.org>; Tue, 25 Nov 2014 03:08:38 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: remove unnecessary if statement
Date: Tue, 25 Nov 2014 16:34:43 +0530
Message-Id: <1416913483-19314-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Removes unnecessary if statement check for net device. Error check performed
after alloc_netdev().

	ndev = alloc_netdev(sizeof(*sdata) + local->hw.vif_data_size, name,
			    NET_NAME_UNKNOWN, ieee802154_if_setup);
        if (!ndev)
                return ERR_PTR(-ENOMEM);
	..

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/mac802154/iface.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 38dfc72..9ae8930 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -510,11 +510,9 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (ret)
 		goto err;
 
-	if (ndev) {
-		ret = register_netdevice(ndev);
-		if (ret < 0)
-			goto err;
-	}
+	ret = register_netdevice(ndev);
+	if (ret < 0)
+		goto err;
 
 	mutex_lock(&local->iflist_mtx);
 	list_add_tail_rcu(&sdata->list, &local->interfaces);
-- 
1.7.9.5

