Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shell.v3.sk ([90.176.6.54]:45152 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933423AbeGBJbP (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 2 Jul 2018 05:31:15 -0400
From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ieee802154: 6lowpan: set IFLA_LINK
Date: Mon,  2 Jul 2018 11:21:47 +0200
Message-Id: <20180702092147.56331-1-lkundrak@v3.sk>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Lubomir Rintel <lkundrak@v3.sk>

Otherwise NetworkManager (and iproute alike) is not able to identify the
parent IEEE 802.15.4 interface of a 6LoWPAN link.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 net/ieee802154/6lowpan/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 275449b0d633..3297e7fa9945 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -90,12 +90,18 @@ static int lowpan_neigh_construct(struct net_device *dev, struct neighbour *n)
 	return 0;
 }
 
+static int lowpan_get_iflink(const struct net_device *dev)
+{
+	return lowpan_802154_dev(dev)->wdev->ifindex;
+}
+
 static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_init		= lowpan_dev_init,
 	.ndo_start_xmit		= lowpan_xmit,
 	.ndo_open		= lowpan_open,
 	.ndo_stop		= lowpan_stop,
 	.ndo_neigh_construct    = lowpan_neigh_construct,
+	.ndo_get_iflink         = lowpan_get_iflink,
 };
 
 static void lowpan_setup(struct net_device *ldev)
-- 
2.17.1

