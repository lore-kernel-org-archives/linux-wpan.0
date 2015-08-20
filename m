Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33270 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbbHTQvd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:33 -0400
Received: by wijp15 with SMTP id p15so21303022wij.0
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:32 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 08/16] ieee802154: 6lowpan: trivial checks at first
Date: Thu, 20 Aug 2015 18:47:37 +0200
Message-Id: <1440089265-23366-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves some trivial checks at first before calling
skb_share_check which could do some memcpy if the buffer is shared.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 4ddf694..74d8fec 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -63,7 +63,8 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	struct net_device *ldev;
 	int ret;
 
-	if (wdev->type != ARPHRD_IEEE802154)
+	if (wdev->type != ARPHRD_IEEE802154 ||
+	    skb->pkt_type == PACKET_OTHERHOST)
 		goto drop;
 
 	ldev = wdev->ieee802154_ptr->lowpan_dev;
@@ -74,9 +75,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	if (!skb)
 		goto drop;
 
-	if (skb->pkt_type == PACKET_OTHERHOST)
-		goto drop_skb;
-
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		goto drop_skb;
 
-- 
2.5.0

