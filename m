Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41022 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbaKLChu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:50 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so3501742wid.2
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:49 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/18] mac802154: add ifname change notifier
Date: Wed, 12 Nov 2014 03:36:53 +0100
Message-Id: <1415759825-8309-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a netdev notifier for interface renaming. We have a name
attribute inside of subif data struct. This is needed to have always the
actual netdev name in sdata name attribute.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  3 +++
 net/mac802154/iface.c        | 35 +++++++++++++++++++++++++++++++++++
 net/mac802154/main.c         | 15 +++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 4be5e23..69cb585 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -169,6 +169,9 @@ void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t);
 void mac802154_unlock_table(struct net_device *dev);
 
+/* interface handling */
+int ieee802154_iface_init(void);
+void ieee802154_iface_exit(void);
 struct net_device *
 mac802154_add_iface(struct wpan_phy *phy, const char *name, int type);
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 85d2155..ec92b48 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -548,3 +548,38 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 	}
 	mutex_unlock(&local->iflist_mtx);
 }
+
+static int netdev_notify(struct notifier_block *nb,
+			 unsigned long state, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ieee802154_sub_if_data *sdata;
+
+	if (state != NETDEV_CHANGENAME)
+		return NOTIFY_DONE;
+
+	if (!dev->ieee802154_ptr || !dev->ieee802154_ptr->wpan_phy)
+		return NOTIFY_DONE;
+
+	if (dev->ieee802154_ptr->wpan_phy->privid != mac802154_wpan_phy_privid)
+		return NOTIFY_DONE;
+
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	memcpy(sdata->name, dev->name, IFNAMSIZ);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mac802154_netdev_notifier = {
+	.notifier_call = netdev_notify,
+};
+
+int ieee802154_iface_init(void)
+{
+	return register_netdevice_notifier(&mac802154_netdev_notifier);
+}
+
+void ieee802154_iface_exit(void)
+{
+	unregister_netdevice_notifier(&mac802154_netdev_notifier);
+}
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 40a3264..46c76e0 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -182,5 +182,20 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 }
 EXPORT_SYMBOL(ieee802154_unregister_hw);
 
+static int __init ieee802154_init(void)
+{
+	return ieee802154_iface_init();
+}
+
+static void __exit ieee802154_exit(void)
+{
+	ieee802154_iface_exit();
+
+	rcu_barrier();
+}
+
+subsys_initcall(ieee802154_init);
+module_exit(ieee802154_exit);
+
 MODULE_DESCRIPTION("IEEE 802.15.4 subsystem");
 MODULE_LICENSE("GPL v2");
-- 
2.1.3

