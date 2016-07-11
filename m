Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47608 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512AbcGKTvV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:21 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 16/20] ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration
Date: Mon, 11 Jul 2016 21:50:40 +0200
Message-Id: <20160711195044.25343-17-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch adds support for 48 bit 6LoWPAN address length
autoconfiguration which is the case for BTLE 6LoWPAN.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ipv6/addrconf.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index a1f6b7b..aab9b0d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2007,12 +2007,21 @@ static void addrconf_leave_anycast(struct inet6_ifaddr *ifp)
 	__ipv6_dev_ac_dec(ifp->idev, &addr);
 }
 
-static int addrconf_ifid_eui64(u8 *eui, struct net_device *dev)
+static int addrconf_ifid_6lowpan(u8 *eui, struct net_device *dev)
 {
-	if (dev->addr_len != EUI64_ADDR_LEN)
+	switch (dev->addr_len) {
+	case ETH_ALEN:
+		return addrconf_ifid_eui48(eui, dev);
+	case EUI64_ADDR_LEN:
+		if (dev->addr_len != EUI64_ADDR_LEN)
+			return -1;
+		memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
+		eui[0] ^= 2;
+		break;
+	default:
 		return -1;
-	memcpy(eui, dev->dev_addr, EUI64_ADDR_LEN);
-	eui[0] ^= 2;
+	}
+
 	return 0;
 }
 
@@ -2103,7 +2112,7 @@ static int ipv6_generate_eui64(u8 *eui, struct net_device *dev)
 	case ARPHRD_IPGRE:
 		return addrconf_ifid_gre(eui, dev);
 	case ARPHRD_6LOWPAN:
-		return addrconf_ifid_eui64(eui, dev);
+		return addrconf_ifid_6lowpan(eui, dev);
 	case ARPHRD_IEEE1394:
 		return addrconf_ifid_ieee1394(eui, dev);
 	case ARPHRD_TUNNEL6:
-- 
2.9.0

