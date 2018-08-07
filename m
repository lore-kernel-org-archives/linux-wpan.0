Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:37106 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHHBt6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Aug 2018 21:49:58 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so335578ioh.4
        for <linux-wpan@vger.kernel.org>; Tue, 07 Aug 2018 16:33:11 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH net-next] ieee802154: hwsim: fix rcu handling
Date: Tue,  7 Aug 2018 19:32:49 -0400
Message-Id: <20180807233249.28572-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>, Stefan Schmidt <stefan@datenfreihafen.org>

This patch adds missing rcu_assign_pointer()/rcu_dereference() to used rcu
pointers. There was already a previous commit c5d99d2b35da ("ieee802154:
hwsim: fix rcu address annotation"), but there was more which was
pointed out on my side by using newest sparse version.

Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
After I installed finally the newest sparse version I found more what kbuild
was pointed out.

I hope I did it right, not sure if I really need rcu functionality in these
case because protection by mutex but I make sparse silent.
At some places the resource isn't a shared resource at this moment.

Anyway in my case I want to use this driver to create easily multi-hop
scenarios, if somebody report things (or I hit it) which smells like some
memory in this area - I will try and help to fix it.

Newest sparse version from git is happy now and I hope kbuild bot as well.

I tested this patch with RPOVE_RCU enabled and tried to update these settings
while heavy loading in rcu protected xmit hotpath is occured, without any
issues so far.

Sorry again.

 drivers/net/ieee802154/mac802154_hwsim.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index f4e92054f7df..53f39435321e 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/platform_device.h>
+#include <linux/rtnetlink.h>
 #include <linux/netdevice.h>
 #include <linux/device.h>
 #include <linux/spinlock.h>
@@ -110,7 +111,7 @@ static int hwsim_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	pib->page = page;
 	pib->channel = channel;
 
-	pib_old = phy->pib;
+	pib_old = rtnl_dereference(phy->pib);
 	rcu_assign_pointer(phy->pib, pib);
 	kfree_rcu(pib_old, rcu);
 	return 0;
@@ -406,7 +407,7 @@ static struct hwsim_edge *hwsim_alloc_edge(struct hwsim_phy *endpoint, u8 lqi)
 	}
 
 	einfo->lqi = 0xff;
-	e->info = einfo;
+	rcu_assign_pointer(e->info, einfo);
 	e->endpoint = endpoint;
 
 	return e;
@@ -414,7 +415,13 @@ static struct hwsim_edge *hwsim_alloc_edge(struct hwsim_phy *endpoint, u8 lqi)
 
 static void hwsim_free_edge(struct hwsim_edge *e)
 {
-	kfree_rcu(e->info, rcu);
+	struct hwsim_edge_info *einfo;
+
+	rcu_read_lock();
+	einfo = rcu_dereference(e->info);
+	rcu_read_unlock();
+
+	kfree_rcu(einfo, rcu);
 	kfree_rcu(e, rcu);
 }
 
@@ -796,7 +803,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 		goto err_pib;
 	}
 
-	phy->pib = pib;
+	rcu_assign_pointer(phy->pib, pib);
 	phy->idx = idx;
 	INIT_LIST_HEAD(&phy->edges);
 
@@ -829,10 +836,17 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 
 static void hwsim_del(struct hwsim_phy *phy)
 {
+	struct hwsim_pib *pib;
+
 	hwsim_edge_unsubscribe_me(phy);
 
 	list_del(&phy->list);
-	kfree_rcu(phy->pib, rcu);
+
+	rcu_read_lock();
+	pib = rcu_dereference(phy->pib);
+	rcu_read_unlock();
+
+	kfree_rcu(pib, rcu);
 
 	ieee802154_unregister_hw(phy->hw);
 	ieee802154_free_hw(phy->hw);
-- 
2.11.0

