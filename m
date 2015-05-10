Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35592 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbbEJUlK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 10 May 2015 16:41:10 -0400
Received: by wgbhc8 with SMTP id hc8so11566824wgb.2
        for <linux-wpan@vger.kernel.org>; Sun, 10 May 2015 13:41:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] mac802154: remove pib lock
Date: Sun, 10 May 2015 22:40:55 +0200
Message-Id: <1431290456-25524-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
References: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the pib lock which is now replaced by rtnl lock. The
new interface already use the rtnl lock only. Nevertheless this patch
will fix issues while using new and old interface at the same time.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h | 2 --
 net/ieee802154/core.c   | 2 --
 net/ieee802154/nl-phy.c | 6 +++---
 net/mac802154/iface.c   | 7 -------
 net/mac802154/mib.c     | 4 ++--
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 6ea16c8..c867d4f 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -67,8 +67,6 @@ struct wpan_phy_cca {
 };
 
 struct wpan_phy {
-	struct mutex pib_lock;
-
 	/* If multiple wpan_phys are registered and you're handed e.g.
 	 * a regular netdev with assigned ieee802154_ptr, you won't
 	 * know whether it points to a wpan_phy your driver has registered
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 2ee00e8..b0248e9 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -121,8 +121,6 @@ wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
 	/* atomic_inc_return makes it start at 1, make it start at 0 */
 	rdev->wpan_phy_idx--;
 
-	mutex_init(&rdev->wpan_phy.pib_lock);
-
 	INIT_LIST_HEAD(&rdev->wpan_dev_list);
 	device_initialize(&rdev->wpan_phy.dev);
 	dev_set_name(&rdev->wpan_phy.dev, PHY_NAME "%d", rdev->wpan_phy_idx);
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 346c666..543bd09 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -50,7 +50,7 @@ static int ieee802154_nl_fill_phy(struct sk_buff *msg, u32 portid,
 	if (!hdr)
 		goto out;
 
-	mutex_lock(&phy->pib_lock);
+	rtnl_lock();
 	if (nla_put_string(msg, IEEE802154_ATTR_PHY_NAME, wpan_phy_name(phy)) ||
 	    nla_put_u8(msg, IEEE802154_ATTR_PAGE, phy->current_page) ||
 	    nla_put_u8(msg, IEEE802154_ATTR_CHANNEL, phy->current_channel))
@@ -63,13 +63,13 @@ static int ieee802154_nl_fill_phy(struct sk_buff *msg, u32 portid,
 	    nla_put(msg, IEEE802154_ATTR_CHANNEL_PAGE_LIST,
 		    pages * sizeof(uint32_t), buf))
 		goto nla_put_failure;
-	mutex_unlock(&phy->pib_lock);
+	rtnl_unlock();
 	kfree(buf);
 	genlmsg_end(msg, hdr);
 	return 0;
 
 nla_put_failure:
-	mutex_unlock(&phy->pib_lock);
+	rtnl_unlock();
 	genlmsg_cancel(msg, hdr);
 out:
 	kfree(buf);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 2a58788..22f478b 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -242,7 +242,6 @@ static int mac802154_wpan_open(struct net_device *dev)
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
-	struct wpan_phy *phy = sdata->local->phy;
 
 	rc = ieee802154_check_concurrent_iface(sdata, sdata->vif.type);
 	if (rc < 0)
@@ -252,8 +251,6 @@ static int mac802154_wpan_open(struct net_device *dev)
 	if (rc < 0)
 		return rc;
 
-	mutex_lock(&phy->pib_lock);
-
 	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
 		rc = drv_set_promiscuous_mode(local,
 					      wpan_dev->promiscuous_mode);
@@ -295,11 +292,7 @@ static int mac802154_wpan_open(struct net_device *dev)
 			goto out;
 	}
 
-	mutex_unlock(&phy->pib_lock);
-	return 0;
-
 out:
-	mutex_unlock(&phy->pib_lock);
 	return rc;
 }
 
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 5cf019a..437ed44 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -97,10 +97,10 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 	if (res) {
 		pr_debug("set_channel failed\n");
 	} else {
-		mutex_lock(&local->phy->pib_lock);
+		rtnl_lock();
 		local->phy->current_channel = chan;
 		local->phy->current_page = page;
-		mutex_unlock(&local->phy->pib_lock);
+		rtnl_unlock();
 	}
 }
 
-- 
2.3.7

