Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:52723 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeHLXEU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Aug 2018 19:04:20 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so9822071itf.2
        for <linux-wpan@vger.kernel.org>; Sun, 12 Aug 2018 13:25:11 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH net-next] ieee802154: hwsim: using right kind of iteration
Date: Sun, 12 Aug 2018 16:24:56 -0400
Message-Id: <20180812202456.22317-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>, Stefan Schmidt <stefan@datenfreihafen.org>

This patch fixes the error path to unsubscribe all other phy's from
current phy. The actually code using a wrong kind of list iteration may
copied from the case to unsubscribe the current phy from all other
phy's.

Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 07a493dea11e..bf70ab892e69 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -735,10 +735,12 @@ static int hwsim_subscribe_all_others(struct hwsim_phy *phy)
 	return 0;
 
 me_fail:
-	list_for_each_entry(phy, &hwsim_phys, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &phy->edges, list) {
 		list_del_rcu(&e->list);
 		hwsim_free_edge(e);
 	}
+	rcu_read_unlock();
 sub_fail:
 	hwsim_edge_unsubscribe_me(phy);
 	return -ENOMEM;
-- 
2.11.0
