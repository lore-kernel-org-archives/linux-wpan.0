Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56795 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaJBI5N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 04:57:13 -0400
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCH linux-wpan 1/3] 6lowpan: Ensure pkt_type is not lost
Date: Thu,  2 Oct 2014 09:56:44 +0100
Message-Id: <1412240206-6098-2-git-send-email-simon.vincent@xsilon.com>
In-Reply-To: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: varkabhadram@gmail.com, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Simon Vincent <simon.vincent@xsilon.com>

Remove line which overrrides pkt_type to PACKET_HOST

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
---
 net/6lowpan/iphc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 142eef5..002cd7c 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -189,7 +189,6 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
 
 	new->protocol = htons(ETH_P_IPV6);
-	new->pkt_type = PACKET_HOST;
 	new->dev = dev;
 
 	raw_dump_table(__func__, "raw skb data dump before receiving",
-- 
1.9.1

