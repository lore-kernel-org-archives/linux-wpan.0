Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35539 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbK2Lfa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 29 Nov 2015 06:35:30 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv3 bluetooth-next 3/4] ipv6: add ipv6_addr_prefix_copy
Date: Sun, 29 Nov 2015 12:34:41 +0100
Message-Id: <1448796882-316-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1448796882-316-1-git-send-email-alex.aring@gmail.com>
References: <1448796882-316-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, Alexander Aring <alex.aring@gmail.com>, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

This patch adds a static inline function ipv6_addr_prefix_copy which
copies a ipv6 address prefix(argument pfx) into the ipv6 address prefix.
The prefix len is given by plen as bits. This function mainly based on
ipv6_addr_prefix which copies one address prefix from address into a new
ipv6 address destination and zero all other address bits.

The difference is that ipv6_addr_prefix_copy don't get a prefix from an
ipv6 address, it sets a prefix to an ipv6 address with keeping other
address bits. The use case is for context based address compression
inside 6LoWPAN IPHC header which keeping ipv6 prefixes inside a context
table to lookup address-bits without sending them.

Cc: David S. Miller <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: James Morris <jmorris@namei.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Patrick McHardy <kaber@trash.net>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/ipv6.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index e1a10b0..cd3881e6 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -382,6 +382,21 @@ static inline void ipv6_addr_prefix(struct in6_addr *pfx,
 		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
 }
 
+static inline void ipv6_addr_prefix_copy(struct in6_addr *addr,
+					 const struct in6_addr *pfx,
+					 int plen)
+{
+	/* caller must guarantee 0 <= plen <= 128 */
+	int o = plen >> 3,
+	    b = plen & 0x7;
+
+	memcpy(addr->s6_addr, pfx, o);
+	if (b != 0) {
+		addr->s6_addr[o] &= ~(0xff00 >> b);
+		addr->s6_addr[o] |= (pfx->s6_addr[o] & (0xff00 >> b));
+	}
+}
+
 static inline void __ipv6_addr_set_half(__be32 *addr,
 					__be32 wh, __be32 wl)
 {
-- 
2.6.1

