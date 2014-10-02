Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54454 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaJBI5N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 04:57:13 -0400
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan
Date: Thu,  2 Oct 2014 09:56:46 +0100
Message-Id: <1412240206-6098-4-git-send-email-simon.vincent@xsilon.com>
In-Reply-To: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: varkabhadram@gmail.com, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Simon Vincent <simon.vincent@xsilon.com>

There is no point processing pkts which are PACKET_OTHERHOST
in 6lowpan as they are discarded as soon as they reach the
ipv6 layer. Therefore we should drop them in the 6lowpan layer.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
---
 net/ieee802154/6lowpan_rtnl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index e246edc..820922a 100644
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
1.9.1

