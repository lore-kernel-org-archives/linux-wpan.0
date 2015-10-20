Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37681 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbJTGcI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:08 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/6] 6lowpan: iphc: change define values
Date: Tue, 20 Oct 2015 08:31:24 +0200
Message-Id: <1445322686-2952-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch has the main goal to delete shift operations. Instead we
doing masks and equals afterwards. E.g. for the SAM evaluation we
masking only the SAM value which fits in iphc1 byte, then comparing with
all possible SAM values over a switch case statement. We will not
shifting the SAM value to somewhat readable anymore.
Additional this patch slighty change the naming style like RFC 6282,
e.g. TTL to HLIM and we will drop an errno now if CID flag is set,
because we don't support it.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 199 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 106 insertions(+), 93 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index fcf583f..af8af98 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -58,41 +58,42 @@
 
 #include "nhc.h"
 
-/* Values of fields within the IPHC encoding first byte
- * (C stands for compressed and I for inline)
- */
-#define LOWPAN_IPHC_TF		0x18
+/* Values of fields within the IPHC encoding first byte */
+#define LOWPAN_IPHC_TF_MASK	0x18
+#define LOWPAN_IPHC_TF_00	0x00
+#define LOWPAN_IPHC_TF_01	0x08
+#define LOWPAN_IPHC_TF_10	0x10
+#define LOWPAN_IPHC_TF_11	0x18
+
+#define LOWPAN_IPHC_NH		0x04
 
-#define LOWPAN_IPHC_FL_C	0x10
-#define LOWPAN_IPHC_TC_C	0x08
-#define LOWPAN_IPHC_NH_C	0x04
-#define LOWPAN_IPHC_TTL_1	0x01
-#define LOWPAN_IPHC_TTL_64	0x02
-#define LOWPAN_IPHC_TTL_255	0x03
-#define LOWPAN_IPHC_TTL_I	0x00
+#define LOWPAN_IPHC_HLIM_MASK	0x03
+#define LOWPAN_IPHC_HLIM_00	0x00
+#define LOWPAN_IPHC_HLIM_01	0x01
+#define LOWPAN_IPHC_HLIM_10	0x02
+#define LOWPAN_IPHC_HLIM_11	0x03
 
 /* Values of fields within the IPHC encoding second byte */
 #define LOWPAN_IPHC_CID		0x80
 
-#define LOWPAN_IPHC_ADDR_00	0x00
-#define LOWPAN_IPHC_ADDR_01	0x01
-#define LOWPAN_IPHC_ADDR_02	0x02
-#define LOWPAN_IPHC_ADDR_03	0x03
-
 #define LOWPAN_IPHC_SAC		0x40
-#define LOWPAN_IPHC_SAM		0x30
 
-#define LOWPAN_IPHC_SAM_BIT	4
+#define LOWPAN_IPHC_SAM_MASK	0x30
+#define LOWPAN_IPHC_SAM_00	0x00
+#define LOWPAN_IPHC_SAM_01	0x10
+#define LOWPAN_IPHC_SAM_10	0x20
+#define LOWPAN_IPHC_SAM_11	0x30
 
 #define LOWPAN_IPHC_M		0x08
+
 #define LOWPAN_IPHC_DAC		0x04
+
+#define LOWPAN_IPHC_DAM_MASK	0x03
 #define LOWPAN_IPHC_DAM_00	0x00
 #define LOWPAN_IPHC_DAM_01	0x01
 #define LOWPAN_IPHC_DAM_10	0x02
 #define LOWPAN_IPHC_DAM_11	0x03
 
-#define LOWPAN_IPHC_DAM_BIT	0
-
 /* ipv6 address based on mac
  * second bit-flip (Universe/Local) is done according RFC2464
  */
@@ -197,7 +198,7 @@ static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
- * address_mode is sam value or dam value.
+ * address_mode is the masked value for sam or dam value
  */
 static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 			   struct in6_addr *ipaddr, u8 address_mode,
