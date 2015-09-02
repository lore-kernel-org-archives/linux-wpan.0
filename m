Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34296 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbbIBMWT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:19 -0400
Received: by wicfx3 with SMTP id fx3so15721639wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/16] ieee802154: 6lowpan: remove packet type to host
Date: Wed,  2 Sep 2015 14:21:30 +0200
Message-Id: <1441196491-25013-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch remove the packet_type to host and leave the mac pkt_type.
By running 'grep -r "pkt_type" net/ipv6', the IPv6 stack will evaluate
this value for PACKET_BROADCAST. Instead of overwriting this value we
will leave the mac value there which is broadcasts if the mac frame was
a broadcast frame.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index f7eb091..856052b 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -29,7 +29,6 @@
 static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->pkt_type = PACKET_HOST;
 
 	return netif_rx(skb);
 }
-- 
2.5.1

