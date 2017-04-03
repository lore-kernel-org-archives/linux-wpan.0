Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36680 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbdDCOtE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Apr 2017 10:49:04 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 2/3] Bluetooth: 6lowpan: Print errors during recv_pkt
Date: Mon,  3 Apr 2017 17:48:56 +0300
Message-Id: <20170403144857.4661-2-luiz.dentz@gmail.com>
In-Reply-To: <20170403144857.4661-1-luiz.dentz@gmail.com>
References: <20170403144857.4661-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes should make it more clear why a packet is being dropped.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2063e96..5b91e85 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -337,6 +337,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 
 		ret = iphc_decompress(local_skb, dev, peer);
 		if (ret < 0) {
+			BT_DBG("iphc_decompress failed: %d", ret);
 			kfree_skb(local_skb);
 			goto drop;
 		}
@@ -356,6 +357,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		consume_skb(local_skb);
 		consume_skb(skb);
 	} else {
+		BT_DBG("unknown packet type");
 		goto drop;
 	}
 
-- 
2.9.3

