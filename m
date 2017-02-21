Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36814 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdBUKiT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 21 Feb 2017 05:38:19 -0500
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v3 2/5] 6lowpan: Set MAC address lenght according to LOWPAN_LLTYPE
Date: Tue, 21 Feb 2017 12:38:07 +0200
Message-Id: <20170221103811.1506-3-luiz.dentz@gmail.com>
In-Reply-To: <20170221103811.1506-1-luiz.dentz@gmail.com>
References: <20170221103811.1506-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Patrik Flykt <patrik.flykt@linux.intel.com>

Set MAC address length according to the 6LoWPAN link layer in use.
Bluetooth Low Energy uses 48 bit addressing while IEEE802.15.4 uses
64 bits.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 net/6lowpan/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 5945f7e..5f9909a 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -23,7 +23,16 @@ int lowpan_register_netdevice(struct net_device *dev,
 {
 	int i, ret;
 
-	dev->addr_len = EUI64_ADDR_LEN;
+	switch (lltype) {
+	case LOWPAN_LLTYPE_IEEE802154:
+		dev->addr_len = EUI64_ADDR_LEN;
+		break;
+
+	case LOWPAN_LLTYPE_BTLE:
+		dev->addr_len = ETH_ALEN;
+		break;
+	}
+
 	dev->type = ARPHRD_6LOWPAN;
 	dev->mtu = IPV6_MIN_MTU;
 	dev->priv_flags |= IFF_NO_QUEUE;
-- 
2.9.3

