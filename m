Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34239 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbbHCGXr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:47 -0400
Received: by wibud3 with SMTP id ud3so121964954wib.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 04/16] ieee802154: 6lowpan: remove check on wdev is running
Date: Mon,  3 Aug 2015 08:23:43 +0200
Message-Id: <1438583035-6287-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We don't need to check if the wpan interface is running because the
lowpan_rcv is the packet layer receive handler for thw wpan interface.
This means for the check if the wpan interface is running ends always in
true.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 6302b94..99aeb56 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -71,9 +71,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	if (!skb)
 		goto drop;
 
-	if (!netif_running(wdev))
-		goto drop_skb;
-
 	if (skb->pkt_type == PACKET_OTHERHOST)
 		goto drop_skb;
 
-- 
2.5.0

