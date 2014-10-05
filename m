Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35230 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaJESXa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Oct 2014 14:23:30 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan
Date: Sun,  5 Oct 2014 20:23:12 +0200
Message-Id: <1412533392-4072-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
References: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Simon Vincent <simon.vincent@xsilon.com>, Alexander Aring <alex.aring@gmail.com>

From: Simon Vincent <simon.vincent@xsilon.com>

There is no point processing pkts which are PACKET_OTHERHOST
in 6lowpan as they are discarded as soon as they reach the
ipv6 layer. Therefore we should drop them in the 6lowpan layer.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 4413629..56252ee 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -515,6 +515,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!netif_running(dev))
 		goto drop_skb;
 
+	if (skb->pkt_type == PACKET_OTHERHOST)
+		goto drop_skb;
+
 	if (dev->type != ARPHRD_IEEE802154)
 		goto drop_skb;
 
-- 
2.1.2

