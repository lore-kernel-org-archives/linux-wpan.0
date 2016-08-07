Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55200 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752054AbcHGOdG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:06 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 16/19] 6lowpan: iphc: add handling for btle
Date: Sun,  7 Aug 2016 16:30:53 +0200
Message-Id: <20160807143056.3116-17-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch adds right handling for uncompress/compress L3 addresses
which are compressed by BTLE L2 address.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index fb5f6fa..e93f656 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -50,6 +50,7 @@
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 
+#include <net/bluetooth/bluetooth.h>
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
 
@@ -186,6 +187,27 @@ lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 	}
 }
 
+static inline void
+lowpan_iphc_uncompress_btle_lladdr(struct in6_addr *ipaddr, const void *lladdr)
+{
+	bdaddr_t be_bdaddr;
+
+	/* ipv6 addr needs big endian form here
+	 * TODO make src in baswap const?
+	 */
+	baswap(&be_bdaddr, (bdaddr_t *)lladdr);
+
+	ipaddr->s6_addr[0] = 0xFE;
+	ipaddr->s6_addr[1] = 0x80;
+
+	memcpy(&ipaddr->s6_addr[8], be_bdaddr.b, 3);
+	memcpy(&ipaddr->s6_addr[13], be_bdaddr.b + 3, 3);
+
+	ipaddr->s6_addr[11] = 0xFF;
+	ipaddr->s6_addr[12] = 0xFE;
+	ipaddr->s6_addr[8] ^= 2;
+}
+
 static struct lowpan_iphc_ctx *
 lowpan_iphc_ctx_get_by_id(const struct net_device *dev, u8 id)
 {
@@ -315,11 +337,19 @@ static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
 	case LOWPAN_IPHC_SAM_11:
 	case LOWPAN_IPHC_DAM_11:
 		fail = false;
+		/* TODO this can work to work as length here, ipv6 addrconf
+		 * has similar functionality to generate autoconfigured
+		 * addresses - use shared code here.
+		 */
 		switch (lowpan_dev(dev)->lltype) {
 		case LOWPAN_LLTYPE_IEEE802154:
 			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
+		case LOWPAN_LLTYPE_BTLE:
+			lowpan_iphc_uncompress_btle_lladdr(ipaddr, lladdr);
+			break;
 		default:
+			/* TODO remove? */
 			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
 			break;
 		}
@@ -380,6 +410,9 @@ static int lowpan_iphc_uncompress_ctx_addr(struct sk_buff *skb,
 		case LOWPAN_LLTYPE_IEEE802154:
 			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
+		case LOWPAN_LLTYPE_BTLE:
+			lowpan_iphc_uncompress_btle_lladdr(ipaddr, lladdr);
+			break;
 		default:
 			lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
 			break;
@@ -810,6 +843,29 @@ lowpan_iphc_compress_ctx_802154_lladdr(const struct in6_addr *ipaddr,
 	return lladdr_compress;
 }
 
+static inline bool
+lowpan_iphc_compress_ctx_btle_lladdr(const struct in6_addr *ipaddr,
+				     const struct lowpan_iphc_ctx *ctx,
+				     const void *lladdr)
+{
+	struct in6_addr tmp = {};
+	bdaddr_t be_bdaddr;
+
+	/* ipv6 addr needs big endian form here */
+	baswap(&be_bdaddr, (bdaddr_t *)lladdr);
+
+	memcpy(&tmp.s6_addr[8], be_bdaddr.b, 3);
+	memcpy(&tmp.s6_addr[13], be_bdaddr.b + 3, 3);
+
+	tmp.s6_addr[11] = 0xFF;
+	tmp.s6_addr[12] = 0xFE;
+	tmp.s6_addr[8] ^= 2;
+
+	/* context information are always used */
+	ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
+	return ipv6_addr_equal(&tmp, ipaddr);
+}
+
 static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
 				   const struct in6_addr *ipaddr,
 				   const struct lowpan_iphc_ctx *ctx,
@@ -826,6 +882,13 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
 			goto out;
 		}
 		break;
+	case LOWPAN_LLTYPE_BTLE:
+		if (lowpan_iphc_compress_ctx_btle_lladdr(ipaddr, ctx,
+							 lladdr)) {
+			dam = LOWPAN_IPHC_DAM_11;
+			goto out;
+		}
+		break;
 	default:
 		/* check for SAM/DAM = 11 */
 		memcpy(&tmp.s6_addr[8], lladdr, EUI64_ADDR_LEN);
@@ -886,6 +949,7 @@ lowpan_iphc_compress_802154_lladdr(const struct in6_addr *ipaddr,
 	switch (addr->mode) {
 	case IEEE802154_ADDR_LONG:
 		ieee802154_le64_to_be64(&extended_addr, &addr->extended_addr);
+		/* TODO remove this macro and use ipv6_addr_equal */
 		if (is_addr_mac_addr_based(ipaddr, extended_addr))
 			lladdr_compress = true;
 		break;
@@ -914,12 +978,38 @@ lowpan_iphc_compress_802154_lladdr(const struct in6_addr *ipaddr,
 	return lladdr_compress;
 }
 
+static inline bool
+lowpan_iphc_compress_btle_lladdr(const struct in6_addr *ipaddr,
+				 const void *lladdr)
+{
+	struct in6_addr tmp = {};
+	bdaddr_t be_bdaddr;
+
+	/* ipv6 addr needs big endian form here */
+	baswap(&be_bdaddr, (bdaddr_t *)lladdr);
+
+	tmp.s6_addr[0] = 0xFE;
+	tmp.s6_addr[1] = 0x80;
+
+	memcpy(&tmp.s6_addr[8], be_bdaddr.b, 3);
+	memcpy(&tmp.s6_addr[13], be_bdaddr.b + 3, 3);
+
+	tmp.s6_addr[11] = 0xFF;
+	tmp.s6_addr[12] = 0xFE;
+	tmp.s6_addr[8] ^= 2;
+
+	return ipv6_addr_equal(&tmp, ipaddr);
+}
+
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct net_device *dev,
 				  const struct in6_addr *ipaddr,
 				  const unsigned char *lladdr, bool sam)
 {
 	u8 dam = LOWPAN_IPHC_DAM_01;
 
+	/* TODO share code with compress ctx stuff here, stateless compress
+	 * is the same like stateful except the prefix must be fe80::/64
+	 */
 	switch (lowpan_dev(dev)->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_iphc_compress_802154_lladdr(ipaddr, lladdr)) {
@@ -928,7 +1018,15 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct net_device *dev,
 			goto out;
 		}
 		break;
+	case LOWPAN_LLTYPE_BTLE:
+		if (lowpan_iphc_compress_btle_lladdr(ipaddr, lladdr)) {
+			dam = LOWPAN_IPHC_DAM_11; /* 0-bits */
+			pr_debug("address compression 0 bits\n");
+			goto out;
+		}
+		break;
 	default:
+		/* TODO remove? */
 		if (is_addr_mac_addr_based(ipaddr, lladdr)) {
 			dam = LOWPAN_IPHC_DAM_11; /* 0-bits */
 			pr_debug("address compression 0 bits\n");
@@ -1100,6 +1198,11 @@ static u8 lowpan_iphc_mcast_addr_compress(u8 **hc_ptr,
 	return val;
 }
 
+/* TODO maybe handle directly saddr, daddr as big endian? unnecessary byteswaps.
+ * Neighbour cachane and dev->dev_addr is big endian saved, don't use l2 format
+ * here maybe? Cons: Will confuse everything, because lladdr are saved always
+ * in format as mac header format. Same for lowpan_header_decompress.
+ */
 int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 			   const void *daddr, const void *saddr)
 {
-- 
2.9.2

