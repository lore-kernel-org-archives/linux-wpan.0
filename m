Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35087 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbaJGD4w (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 23:56:52 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so4292722pdj.26
        for <linux-wpan@vger.kernel.org>; Mon, 06 Oct 2014 20:56:52 -0700 (PDT)
From: varkabhadram@gmail.com
Subject: [PATCH wpan-next] 6lowpan: cleanup for lowpan_rcv
Date: Tue,  7 Oct 2014 09:24:15 +0530
Message-Id: <1412654055-15368-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

From: Varka Bhadram <varkab@cdac.in>

Instead of collecting the return value into 'ret' variable and
checking the perticular return value specifically, this patch
remove these by directly including function within 'if' statement

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/ieee802154/6lowpan_rtnl.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index c7e07b8..38772d4 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -507,7 +507,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		      struct packet_type *pt, struct net_device *orig_dev)
 {
 	struct ieee802154_hdr hdr;
-	int ret;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
@@ -533,31 +532,23 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
 
-		ret = lowpan_give_skb_to_devices(skb, NULL);
-		if (ret == NET_RX_DROP)
+		if (lowpan_give_skb_to_devices(skb, NULL))
 			goto drop;
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = process_data(skb, &hdr);
-			if (ret == NET_RX_DROP)
+			if (process_data(skb, &hdr))
 				goto drop;
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
-			if (ret == 1) {
-				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
+			if (lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1))
+				if (process_data(skb, &hdr))
 					goto drop;
-			}
 			break;
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
-			if (ret == 1) {
-				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
+			if (lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN))
+				if (process_data(skb, &hdr))
 					goto drop;
-			}
 			break;
 		default:
 			break;
-- 
1.7.9.5

