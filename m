Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40446 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101AbcHGOdH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:07 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 18/19] 6lowpan: move addr_len setting away from generic
Date: Sun,  7 Aug 2016 16:30:55 +0200
Message-Id: <20160807143056.3116-19-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

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
2.9.2

