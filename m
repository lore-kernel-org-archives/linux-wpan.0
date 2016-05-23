Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43012 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459AbcEWTXB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 23 May 2016 15:23:01 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC 01/12] 6lowpan: add private neighbour data
Date: Mon, 23 May 2016 21:21:57 +0200
Message-Id: <1464031328-17524-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
References: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, "David S . Miller" <davem@davemloft.net>

This patch will introduce a 6lowpan neighbour private data. Like the
interface private data we handle private data for generic 6lowpan and
for link-layer specific 6lowpan.

The current first use case if to save the short address for a 802.15.4
6lowpan neighbour.

Cc: David S. Miller <davem@davemloft.net>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/linux/netdevice.h     |  3 +--
 include/net/6lowpan.h         | 10 ++++++++++
 net/ieee802154/6lowpan/core.c | 12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c148edf..42737c4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1484,8 +1484,7 @@ enum netdev_priv_flags {
  * 	@perm_addr:		Permanent hw address
  * 	@addr_assign_type:	Hw address assignment type
  * 	@addr_len:		Hardware address length
- * 	@neigh_priv_len;	Used in neigh_alloc(),
- * 				initialized only in atm/clip.c
+ *	@neigh_priv_len:	Used in neigh_alloc()
  * 	@dev_id:		Used to differentiate devices that share
  * 				the same link layer address
  * 	@dev_port:		Used to differentiate devices that share
diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index da84cf9..2d9b9d3 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -141,6 +141,16 @@ struct lowpan_dev {
 	u8 priv[0] __aligned(sizeof(void *));
 };
 
+struct lowpan_802154_neigh {
+	__le16 short_addr;
+};
+
+static inline
+struct lowpan_802154_neigh *lowpan_802154_neigh(void *neigh_priv)
+{
+	return neigh_priv;
+}
+
 static inline
 struct lowpan_dev *lowpan_dev(const struct net_device *dev)
 {
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index dd085db..dcc0d59 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -92,11 +92,21 @@ static int lowpan_stop(struct net_device *dev)
 	return 0;
 }
 
+static int lowpan_neigh_construct(struct neighbour *n)
+{
+	struct lowpan_802154_neigh *neigh = lowpan_802154_neigh(neighbour_priv(n));
+
+	/* default no short_addr is available for a neighbour */
+	neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	return 0;
+}
+
 static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_init		= lowpan_dev_init,
 	.ndo_start_xmit		= lowpan_xmit,
 	.ndo_open		= lowpan_open,
 	.ndo_stop		= lowpan_stop,
+	.ndo_neigh_construct    = lowpan_neigh_construct,
 };
 
 static void lowpan_setup(struct net_device *ldev)
@@ -161,6 +171,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 				wdev->needed_headroom;
 	ldev->needed_tailroom = wdev->needed_tailroom;
 
+	ldev->neigh_priv_len = sizeof(struct lowpan_802154_neigh);
+
 	ret = lowpan_register_netdevice(ldev, LOWPAN_LLTYPE_IEEE802154);
 	if (ret < 0) {
 		dev_put(wdev);
-- 
2.8.2

