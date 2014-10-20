Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:42176 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbaJTOkJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 10:40:09 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v2 bluetooth-next 3/4] bluetooth:6lowpan: use consume_skb when packet processed successfully
Date: Mon, 20 Oct 2014 15:39:50 +0100
Message-Id: <1413815991-5078-4-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1413815991-5078-1-git-send-email-martin.townsend@xsilon.com>
References: <1413815991-5078-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <mtownsend1973@gmail.com>, Martin Townsend <martin.townsend@xsilon.com>

From: Martin Townsend <mtownsend1973@gmail.com>

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 net/bluetooth/6lowpan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 702bf3c..6c3182f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -337,8 +337,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		dev->stats.rx_bytes += skb->len;
 		dev->stats.rx_packets++;
 
-		kfree_skb(local_skb);
-		kfree_skb(skb);
+		consume_skb(local_skb);
+		consume_skb(skb);
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
@@ -363,7 +363,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 			dev->stats.rx_bytes += skb->len;
 			dev->stats.rx_packets++;
 
-			kfree_skb(skb);
+			consume_skb(local_skb);
+			consume_skb(skb);
 			break;
 		default:
 			break;
-- 
1.9.1

