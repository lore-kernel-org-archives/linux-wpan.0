Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37432 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbbIBMWJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:09 -0400
Received: by wicfx3 with SMTP id fx3so17118167wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/16] ieee802154: 6lowpan: change if lowpan dev is running
Date: Wed,  2 Sep 2015 14:21:21 +0200
Message-Id: <1441196491-25013-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We don't need to check if the wpan interface is running because the
lowpan_rcv is the packet layer receive handler for the wpan interface.

Instead doing a check if wpan interface is running we should check if
the lowpan interface is running before starting 6lowpan adaptation layer.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
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
2.5.1

