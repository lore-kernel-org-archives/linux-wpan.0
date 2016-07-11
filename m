Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36423 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752468AbcGKTvR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:17 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 05/20] 6lowpan: remove LOWPAN_IPHC_MAX_HEADER_LEN
Date: Mon, 11 Jul 2016 21:50:29 +0200
Message-Id: <20160711195044.25343-6-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

My observations with btle 6lowpan was that such parameter doesn't
exists. IPHC will not increase the packet size of IPv6 afterwards, but
decrease it.

I thought about that LOWPAN_IPHC are the 2 bytes headers, but we will
always save two bytes because the payload_length of ipv6 will be elided.

Then I thought the CID byte will increase the payload at one byte, this
is correct but when we add the CID byte, we need to compress at
worst-case 8 bytes.

After that I thought the nhc id will be at least increase currently the
payload to one byte. This is correct, but when we set the NHC bit, then
we save one byte because ipv6 next header byte will be elided. That's
why everything should be fine until we have NHC's which have two bytes
length until or NHC compression use more bytes than raw next header
format.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h         | 7 -------
 net/ieee802154/6lowpan/core.c | 6 ++----
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 6d56be7..7f4b63c 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -68,15 +68,8 @@
  * possible inline data.
  */
 #define LOWPAN_NHC_MAX_HDR_LEN	(sizeof(struct udphdr))
-/* Max IPHC Header len without IPv6 hdr specific inline data.
- * Useful for getting the "extra" bytes we need at worst case compression.
- *
- * LOWPAN_IPHC + CID + LOWPAN_NHC_MAX_ID_LEN
- */
-#define LOWPAN_IPHC_MAX_HEADER_LEN	(2 + 1 + LOWPAN_NHC_MAX_ID_LEN)
 /* Maximum worst case IPHC header buffer size */
 #define LOWPAN_IPHC_MAX_HC_BUF_LEN	(sizeof(struct ipv6hdr) +	\
-					 LOWPAN_IPHC_MAX_HEADER_LEN +	\
 					 LOWPAN_NHC_MAX_HDR_LEN)
 /* SCI/DCI is 4 bit width, so we have maximum 16 entries */
 #define LOWPAN_IPHC_CTX_TABLE_SIZE	(1 << 4)
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 6afb8cd..f70edcc 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -152,11 +152,9 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	/* We need headroom for possible wpan_dev_hard_header call and tailroom
 	 * for encryption/fcs handling. The lowpan interface will replace
 	 * the IPv6 header with 6LoWPAN header. At worst case the 6LoWPAN
-	 * header has LOWPAN_IPHC_MAX_HEADER_LEN more bytes than the IPv6
-	 * header.
+	 * header has one byte more for possible raw IPv6 dispatch.
 	 */
-	ldev->needed_headroom = LOWPAN_IPHC_MAX_HEADER_LEN +
-				wdev->needed_headroom;
+	ldev->needed_headroom = 1 + wdev->needed_headroom;
 	ldev->needed_tailroom = wdev->needed_tailroom;
 
 	ldev->neigh_priv_len = sizeof(struct lowpan_802154_neigh);
-- 
2.9.0

