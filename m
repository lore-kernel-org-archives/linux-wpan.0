Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51161 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070AbcHGOdG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:06 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 17/19] 6lowpan: move multicast flags to generic
Date: Sun,  7 Aug 2016 16:30:54 +0200
Message-Id: <20160807143056.3116-18-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

These flags should be all the same for 6LoWPAN so move it to 6LoWPAN generic.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/core.c            | 1 +
 net/ieee802154/6lowpan/core.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index a978000..6b7de14 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -62,6 +62,7 @@ int lowpan_register_netdevice(struct net_device *dev,
 	dev->type = ARPHRD_6LOWPAN;
 	dev->mtu = IPV6_MIN_MTU;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->flags = IFF_BROADCAST | IFF_MULTICAST;
 
 	dev->header_ops = &header_ops;
 
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 228a711..a60abad 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -92,7 +92,6 @@ static void lowpan_setup(struct net_device *ldev)
 	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
 	/* We need an ipv6hdr as minimum len when calling xmit */
 	ldev->hard_header_len	= sizeof(struct ipv6hdr);
-	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->destructor	= free_netdev;
-- 
2.9.2

