Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:55062 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaKIHhj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:39 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so6642004wgg.16
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:38 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/15] ieee802154: netlink add rtnl lock
Date: Sun,  9 Nov 2014 08:36:57 +0100
Message-Id: <1415518619-4370-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds rtnl lock hold mechanism while accessing wpan_dev
attributes. Furthermore these attributes should be protected by rtnl
lock and netif_running only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl-mac.c |  6 ++++++
 net/mac802154/mac_cmd.c | 10 ++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 7127b9d..50e9863 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -113,7 +113,9 @@ static int ieee802154_nl_fill_iface(struct sk_buff *msg, u32 portid,
 	if (ops->get_mac_params) {
 		struct ieee802154_mac_params params;
 
+		rtnl_lock();
 		ops->get_mac_params(dev, &params);
+		rtnl_unlock();
 
 		if (nla_put_s8(msg, IEEE802154_ATTR_TXPOWER,
 			       params.transmit_power) ||
@@ -348,8 +350,10 @@ int ieee802154_start_req(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	rtnl_lock();
 	ret = ieee802154_mlme_ops(dev)->start_req(dev, &addr, channel, page,
 		bcn_ord, sf_ord, pan_coord, blx, coord_realign);
+	rtnl_unlock();
 
 	/* FIXME: add validation for unused parameters to be sane
 	 * for SoftMAC
@@ -497,6 +501,7 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 	phy = dev->ieee802154_ptr->wpan_phy;
 	get_device(&phy->dev);
 
+	rtnl_lock();
 	ops->get_mac_params(dev, &params);
 
 	if (info->attrs[IEEE802154_ATTR_TXPOWER])
@@ -524,6 +529,7 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 		params.frame_retries = nla_get_s8(info->attrs[IEEE802154_ATTR_FRAME_RETRIES]);
 
 	rc = ops->set_mac_params(dev, &params);
+	rtnl_unlock();
 
 	wpan_phy_put(phy);
 	dev_put(dev);
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index b8bd952..6aacb18 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -39,6 +39,8 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
 	int rc = 0;
 
+	ASSERT_RTNL();
+
 	BUG_ON(addr->mode != IEEE802154_ADDR_SHORT);
 
 	mac802154_dev_set_pan_id(dev, addr->pan_id);
@@ -75,7 +77,8 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	int ret;
 
-	mutex_lock(&sdata->local->iflist_mtx);
+	ASSERT_RTNL();
+
 	/* PHY */
 	wpan_dev->wpan_phy->transmit_power = params->transmit_power;
 	wpan_dev->wpan_phy->cca_mode = params->cca_mode;
@@ -87,7 +90,6 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	wpan_dev->csma_retries = params->csma_retries;
 	wpan_dev->frame_retries = params->frame_retries;
 	wpan_dev->lbt = params->lbt;
-	mutex_unlock(&sdata->local->iflist_mtx);
 
 	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
 		ret = drv_set_tx_power(local, params->transmit_power);
@@ -116,7 +118,8 @@ static void mac802154_get_mac_params(struct net_device *dev,
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 
-	mutex_lock(&sdata->local->iflist_mtx);
+	ASSERT_RTNL();
+
 	/* PHY */
 	params->transmit_power = wpan_dev->wpan_phy->transmit_power;
 	params->cca_mode = wpan_dev->wpan_phy->cca_mode;
@@ -128,7 +131,6 @@ static void mac802154_get_mac_params(struct net_device *dev,
 	params->csma_retries = wpan_dev->csma_retries;
 	params->frame_retries = wpan_dev->frame_retries;
 	params->lbt = wpan_dev->lbt;
-	mutex_unlock(&sdata->local->iflist_mtx);
 }
 
 static struct ieee802154_llsec_ops mac802154_llsec_ops = {
-- 
2.1.3

