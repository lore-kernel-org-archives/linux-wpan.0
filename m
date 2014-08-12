Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62485 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaHLNOf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:35 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so7988104lan.33
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:07 +0200
Message-Id: <1407849255-11500-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 03/11] mac802154: remove not functional monitor device
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This is broken in many ways, drop the current monitor device support and
later we will implement a new implement for this.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/nl802154.h  |   1 -
 net/mac802154/Makefile    |   2 +-
 net/mac802154/mac802154.h |   3 --
 net/mac802154/main.c      |   5 --
 net/mac802154/monitor.c   | 117 ----------------------------------------------
 net/mac802154/rx.c        |   1 -
 net/mac802154/tx.c        |   2 -
 7 files changed, 1 insertion(+), 130 deletions(-)
 delete mode 100644 net/mac802154/monitor.c

diff --git a/include/linux/nl802154.h b/include/linux/nl802154.h
index 20163b9..fe775e3 100644
--- a/include/linux/nl802154.h
+++ b/include/linux/nl802154.h
@@ -174,7 +174,6 @@ enum {
 	__IEEE802154_DEV_INVALID = -1,
 
 	IEEE802154_DEV_WPAN,
-	IEEE802154_DEV_MONITOR,
 
 	__IEEE802154_DEV_MAX,
 };
diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 1ecbc47..5f54676 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   monitor.o wpan.o llsec.o
+			   wpan.o llsec.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/mac802154.h b/net/mac802154/mac802154.h
index 6375a39..1c4fb8f 100644
--- a/net/mac802154/mac802154.h
+++ b/net/mac802154/mac802154.h
@@ -113,9 +113,6 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 int mac802154_slave_open(struct net_device *dev);
 int mac802154_slave_close(struct net_device *dev);
 
-void mac802154_monitors_rx(struct mac802154_priv *priv, struct sk_buff *skb);
-void mac802154_monitor_setup(struct net_device *dev);
-
 void mac802154_wpans_rx(struct mac802154_priv *priv, struct sk_buff *skb);
 void mac802154_wpan_setup(struct net_device *dev);
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 645a994..1e68e49 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -161,11 +161,6 @@ mac802154_add_iface(struct wpan_phy *phy, const char *name, int type)
 	int err = -ENOMEM;
 
 	switch (type) {
-	case IEEE802154_DEV_MONITOR:
-		dev = alloc_netdev(sizeof(struct mac802154_sub_if_data),
-				   name, NET_NAME_UNKNOWN,
-				   mac802154_monitor_setup);
-		break;
 	case IEEE802154_DEV_WPAN:
 		dev = alloc_netdev(sizeof(struct mac802154_sub_if_data),
 				   name, NET_NAME_UNKNOWN,
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
deleted file mode 100644
index a68230e..0000000
--- a/net/mac802154/monitor.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * Copyright 2007, 2008, 2009 Siemens AG
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Written by:
- * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
- * Sergey Lapin <slapin@ossfans.org>
- * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
- * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
- */
-
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/if_arp.h>
-#include <linux/crc-ccitt.h>
-
-#include <net/ieee802154.h>
-#include <net/mac802154.h>
-#include <net/netlink.h>
-#include <net/wpan-phy.h>
-#include <linux/nl802154.h>
-
-#include "mac802154.h"
-
-static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
-					  struct net_device *dev)
-{
-	struct mac802154_sub_if_data *priv;
-	u8 chan, page;
-
-	priv = netdev_priv(dev);
-
-	/* FIXME: locking */
-	chan = priv->hw->phy->current_channel;
-	page = priv->hw->phy->current_page;
-
-	if (chan == MAC802154_CHAN_NONE) /* not initialized */
-		return NETDEV_TX_OK;
-
-	if (WARN_ON(page >= WPAN_NUM_PAGES) ||
-	    WARN_ON(chan >= WPAN_NUM_CHANNELS))
-		return NETDEV_TX_OK;
-
-	skb->skb_iif = dev->ifindex;
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-
-	return mac802154_tx(priv->hw, skb, page, chan);
-}
-
-
-void mac802154_monitors_rx(struct mac802154_priv *priv, struct sk_buff *skb)
-{
-	struct sk_buff *skb2;
-	struct mac802154_sub_if_data *sdata;
-	u16 crc = crc_ccitt(0, skb->data, skb->len);
-	u8 *data;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &priv->slaves, list) {
-		if (sdata->type != IEEE802154_DEV_MONITOR ||
-		    !netif_running(sdata->dev))
-			continue;
-
-		skb2 = skb_clone(skb, GFP_ATOMIC);
-		skb2->dev = sdata->dev;
-		skb2->pkt_type = PACKET_HOST;
-		data = skb_put(skb2, 2);
-		data[0] = crc & 0xff;
-		data[1] = crc >> 8;
-
-		netif_rx_ni(skb2);
-	}
-	rcu_read_unlock();
-}
-
-static const struct net_device_ops mac802154_monitor_ops = {
-	.ndo_open		= mac802154_slave_open,
-	.ndo_stop		= mac802154_slave_close,
-	.ndo_start_xmit		= mac802154_monitor_xmit,
-};
-
-void mac802154_monitor_setup(struct net_device *dev)
-{
-	struct mac802154_sub_if_data *priv;
-
-	dev->addr_len		= 0;
-	dev->hard_header_len	= 0;
-	dev->needed_tailroom	= 2; /* room for FCS */
-	dev->mtu		= IEEE802154_MTU;
-	dev->tx_queue_len	= 10;
-	dev->type		= ARPHRD_IEEE802154_MONITOR;
-	dev->flags		= IFF_NOARP | IFF_BROADCAST;
-	dev->watchdog_timeo	= 0;
-
-	dev->destructor		= free_netdev;
-	dev->netdev_ops		= &mac802154_monitor_ops;
-	dev->ml_priv		= &mac802154_mlme_reduced;
-
-	priv = netdev_priv(dev);
-	priv->type = IEEE802154_DEV_MONITOR;
-
-	priv->chan = MAC802154_CHAN_NONE; /* not initialized */
-	priv->page = 0;
-}
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 574290d..48f1523 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -74,7 +74,6 @@ mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
 		skb_trim(skb, skb->len - 2); /* CRC */
 	}
 
-	mac802154_monitors_rx(priv, skb);
 	mac802154_wpans_rx(priv, skb);
 
 	return;
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index fdf4c0e6..bacb6ce 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -92,8 +92,6 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, struct sk_buff *skb,
 		goto err_tx;
 	}
 
-	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
-
 	if (!(priv->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 		u8 *data = skb_put(skb, 2);
-- 
2.0.3

