Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:21936 "EHLO
	ironport01.nordicsemi.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbbGMLuq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jul 2015 07:50:46 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [RFC v2 3/4] 6lowpan: Add stateful compression support for iphc.c
Date: Mon, 13 Jul 2015 13:50:32 +0200
Message-ID: <1436788233-13960-4-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Make use of stateful compression implemented in context.c.
The code does not impact current stateless compression.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/6lowpan/iphc.c | 232 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 196 insertions(+), 36 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index c845a8a..48267e9 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -56,10 +56,63 @@
 #include <net/af_ieee802154.h>
 
 #include "nhc.h"
+#include "context.h"
+
+#define CTX_SRC(context)  ((context & 0xf0) >> 4)
+#define CTX_DEST(context) (context & 0x0f)
+#define CID_NOT_USED      0xff
 
 struct dentry *lowpan_debugfs;
 EXPORT_SYMBOL_GPL(lowpan_debugfs);
 
+/* Add context prefix into given IPv6 address.
+ * Context prefix is always used, therefore any original bits can be
+ * overwritten.
+ */
+static inline void add_cid_prefix(struct in6_addr *ipaddr,
+				  struct lowpan_context_entry *ctx_entry)
+{
+	int o = ctx_entry->prefix_len >> 3;
+	int b = ctx_entry->prefix_len & 0x7;
+
+	memcpy(ipaddr->s6_addr, ctx_entry->prefix.s6_addr, o);
+
+	if (b != 0)
+		ipaddr->s6_addr[o] = ctx_entry->prefix.s6_addr[o] &
+				     (0xff00 >> b);
+}
+
+/* Check if address can be fully compressed with stateful compression. */
+static inline bool is_iid_compressable(struct in6_addr *ipaddr,
+				       unsigned int ctx_length,
+				       u8 *lladdr)
+{
+	unsigned int start_byte, offset;
+
+	/* Context covers IPv6 address by its size. */
+	if (ctx_length == 128)
+		return true;
+
+	/* Check if IID can be retrieved when prefix is longer than 64 bits. */
+	if (ctx_length > 64) {
+		/* Check only IID bytes that are not covered by context. */
+		start_byte = ctx_length >> 3;
+		offset = ctx_length % 8;
+
+		/* Check all bytes from the second one. */
+		if (start_byte == 15 ||
+		    !memcmp(&ipaddr->s6_addr[start_byte + 1],
+			    &lladdr[start_byte - 7],
+			    15 - start_byte)) {
+			/* Then check first byte. */
+			return (u8)(ipaddr->s6_addr[start_byte] << offset) ==
+			       (u8)(lladdr[start_byte - 8] << offset);
+		}
+	}
+
+	return false;
+}
+
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
@@ -141,34 +194,82 @@ static int uncompress_addr(struct sk_buff *skb,
 	return 0;
 }
 
