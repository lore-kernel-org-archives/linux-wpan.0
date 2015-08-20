Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37874 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbbHTQva (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:30 -0400
Received: by widdq5 with SMTP id dq5so11577011wid.0
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:29 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 06/16] ieee802154: 6lowpan: change if lowpan dev is running
Date: Thu, 20 Aug 2015 18:47:35 +0200
Message-Id: <1440089265-23366-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We don't need to check if the wpan interface is running because the
lowpan_rcv is the packet layer receive handler for the wpan interface.

Instead doing a check if wpan interface is running we should check if
the lowpan interface is running before starting 6lowpan adaptation layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index b1442f3..c529d9f 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -65,19 +65,20 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 		      struct packet_type *pt, struct net_device *orig_wdev)
 {
 	struct ieee802154_hdr hdr;
+	struct net_device *ldev;
 	int ret;
 
-	if (wdev->type != ARPHRD_IEEE802154 ||
-	    !wdev->ieee802154_ptr->lowpan_dev)
+	if (wdev->type != ARPHRD_IEEE802154)
+		goto drop;
+
+	ldev = wdev->ieee802154_ptr->lowpan_dev;
+	if (!ldev || !netif_running(ldev))
 		goto drop;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
 		goto drop;
 
-	if (!netif_running(wdev))
-		goto drop_skb;
-
 	if (skb->pkt_type == PACKET_OTHERHOST)
 		goto drop_skb;
 
-- 
2.5.0

