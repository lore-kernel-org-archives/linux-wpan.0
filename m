Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36600 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbHTQve (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:34 -0400
Received: by wicja10 with SMTP id ja10so150528561wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:33 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 09/16] ieee802154: 6lowpan: earlier skb->dev switch
Date: Thu, 20 Aug 2015 18:47:38 +0200
Message-Id: <1440089265-23366-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We should change the skb->dev pointer earlier to the lowpan interface
Sometimes we call iphc_decompress which also use some netdev printout
functionality. This patch will change that the correct interface will be
displayed in this case, which should be the lowpan interface.

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
2.5.0

