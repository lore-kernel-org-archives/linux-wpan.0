Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48894 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751683AbcGYMPD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 08:15:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 4/4] mac802154: iface: remove ioctl functionality
Date: Mon, 25 Jul 2016 14:14:50 +0200
Message-Id: <20160725121450.4093-5-aar@pengutronix.de>
In-Reply-To: <20160725121450.4093-1-aar@pengutronix.de>
References: <20160725121450.4093-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch removed deprecated ioctl functionality. This functionality
offers to set not usual addresses: pan id and short address. When
setting the short address the user gets the info to not use SIOCSIFADDR
because it's not recommended.

This ioctl was a fast solution to offer the setting of pan and short
address. Nowadays we have nl802154.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/mac802154/iface.c | 64 ---------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9723099..4aed0f7 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -46,69 +46,6 @@ int mac802154_wpan_update_llsec(struct net_device *dev)
 	return mac802154_llsec_set_params(&sdata->sec, &params, changed);
 }
 
-static int
-mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
-	struct sockaddr_ieee802154 *sa =
-		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
-	int err = -ENOIOCTLCMD;
-
-	if (cmd != SIOCGIFADDR && cmd != SIOCSIFADDR)
-		return err;
-
-	rtnl_lock();
-
-	switch (cmd) {
-	case SIOCGIFADDR:
-	{
-		u16 pan_id, short_addr;
-
-		pan_id = le16_to_cpu(wpan_dev->pan_id);
-		short_addr = le16_to_cpu(wpan_dev->short_addr);
-		if (pan_id == IEEE802154_PANID_BROADCAST ||
-		    short_addr == IEEE802154_ADDR_BROADCAST) {
-			err = -EADDRNOTAVAIL;
-			break;
-		}
-
-		sa->family = AF_IEEE802154;
-		sa->addr.addr_type = IEEE802154_ADDR_SHORT;
-		sa->addr.pan_id = pan_id;
-		sa->addr.short_addr = short_addr;
-
-		err = 0;
-		break;
-	}
-	case SIOCSIFADDR:
-		if (netif_running(dev)) {
-			rtnl_unlock();
-			return -EBUSY;
-		}
-
-		dev_warn(&dev->dev,
-			 "Using DEBUGing ioctl SIOCSIFADDR isn't recommended!\n");
-		if (sa->family != AF_IEEE802154 ||
-		    sa->addr.addr_type != IEEE802154_ADDR_SHORT ||
-		    sa->addr.pan_id == IEEE802154_PANID_BROADCAST ||
-		    sa->addr.short_addr == IEEE802154_ADDR_BROADCAST ||
-		    sa->addr.short_addr == IEEE802154_ADDR_UNDEF) {
-			err = -EINVAL;
-			break;
-		}
-
-		wpan_dev->pan_id = cpu_to_le16(sa->addr.pan_id);
-		wpan_dev->short_addr = cpu_to_le16(sa->addr.short_addr);
-
-		err = mac802154_wpan_update_llsec(dev);
-		break;
-	}
-
-	rtnl_unlock();
-	return err;
-}
-
 static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
@@ -504,7 +441,6 @@ static const struct net_device_ops mac802154_wpan_ops = {
 	.ndo_open		= mac802154_wpan_open,
 	.ndo_stop		= mac802154_slave_close,
 	.ndo_start_xmit		= ieee802154_subif_start_xmit,
-	.ndo_do_ioctl		= mac802154_wpan_ioctl,
 	.ndo_set_mac_address	= mac802154_wpan_mac_addr,
 };
 
-- 
2.9.0