@@ -206,17 +207,20 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 	bool fail;
 
 	switch (address_mode) {
-	case LOWPAN_IPHC_ADDR_00:
+	/* SAM and DAM are the same here */
+	case LOWPAN_IPHC_DAM_00:
 		/* for global link addresses */
 		fail = lowpan_fetch_skb(skb, ipaddr->s6_addr, 16);
 		break;
-	case LOWPAN_IPHC_ADDR_01:
+	case LOWPAN_IPHC_SAM_01:
+	case LOWPAN_IPHC_DAM_01:
 		/* fe:80::XXXX:XXXX:XXXX:XXXX */
 		ipaddr->s6_addr[0] = 0xFE;
 		ipaddr->s6_addr[1] = 0x80;
 		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[8], 8);
 		break;
-	case LOWPAN_IPHC_ADDR_02:
+	case LOWPAN_IPHC_SAM_10:
+	case LOWPAN_IPHC_DAM_10:
 		/* fe:80::ff:fe00:XXXX */
 		ipaddr->s6_addr[0] = 0xFE;
 		ipaddr->s6_addr[1] = 0x80;
@@ -224,7 +228,8 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 		ipaddr->s6_addr[12] = 0xFE;
 		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[14], 2);
 		break;
-	case LOWPAN_IPHC_ADDR_03:
+	case LOWPAN_IPHC_SAM_11:
+	case LOWPAN_IPHC_DAM_11:
 		fail = false;
 		switch (lowpan_priv(dev)->lltype) {
 		case LOWPAN_LLTYPE_IEEE802154:
@@ -256,24 +261,25 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
  */
 static int uncompress_context_based_src_addr(struct sk_buff *skb,
 					     struct in6_addr *ipaddr,
-					     const u8 sam)
+					     u8 address_mode)
 {
-	switch (sam) {
-	case LOWPAN_IPHC_ADDR_00:
+	switch (address_mode) {
+	case LOWPAN_IPHC_SAM_00:
 		/* unspec address ::
 		 * Do nothing, address is already ::
 		 */
 		break;
-	case LOWPAN_IPHC_ADDR_01:
+	case LOWPAN_IPHC_SAM_01:
 		/* TODO */
-	case LOWPAN_IPHC_ADDR_02:
+	case LOWPAN_IPHC_SAM_10:
 		/* TODO */
-	case LOWPAN_IPHC_ADDR_03:
+	case LOWPAN_IPHC_SAM_11:
 		/* TODO */
-		netdev_warn(skb->dev, "SAM value 0x%x not supported\n", sam);
+		netdev_warn(skb->dev, "SAM value 0x%x not supported\n",
+			    address_mode);
 		return -EINVAL;
 	default:
-		pr_debug("Invalid sam value: 0x%x\n", sam);
+		pr_debug("Invalid sam value: 0x%x\n", address_mode);
 		return -EINVAL;
 	}
 
@@ -289,11 +295,11 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
  */
 static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 					     struct in6_addr *ipaddr,
-					     const u8 dam)
+					     u8 address_mode)
 {
 	bool fail;
 
-	switch (dam) {
+	switch (address_mode) {
 	case LOWPAN_IPHC_DAM_00:
 		/* 00:  128 bits.  The full address
 		 * is carried in-line.
@@ -325,7 +331,7 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 		fail = lowpan_fetch_skb(skb, &ipaddr->s6_addr[15], 1);
 		break;
 	default:
-		pr_debug("DAM value has a wrong value: 0x%x\n", dam);
+		pr_debug("DAM value has a wrong value: 0x%x\n", address_mode);
 		return -EINVAL;
 	}
 
@@ -341,13 +347,17 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 }
 
 /* TTL uncompression values */
-static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
+static const u8 lowpan_ttl_values[] = {
+	[LOWPAN_IPHC_HLIM_01] = 1,
+	[LOWPAN_IPHC_HLIM_10] = 64,
+	[LOWPAN_IPHC_HLIM_11] = 255,
+};
 
 int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 			     const void *daddr, const void *saddr)
 {
 	struct ipv6hdr hdr = {};
-	u8 iphc0, iphc1, tmp, num_context = 0;
+	u8 iphc0, iphc1, tmp = 0;
 	int err;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
@@ -358,20 +368,17 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		return -EINVAL;
 
 	/* another if the CID flag is set */
-	if (iphc1 & LOWPAN_IPHC_CID) {
-		pr_debug("CID flag is set, increase header with one\n");
-		if (lowpan_fetch_skb(skb, &num_context, sizeof(num_context)))
-			return -EINVAL;
-	}
+	if (iphc1 & LOWPAN_IPHC_CID)
+		return -ENOTSUPP;
 
 	hdr.version = 6;
 
 	/* Traffic Class and Flow Label */
-	switch ((iphc0 & LOWPAN_IPHC_TF) >> 3) {
+	switch (iphc0 & LOWPAN_IPHC_TF_MASK) {
 	/* Traffic Class and FLow Label carried in-line
 	 * ECN + DSCP + 4-bit Pad + Flow Label (4 bytes)
 	 */
-	case 0: /* 00b */
+	case LOWPAN_IPHC_TF_00:
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
 			return -EINVAL;
 
@@ -381,20 +388,10 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		hdr.flow_lbl[0] = ((tmp >> 2) & 0x30) | (tmp << 6) |
 					(hdr.flow_lbl[0] & 0x0f);
 		break;
-	/* Traffic class carried in-line
-	 * ECN + DSCP (1 byte), Flow Label is elided
-	 */
-	case 2: /* 10b */
-		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			return -EINVAL;
-
-		hdr.priority = ((tmp >> 2) & 0x0f);
-		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
-		break;
 	/* Flow Label carried in-line
 	 * ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided
 	 */
-	case 1: /* 01b */
+	case LOWPAN_IPHC_TF_01:
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
 			return -EINVAL;
 
@@ -402,15 +399,26 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
 		skb_pull(skb, 2);
 		break;
+	/* Traffic class carried in-line
+	 * ECN + DSCP (1 byte), Flow Label is elided
+	 */
+	case LOWPAN_IPHC_TF_10:
+		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
+			return -EINVAL;
+
+		hdr.priority = ((tmp >> 2) & 0x0f);
+		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
+		break;
 	/* Traffic Class and Flow Label are elided */
-	case 3: /* 11b */
+	case LOWPAN_IPHC_TF_11:
 		break;
 	default:
+		WARN_ON_ONCE(1);
 		break;
 	}
 
 	/* Next Header */
-	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
+	if (!(iphc0 & LOWPAN_IPHC_NH)) {
 		/* Next header is carried inline */
 		if (lowpan_fetch_skb(skb, &hdr.nexthdr, sizeof(hdr.nexthdr)))
 			return -EINVAL;
@@ -420,34 +428,30 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	}
 
 	/* Hop Limit */
-	if ((iphc0 & 0x03) != LOWPAN_IPHC_TTL_I) {
-		hdr.hop_limit = lowpan_ttl_values[iphc0 & 0x03];
+	if ((iphc0 & LOWPAN_IPHC_HLIM_MASK) != LOWPAN_IPHC_HLIM_00) {
+		hdr.hop_limit = lowpan_ttl_values[iphc0 & LOWPAN_IPHC_HLIM_MASK];
 	} else {
 		if (lowpan_fetch_skb(skb, &hdr.hop_limit,
 				     sizeof(hdr.hop_limit)))
 			return -EINVAL;
 	}
 
-	/* Extract SAM to the tmp variable */
-	tmp = ((iphc1 & LOWPAN_IPHC_SAM) >> LOWPAN_IPHC_SAM_BIT) & 0x03;
-
 	if (iphc1 & LOWPAN_IPHC_SAC) {
 		/* Source address context based uncompression */
 		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = uncompress_context_based_src_addr(skb, &hdr.saddr, tmp);
+		err = uncompress_context_based_src_addr(skb, &hdr.saddr,
+							iphc1 & LOWPAN_IPHC_SAM_MASK);
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
-		err = uncompress_addr(skb, dev, &hdr.saddr, tmp, saddr);
+		err = uncompress_addr(skb, dev, &hdr.saddr,
+				      iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
 	}
 
 	/* Check on error of previous branch */
 	if (err)
 		return -EINVAL;
 
-	/* Extract DAM to the tmp variable */
-	tmp = ((iphc1 & LOWPAN_IPHC_DAM_11) >> LOWPAN_IPHC_DAM_BIT) & 0x03;
-
 	/* check for Multicast Compression */
 	if (iphc1 & LOWPAN_IPHC_M) {
 		if (iphc1 & LOWPAN_IPHC_DAC) {
@@ -455,21 +459,22 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 			/* TODO: implement this */
 		} else {
 			err = lowpan_uncompress_multicast_daddr(skb, &hdr.daddr,
-								tmp);
+								iphc1 & LOWPAN_IPHC_DAM_MASK);
 
 			if (err)
 				return -EINVAL;
 		}
 	} else {
-		err = uncompress_addr(skb, dev, &hdr.daddr, tmp, daddr);
+		err = uncompress_addr(skb, dev, &hdr.daddr,
+				      iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
-			 tmp, &hdr.daddr);
+			 iphc1 & LOWPAN_IPHC_DAM_MASK, &hdr.daddr);
 		if (err)
 			return -EINVAL;
 	}
 
 	/* Next header data uncompression */
-	if (iphc0 & LOWPAN_IPHC_NH_C) {
+	if (iphc0 & LOWPAN_IPHC_NH) {
 		err = lowpan_nhc_do_uncompression(skb, dev, &hdr);
 		if (err < 0)
 			return err;
@@ -510,30 +515,39 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
-static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
-				  const struct in6_addr *ipaddr,
-				  const unsigned char *lladdr)
+static const u8 lowpan_iphc_dam_to_sam_value[] = {
+	[LOWPAN_IPHC_DAM_00] = LOWPAN_IPHC_SAM_00,
+	[LOWPAN_IPHC_DAM_01] = LOWPAN_IPHC_SAM_01,
+	[LOWPAN_IPHC_DAM_10] = LOWPAN_IPHC_SAM_10,
+	[LOWPAN_IPHC_DAM_11] = LOWPAN_IPHC_SAM_11,
+};
+
+static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct in6_addr *ipaddr,
+				  const unsigned char *lladdr, bool sam)
 {
-	u8 val = 0;
+	u8 dam = LOWPAN_IPHC_DAM_00;
 
 	if (is_addr_mac_addr_based(ipaddr, lladdr)) {
-		val = 3; /* 0-bits */
+		dam = LOWPAN_IPHC_DAM_11; /* 0-bits */
 		pr_debug("address compression 0 bits\n");
 	} else if (lowpan_is_iid_16_bit_compressable(ipaddr)) {
 		/* compress IID to 16 bits xxxx::XXXX */
 		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr16[7], 2);
-		val = 2; /* 16-bits */
+		dam = LOWPAN_IPHC_DAM_10; /* 16-bits */
 		raw_dump_inline(NULL, "Compressed ipv6 addr is (16 bits)",
 				*hc_ptr - 2, 2);
 	} else {
 		/* do not compress IID => xxxx::IID */
 		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr16[4], 8);
-		val = 1; /* 64-bits */
+		dam = LOWPAN_IPHC_DAM_01; /* 64-bits */
 		raw_dump_inline(NULL, "Compressed ipv6 addr is (64 bits)",
 				*hc_ptr - 8, 8);
 	}
 
-	return rol8(val, shift);
+	if (sam)
+		return lowpan_iphc_dam_to_sam_value[dam];
+	else
+		return dam;
 }
 
 int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
@@ -587,11 +601,11 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	if (((hdr->flow_lbl[0] & 0x0F) == 0) &&
 	    (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {
 		/* flow label can be compressed */
-		iphc0 |= LOWPAN_IPHC_FL_C;
+		iphc0 |= LOWPAN_IPHC_TF_10;
 		if ((hdr->priority == 0) &&
 		    ((hdr->flow_lbl[0] & 0xF0) == 0)) {
 			/* compress (elide) all */
-			iphc0 |= LOWPAN_IPHC_TC_C;
+			iphc0 |= LOWPAN_IPHC_TF_11;
 		} else {
 			/* compress only the flow label */
 			*hc_ptr = tmp;
@@ -602,7 +616,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		if ((hdr->priority == 0) &&
 		    ((hdr->flow_lbl[0] & 0xF0) == 0)) {
 			/* compress only traffic class */
-			iphc0 |= LOWPAN_IPHC_TC_C;
+			iphc0 |= LOWPAN_IPHC_TF_01;
 			*hc_ptr = (tmp & 0xc0) | (hdr->flow_lbl[0] & 0x0F);
 			memcpy(hc_ptr + 1, &hdr->flow_lbl[1], 2);
 			hc_ptr += 3;
@@ -625,7 +639,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		lowpan_push_hc_data(&hc_ptr, &hdr->nexthdr,
 				    sizeof(hdr->nexthdr));
 	else
-		iphc0 |= LOWPAN_IPHC_NH_C;
+		iphc0 |= LOWPAN_IPHC_NH;
 
 	/* Hop limit
 	 * if 1:   compress, encoding is 01
@@ -635,13 +649,13 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	 */
 	switch (hdr->hop_limit) {
 	case 1:
-		iphc0 |= LOWPAN_IPHC_TTL_1;
+		iphc0 |= LOWPAN_IPHC_HLIM_01;
 		break;
 	case 64:
-		iphc0 |= LOWPAN_IPHC_TTL_64;
+		iphc0 |= LOWPAN_IPHC_HLIM_10;
 		break;
 	case 255:
-		iphc0 |= LOWPAN_IPHC_TTL_255;
+		iphc0 |= LOWPAN_IPHC_HLIM_11;
 		break;
 	default:
 		lowpan_push_hc_data(&hc_ptr, &hdr->hop_limit,
@@ -655,9 +669,8 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		iphc1 |= LOWPAN_IPHC_SAC;
 	} else {
 		if (addr_type & IPV6_ADDR_LINKLOCAL) {
-			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
-							 LOWPAN_IPHC_SAM_BIT,
-							 &hdr->saddr, saddr);
+			iphc1 |= lowpan_compress_addr_64(&hc_ptr, &hdr->saddr,
+							 saddr, true);
 			pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
 				 &hdr->saddr, iphc1);
 		} else {
@@ -701,8 +714,8 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	} else {
 		if (addr_type & IPV6_ADDR_LINKLOCAL) {
 			/* TODO: context lookup */
-			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
-				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, daddr);
+			iphc1 |= lowpan_compress_addr_64(&hc_ptr, &hdr->daddr,
+							 daddr, false);
 			pr_debug("dest address unicast link-local %pI6c "
 				 "iphc1 0x%02x\n", &hdr->daddr, iphc1);
 		} else {
@@ -712,7 +725,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	}
 
 	/* next header compression */
-	if (iphc0 & LOWPAN_IPHC_NH_C) {
+	if (iphc0 & LOWPAN_IPHC_NH) {
 		ret = lowpan_nhc_do_compression(skb, hdr, &hc_ptr);
 		if (ret < 0)
 			return ret;
-- 
2.6.1