-/* Uncompress address function for source context
- * based address(non-multicast).
- */
-static int uncompress_context_based_src_addr(struct sk_buff *skb,
-					     struct in6_addr *ipaddr,
-					     const u8 sam)
+/* Uncompress address after stateful compression. */
+static int uncompress_context_based_addr(struct sk_buff *skb,
+					 struct net_device *dev,
+					 struct in6_addr *ipaddr,
+					 const u8 address_mode,
+					 const u8 *lladdr,
+					 const u8 addr_type,
+					 const u8 addr_len,
+					 const u8 context_id)
 {
-	switch (sam) {
-	case LOWPAN_IPHC_ADDR_00:
-		/* unspec address ::
+	bool fail = false;
+	struct lowpan_context_entry *ctx_entry;
+
+	if (address_mode == LOWPAN_IPHC_ADDR_00)
+		/* Unspecified address ::
 		 * Do nothing, address is already ::
 		 */
-		break;
+		return 0;
+
+	/* Look for prefix assigned to given context id. */
+	ctx_entry = lowpan_context_decompress(dev, context_id);
+	if (!ctx_entry) {
+		pr_debug("Unknown Context. Unable to decompress\n");
+		return -EINVAL;
+	}
+
+	switch (address_mode) {
 	case LOWPAN_IPHC_ADDR_01:
-		/* TODO */
+		/* CID Prefix + 64-bits in-line. */
+		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[8], 8);
+	break;
 	case LOWPAN_IPHC_ADDR_02:
-		/* TODO */
+		/* CID Prefix + 16-bits in-line. */
+		ipaddr->s6_addr[11] = 0xFF;
+		ipaddr->s6_addr[12] = 0xFE;
+		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[14], 2);
+	break;
 	case LOWPAN_IPHC_ADDR_03:
-		/* TODO */
-		netdev_warn(skb->dev, "SAM value 0x%x not supported\n", sam);
-		return -EINVAL;
+		switch (addr_type) {
+		case IEEE802154_ADDR_LONG:
+			/* CID Prefix + 64-bits from LL Address. */
+			memcpy(&ipaddr->s6_addr[8],
+			       lladdr,
+			       addr_len);
+
+			/* Second bit-flip (Universe/Local)
+			* is done according RFC2464
+			*/
+			ipaddr->s6_addr[8] ^= 0x02;
+			break;
+		case IEEE802154_ADDR_SHORT:
+			/* CID Prefix + 16-bits from LL Address. */
+			ipaddr->s6_addr[11] = 0xFF;
+			ipaddr->s6_addr[12] = 0xFE;
+			ipaddr->s6_addr16[7] = htons(*((u16 *)lladdr));
+			break;
+		default:
+			pr_debug("Invalid addr_type set\n");
+			return -EINVAL;
+		}
+	break;
 	default:
-		pr_debug("Invalid sam value: 0x%x\n", sam);
+		pr_debug("Invalid address mode value: 0x%x\n",
+			 address_mode);
 		return -EINVAL;
 	}
 
-	raw_dump_inline(NULL,
-			"Reconstructed context based ipv6 src addr is",
+	if (fail) {
+		pr_debug("Failed to fetch skb data\n");
+		return -EIO;
+	}
+
+	/* Add context prefix to IPv6 address. Context bits are always used. */
+	add_cid_prefix(ipaddr, ctx_entry);
+
+	raw_dump_inline(NULL, "Reconstructed ipv6 addr is",
 			ipaddr->s6_addr, 16);
 
 	return 0;
@@ -323,11 +424,14 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 
 	if (iphc1 & LOWPAN_IPHC_SAC) {
 		/* Source address context based uncompression */
-		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = uncompress_context_based_src_addr(skb, &hdr.saddr, tmp);
+		pr_debug("source: address stateful compression.\n");
+		err = uncompress_context_based_addr(skb, dev, &hdr.saddr,
+						    tmp, saddr, saddr_type,
+						    saddr_len,
+						    CTX_SRC(num_context));
 	} else {
 		/* Source address uncompression */
-		pr_debug("source address stateless compression\n");
+		pr_debug("source: address stateless compression\n");
 		err = uncompress_addr(skb, &hdr.saddr, tmp, saddr,
 				      saddr_type, saddr_len);
 	}
@@ -352,10 +456,19 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 				return -EINVAL;
 		}
 	} else {
-		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
-				      daddr_type, daddr_len);
-		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
-			 tmp, &hdr.daddr);
+		if (iphc1 & LOWPAN_IPHC_DAC) {
+			/* Destination address context based uncompression */
+			pr_debug("dest: address steteful compression.\n");
+			err = uncompress_context_based_addr(
+				skb, dev, &hdr.daddr, tmp, daddr, daddr_type,
+				daddr_len, CTX_DEST(num_context));
+		} else {
+			/* Destination address uncompression */
+			pr_debug("dest: address stateless compression\n");
+			err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
+					      daddr_type, daddr_len);
+		}
+
 		if (err)
 			return -EINVAL;
 	}
