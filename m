Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52975 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaJBI5P (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 04:57:15 -0400
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCH linux-wpan 2/3] ieee802154: 6lowpan: Ensure pkt_type is not lost
Date: Thu,  2 Oct 2014 09:56:45 +0100
Message-Id: <1412240206-6098-3-git-send-email-simon.vincent@xsilon.com>
In-Reply-To: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: varkabhadram@gmail.com, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Simon Vincent <simon.vincent@xsilon.com>

Remove line which overrides pkt_type to PACKET_HOST

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
---
 net/ieee802154/6lowpan_rtnl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 4413629..e246edc 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -524,7 +524,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	/* check that it's our buffer */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
 		skb->protocol = htons(ETH_P_IPV6);
-		skb->pkt_type = PACKET_HOST;
 
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
-- 
1.9.1

