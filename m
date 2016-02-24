Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:17415 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbcBXIc1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Feb 2016 03:32:27 -0500
From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] 6lowpan: fix error checking code
Date: Wed, 24 Feb 2016 09:32:13 +0100
Message-id: <1456302733-7053-1-git-send-email-a.hajda@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Bool variable 'fail' is always non-negative, it indicates an error if it
is true.

The problem has been detected using coccinelle script
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 net/6lowpan/iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index d2a565c..0fe954f 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -482,7 +482,7 @@ static int lowpan_uncompress_multicast_ctx_daddr(struct sk_buff *skb,
 	ipaddr->s6_addr[0] = 0xFF;
 	fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[1], 2);
 	fail |= lowpan_fetch_skb(skb, &ipaddr->s6_addr[12], 4);
-	if (fail < 0)
+	if (fail)
 		return -EIO;
 
 	/* take prefix_len and network prefix from the context */
-- 
1.9.1

