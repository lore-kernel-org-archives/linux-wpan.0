Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:54853 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbaKETwP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:15 -0500
Received: by mail-wi0-f179.google.com with SMTP id h11so3082847wiw.6
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:14 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/18] ieee802154: remove mlme get_phy callback
Date: Wed,  5 Nov 2014 20:51:18 +0100
Message-Id: <1415217089-24919-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the get_phy callback from mlme ops structure. Instead
we doing a dereference via ieee802154_ptr dev pointer. For backwards
compatibility we need to run get_device after dereference wpan_phy via
ieee802154_ptr.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/ieee802154_netdev.h | 12 ------------
 net/ieee802154/6lowpan_rtnl.c   |  8 --------
 net/ieee802154/nl-mac.c         |  6 ++++--
 net/ieee802154/nl-phy.c         |  3 ++-
 net/mac802154/iface.c           |  1 -
 net/mac802154/mac_cmd.c         | 14 --------------
 6 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 5e62d75..83bb8a73 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -423,8 +423,6 @@ struct ieee802154_mlme_ops {
 
 	/* The fields below are required. */
 
-	struct wpan_phy *(*get_phy)(const struct net_device *dev);
-
 	/*
 	 * FIXME: these should become the part of PIB/MIB interface.
 	 * However we still don't have IB interface of any kind
@@ -434,16 +432,6 @@ struct ieee802154_mlme_ops {
 	u8 (*get_dsn)(const struct net_device *dev);
 };
 
-/* The IEEE 802.15.4 standard defines 2 type of the devices:
- * - FFD - full functionality device
- * - RFD - reduce functionality device
- *
- * So 2 sets of mlme operations are needed
- */
-struct ieee802154_reduced_mlme_ops {
-	struct wpan_phy *(*get_phy)(const struct net_device *dev);
-};
-
 static inline struct ieee802154_mlme_ops *
 ieee802154_mlme_ops(const struct net_device *dev)
 {
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 659f7b2..a96b64c 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -407,13 +407,6 @@ static netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 }
 
-static struct wpan_phy *lowpan_get_phy(const struct net_device *dev)
-{
-	struct net_device *real_dev = lowpan_dev_info(dev)->real_dev;
-
-	return ieee802154_mlme_ops(real_dev)->get_phy(real_dev);
-}
-
 static __le16 lowpan_get_pan_id(const struct net_device *dev)
 {
 	struct net_device *real_dev = lowpan_dev_info(dev)->real_dev;
@@ -465,7 +458,6 @@ static const struct net_device_ops lowpan_netdev_ops = {
 
 static struct ieee802154_mlme_ops lowpan_mlme = {
 	.get_pan_id = lowpan_get_pan_id,
-	.get_phy = lowpan_get_phy,
 	.get_short_addr = lowpan_get_short_addr,
 	.get_dsn = lowpan_get_dsn,
 };
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 91a1855..7127b9d 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -94,8 +94,9 @@ static int ieee802154_nl_fill_iface(struct sk_buff *msg, u32 portid,
 		goto out;
 
 	ops = ieee802154_mlme_ops(dev);
-	phy = ops->get_phy(dev);
+	phy = dev->ieee802154_ptr->wpan_phy;
 	BUG_ON(!phy);
+	get_device(&phy->dev);
 
 	short_addr = ops->get_short_addr(dev);
 	pan_id = ops->get_pan_id(dev);
@@ -493,7 +494,8 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 	    !info->attrs[IEEE802154_ATTR_FRAME_RETRIES])
 		goto out;
 
-	phy = ops->get_phy(dev);
+	phy = dev->ieee802154_ptr->wpan_phy;
+	get_device(&phy->dev);
 
 	ops->get_mac_params(dev, &params);
 
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 397ca126..80a946d 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -287,8 +287,9 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 	if (!dev)
 		return -ENODEV;
 
-	phy = ieee802154_mlme_ops(dev)->get_phy(dev);
+	phy = dev->ieee802154_ptr->wpan_phy;
 	BUG_ON(!phy);
+	get_device(&phy->dev);
 
 	rc = -EINVAL;
 	/* phy name is optional, but should be checked if it's given */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index f9ed608..2e2638e 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -428,7 +428,6 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	case IEEE802154_DEV_MONITOR:
 		sdata->dev->destructor = free_netdev;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
-		sdata->dev->ml_priv = &mac802154_mlme_reduced;
 		sdata->promisuous_mode = true;
 		break;
 	default:
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index e1ad83e..00b2b21 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -67,15 +67,6 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 	return rc;
 }
 
-static struct wpan_phy *mac802154_get_phy(const struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	return to_phy(get_device(&sdata->local->phy->dev));
-}
-
 static int mac802154_set_mac_params(struct net_device *dev,
 				    const struct ieee802154_mac_params *params)
 {
@@ -134,12 +125,7 @@ static struct ieee802154_llsec_ops mac802154_llsec_ops = {
 	.unlock_table = mac802154_unlock_table,
 };
 
-struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced = {
-	.get_phy = mac802154_get_phy,
-};
-
 struct ieee802154_mlme_ops mac802154_mlme_wpan = {
-	.get_phy = mac802154_get_phy,
 	.start_req = mac802154_mlme_start_req,
 	.get_pan_id = mac802154_dev_get_pan_id,
 	.get_short_addr = mac802154_dev_get_short_addr,
-- 
2.1.3

