Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:38160 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaKIHhe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:34 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so6548477wgh.28
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:33 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/15] ieee802154: add nl802154 framework
Date: Sun,  9 Nov 2014 08:36:53 +0100
Message-Id: <1415518619-4370-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a basic nl802154 framework. Most of this code was
grabbed from nl80211 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Makefile     |   2 +-
 net/ieee802154/core.c       |  28 +++-
 net/ieee802154/core.h       |   4 +
 net/ieee802154/ieee802154.h |   2 +-
 net/ieee802154/netlink.c    |   2 +-
 net/ieee802154/nl802154.c   | 309 ++++++++++++++++++++++++++++++++++++++++++++
 net/ieee802154/nl802154.h   |   7 +
 7 files changed, 350 insertions(+), 4 deletions(-)
 create mode 100644 net/ieee802154/nl802154.c
 create mode 100644 net/ieee802154/nl802154.h

diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 38354d4..9f6970f 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
-                header_ops.o sysfs.o
+                header_ops.o sysfs.o nl802154.o
 af_802154-y := af_ieee802154.o raw.o dgram.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 3ee00bf..ae5ecbc 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -21,11 +21,12 @@
 #include <net/rtnetlink.h>
 
 #include "ieee802154.h"
+#include "nl802154.h"
 #include "sysfs.h"
 #include "core.h"
 
 /* RCU-protected (and RTNL for writers) */
-static LIST_HEAD(cfg802154_rdev_list);
+LIST_HEAD(cfg802154_rdev_list);
 static int cfg802154_rdev_list_generation;
 
 static int wpan_phy_match(struct device *dev, const void *data)
@@ -74,6 +75,23 @@ int wpan_phy_for_each(int (*fn)(struct wpan_phy *phy, void *data),
 }
 EXPORT_SYMBOL(wpan_phy_for_each);
 
+struct cfg802154_registered_device *
+cfg802154_rdev_by_wpan_phy_idx(int wpan_phy_idx)
+{
+	struct cfg802154_registered_device *result = NULL, *rdev;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
+		if (rdev->wpan_phy_idx == wpan_phy_idx) {
+			result = rdev;
+			break;
+		}
+	}
+
+	return result;
+}
+
 struct wpan_phy *
 wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
 {
@@ -270,8 +288,15 @@ static int __init wpan_phy_class_init(void)
 	if (rc)
 		goto err_notifier;
 
+	rc = nl802154_init();
+	if (rc)
+		goto err_ieee802154_nl;
+
 	return 0;
 
+err_ieee802154_nl:
+	ieee802154_nl_exit();
+
 err_notifier:
 	unregister_netdevice_notifier(&cfg802154_netdev_notifier);
 err_nl:
@@ -283,6 +308,7 @@ subsys_initcall(wpan_phy_class_init);
 
 static void __exit wpan_phy_class_exit(void)
 {
+	nl802154_exit();
 	ieee802154_nl_exit();
 	unregister_netdevice_notifier(&cfg802154_netdev_notifier);
 	wpan_phy_sysfs_exit();
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index e708d9d..c8319bf 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -35,7 +35,11 @@ wpan_phy_to_rdev(struct wpan_phy *wpan_phy)
 			    wpan_phy);
 }
 
+extern struct list_head cfg802154_rdev_list;
+
 /* free object */
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev);
+struct cfg802154_registered_device *
+cfg802154_rdev_by_wpan_phy_idx(int wpan_phy_idx);
 
 #endif /* __IEEE802154_CORE_H */
diff --git a/net/ieee802154/ieee802154.h b/net/ieee802154/ieee802154.h
index 42ae63a..a5d7515 100644
--- a/net/ieee802154/ieee802154.h
+++ b/net/ieee802154/ieee802154.h
@@ -15,7 +15,7 @@
 #define IEEE_802154_LOCAL_H
 
 int __init ieee802154_nl_init(void);
-void __exit ieee802154_nl_exit(void);
+void ieee802154_nl_exit(void);
 
 #define IEEE802154_OP(_cmd, _func)			\
 	{						\
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 6c3c259..63ee7d6 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -155,7 +155,7 @@ int __init ieee802154_nl_init(void)
 						    ieee802154_mcgrps);
 }
 
