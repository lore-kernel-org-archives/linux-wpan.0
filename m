Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37902 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaJRHJd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 18 Oct 2014 03:09:33 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth-next 3/5] Use consume_skb when packet processed successfully.
Date: Sat, 18 Oct 2014 08:09:11 +0100
Message-Id: <1413616153-7562-4-git-send-email-mtownsend1973@gmail.com>
In-Reply-To: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <mtownsend1973@gmail.com>

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 702bf3c..ec68706 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -363,7 +363,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 			dev->stats.rx_bytes += skb->len;
 			dev->stats.rx_packets++;
 
-			kfree_skb(skb);
+			consume_skb(skb);
 			break;
 		default:
 			break;
-- 
1.9.1

