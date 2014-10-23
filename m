Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35514 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbaJWOlP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Oct 2014 10:41:15 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v5 bluetooth-next 2/4] 6lowpan: fix process_data return values
Date: Thu, 23 Oct 2014 15:40:54 +0100
Message-Id: <1414075256-9448-3-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
References: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>

As process_data now returns just error codes fix up the calls to this
function to only drop the skb if an error code is returned.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 net/bluetooth/6lowpan.c       | 2 +-
 net/ieee802154/6lowpan_rtnl.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 45d9a9f..94bbb66 100644
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
index 09feacf..577597d 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -542,7 +542,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
 			ret = process_data(skb, &hdr);
-			if (ret == NET_RX_DROP)
+			if (ret < 0)
 				goto drop;
 
 			return lowpan_give_skb_to_devices(skb, NULL);
@@ -550,7 +550,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
 				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
+				if (ret < 0)
 					goto drop;
 
 				return lowpan_give_skb_to_devices(skb, NULL);
@@ -563,7 +563,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
 				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
+				if (ret < 0)
 					goto drop;
 
 				return lowpan_give_skb_to_devices(skb, NULL);
-- 
1.9.1

