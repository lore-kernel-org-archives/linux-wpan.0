Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35124 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbbI3IUX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 04:20:23 -0400
Received: by wicge5 with SMTP id ge5so184828324wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2015 01:20:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: 6lowpan: add tx/rx stats
Date: Wed, 30 Sep 2015 10:20:11 +0200
Message-Id: <1443601211-27790-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
References: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for increment transmit and receive stats. The
meaning of these stats are IPv6 based, which shows the stats after
running the 6lowpan adaptation layer (uncompression/compression,
fragmentation handling) on receive and before the adaptation layer
when transmit.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 2 ++
 net/ieee802154/6lowpan/tx.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index b1fd47d..65d55e0 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -29,6 +29,8 @@
 static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
 	skb->protocol = htons(ETH_P_IPV6);
+	skb->dev->stats.rx_packets++;
+	skb->dev->stats.rx_bytes += skb->len;
 
 	return netif_rx(skb);
 }
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 3b665e1..5736302 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -192,6 +192,8 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
 		}
 	} while (skb_unprocessed > frag_cap);
 
+	ldev->stats.tx_packets++;
+	ldev->stats.tx_bytes += dgram_size;
 	consume_skb(skb);
 	return NET_XMIT_SUCCESS;
 
@@ -277,6 +279,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 
 	if (skb_tail_pointer(skb) - skb_network_header(skb) <= max_single) {
 		skb->dev = lowpan_dev_info(ldev)->wdev;
+		ldev->stats.tx_packets++;
+		ldev->stats.tx_bytes += dgram_size;
 		return dev_queue_xmit(skb);
 	} else {
 		netdev_tx_t rc;
-- 
2.6.0

