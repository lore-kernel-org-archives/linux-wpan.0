Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34351 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbdDKTVM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2017 15:21:12 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 5/6] Bluetooth: 6lowpan: Set tx_queue_len to DEFAULT_TX_QUEUE_LEN
Date: Tue, 11 Apr 2017 22:21:02 +0300
Message-Id: <20170411192103.3209-5-luiz.dentz@gmail.com>
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make netdev queue packets if we run out of credits.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index dc7fda3..a4deba6 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -20,6 +20,7 @@
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
+#include <net/pkt_sched.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -594,6 +595,7 @@ static void netdev_setup(struct net_device *dev)
 	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
 				  IFF_MULTICAST;
 	dev->watchdog_timeo	= 0;
+	dev->tx_queue_len	= DEFAULT_TX_QUEUE_LEN;
 
 	dev->netdev_ops		= &netdev_ops;
 	dev->header_ops		= &header_ops;
-- 
2.9.3

