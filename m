Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34188 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775AbbEVPoH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 11:44:07 -0400
Received: by wicmc15 with SMTP id mc15so43962509wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 08:44:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 2/4] mac802154: remove pib lock
Date: Fri, 22 May 2015 17:43:52 +0200
Message-Id: <1432309434-8215-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the pib lock which is now replaced by rtnl lock. The
new interface already use the rtnl lock only. Nevertheless this patch
will fix issues while using new and old interface at the same time.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 include/net/cfg802154.h | 2 --
 net/ieee802154/core.c   | 2 --
 net/ieee802154/nl-phy.c | 6 +++---
 net/mac802154/iface.c   | 7 -------
 net/mac802154/mib.c     | 4 ++--
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 11bbf17..c6aa1d2 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -121,8 +121,6 @@ enum wpan_phy_flags {
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
index cbc0d09..77d7301 100644
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
index 5cf019a..033dfc7 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -91,16 +91,16 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 	struct ieee802154_local *local = sdata->local;
 	int res;
 
+	ASSERT_RTNL();
+
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
 	res = drv_set_channel(local, page, chan);
 	if (res) {
 		pr_debug("set_channel failed\n");
 	} else {
-		mutex_lock(&local->phy->pib_lock);
 		local->phy->current_channel = chan;
 		local->phy->current_page = page;
-		mutex_unlock(&local->phy->pib_lock);
 	}
 }
 
-- 
2.4.1

