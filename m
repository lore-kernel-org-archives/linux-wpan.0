Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:59757 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaKBDTV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:21 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so3948611wib.7
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/16] mac802154: set extended address filter on ifup
Date: Sun,  2 Nov 2014 04:18:41 +0100
Message-Id: <1414898327-20759-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the setting of hardware extended address filtering
inside of interface up instead doing it directly inside of netlink interface.
Also we don't need to set the sdata extended attribute in netlink. This
is already done by ndo_set_mac_address of net_device_ops.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  1 -
 net/mac802154/iface.c        | 10 +++++++++-
 net/mac802154/mac_cmd.c      |  1 -
 net/mac802154/mib.c          | 14 --------------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 39af6ea..27e17e6 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -135,7 +135,6 @@ ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev);
 /* MIB callbacks */
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
 __le16 mac802154_dev_get_short_addr(const struct net_device *dev);
-void mac802154_dev_set_ieee_addr(struct net_device *dev);
 __le16 mac802154_dev_get_pan_id(const struct net_device *dev);
 void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val);
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index f7a6f83..a509a71 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -110,6 +110,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 {
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct sockaddr *addr = p;
 
 	if (netif_running(dev))
@@ -117,7 +118,8 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 
 	/* FIXME: validate addr */
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
-	mac802154_dev_set_ieee_addr(dev);
+	sdata->extended_addr = ieee802154_netdev_to_extended_addr(dev->dev_addr);
+
 	return mac802154_wpan_update_llsec(dev);
 }
 
@@ -202,6 +204,12 @@ static int mac802154_wpan_open(struct net_device *dev)
 			goto out;
 	}
 
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		rc = drv_set_extended_addr(local, sdata->extended_addr);
+		if (rc < 0)
+			goto out;
+	}
+
 	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
 		rc = drv_set_tx_power(local, sdata->mac_params.transmit_power);
 		if (rc < 0)
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index fc261ab..90c1ad8 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -43,7 +43,6 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 
 	mac802154_dev_set_pan_id(dev, addr->pan_id);
 	mac802154_dev_set_short_addr(dev, addr->short_addr);
-	mac802154_dev_set_ieee_addr(dev);
 	mac802154_dev_set_page_channel(dev, page, channel);
 
 	if (ops->llsec) {
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 0184fce..cfd4f65 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -102,20 +102,6 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 	return ret;
 }
 
-void mac802154_dev_set_ieee_addr(struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct ieee802154_local *local = sdata->local;
-
-	sdata->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
-
-	if (local->ops->set_hw_addr_filt &&
-	    local->hw.hw_filt.ieee_addr != sdata->extended_addr) {
-		local->hw.hw_filt.ieee_addr = sdata->extended_addr;
-		set_hw_addr_filt(dev, IEEE802154_AFILT_IEEEADDR_CHANGED);
-	}
-}
-
 __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-- 
2.1.3

