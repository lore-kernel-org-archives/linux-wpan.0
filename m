Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63023 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaKIHhb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:31 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so6548420wgh.28
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:29 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/15] ieee802154: add wpan_dev_list
Date: Sun,  9 Nov 2014 08:36:50 +0100
Message-Id: <1415518619-4370-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a wpan_dev_list list into cfg802154_registered_device
struct. Also adding new wpan_dev into this list while
cfg802154_netdev_notifier_call. This behaviour is mostly grab from
wireless core.c implementation and is needed for preparing nl802154
framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h |  6 ++++
 net/ieee802154/core.c   | 95 +++++++++++++++++++++++++++++++++++++++++++++++--
 net/ieee802154/core.h   | 11 ++++++
 3 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 7e1bc21..e5570e0 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -66,6 +66,12 @@ struct wpan_dev {
 	struct wpan_phy *wpan_phy;
 	int iftype;
 
+	/* the remainder of this struct should be private to cfg802154 */
+	struct list_head list;
+	struct net_device *netdev;
+
+	u32 identifier;
+
 	/* MAC PIB */
 	__le16 pan_id;
 	__le16 short_addr;
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 11a1d2e..3ee00bf 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -102,12 +102,15 @@ wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
 
 	mutex_init(&rdev->wpan_phy.pib_lock);
 
+	INIT_LIST_HEAD(&rdev->wpan_dev_list);
 	device_initialize(&rdev->wpan_phy.dev);
 	dev_set_name(&rdev->wpan_phy.dev, "wpan-phy%d", rdev->wpan_phy_idx);
 
 	rdev->wpan_phy.dev.class = &wpan_phy_class;
 	rdev->wpan_phy.dev.platform_data = rdev;
 
+	init_waitqueue_head(&rdev->dev_wait);
+
 	return &rdev->wpan_phy;
 }
 EXPORT_SYMBOL(wpan_phy_new);
@@ -140,13 +143,18 @@ void wpan_phy_unregister(struct wpan_phy *phy)
 {
 	struct cfg802154_registered_device *rdev = wpan_phy_to_rdev(phy);
 
-	/* TODO open count */
+	wait_event(rdev->dev_wait, ({
+		int __count;
+		rtnl_lock();
+		__count = rdev->opencount;
+		rtnl_unlock();
+		__count == 0; }));
 
 	rtnl_lock();
 	/* TODO nl802154 phy notify */
 	/* TODO phy registered lock */
 
-	/* TODO WARN_ON wpan_dev_list */
+	WARN_ON(!list_empty(&rdev->wpan_dev_list));
 
 	/* First remove the hardware from everywhere, this makes
 	 * it impossible to find from userspace.
@@ -173,6 +181,79 @@ void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
 	kfree(rdev);
 }
 
+static void
+cfg802154_update_iface_num(struct cfg802154_registered_device *rdev,
+			   int iftype, int num)
+{
+	ASSERT_RTNL();
+
+	rdev->num_running_ifaces += num;
+}
+
+static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
+					  unsigned long state, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	struct cfg802154_registered_device *rdev;
+
+	if (!wpan_dev)
+		return NOTIFY_DONE;
+
+	rdev = wpan_phy_to_rdev(wpan_dev->wpan_phy);
+
+	/* TODO WARN_ON unspec type */
+
+	switch (state) {
+		/* TODO NETDEV_DEVTYPE */
+	case NETDEV_REGISTER:
+		wpan_dev->identifier = ++rdev->wpan_dev_id;
+		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
+		rdev->devlist_generation++;
+
+		wpan_dev->netdev = dev;
+		break;
+	case NETDEV_DOWN:
+		cfg802154_update_iface_num(rdev, wpan_dev->iftype, -1);
+
+		rdev->opencount--;
+		wake_up(&rdev->dev_wait);
+		break;
+	case NETDEV_UP:
+		cfg802154_update_iface_num(rdev, wpan_dev->iftype, 1);
+
+		rdev->opencount++;
+		break;
+	case NETDEV_UNREGISTER:
+		/* It is possible to get NETDEV_UNREGISTER
+		 * multiple times. To detect that, check
+		 * that the interface is still on the list
+		 * of registered interfaces, and only then
+		 * remove and clean it up.
+		 */
+		if (!list_empty(&wpan_dev->list)) {
+			list_del_rcu(&wpan_dev->list);
+			rdev->devlist_generation++;
+		}
+		/* synchronize (so that we won't find this netdev
+		 * from other code any more) and then clear the list
+		 * head so that the above code can safely check for
+		 * !list_empty() to avoid double-cleanup.
+		 */
+		synchronize_rcu();
+		INIT_LIST_HEAD(&wpan_dev->list);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cfg802154_netdev_notifier = {
+	.notifier_call = cfg802154_netdev_notifier_call,
+};
+
 static int __init wpan_phy_class_init(void)
 {
 	int rc;
@@ -181,11 +262,18 @@ static int __init wpan_phy_class_init(void)
 	if (rc)
 		goto err;
 
-	rc = ieee802154_nl_init();
+	rc = register_netdevice_notifier(&cfg802154_netdev_notifier);
 	if (rc)
 		goto err_nl;
 
+	rc = ieee802154_nl_init();
+	if (rc)
+		goto err_notifier;
+
 	return 0;
+
+err_notifier:
+	unregister_netdevice_notifier(&cfg802154_netdev_notifier);
 err_nl:
 	wpan_phy_sysfs_exit();
 err:
@@ -196,6 +284,7 @@ subsys_initcall(wpan_phy_class_init);
 static void __exit wpan_phy_class_exit(void)
 {
 	ieee802154_nl_exit();
+	unregister_netdevice_notifier(&cfg802154_netdev_notifier);
 	wpan_phy_sysfs_exit();
 }
 module_exit(wpan_phy_class_exit);
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index 38887cb2..e708d9d 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -10,6 +10,17 @@ struct cfg802154_registered_device {
 	/* wpan_phy index, internal only */
 	int wpan_phy_idx;
 
+	/* also protected by devlist_mtx */
+	int opencount;
+	wait_queue_head_t dev_wait;
+
+	/* protected by RTNL only */
+	int num_running_ifaces;
+
+	/* associated wpan interfaces, protected by rtnl or RCU */
+	struct list_head wpan_dev_list;
+	int devlist_generation, wpan_dev_id;
+
 	/* must be last because of the way we do wpan_phy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN
 	 */
-- 
2.1.3

