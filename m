Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36975 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeJAEQO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Oct 2018 00:16:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id n6-v6so12054290qtl.4
        for <linux-wpan@vger.kernel.org>; Sun, 30 Sep 2018 14:41:38 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan-next] ieee802154: hwsim: remove not used ifup list
Date: Sun, 30 Sep 2018 17:41:29 -0400
Message-Id: <20180930214129.2600-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aring@mojatatu.com>

This list is a leftover from fakelb driver which had always a full mesh
topology. Idea was to remember all phy's which are currently used by the
subsystem and deliver everything out. The hwsim driver works differently
each phy has a list of other phy's to deliver frames which allows a
own mesh topology.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index bf70ab892e69..51b5198d5943 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -37,8 +37,6 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(hwsim_phys);
 static DEFINE_MUTEX(hwsim_phys_lock);
 
-static LIST_HEAD(hwsim_ifup_phys);
-
 static struct platform_device *mac802154hwsim_dev;
 
 /* MAC802154_HWSIM netlink family */
@@ -85,7 +83,6 @@ struct hwsim_phy {
 	struct list_head edges;
 
 	struct list_head list;
-	struct list_head list_ifup;
 };
 
 static int hwsim_add_one(struct genl_info *info, struct device *dev,
@@ -159,9 +156,6 @@ static int hwsim_hw_start(struct ieee802154_hw *hw)
 	struct hwsim_phy *phy = hw->priv;
 
 	phy->suspended = false;
-	list_add_rcu(&phy->list_ifup, &hwsim_ifup_phys);
-	synchronize_rcu();
-
 	return 0;
 }
 
@@ -170,8 +164,6 @@ static void hwsim_hw_stop(struct ieee802154_hw *hw)
 	struct hwsim_phy *phy = hw->priv;
 
 	phy->suspended = true;
-	list_del_rcu(&phy->list_ifup);
-	synchronize_rcu();
 }
 
 static int
-- 
2.11.0
