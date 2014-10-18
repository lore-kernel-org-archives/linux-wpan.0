Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:60460 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaJRHJb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 18 Oct 2014 03:09:31 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth-next 2/5] Fix process_data return values
Date: Sat, 18 Oct 2014 08:09:10 +0100
Message-Id: <1413616153-7562-3-git-send-email-mtownsend1973@gmail.com>
In-Reply-To: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <mtownsend1973@gmail.com>

As process_data now returns just error codes fix up the calls to this
function to only drop the skb if an error code is returned.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 net/bluetooth/6lowpan.c       | 2 +-
 net/ieee802154/6lowpan_rtnl.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 03787e0..702bf3c 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -347,7 +347,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 				goto drop;
 
 			ret = process_data(local_skb, dev, chan);
-			if (ret != NET_RX_SUCCESS)
+			if (ret < 0)
 				goto drop;
 
 			local_skb->protocol = htons(ETH_P_IPV6);
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 82ef0df..2c6bc36 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -533,14 +533,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
 			ret = process_data(skb, &hdr);
-			if (ret == NET_RX_DROP)
+			if (ret < 0)
 				goto drop;
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
 				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
+				if (ret < 0)
 					goto drop;
 			}
 			break;
@@ -548,7 +548,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
 				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
+				if (ret < 0)
 					goto drop;
 			}
 			break;
-- 
1.9.1

