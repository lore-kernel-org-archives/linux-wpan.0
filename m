Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55865 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753848AbcDKJE3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:29 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 07/11] 6lowpan: iphc: rename add lowpan prefix
Date: Mon, 11 Apr 2016 11:04:20 +0200
Message-Id: <1460365464-12435-8-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch adds a lowpan prefix to each functions which doesn't have
such prefix currently.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 56 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 5fb764e..66b4139 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -156,8 +156,8 @@
 #define LOWPAN_IPHC_CID_DCI(cid)	(cid & 0x0f)
 #define LOWPAN_IPHC_CID_SCI(cid)	((cid & 0xf0) >> 4)
 
-static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
-						const void *lladdr)
+static inline void lowpan_iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
+						       const void *lladdr)
 {
 	/* fe:80::XXXX:XXXX:XXXX:XXXX
 	 *        \_________________/
@@ -172,8 +172,9 @@ static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
 	ipaddr->s6_addr[8] ^= 0x02;
 }
 
-static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
-						 const void *lladdr)
+static inline void
+lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
+				     const void *lladdr)
 {
 	const struct ieee802154_addr *addr = lladdr;
 	u8 eui64[EUI64_ADDR_LEN] = { };
@@ -181,7 +182,7 @@ static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 	switch (addr->mode) {
 	case IEEE802154_ADDR_LONG:
 		ieee802154_le64_to_be64(eui64, &addr->extended_addr);
-		iphc_uncompress_eui64_lladdr(ipaddr, eui64);
+		lowpan_iphc_uncompress_eui64_lladdr(ipaddr, eui64);
 		break;
 	case IEEE802154_ADDR_SHORT:
 		/* fe:80::ff:fe00:XXXX
@@ -301,9 +302,10 @@ lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
  *
  * address_mode is the masked value for sam or dam value
  */
-static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
-			   struct in6_addr *ipaddr, u8 address_mode,
-			   const void *lladdr)
+static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
+				       const struct net_device *dev,
+				       struct in6_addr *ipaddr,
+				       u8 address_mode, const void *lladdr)
 {
 	bool fail;
 
@@ -334,10 +336,10 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 		fail = false;
 		switch (lowpan_dev(dev)->lltype) {
 		case LOWPAN_LLTYPE_IEEE802154:
-			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
+			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
 		default:
-			iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
+			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
 			break;
 		}
 		break;
@@ -360,11 +362,11 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 /* Uncompress address function for source context
  * based address(non-multicast).
  */
-static int uncompress_ctx_addr(struct sk_buff *skb,
-			       const struct net_device *dev,
-			       const struct lowpan_iphc_ctx *ctx,
-			       struct in6_addr *ipaddr, u8 address_mode,
-			       const void *lladdr)
+static int lowpan_iphc_uncompress_ctx_addr(struct sk_buff *skb,
+					   const struct net_device *dev,
+					   const struct lowpan_iphc_ctx *ctx,
+					   struct in6_addr *ipaddr,
+					   u8 address_mode, const void *lladdr)
 {
 	bool fail;
 
@@ -395,10 +397,10 @@ static int uncompress_ctx_addr(struct sk_buff *skb,
 		fail = false;
 		switch (lowpan_dev(dev)->lltype) {
 		case LOWPAN_LLTYPE_IEEE802154:
-			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
+			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
 		default:
-			iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
+			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
 			break;
 		}
 		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
@@ -665,14 +667,16 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		}
 
 		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
-					  iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
+		err = lowpan_iphc_uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
+						      iphc1 & LOWPAN_IPHC_SAM_MASK,
+						      saddr);
 		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
-		err = uncompress_addr(skb, dev, &hdr.saddr,
-				      iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
+		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.saddr,
+						  iphc1 & LOWPAN_IPHC_SAM_MASK,
+						  saddr);
 	}
 
 	/* Check on error of previous branch */
@@ -710,13 +714,15 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 
 		/* Destination address context based uncompression */
 		pr_debug("DAC bit is set. Handle context based destination address.\n");
-		err = uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
-					  iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
+		err = lowpan_iphc_uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
+						      iphc1 & LOWPAN_IPHC_DAM_MASK,
+						      daddr);
 		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 		break;
 	default:
-		err = uncompress_addr(skb, dev, &hdr.daddr,
-				      iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
+		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.daddr,
+						  iphc1 & LOWPAN_IPHC_DAM_MASK,
+						  daddr);
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
 			 iphc1 & LOWPAN_IPHC_DAM_MASK, &hdr.daddr);
 		break;
-- 
2.8.0

