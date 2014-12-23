Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:59519 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbaLWO3D (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:29:03 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so10999105wid.6
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:29:02 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/7] ieee802154: 6lowpan: cleanup frag dispatch cases
Date: Tue, 23 Dec 2014 15:28:28 +0100
Message-Id: <1419344909-16007-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch is a cleanup because case for LOWPAN_DISPATCH_FRAG1 and
LOWPAN_DISPATCH_FRAGN looks almost the same except the dispatch value
which is stored in a variables before now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 158756f..fc7228c 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -109,7 +109,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 
 		return lowpan_give_skb_to_devices(skb, NULL);
 	} else {
-		switch (*skb_network_header(skb) & 0xe0) {
+		u8 dispatch = *skb_network_header(skb) & 0xe0;
+
+		switch (dispatch) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
 			if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 				goto drop_skb;
@@ -120,18 +122,8 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 
 			return lowpan_give_skb_to_devices(skb, NULL);
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
-			if (ret == 1) {
-				ipv6_hdr(skb)->payload_len = htons(skb->len -
-								   sizeof(struct ipv6hdr));
-				return lowpan_give_skb_to_devices(skb, NULL);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
-			}
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
+			ret = lowpan_frag_rcv(skb, dispatch);
 			if (ret == 1) {
 				ipv6_hdr(skb)->payload_len = htons(skb->len -
 								   sizeof(struct ipv6hdr));
-- 
2.2.0

