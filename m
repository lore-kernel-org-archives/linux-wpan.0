Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33081 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbbFTNsh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Jun 2015 09:48:37 -0400
Received: by wiwl6 with SMTP id l6so1337207wiw.0
        for <linux-wpan@vger.kernel.org>; Sat, 20 Jun 2015 06:48:35 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 2/3] cfg802154: add PM hooks
Date: Sat, 20 Jun 2015 15:48:16 +0200
Message-Id: <1434808097-29824-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434808097-29824-1-git-send-email-alex.aring@gmail.com>
References: <1434808097-29824-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, varkab@cdac.in, Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkabhadram@gmail.com>

This patch help to implement suspend/resume in mac802154, these
hooks will be run before the device is suspended and after it
resumes.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  2 ++
 net/ieee802154/rdev-ops.h | 20 ++++++++++++++++++++
 net/ieee802154/sysfs.c    | 38 ++++++++++++++++++++++++++++++++++++++
 net/ieee802154/trace.h    | 22 ++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 290a9a6..382f94b 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -34,6 +34,8 @@ struct cfg802154_ops {
 							   int type);
 	void	(*del_virtual_intf_deprecated)(struct wpan_phy *wpan_phy,
 					       struct net_device *dev);
+	int	(*suspend)(struct wpan_phy *wpan_phy);
+	int	(*resume)(struct wpan_phy *wpan_phy);
 	int	(*add_virtual_intf)(struct wpan_phy *wpan_phy,
 				    const char *name,
 				    unsigned char name_assign_type,
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index b2155a1..8d5960a 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -24,6 +24,26 @@ rdev_del_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
+rdev_suspend(struct cfg802154_registered_device *rdev)
+{
+	int ret;
+	trace_802154_rdev_suspend(&rdev->wpan_phy);
+	ret = rdev->ops->suspend(&rdev->wpan_phy);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
+}
+
+static inline int
+rdev_resume(struct cfg802154_registered_device *rdev)
+{
+	int ret;
+	trace_802154_rdev_resume(&rdev->wpan_phy);
+	ret = rdev->ops->resume(&rdev->wpan_phy);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
+}
+
+static inline int
 rdev_add_virtual_intf(struct cfg802154_registered_device *rdev, char *name,
 		      unsigned char name_assign_type,
 		      enum nl802154_iftype type, __le64 extended_addr)
diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index 133b428..bd88525 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -14,11 +14,13 @@
  */
 
 #include <linux/device.h>
+#include <linux/rtnetlink.h>
 
 #include <net/cfg802154.h>
 
 #include "core.h"
 #include "sysfs.h"
+#include "rdev-ops.h"
 
 static inline struct cfg802154_registered_device *
 dev_to_rdev(struct device *dev)
@@ -62,10 +64,46 @@ static struct attribute *pmib_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pmib);
 
+#ifdef CONFIG_PM_SLEEP
+static int wpan_phy_suspend(struct device *dev)
+{
+	struct cfg802154_registered_device *rdev = dev_to_rdev(dev);
+	int ret = 0;
+
+	if (rdev->ops->suspend) {
+		rtnl_lock();
+		ret = rdev_suspend(rdev);
+		rtnl_unlock();
+	}
+
+	return ret;
+}
+
+static int wpan_phy_resume(struct device *dev)
+{
+	struct cfg802154_registered_device *rdev = dev_to_rdev(dev);
+	int ret = 0;
+
+	if (rdev->ops->resume) {
+		rtnl_lock();
+		ret = rdev_resume(rdev);
+		rtnl_unlock();
+	}
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(wpan_phy_pm_ops, wpan_phy_suspend, wpan_phy_resume);
+#define WPAN_PHY_PM_OPS (&wpan_phy_pm_ops)
+#else
+#define WPAN_PHY_PM_OPS NULL
+#endif
+
 struct class wpan_phy_class = {
 	.name = "ieee802154",
 	.dev_release = wpan_phy_release,
 	.dev_groups = pmib_groups,
+	.pm = WPAN_PHY_PM_OPS,
 };
 
 int wpan_phy_sysfs_init(void)
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 9b5f0eb..4399b7f 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -40,6 +40,28 @@
  *			rdev->ops traces		     *
  *************************************************************/
 
+DECLARE_EVENT_CLASS(wpan_phy_only_evt,
+	TP_PROTO(struct wpan_phy *wpan_phy),
+	TP_ARGS(wpan_phy),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+	),
+	TP_printk(WPAN_PHY_PR_FMT, WPAN_PHY_PR_ARG)
+);
+
+DEFINE_EVENT(wpan_phy_only_evt, 802154_rdev_suspend,
+	TP_PROTO(struct wpan_phy *wpan_phy),
+	TP_ARGS(wpan_phy)
+);
+
+DEFINE_EVENT(wpan_phy_only_evt, 802154_rdev_resume,
+	TP_PROTO(struct wpan_phy *wpan_phy),
+	TP_ARGS(wpan_phy)
+);
+
 TRACE_EVENT(802154_rdev_add_virtual_intf,
 	TP_PROTO(struct wpan_phy *wpan_phy, char *name,
 		 enum nl802154_iftype type, __le64 extended_addr),
-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
