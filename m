Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36607 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbbHCGXu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:50 -0400
Received: by wicgj17 with SMTP id gj17so89916964wic.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:48 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 06/16] ieee802154: 6lowpan: trivial checks at first
Date: Mon,  3 Aug 2015 08:23:45 +0200
Message-Id: <1438583035-6287-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves some trivial checks at first before calling
skb_share_check which could do some memcpy if the buffer is shared.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 7b6b038..11a5629 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -62,16 +62,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	struct ieee802154_hdr hdr;
 	int ret;
 
+	if (skb->pkt_type == PACKET_OTHERHOST ||
+	    wdev->type != ARPHRD_IEEE802154)
+		goto drop;
+
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
 		goto drop;
 
-	if (skb->pkt_type == PACKET_OTHERHOST)
-		goto drop_skb;
-
-	if (wdev->type != ARPHRD_IEEE802154)
-		goto drop_skb;
-
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		goto drop_skb;
 
-- 
2.5.0