-void __exit ieee802154_nl_exit(void)
+void ieee802154_nl_exit(void)
 {
 	genl_unregister_family(&nl802154_family);
 }
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
new file mode 100644
index 0000000..5dec0bb
--- /dev/null
+++ b/net/ieee802154/nl802154.c
@@ -0,0 +1,309 @@
+/* This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors:
+ * Alexander Aring <aar@pengutronix.de>
+ *
+ * Based on: net/wireless/nl80211.c
+ */
+
+#include <linux/rtnetlink.h>
+
+#include <net/cfg802154.h>
+#include <net/genetlink.h>
+#include <net/mac802154.h>
+#include <net/netlink.h>
+#include <net/nl802154.h>
+#include <net/sock.h>
+
+#include "nl802154.h"
+#include "core.h"
+
+static int nl802154_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			     struct genl_info *info);
+
+static void nl802154_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			       struct genl_info *info);
+
+/* the netlink family */
+static struct genl_family nl802154_fam = {
+	.id = GENL_ID_GENERATE,		/* don't bother with a hardcoded ID */
+	.name = NL802154_GENL_NAME,	/* have users key off the name instead */
+	.hdrsize = 0,			/* no private header */
+	.version = 1,			/* no particular meaning now */
+	.maxattr = NL802154_ATTR_MAX,
+	.netnsok = true,
+	.pre_doit = nl802154_pre_doit,
+	.post_doit = nl802154_post_doit,
+};
+
+/* multicast groups */
+enum nl802154_multicast_groups {
+	NL802154_MCGRP_CONFIG,
+};
+
+static const struct genl_multicast_group nl802154_mcgrps[] = {
+	[NL802154_MCGRP_CONFIG] = { .name = "config", },
+};
+
+/* returns ERR_PTR values */
+static struct wpan_dev *
+__cfg802154_wpan_dev_from_attrs(struct net *netns, struct nlattr **attrs)
+{
+	struct cfg802154_registered_device *rdev;
+	struct wpan_dev *result = NULL;
+	bool have_ifidx = attrs[NL802154_ATTR_IFINDEX];
+	bool have_wpan_dev_id = attrs[NL802154_ATTR_WPAN_DEV];
+	u64 wpan_dev_id;
+	int wpan_phy_idx = -1;
+	int ifidx = -1;
+
+	ASSERT_RTNL();
+
+	if (!have_ifidx && !have_wpan_dev_id)
+		return ERR_PTR(-EINVAL);
+
+	if (have_ifidx)
+		ifidx = nla_get_u32(attrs[NL802154_ATTR_IFINDEX]);
+	if (have_wpan_dev_id) {
+		wpan_dev_id = nla_get_u64(attrs[NL802154_ATTR_WPAN_DEV]);
+		wpan_phy_idx = wpan_dev_id >> 32;
+	}
+
+	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
+		struct wpan_dev *wpan_dev;
+
+		/* TODO netns compare */
+
+		if (have_wpan_dev_id && rdev->wpan_phy_idx != wpan_phy_idx)
+			continue;
+
+		list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
+			if (have_ifidx && wpan_dev->netdev &&
+			    wpan_dev->netdev->ifindex == ifidx) {
+				result = wpan_dev;
+				break;
+			}
+			if (have_wpan_dev_id &&
+			    wpan_dev->identifier == (u32)wpan_dev_id) {
+				result = wpan_dev;
+				break;
+			}
+		}
+
+		if (result)
+			break;
+	}
+
+	if (result)
+		return result;
+
+	return ERR_PTR(-ENODEV);
+}
+
+static struct cfg802154_registered_device *
+__cfg802154_rdev_from_attrs(struct net *netns, struct nlattr **attrs)
+{
+	struct cfg802154_registered_device *rdev = NULL, *tmp;
+	struct net_device *netdev;
+
+	ASSERT_RTNL();
+
+	if (!attrs[NL802154_ATTR_WPAN_PHY] &&
+	    !attrs[NL802154_ATTR_IFINDEX] &&
+	    !attrs[NL802154_ATTR_WPAN_DEV])
+		return ERR_PTR(-EINVAL);
+
+	if (attrs[NL802154_ATTR_WPAN_PHY])
+		rdev = cfg802154_rdev_by_wpan_phy_idx(
+				nla_get_u32(attrs[NL802154_ATTR_WPAN_PHY]));
+
+	if (attrs[NL802154_ATTR_WPAN_DEV]) {
+		u64 wpan_dev_id = nla_get_u64(attrs[NL802154_ATTR_WPAN_DEV]);
+		struct wpan_dev *wpan_dev;
+		bool found = false;
+
+		tmp = cfg802154_rdev_by_wpan_phy_idx(wpan_dev_id >> 32);
+		if (tmp) {
+			/* make sure wpan_dev exists */
+			list_for_each_entry(wpan_dev, &tmp->wpan_dev_list, list) {
+				if (wpan_dev->identifier != (u32)wpan_dev_id)
+					continue;
+				found = true;
+				break;
+			}
+
+			if (!found)
+				tmp = NULL;
+
+			if (rdev && tmp != rdev)
+				return ERR_PTR(-EINVAL);
+			rdev = tmp;
+		}
+	}
+
+	if (attrs[NL802154_ATTR_IFINDEX]) {
+		int ifindex = nla_get_u32(attrs[NL802154_ATTR_IFINDEX]);
+
+		netdev = __dev_get_by_index(netns, ifindex);
+		if (netdev) {
+			if (netdev->ieee802154_ptr)
+				tmp = wpan_phy_to_rdev(
+						netdev->ieee802154_ptr->wpan_phy);
+			else
+				tmp = NULL;
+
+			/* not wireless device -- return error */
+			if (!tmp)
+				return ERR_PTR(-EINVAL);
+
+			/* mismatch -- return error */
+			if (rdev && tmp != rdev)
+				return ERR_PTR(-EINVAL);
+
+			rdev = tmp;
+		}
+	}
+
+	if (!rdev)
+		return ERR_PTR(-ENODEV);
+
+	/* TODO netns compare */
+
+	return rdev;
+}
+
+/* This function returns a pointer to the driver
+ * that the genl_info item that is passed refers to.
+ *
+ * The result of this can be a PTR_ERR and hence must
+ * be checked with IS_ERR() for errors.
+ */
+static struct cfg802154_registered_device *
+cfg802154_get_dev_from_info(struct net *netns, struct genl_info *info)
+{
+	return __cfg802154_rdev_from_attrs(netns, info->attrs);
+}
+
+/* policy for the attributes */
+static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
+};
+
+/* message building helper */
+static inline void *nl802154hdr_put(struct sk_buff *skb, u32 portid, u32 seq,
+				    int flags, u8 cmd)
+{
+	/* since there is no private header just add the generic one */
+	return genlmsg_put(skb, portid, seq, &nl802154_fam, flags, cmd);
+}
+
+#define NL802154_FLAG_NEED_WPAN_PHY	0x01
+#define NL802154_FLAG_NEED_NETDEV	0x02
+#define NL802154_FLAG_NEED_RTNL		0x04
+#define NL802154_FLAG_CHECK_NETDEV_UP	0x08
+#define NL802154_FLAG_NEED_NETDEV_UP	(NL802154_FLAG_NEED_NETDEV |\
+					 NL802154_FLAG_CHECK_NETDEV_UP)
+#define NL802154_FLAG_NEED_WPAN_DEV	0x10
+#define NL802154_FLAG_NEED_WPAN_DEV_UP	(NL802154_FLAG_NEED_WPAN_DEV |\
+					 NL802154_FLAG_CHECK_NETDEV_UP)
+
+static int nl802154_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			     struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev;
+	struct wpan_dev *wpan_dev;
+	struct net_device *dev;
+	bool rtnl = ops->internal_flags & NL802154_FLAG_NEED_RTNL;
+
+	if (rtnl)
+		rtnl_lock();
+
+	if (ops->internal_flags & NL802154_FLAG_NEED_WPAN_PHY) {
+		rdev = cfg802154_get_dev_from_info(genl_info_net(info), info);
+		if (IS_ERR(rdev)) {
+			if (rtnl)
+				rtnl_unlock();
+			return PTR_ERR(rdev);
+		}
+		info->user_ptr[0] = rdev;
+	} else if (ops->internal_flags & NL802154_FLAG_NEED_NETDEV ||
+		   ops->internal_flags & NL802154_FLAG_NEED_WPAN_DEV) {
+		ASSERT_RTNL();
+		wpan_dev = __cfg802154_wpan_dev_from_attrs(genl_info_net(info),
+							   info->attrs);
+		if (IS_ERR(wpan_dev)) {
+			if (rtnl)
+				rtnl_unlock();
+			return PTR_ERR(wpan_dev);
+		}
+
+		dev = wpan_dev->netdev;
+		rdev = wpan_phy_to_rdev(wpan_dev->wpan_phy);
+
+		if (ops->internal_flags & NL802154_FLAG_NEED_NETDEV) {
+			if (!dev) {
+				if (rtnl)
+					rtnl_unlock();
+				return -EINVAL;
+			}
+
+			info->user_ptr[1] = dev;
+		} else {
+			info->user_ptr[1] = wpan_dev;
+		}
+
+		if (dev) {
+			if (ops->internal_flags & NL802154_FLAG_CHECK_NETDEV_UP &&
+			    !netif_running(dev)) {
+				if (rtnl)
+					rtnl_unlock();
+				return -ENETDOWN;
+			}
+
+			dev_hold(dev);
+		}
+
+		info->user_ptr[0] = rdev;
+	}
+
+	return 0;
+}
+
+static void nl802154_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			       struct genl_info *info)
+{
+	if (info->user_ptr[1]) {
+		if (ops->internal_flags & NL802154_FLAG_NEED_WPAN_DEV) {
+			struct wpan_dev *wpan_dev = info->user_ptr[1];
+
+			if (wpan_dev->netdev)
+				dev_put(wpan_dev->netdev);
+		} else {
+			dev_put(info->user_ptr[1]);
+		}
+	}
+
+	if (ops->internal_flags & NL802154_FLAG_NEED_RTNL)
+		rtnl_unlock();
+}
+
+static const struct genl_ops nl802154_ops[] = {
+};
+
+/* initialisation/exit functions */
+int nl802154_init(void)
+{
+	return genl_register_family_with_ops_groups(&nl802154_fam, nl802154_ops,
+						    nl802154_mcgrps);
+}
+
+void nl802154_exit(void)
+{
+	genl_unregister_family(&nl802154_fam);
+}
diff --git a/net/ieee802154/nl802154.h b/net/ieee802154/nl802154.h
new file mode 100644
index 0000000..3846a89
--- /dev/null
+++ b/net/ieee802154/nl802154.h
@@ -0,0 +1,7 @@
+#ifndef __IEEE802154_NL802154_H
+#define __IEEE802154_NL802154_H
+
+int nl802154_init(void);
+void nl802154_exit(void);
+
+#endif /* __IEEE802154_NL802154_H */
-- 
2.1.3

