Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35255 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbIBMWM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:12 -0400
Received: by wicge5 with SMTP id ge5so38850509wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/16] ieee802154: 6lowpan: earlier skb->dev switch
Date: Wed,  2 Sep 2015 14:21:24 +0200
Message-Id: <1441196491-25013-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We should change the skb->dev pointer earlier to the lowpan interface
Sometimes we call iphc_decompress which also use some netdev printout
functionality. This patch will change that the correct interface will be
displayed in this case, which should be the lowpan interface.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 74d8fec..f9cb70b 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -18,7 +18,6 @@
 static int lowpan_give_skb_to_device(struct sk_buff *skb,
 				     struct net_device *wdev)
 {
-	skb->dev = wdev->ieee802154_ptr->lowpan_dev;
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->pkt_type = PACKET_HOST;
 
@@ -71,9 +70,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	if (!ldev || !netif_running(ldev))
 		goto drop;
 
+	/* Replacing skb->dev and followed rx handlers will manipulate skb. */
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
 		goto drop;
+	skb->dev = ldev;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		goto drop_skb;
-- 
2.5.1

