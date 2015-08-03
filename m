Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37762 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbHCGYL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:24:11 -0400
Received: by wibud3 with SMTP id ud3so99356374wib.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:24:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 16/16] ieee802154: 6lowpan: remove packet type to host
Date: Mon,  3 Aug 2015 08:23:55 +0200
Message-Id: <1438583035-6287-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch remove the packet_type to host and leave the mac pkt_type.
By running 'grep -r "pkt_type" net/ipv6', the IPv6 stack will evaluate
this value for PACKET_BROADCAST. Instead of overwriting this value we
will leave the mac value there which is broadcasts if the mac frame was
a broadcast frame.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index b1a9d14..1d9866a 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -56,7 +56,6 @@ static int lowpan_give_skb_to_device(struct sk_buff *skb)
 	int ret;
 
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->pkt_type = PACKET_HOST;
 
 	ret = netif_rx(skb);
 	/* kfree_skb handled by netif_rx, so RX_DROP on failure */
-- 
2.5.0

