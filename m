Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48511 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918AbcFRIpy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 18 Jun 2016 04:45:54 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH RESEND bluetooth-next 2/3] ieee802154: add netns support
Date: Sat, 18 Jun 2016 10:45:34 +0200
Message-Id: <20160618084535.4699-2-aar@pengutronix.de>
In-Reply-To: <20160618084535.4699-1-aar@pengutronix.de>
References: <20160618084535.4699-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>, Nicolas Dichtel <nicolas.dichtel@6wind.com>

This patch adds netns support for 802.15.4 subsystem. Most parts are
copy&pasted from wireless subsystem, it has the identically userspace
API.

Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/cfg802154.h   | 13 +++++++++
 include/net/nl802154.h    |  5 ++++
 net/ieee802154/core.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
 net/ieee802154/core.h     |  2 ++
 net/ieee802154/nl802154.c | 54 ++++++++++++++++++++++++++++++++----
 5 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 171cd76..795ca40 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -219,9 +219,22 @@ struct wpan_phy {
 
 	struct device dev;
 
+	/* the network namespace this phy lives in currently */
+	possible_net_t _net;
+
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
+static inline struct net *wpan_phy_net(struct wpan_phy *wpan_phy)
+{
+	return read_pnet(&wpan_phy->_net);
+}
+
+static inline void wpan_phy_net_set(struct wpan_phy *wpan_phy, struct net *net)
+{
+	write_pnet(&wpan_phy->_net, net);
+}
+
 struct ieee802154_addr {
 	u8 mode;
 	__le16 pan_id;
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 7aad2fd..ddcee12 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -54,6 +54,8 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_ACKREQ_DEFAULT,
 
+	NL802154_CMD_SET_WPAN_PHY_NETNS,
+
 	/* add new commands above here */
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
@@ -126,6 +128,9 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_PAD,
 
+	NL802154_ATTR_PID,
+	NL802154_ATTR_NETNS_FD,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index c35fdfa..cb7176c 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -140,6 +140,8 @@ wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
 	rdev->wpan_phy.dev.class = &wpan_phy_class;
 	rdev->wpan_phy.dev.platform_data = rdev;
 
+	wpan_phy_net_set(&rdev->wpan_phy, &init_net);
+
 	init_waitqueue_head(&rdev->dev_wait);
 
 	return &rdev->wpan_phy;
@@ -207,6 +209,49 @@ void wpan_phy_free(struct wpan_phy *phy)
 }
 EXPORT_SYMBOL(wpan_phy_free);
 
+int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
+			   struct net *net)
+{
+	struct wpan_dev *wpan_dev;
+	int err = 0;
+
+	list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
+		if (!wpan_dev->netdev)
+			continue;
+		wpan_dev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+		err = dev_change_net_namespace(wpan_dev->netdev, net, "wpan%d");
+		if (err)
+			break;
+		wpan_dev->netdev->features |= NETIF_F_NETNS_LOCAL;
+	}
+
+	if (err) {
+		/* failed -- clean up to old netns */
+		net = wpan_phy_net(&rdev->wpan_phy);
+
+		list_for_each_entry_continue_reverse(wpan_dev,
+						     &rdev->wpan_dev_list,
+						     list) {
+			if (!wpan_dev->netdev)
+				continue;
+			wpan_dev->netdev->features &= ~NETIF_F_NETNS_LOCAL;
+			err = dev_change_net_namespace(wpan_dev->netdev, net,
+						       "wpan%d");
+			WARN_ON(err);
+			wpan_dev->netdev->features |= NETIF_F_NETNS_LOCAL;
+		}
+
+		return err;
+	}
+
+	wpan_phy_net_set(&rdev->wpan_phy, net);
+
+	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
+	WARN_ON(err);
+
+	return 0;
+}
+
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
 {
 	kfree(rdev);
@@ -286,14 +331,34 @@ static struct notifier_block cfg802154_netdev_notifier = {
 	.notifier_call = cfg802154_netdev_notifier_call,
 };
 
+static void __net_exit cfg802154_pernet_exit(struct net *net)
+{
+	struct cfg802154_registered_device *rdev;
+
+	rtnl_lock();
+	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
+		if (net_eq(wpan_phy_net(&rdev->wpan_phy), net))
+			WARN_ON(cfg802154_switch_netns(rdev, &init_net));
+	}
+	rtnl_unlock();
+}
+
+static struct pernet_operations cfg802154_pernet_ops = {
+	.exit = cfg802154_pernet_exit,
+};
+
 static int __init wpan_phy_class_init(void)
 {
 	int rc;
 
-	rc = wpan_phy_sysfs_init();
+	rc = register_pernet_device(&cfg802154_pernet_ops);
 	if (rc)
 		goto err;
 
+	rc = wpan_phy_sysfs_init();
+	if (rc)
+		goto err_sysfs;
+
 	rc = register_netdevice_notifier(&cfg802154_netdev_notifier);
 	if (rc)
 		goto err_nl;
@@ -315,6 +380,8 @@ err_notifier:
 	unregister_netdevice_notifier(&cfg802154_netdev_notifier);
 err_nl:
 	wpan_phy_sysfs_exit();
+err_sysfs:
+	unregister_pernet_device(&cfg802154_pernet_ops);
 err:
 	return rc;
 }
