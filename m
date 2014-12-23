Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33781 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbaLWO3D (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:29:03 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so9129509wgg.25
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:29:01 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/7] ieee802154: 6lowpan: handle fragmented IPv6
Date: Tue, 23 Dec 2014 15:28:27 +0100
Message-Id: <1419344909-16007-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds handling for a fragmented uncompressed 6LoWPAN packet.
In case that the IPHC compression is above MTU 127, we should not run
IPHC compression. This is still a bug in transmit functionality that we
don't support that, but also not a bug because in worst-case we didn't
hit the case that IPHC compression doesn't fit into a single 802.15.4
frame. Nevertheless this patch adds this handling for receive functionality
only, so other 6LoWPAN stacks can send uncompressed fragmented 6LoWPAN
packets.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/reassembly.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index c76c0cb..d47b34e 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -209,15 +209,21 @@ found:
 			goto err;
 
 		/* TODO use CALL_RXH when parsing rework is done. */
-		switch (*skb_network_header(skb) & 0xe0) {
-		case LOWPAN_DISPATCH_IPHC:
-			/* uncompress ipv6 header */
-			ret = iphc_decompress(skb, &hdr);
-			if (ret < 0)
+		if (*skb_network_header(skb) == LOWPAN_DISPATCH_IPV6) {
+			/* Pull off the 1-byte of 6lowpan header. */
+			if (lowpan_fetch_skb(skb, NULL, 1))
 				goto err;
-			break;
-		default:
-			goto err;
+		} else {
+			switch (*skb_network_header(skb) & 0xe0) {
+			case LOWPAN_DISPATCH_IPHC:
+				/* uncompress ipv6 header */
+				ret = iphc_decompress(skb, &hdr);
+				if (ret < 0)
+					goto err;
+				break;
+			default:
+				goto err;
+			}
 		}
 
 		fq->q.flags |= INET_FRAG_FIRST_IN;
-- 
2.2.0

