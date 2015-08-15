Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34478 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbHOJBI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2015 05:01:08 -0400
Received: by wicne3 with SMTP id ne3so37996818wic.1
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2015 02:01:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] ieee802154: 6lowpan: fix non-lowpan wpan interfaces
Date: Sat, 15 Aug 2015 11:00:33 +0200
Message-Id: <1439629233-4328-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
References: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We receive all 802.15.4 frames on the packet handler "lowpan_rcv" this
patch checks if the wpan device belongs to a lowpan interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index d6f5e8e..12e1020 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -67,6 +67,10 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct ieee802154_hdr hdr;
 	int ret;
 
+	if (dev->type != ARPHRD_IEEE802154 ||
+	    !dev->ieee802154_ptr->lowpan_dev)
+		goto drop;
+
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
 		goto drop;
@@ -77,9 +81,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb->pkt_type == PACKET_OTHERHOST)
 		goto drop_skb;
 
-	if (dev->type != ARPHRD_IEEE802154)
-		goto drop_skb;
-
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		goto drop_skb;
 
-- 
2.5.0

