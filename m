Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35518 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbJTGcK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:10 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/6] 6lowpan: rework tc and flow label handling
Date: Tue, 20 Oct 2015 08:31:25 +0200
Message-Id: <1445322686-2952-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch reworks the handling of compression/decompression of traffic
class and flow label handling. The current method is hard to understand,
also doesn't checks if we can read the buffer from skb length.

I tried to put the shifting operations into static inline functions and
comment each steps which I did there to make it hopefully somewhat more
readable. The big mess to deal with that is the that the ipv6 header
bring the order "DSCP + ECN" but iphc uses "ECN + DSCP". Additional the
DCSP + ECN bits are splitted in ipv6_hdr inside the priority and
flow_lbl[0] fields.

I tested these compressions by using fakelb 802.15.4 driver and
manipulate the tc and flow label fields manually in function
"__ip6_local_out" before the skb will be send to lower layers. Then I
looked up the tc and flow label fields in wireshark on a wpan and lowpan
interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 290 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 205 insertions(+), 85 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index af8af98..e6cdfc9 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -346,6 +346,108 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 	return 0;
 }
 
+/* get the ecn values from iphc tf format and set it to ipv6hdr */
+static inline void lowpan_iphc_tf_set_ecn(struct ipv6hdr *hdr, const u8 *tf)
+{
+	/* get the two higher bits which is ecn */
+	u8 ecn = tf[0] & 0xc0;
+
+	/* ECN takes 0x30 in hdr->flow_lbl[0] */
+	hdr->flow_lbl[0] |= (ecn >> 2);
+}
+
+/* get the dscp values from iphc tf format and set it to ipv6hdr */
+static inline void lowpan_iphc_tf_set_dscp(struct ipv6hdr *hdr, const u8 *tf)
+{
+	/* DSCP is at place after ECN */
+	u8 dscp = tf[0] & 0x3f;
+
+	/* The four highest bits need to be set at hdr->priority */
+	hdr->priority |= ((dscp & 0x3c) >> 2);
+	/* The two lower bits is part of hdr->flow_lbl[0] */
+	hdr->flow_lbl[0] |= ((dscp & 0x03) << 6);
+}
+
+/* get the flow label values from iphc tf format and set it to ipv6hdr */
+static inline void lowpan_iphc_tf_set_lbl(struct ipv6hdr *hdr, const u8 *lbl)
+{
+	/* flow label is always some array started with lower nibble of
+	 * flow_lbl[0] and followed with two bytes afterwards. Inside inline
+	 * data the flow_lbl position can be different, which will be handled
+	 * by lbl pointer. E.g. case "01" vs "00" the traffic class is 8 bit
+	 * shifted, the different lbl pointer will handle that.
+	 *
+	 * The flow label will started at lower nibble of flow_lbl[0], the
+	 * higher nibbles are part of DSCP + ECN.
+	 */
+	hdr->flow_lbl[0] |= lbl[0] & 0x0f;
+	memcpy(&hdr->flow_lbl[1], &lbl[1], 2);
+}
+
+/* lowpan_iphc_tf_decompress - decompress the traffic class.
+ *	This function will return zero on success, a value lower than zero if
+ *	failed.
+ */
+static int lowpan_iphc_tf_decompress(struct sk_buff *skb, struct ipv6hdr *hdr,
+				     u8 val)
+{
+	u8 tf[4];
+
+	/* Traffic Class and Flow Label */
+	switch (val) {
+	case LOWPAN_IPHC_TF_00:
+		/* ECN + DSCP + 4-bit Pad + Flow Label (4 bytes) */
+		if (lowpan_fetch_skb(skb, tf, 4))
+			return -EINVAL;
+
+		/*                      1                   2                   3
+		 *  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+		 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+		 * |ECN|   DSCP    |  rsv  |             Flow Label                |
+		 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+		 */
+		lowpan_iphc_tf_set_ecn(hdr, tf);
+		lowpan_iphc_tf_set_dscp(hdr, tf);
+		lowpan_iphc_tf_set_lbl(hdr, &tf[1]);
+		break;
+	case LOWPAN_IPHC_TF_01:
+		/* ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided. */
+		if (lowpan_fetch_skb(skb, tf, 3))
+			return -EINVAL;
+
+		/*                     1                   2
+		 * 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3
+		 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+		 * |ECN|rsv|             Flow Label                |
+		 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+		 */
+		lowpan_iphc_tf_set_ecn(hdr, tf);
+		lowpan_iphc_tf_set_lbl(hdr, &tf[0]);
+		break;
+	case LOWPAN_IPHC_TF_10:
+		/* ECN + DSCP (1 byte), Flow Label is elided. */
+		if (lowpan_fetch_skb(skb, tf, 1))
+			return -EINVAL;
+
+		/*  0 1 2 3 4 5 6 7
+		 * +-+-+-+-+-+-+-+-+
+		 * |ECN|   DSCP    |
+		 * +-+-+-+-+-+-+-+-+
+		 */
+		lowpan_iphc_tf_set_ecn(hdr, tf);
+		lowpan_iphc_tf_set_dscp(hdr, tf);
+		break;
+	case LOWPAN_IPHC_TF_11:
+		/* Traffic Class and Flow Label are elided */
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = {
 	[LOWPAN_IPHC_HLIM_01] = 1,
@@ -357,7 +459,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 			     const void *daddr, const void *saddr)
 {
 	struct ipv6hdr hdr = {};
-	u8 iphc0, iphc1, tmp = 0;
+	u8 iphc0, iphc1;
 	int err;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
@@ -373,49 +475,10 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 
 	hdr.version = 6;
 
-	/* Traffic Class and Flow Label */
-	switch (iphc0 & LOWPAN_IPHC_TF_MASK) {
-	/* Traffic Class and FLow Label carried in-line
-	 * ECN + DSCP + 4-bit Pad + Flow Label (4 bytes)
-	 */
-	case LOWPAN_IPHC_TF_00:
-		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			return -EINVAL;
-
-		memcpy(&hdr.flow_lbl, &skb->data[0], 3);
-		skb_pull(skb, 3);
-		hdr.priority = ((tmp >> 2) & 0x0f);
-		hdr.flow_lbl[0] = ((tmp >> 2) & 0x30) | (tmp << 6) |
-					(hdr.flow_lbl[0] & 0x0f);
-		break;
-	/* Flow Label carried in-line
-	 * ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided
-	 */
-	case LOWPAN_IPHC_TF_01:
-		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			return -EINVAL;
-
-		hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);
-		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
-		skb_pull(skb, 2);
-		break;
-	/* Traffic class carried in-line
-	 * ECN + DSCP (1 byte), Flow Label is elided
-	 */
-	case LOWPAN_IPHC_TF_10:
-		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			return -EINVAL;
-
-		hdr.priority = ((tmp >> 2) & 0x0f);
-		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
-		break;
-	/* Traffic Class and Flow Label are elided */
-	case LOWPAN_IPHC_TF_11:
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
+	err = lowpan_iphc_tf_decompress(skb, &hdr,
+					iphc0 & LOWPAN_IPHC_TF_MASK);
+	if (err < 0)
+		return err;
 
 	/* Next Header */
 	if (!(iphc0 & LOWPAN_IPHC_NH)) {
@@ -550,10 +613,105 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct in6_addr *ipaddr,
 		return dam;
 }
 
+/* lowpan_iphc_get_tc - get the ECN + DCSP fields in hc format */
+static inline u8 lowpan_iphc_get_tc(const struct ipv6hdr *hdr)
+{
+	u8 dscp, ecn;
+
+	/* hdr->priority contains the higher bits of dscp, lower are part of
+	 * flow_lbl[0]. Note ECN, DCSP is swapped in ipv6 hdr.
+	 */
+	dscp = (hdr->priority << 2) | ((hdr->flow_lbl[0] & 0xc0) >> 6);
+	/* ECN is at the two lower bits from first nibble of flow_lbl[0] */
+	ecn = (hdr->flow_lbl[0] & 0x30);
+	/* for pretty debug output, also shift ecn to get the ecn value */
+	pr_debug("ecn 0x%02x dscp 0x%02x\n", ecn >> 4, dscp);
+	/* ECN is at 0x30 now, shift it to have ECN + DCSP */
+	return (ecn << 2) | dscp;
+}
+
+/* lowpan_iphc_is_flow_lbl_zero - check if flow label is zero */
+static inline bool lowpan_iphc_is_flow_lbl_zero(const struct ipv6hdr *hdr)
+{
+	return ((!(hdr->flow_lbl[0] & 0x0f)) &&
+		!hdr->flow_lbl[1] && !hdr->flow_lbl[2]);
+}
+
+/* lowpan_iphc_tf_compress - compress the traffic class which is set by
+ *	ipv6hdr. Return the corresponding format identifier which is used.
+ */
+static u8 lowpan_iphc_tf_compress(u8 **hc_ptr, const struct ipv6hdr *hdr)
+{
+	/* get ecn dscp data in a byteformat as: ECN(hi) + DSCP(lo) */
+	u8 tc = lowpan_iphc_get_tc(hdr), tf[4], val;
+
+	/* printout the traffic class in hc format */
+	pr_debug("tc 0x%02x\n", tc);
+
+	if (lowpan_iphc_is_flow_lbl_zero(hdr)) {
+		if (!tc) {
+			/* 11:  Traffic Class and Flow Label are elided. */
+			val = LOWPAN_IPHC_TF_11;
+		} else {
+			/* 10:  ECN + DSCP (1 byte), Flow Label is elided.
+			 *
+			 *  0 1 2 3 4 5 6 7
+			 * +-+-+-+-+-+-+-+-+
+			 * |ECN|   DSCP    |
+			 * +-+-+-+-+-+-+-+-+
+			 */
+			lowpan_push_hc_data(hc_ptr, &tc, sizeof(tc));
+			val = LOWPAN_IPHC_TF_10;
+		}
+	} else {
+		/* check if dscp is zero, it's after the first two bit */
+		if (!(tc & 0x3f)) {
+			/* 01:  ECN + 2-bit Pad + Flow Label (3 bytes), DSCP is elided
+			 *
+			 *                     1                   2
+			 * 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3
+			 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+			 * |ECN|rsv|             Flow Label                |
+			 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+			 */
+			memcpy(&tf[0], &hdr->flow_lbl[0], 3);
+			/* zero the highest 4-bits, contains DCSP + ECN */
+			tf[0] &= ~0xf0;
+			/* set ECN */
+			tf[0] |= (tc & 0xc0);
+
+			lowpan_push_hc_data(hc_ptr, tf, 3);
+			val = LOWPAN_IPHC_TF_01;
+		} else {
+			/* 00:  ECN + DSCP + 4-bit Pad + Flow Label (4 bytes)
+			 *
+			 *                      1                   2                   3
+			 *  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+			 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+			 * |ECN|   DSCP    |  rsv  |             Flow Label                |
+			 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+			 */
+			memcpy(&tf[0], &tc, sizeof(tc));
+			/* highest nibble of flow_lbl[0] is part of DSCP + ECN
+			 * which will be the 4-bit pad and will be filled with
+			 * zeros afterwards.
+			 */
+			memcpy(&tf[1], &hdr->flow_lbl[0], 3);
+			/* zero the 4-bit pad, which is reserved */
+			tf[1] &= ~0xf0;
+
+			lowpan_push_hc_data(hc_ptr, tf, 4);
+			val = LOWPAN_IPHC_TF_00;
+		}
+	}
+
+	return val;
+}
+
 int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 			   const void *daddr, const void *saddr)
 {
-	u8 tmp, iphc0, iphc1, *hc_ptr;
+	u8 iphc0, iphc1, *hc_ptr;
 	struct ipv6hdr *hdr;
 	u8 head[LOWPAN_IPHC_MAX_HC_BUF_LEN] = {};
 	int ret, addr_type;
@@ -588,46 +746,8 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	raw_dump_table(__func__, "sending raw skb network uncompressed packet",
 		       skb->data, skb->len);
 
-	/* Traffic class, flow label
-	 * If flow label is 0, compress it. If traffic class is 0, compress it
-	 * We have to process both in the same time as the offset of traffic
-	 * class depends on the presence of version and flow label
-	 */
-
-	/* hc format of TC is ECN | DSCP , original one is DSCP | ECN */
-	tmp = (hdr->priority << 4) | (hdr->flow_lbl[0] >> 4);
-	tmp = ((tmp & 0x03) << 6) | (tmp >> 2);
-
-	if (((hdr->flow_lbl[0] & 0x0F) == 0) &&
-	    (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {
-		/* flow label can be compressed */
-		iphc0 |= LOWPAN_IPHC_TF_10;
-		if ((hdr->priority == 0) &&
-		    ((hdr->flow_lbl[0] & 0xF0) == 0)) {
-			/* compress (elide) all */
-			iphc0 |= LOWPAN_IPHC_TF_11;
-		} else {
-			/* compress only the flow label */
-			*hc_ptr = tmp;
-			hc_ptr += 1;
-		}
-	} else {
-		/* Flow label cannot be compressed */
-		if ((hdr->priority == 0) &&
-		    ((hdr->flow_lbl[0] & 0xF0) == 0)) {
-			/* compress only traffic class */
-			iphc0 |= LOWPAN_IPHC_TF_01;
-			*hc_ptr = (tmp & 0xc0) | (hdr->flow_lbl[0] & 0x0F);
-			memcpy(hc_ptr + 1, &hdr->flow_lbl[1], 2);
-			hc_ptr += 3;
-		} else {
-			/* compress nothing */
-			memcpy(hc_ptr, hdr, 4);
-			/* replace the top byte with new ECN | DSCP format */
-			*hc_ptr = tmp;
-			hc_ptr += 4;
-		}
-	}
+	/* Traffic Class, Flow Label compression */
+	iphc0 |= lowpan_iphc_tf_compress(&hc_ptr, hdr);
 
 	/* NOTE: payload length is always compressed */
 
-- 
2.6.1