@@ -393,11 +506,12 @@ EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 				  const struct in6_addr *ipaddr,
-				  const unsigned char *lladdr)
+				  const unsigned char *lladdr,
+				  bool cover_by_context)
 {
 	u8 val = 0;
 
-	if (is_addr_mac_addr_based(ipaddr, lladdr)) {
+	if (is_addr_mac_addr_based(ipaddr, lladdr) || cover_by_context) {
 		val = 3; /* 0-bits */
 		pr_debug("address compression 0 bits\n");
 	} else if (lowpan_is_iid_16_bit_compressable(ipaddr)) {
@@ -422,9 +536,15 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			   const void *_saddr, unsigned int len)
 {
 	u8 tmp, iphc0, iphc1, *hc_ptr;
+	u8 cid = 0;
 	struct ipv6hdr *hdr;
 	u8 head[100] = {};
 	int ret, addr_type;
+	struct lowpan_context_entry *entry;
+	bool scid_used = false;
+	bool dcid_used = false;
+	bool scid_cover = false;
+	bool dcid_cover = false;
 
 	if (type != ETH_P_IPV6)
 		return -EINVAL;
@@ -448,7 +568,26 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	iphc0 = LOWPAN_DISPATCH_IPHC;
 	iphc1 = 0;
 
-	/* TODO: context lookup */
+	/* Look for source context. */
+	entry = lowpan_context_compress(dev, &hdr->saddr);
+	if (entry) {
+		cid = entry->cid << 4;
+		scid_used = true;
+	}
+
+	/* Look for destination context. */
+	entry = lowpan_context_compress(dev, &hdr->daddr);
+	if (entry) {
+		cid |= entry->cid;
+		dcid_used = true;
+	}
+
+	if (scid_used || dcid_used) {
+		/* Add CID flag. */
+		iphc1 |= LOWPAN_IPHC_CID;
+
+		lowpan_push_hc_data(&hc_ptr, &cid, 1);
+	}
 
 	raw_dump_inline(__func__, "saddr",
 			(unsigned char *)_saddr, IEEE802154_ADDR_LEN);
@@ -535,11 +674,19 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		pr_debug("source address is unspecified, setting SAC\n");
 		iphc1 |= LOWPAN_IPHC_SAC;
 	} else {
-		if (addr_type & IPV6_ADDR_LINKLOCAL) {
+		if ((addr_type & IPV6_ADDR_LINKLOCAL) || scid_used) {
+			if (scid_used) {
+				iphc1 |= LOWPAN_IPHC_SAC;
+				scid_cover = is_iid_compressable(
+						&hdr->saddr, entry->prefix_len,
+						(u8 *)_saddr);
+			}
+
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 							 LOWPAN_IPHC_SAM_BIT,
-							 &hdr->saddr, _saddr);
-			pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
+							 &hdr->saddr, _saddr,
+							 scid_cover);
+			pr_debug("source ipv6 address %pI6c iphc1 0x%02x\n",
 				 &hdr->saddr, iphc1);
 		} else {
 			pr_debug("send the full source address\n");
@@ -580,12 +727,20 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
 		}
 	} else {
-		if (addr_type & IPV6_ADDR_LINKLOCAL) {
-			/* TODO: context lookup */
+		if (addr_type & IPV6_ADDR_LINKLOCAL || dcid_used) {
+			if (dcid_used) {
+				iphc1 |= LOWPAN_IPHC_DAC;
+				dcid_cover = is_iid_compressable(
+						&hdr->daddr, entry->prefix_len,
+						(u8 *)_daddr);
+			}
+
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
-				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, _daddr);
-			pr_debug("dest address unicast link-local %pI6c "
-				 "iphc1 0x%02x\n", &hdr->daddr, iphc1);
+							 LOWPAN_IPHC_DAM_BIT,
+							 &hdr->daddr, _daddr,
+							 dcid_cover);
+			pr_debug("dest address %pI6c iphc1 0x%02x\n",
+				 &hdr->daddr, iphc1);
 		} else {
 			pr_debug("dest address unicast %pI6c\n", &hdr->daddr);
 			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
@@ -619,6 +774,9 @@ static int __init lowpan_module_init(void)
 {
 	lowpan_debugfs = debugfs_create_dir("6lowpan", NULL);
 
+	/* Initialize stateful compression. */
+	lowpan_context_init();
+
 	request_module_nowait("ipv6");
 
 	request_module_nowait("nhc_dest");
@@ -635,6 +793,8 @@ static int __init lowpan_module_init(void)
 static void __exit lowpan_module_exit(void)
 {
 	debugfs_remove(lowpan_debugfs);
+
+	lowpan_context_uninit();
 }
 
 module_init(lowpan_module_init);
-- 
2.1.4