@@ -326,6 +393,7 @@ static void __exit wpan_phy_class_exit(void)
 	ieee802154_nl_exit();
 	unregister_netdevice_notifier(&cfg802154_netdev_notifier);
 	wpan_phy_sysfs_exit();
+	unregister_pernet_device(&cfg802154_pernet_ops);
 }
 module_exit(wpan_phy_class_exit);
 
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index 231fade..81141f5 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -38,6 +38,8 @@ wpan_phy_to_rdev(struct wpan_phy *wpan_phy)
 extern struct list_head cfg802154_rdev_list;
 extern int cfg802154_rdev_list_generation;
 
+int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
+			   struct net *net);
 /* free object */
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev);
 struct cfg802154_registered_device *
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 116187b..d90a4ed 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -80,7 +80,8 @@ __cfg802154_wpan_dev_from_attrs(struct net *netns, struct nlattr **attrs)
 	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
 		struct wpan_dev *wpan_dev;
 
-		/* TODO netns compare */
+		if (wpan_phy_net(&rdev->wpan_phy) != netns)
+			continue;
 
 		if (have_wpan_dev_id && rdev->wpan_phy_idx != wpan_phy_idx)
 			continue;
@@ -175,7 +176,8 @@ __cfg802154_rdev_from_attrs(struct net *netns, struct nlattr **attrs)
 	if (!rdev)
 		return ERR_PTR(-ENODEV);
 
-	/* TODO netns compare */
+	if (netns != wpan_phy_net(&rdev->wpan_phy))
+		return ERR_PTR(-ENODEV);
 
 	return rdev;
 }
@@ -233,6 +235,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 
 	[NL802154_ATTR_ACKREQ_DEFAULT] = { .type = NLA_U8 },
 
+	[NL802154_ATTR_PID] = { .type = NLA_U32 },
+	[NL802154_ATTR_NETNS_FD] = { .type = NLA_U32 },
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	[NL802154_ATTR_SEC_ENABLED] = { .type = NLA_U8, },
 	[NL802154_ATTR_SEC_OUT_LEVEL] = { .type = NLA_U32, },
@@ -590,7 +594,6 @@ static int nl802154_dump_wpan_phy_parse(struct sk_buff *skb,
 		struct cfg802154_registered_device *rdev;
 		int ifidx = nla_get_u32(tb[NL802154_ATTR_IFINDEX]);
 
-		/* TODO netns */
 		netdev = __dev_get_by_index(&init_net, ifidx);
 		if (!netdev)
 			return -ENODEV;
@@ -629,7 +632,8 @@ nl802154_dump_wpan_phy(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
-		/* TODO net ns compare */
+		if (!net_eq(wpan_phy_net(&rdev->wpan_phy), sock_net(skb->sk)))
+			continue;
 		if (++idx <= state->start)
 			continue;
 		if (state->filter_wpan_phy != -1 &&
@@ -871,7 +875,8 @@ nl802154_dump_interface(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rtnl_lock();
 	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
-		/* TODO netns compare */
+		if (!net_eq(wpan_phy_net(&rdev->wpan_phy), sock_net(skb->sk)))
+			continue;
 		if (wp_idx < wp_start) {
 			wp_idx++;
 			continue;
@@ -1271,6 +1276,37 @@ nl802154_set_ackreq_default(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_ackreq_default(rdev, wpan_dev, ackreq);
 }
 
+static int nl802154_wpan_phy_netns(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net *net;
+	int err;
+
+	if (info->attrs[NL802154_ATTR_PID]) {
+		u32 pid = nla_get_u32(info->attrs[NL802154_ATTR_PID]);
+
+		net = get_net_ns_by_pid(pid);
+	} else if (info->attrs[NL802154_ATTR_NETNS_FD]) {
+		u32 fd = nla_get_u32(info->attrs[NL802154_ATTR_NETNS_FD]);
+
+		net = get_net_ns_by_fd(fd);
+	} else {
+		return -EINVAL;
+	}
+
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
+	err = 0;
+
+	/* check if anything to do */
+	if (!net_eq(wpan_phy_net(&rdev->wpan_phy), net))
+		err = cfg802154_switch_netns(rdev, net);
+
+	put_net(net);
+	return err;
+}
+
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 static const struct nla_policy nl802154_dev_addr_policy[NL802154_DEV_ADDR_ATTR_MAX + 1] = {
 	[NL802154_DEV_ADDR_ATTR_PAN_ID] = { .type = NLA_U16 },
@@ -2262,6 +2298,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_SET_WPAN_PHY_NETNS,
+		.doit = nl802154_wpan_phy_netns,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_SET_PAN_ID,
 		.doit = nl802154_set_pan_id,
 		.policy = nl802154_policy,
-- 
2.8.3

