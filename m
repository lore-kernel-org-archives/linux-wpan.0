Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49340 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaKQHVe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:34 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so640449wiv.5
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:33 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/13] ieee802154: setting extended address while iface add
Date: Mon, 17 Nov 2014 08:20:52 +0100
Message-Id: <1416208855-8623-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting an extended address while
registration a new interface. If ieee802154_is_valid_extended_addr
getting as parameter and invalid extended address then the perm address
is fallback. This is useful to make some default handling while for
example default registration of a wpan interface while phy registration.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h      |  3 ++-
 net/ieee802154/nl802154.c    |  8 +++++++-
 net/ieee802154/rdev-ops.h    |  5 +++--
 net/mac802154/cfg.c          |  7 ++++---
 net/mac802154/ieee802154_i.h |  2 +-
 net/mac802154/iface.c        | 12 ++++++++----
 net/mac802154/main.c         |  3 ++-
 7 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 24c7321..4a9bb0e 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -41,7 +41,8 @@ struct cfg802154_ops {
 					       struct net_device *dev);
 	int	(*add_virtual_intf)(struct wpan_phy *wpan_phy,
 				    const char *name,
-				    enum nl802154_iftype type);
+				    enum nl802154_iftype type,
+				    __le64 extended_addr);
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, u16 pan_id);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index e7224f3..49c4d8a 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -555,6 +555,7 @@ static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	enum nl802154_iftype type = NL802154_IFTYPE_UNSPEC;
+	__le64 extended_addr = cpu_to_le64(0x0000000000000000ULL);
 
 	/* TODO avoid failing a new interface
 	 * creation due to pending removal?
@@ -569,12 +570,17 @@ static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	/* TODO add nla_get_le64 to netlink */
+	if (info->attrs[NL802154_ATTR_EXTENDED_ADDR])
+		extended_addr = (__force __le64)nla_get_u64(
+				info->attrs[NL802154_ATTR_EXTENDED_ADDR]);
+
 	if (!rdev->ops->add_virtual_intf)
 		return -EOPNOTSUPP;
 
 	return rdev_add_virtual_intf(rdev,
 				     nla_data(info->attrs[NL802154_ATTR_IFNAME]),
-				     type);
+				     type, extended_addr);
 }
 
 static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index d3a4f94..06e9754 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -22,9 +22,10 @@ rdev_del_virtual_intf_deprecated(struct cfg802154_registered_device *rdev,
 
 static inline int
 rdev_add_virtual_intf(struct cfg802154_registered_device *rdev, char *name,
-		      enum nl802154_iftype type)
+		      enum nl802154_iftype type, __le64 extended_addr)
 {
-	return rdev->ops->add_virtual_intf(&rdev->wpan_phy, name, type);
+	return rdev->ops->add_virtual_intf(&rdev->wpan_phy, name, type,
+					   extended_addr);
 }
 
 static inline int
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index ae1a9ef..568d712 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -28,7 +28,8 @@ ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
 	struct net_device *dev;
 
 	rtnl_lock();
-	dev = ieee802154_if_add(local, name, type);
+	dev = ieee802154_if_add(local, name, type,
+				cpu_to_le64(0x0000000000000000ULL));
 	rtnl_unlock();
 
 	return dev;
@@ -44,12 +45,12 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 
 static int
 ieee802154_add_iface(struct wpan_phy *phy, const char *name,
-		     enum nl802154_iftype type)
+		     enum nl802154_iftype type, __le64 extended_addr)
 {
 	struct ieee802154_local *local = wpan_phy_priv(phy);
 	struct net_device *err;
 
-	err = ieee802154_if_add(local, name, type);
+	err = ieee802154_if_add(local, name, type, extended_addr);
 	if (IS_ERR(err))
 		return PTR_ERR(err);
 
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 4655383..cc69163 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -176,7 +176,7 @@ void ieee802154_iface_exit(void);
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-		  enum nl802154_iftype type);
+		  enum nl802154_iftype type, __le64 extended_addr);
 void ieee802154_remove_interfaces(struct ieee802154_local *local);
 
 #endif /* __IEEE802154_I_H */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index ba63ac9..38dfc72 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -458,7 +458,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-		  enum nl802154_iftype type)
+		  enum nl802154_iftype type, __le64 extended_addr)
 {
 	struct net_device *ndev = NULL;
 	struct ieee802154_sub_if_data *sdata = NULL;
@@ -477,9 +477,16 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (ret < 0)
 		goto err;
 
+	ieee802154_le64_to_be64(ndev->perm_addr,
+				&local->hw.phy->perm_extended_addr);
 	switch (type) {
 	case NL802154_IFTYPE_NODE:
 		ndev->type = ARPHRD_IEEE802154;
+		if (ieee802154_is_valid_extended_addr(extended_addr))
+			ieee802154_le64_to_be64(ndev->dev_addr, &extended_addr);
+		else
+			memcpy(ndev->dev_addr, ndev->perm_addr,
+			       IEEE802154_EXTENDED_ADDR_LEN);
 		break;
 	case NL802154_IFTYPE_MONITOR:
 		ndev->type = ARPHRD_IEEE802154_MONITOR;
@@ -489,9 +496,6 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		goto err;
 	}
 
-	ieee802154_le64_to_be64(ndev->perm_addr,
-				&local->hw.phy->perm_extended_addr);
-	memcpy(ndev->dev_addr, ndev->perm_addr, IEEE802154_EXTENDED_ADDR_LEN);
 	/* TODO check this */
 	SET_NETDEV_DEV(ndev, &local->phy->dev);
 	sdata = netdev_priv(ndev);
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index bbb19dd..8500378 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -161,7 +161,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
-	dev = ieee802154_if_add(local, "wpan%d", NL802154_IFTYPE_NODE);
+	dev = ieee802154_if_add(local, "wpan%d", NL802154_IFTYPE_NODE,
+				cpu_to_le64(0x0000000000000000ULL));
 	if (IS_ERR(dev)) {
 		rtnl_unlock();
 		rc = PTR_ERR(dev);
-- 
2.1.3

