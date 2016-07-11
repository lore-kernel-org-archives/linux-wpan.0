Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50354 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752585AbcGKTvW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:22 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 19/20] 6lowpan: delete addr_len handling to generic
Date: Mon, 11 Jul 2016 21:50:43 +0200
Message-Id: <20160711195044.25343-20-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

The address length for BTLE 6LoWPAN is not 8 bytes, it's 6 bytes. We
need to move this setting away from generic branch.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/core.c            | 1 -
 net/ieee802154/6lowpan/core.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 6b7de14..e03cecf 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -58,7 +58,6 @@ int lowpan_register_netdevice(struct net_device *dev,
 {
 	int i, ret;
 
-	dev->addr_len = EUI64_ADDR_LEN;
 	dev->type = ARPHRD_6LOWPAN;
 	dev->mtu = IPV6_MIN_MTU;
 	dev->priv_flags |= IFF_NO_QUEUE;
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index a60abad..c97eb7a 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -134,6 +134,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	}
 
 	lowpan_802154_dev(ldev)->wdev = wdev;
+	ldev->addr_len = IEEE802154_ADDR_LEN;
 	/* Set the lowpan hardware address to the wpan hardware address. */
 	memcpy(ldev->dev_addr, wdev->dev_addr, IEEE802154_ADDR_LEN);
 	/* We need headroom for possible wpan_dev_hard_header call and tailroom
-- 
2.9.0

