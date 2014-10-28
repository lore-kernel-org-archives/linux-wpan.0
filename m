Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55449 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaJ1RWK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:10 -0400
Received: by mail-lb0-f173.google.com with SMTP id l4so1028084lbv.32
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/17] mac802154: iface: remove assign to zero
Date: Tue, 28 Oct 2014 18:21:28 +0100
Message-Id: <1414516892-4107-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

These variables should already be zero, so we remove the extra assign to
zero.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index e10fd78..2423aa7 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -409,7 +409,6 @@ void mac802154_wpan_setup(struct net_device *dev)
 	dev->tx_queue_len	= 300;
 	dev->type		= ARPHRD_IEEE802154;
 	dev->flags		= IFF_NOARP | IFF_BROADCAST;
-	dev->watchdog_timeo	= 0;
 
 	dev->destructor		= mac802154_wpan_free;
 	dev->netdev_ops		= &mac802154_wpan_ops;
@@ -419,7 +418,6 @@ void mac802154_wpan_setup(struct net_device *dev)
 	sdata->type = IEEE802154_DEV_WPAN;
 
 	sdata->chan = MAC802154_CHAN_NONE;
-	sdata->page = 0;
 
 	spin_lock_init(&sdata->mib_lock);
 	mutex_init(&sdata->sec_mtx);
@@ -444,14 +442,11 @@ void mac802154_monitor_setup(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata;
 
-	dev->addr_len		= 0;
-	dev->hard_header_len	= 0;
 	dev->needed_tailroom	= 2; /* room for FCS */
 	dev->mtu		= IEEE802154_MTU;
 	dev->tx_queue_len	= 10;
 	dev->type		= ARPHRD_IEEE802154_MONITOR;
 	dev->flags		= IFF_NOARP | IFF_BROADCAST;
-	dev->watchdog_timeo	= 0;
 
 	dev->destructor		= free_netdev;
 	dev->netdev_ops		= &mac802154_monitor_ops;
@@ -461,5 +456,4 @@ void mac802154_monitor_setup(struct net_device *dev)
 	sdata->type = IEEE802154_DEV_MONITOR;
 
 	sdata->chan = MAC802154_CHAN_NONE; /* not initialized */
-	sdata->page = 0;
 }
-- 
2.1.2

