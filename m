Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:38303 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389085AbeHGQt0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Aug 2018 12:49:26 -0400
Received: by mail-it0-f67.google.com with SMTP id v71-v6so23251212itb.3
        for <linux-wpan@vger.kernel.org>; Tue, 07 Aug 2018 07:34:50 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH net-next] ieee802154: hwsim: fix rcu address annotation
Date: Tue,  7 Aug 2018 10:34:44 -0400
Message-Id: <20180807143444.32224-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>, Stefan Schmidt <stefan@datenfreihafen.org>

This patch fixes the following sparse warning about mismatch rcu
attribute for address space annotation:

...
error: incompatible types in comparison expression (different modifiers)
error: incompatible types in comparison expression (different address spaces)
...

Some __rcu annotation was at non-pointers list head structures and one was
missing in edge information which is used by rcu_assign_pointer() to
update edge setting information.

Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
Hopefully I did it right now. Sorry again.

 drivers/net/ieee802154/mac802154_hwsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 1982308b9b1c..f4e92054f7df 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -36,7 +36,7 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(hwsim_phys);
 static DEFINE_MUTEX(hwsim_phys_lock);
 
-static __rcu LIST_HEAD(hwsim_ifup_phys);
+static LIST_HEAD(hwsim_ifup_phys);
 
 static struct platform_device *mac802154hwsim_dev;
 
@@ -68,7 +68,7 @@ struct hwsim_edge_info {
 
 struct hwsim_edge {
 	struct hwsim_phy *endpoint;
-	struct hwsim_edge_info *info;
+	struct hwsim_edge_info __rcu *info;
 
 	struct list_head list;
 	struct rcu_head rcu;
@@ -81,7 +81,7 @@ struct hwsim_phy {
 	struct hwsim_pib __rcu *pib;
 
 	bool suspended;
-	struct list_head __rcu edges;
+	struct list_head edges;
 
 	struct list_head list;
 	struct list_head list_ifup;
-- 
2.11.0

