Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:49356 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaHLNOg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:36 -0400
Received: by mail-la0-f44.google.com with SMTP id el20so6962794lab.3
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:35 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:08 +0200
Message-Id: <1407849255-11500-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 04/11] ieee802154: add new interface types
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds the new interface types NODE, MONITOR and COORD.
The NODE has the identically number like WPAN_DEV and should be backwards
compatible with current userspace tools.

This patch is part of getting wireless feeling into the ieee802154
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/nl802154.h | 12 ++++++++----
 net/ieee802154/nl-phy.c  |  4 ++--
 net/mac802154/main.c     |  4 ++--
 net/mac802154/wpan.c     |  4 ++--
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/nl802154.h b/include/linux/nl802154.h
index fe775e3..3058544 100644
--- a/include/linux/nl802154.h
+++ b/include/linux/nl802154.h
@@ -170,12 +170,16 @@ enum {
 
 #define IEEE802154_CMD_MAX (__IEEE802154_CMD_MAX - 1)
 
-enum {
-	__IEEE802154_DEV_INVALID = -1,
+enum nl802154_iftype {
+	NL802154_IFTYPE_UNSPEC = -1,
 
-	IEEE802154_DEV_WPAN,
+	NL802154_IFTYPE_NODE,
+	NL802154_IFTYPE_MONITOR,
+	NL802154_IFTYPE_COORD,
 
-	__IEEE802154_DEV_MAX,
+	/* keep last */
+	NUM_NL802154_IFTYPES,
+	NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
 };
 
 #endif
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 972baf8..b4f1bd8 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -176,7 +176,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 	const char *devname;
 	int rc = -ENOBUFS;
 	struct net_device *dev;
-	int type = __IEEE802154_DEV_INVALID;
+	enum nl802154_iftype type = NL802154_IFTYPE_UNSPEC;
 
 	pr_debug("%s\n", __func__);
 
@@ -221,7 +221,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[IEEE802154_ATTR_DEV_TYPE]) {
 		type = nla_get_u8(info->attrs[IEEE802154_ATTR_DEV_TYPE]);
-		if (type >= __IEEE802154_DEV_MAX) {
+		if (type > NL802154_IFTYPE_MAX) {
 			rc = -EINVAL;
 			goto nla_put_failure;
 		}
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 1e68e49..639916e 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -38,7 +38,7 @@ int mac802154_slave_open(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	if (priv->type == IEEE802154_DEV_WPAN) {
+	if (priv->type == NL802154_IFTYPE_NODE) {
 		mutex_lock(&priv->hw->slaves_mtx);
 		list_for_each_entry(subif, &priv->hw->slaves, list) {
 			if (subif != priv && subif->type == priv->type &&
@@ -161,7 +161,7 @@ mac802154_add_iface(struct wpan_phy *phy, const char *name, int type)
 	int err = -ENOMEM;
 
 	switch (type) {
-	case IEEE802154_DEV_WPAN:
+	case NL802154_IFTYPE_NODE:
 		dev = alloc_netdev(sizeof(struct mac802154_sub_if_data),
 				   name, NET_NAME_UNKNOWN,
 				   mac802154_wpan_setup);
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index ce17570..b6f7f75 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -389,7 +389,7 @@ void mac802154_wpan_setup(struct net_device *dev)
 	dev->ml_priv		= &mac802154_mlme_wpan;
 
 	priv = netdev_priv(dev);
-	priv->type = IEEE802154_DEV_WPAN;
+	priv->type = NL802154_IFTYPE_NODE;
 
 	priv->chan = MAC802154_CHAN_NONE;
 	priv->page = 0;
@@ -580,7 +580,7 @@ void mac802154_wpans_rx(struct mac802154_priv *priv, struct sk_buff *skb)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &priv->slaves, list) {
-		if (sdata->type != IEEE802154_DEV_WPAN ||
+		if (sdata->type != NL802154_IFTYPE_NODE ||
 		    !netif_running(sdata->dev))
 			continue;
 
-- 
2.0.3

