Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63316 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaKDOsc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 09:48:32 -0500
From: Simon Vincent <simon.vincent@xsilon.com>
Subject: [PATCHv2 bluetooth-next] 6lowpan: fix udp header compression when using raw sockets
Date: Tue,  4 Nov 2014 14:48:23 +0000
Message-Id: <1415112503-2053-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Simon Vincent <simon.vincent@xsilon.com>

If you use RAW sockets the transport header offset is not set by the
ipv6 stack so when we get to the udp header compression it does not
compress the right part of the packet.

This patch adds a check for this scenario and sets the transport
header offset.

Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
---
 net/6lowpan/iphc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 73a7065..305bf2b 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -512,9 +512,17 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 
 static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
 {
-	struct udphdr *uh = udp_hdr(skb);
+	struct udphdr *uh;
 	u8 tmp;
 
+	/* In the case of RAW sockets the transport header is not set by
+	 * the ip6 stack so we must set it ourselves
+	 */
+	if (skb->transport_header == skb->network_header)
+		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+
+	uh = udp_hdr(skb);
+
 	if (((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_MASK) ==
 	     LOWPAN_NHC_UDP_4BIT_PORT) &&
 	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==
-- 
1.9.1

