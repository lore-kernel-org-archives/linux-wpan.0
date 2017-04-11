Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35948 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbdDKTVN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2017 15:21:13 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 6/6] bluetooth: Do not set IFF_POINTOPOINT
Date: Tue, 11 Apr 2017 22:21:03 +0300
Message-Id: <20170411192103.3209-6-luiz.dentz@gmail.com>
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Patrik Flykt <patrik.flykt@linux.intel.com>

The IPv6 stack needs to send and receive Neighbor Discovery
messages. Remove the IFF_POINTOPOINT flag.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index a4deba6..6089599 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -592,8 +592,7 @@ static void netdev_setup(struct net_device *dev)
 {
 	dev->hard_header_len	= 0;
 	dev->needed_tailroom	= 0;
-	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
-				  IFF_MULTICAST;
+	dev->flags		= IFF_RUNNING | IFF_MULTICAST;
 	dev->watchdog_timeo	= 0;
 	dev->tx_queue_len	= DEFAULT_TX_QUEUE_LEN;
 
-- 
2.9.3

