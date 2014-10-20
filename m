Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45838 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbaJTOkH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 10:40:07 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v2 bluetooth-next 2/4] 6lowpan: fix process_data return values
Date: Mon, 20 Oct 2014 15:39:49 +0100
Message-Id: <1413815991-5078-3-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1413815991-5078-1-git-send-email-martin.townsend@xsilon.com>
References: <1413815991-5078-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>

As process_data now returns just error codes fix up the calls to this
function to only drop the skb if an error code is returned.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
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
index 898d317..a160d0b 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -539,14 +539,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
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
@@ -554,7 +554,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
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

