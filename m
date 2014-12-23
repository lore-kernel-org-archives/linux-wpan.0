Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:64144 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbaLWO3K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:29:10 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so9246989wgh.9
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:29:08 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 7/7] ieee802154: 6lowpan: remove tx full-size calc workaround
Date: Tue, 23 Dec 2014 15:28:29 +0100
Message-Id: <1419344909-16007-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

This patch removes a workaround in transmit fragmentation implementation
which use lowpan_uncompress_size to calculate the full size of
fragmented packet. Instead we calculate the size over skb->len before
and after iphc compression. Additional we remove the whole
lowpan_uncompress_size function which is used by 802154 6LoWPAN only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/6lowpan.h       | 113 --------------------------------------------
 net/ieee802154/6lowpan/tx.c |  18 ++++---
 2 files changed, 11 insertions(+), 120 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index c64d274..fd56994 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -261,119 +261,6 @@ static inline void lowpan_push_hc_data(u8 **hc_ptr, const void *data,
 	*hc_ptr += len;
 }
 
-static inline u8 lowpan_addr_mode_size(const u8 addr_mode)
-{
-	static const u8 addr_sizes[] = {
-		[LOWPAN_IPHC_ADDR_00] = 16,
-		[LOWPAN_IPHC_ADDR_01] = 8,
-		[LOWPAN_IPHC_ADDR_02] = 2,
-		[LOWPAN_IPHC_ADDR_03] = 0,
-	};
-	return addr_sizes[addr_mode];
-}
-
-static inline u8 lowpan_next_hdr_size(const u8 h_enc, u16 *uncomp_header)
-{
-	u8 ret = 1;
-
-	if ((h_enc & LOWPAN_NHC_UDP_MASK) == LOWPAN_NHC_UDP_ID) {
-		*uncomp_header += sizeof(struct udphdr);
-
-		switch (h_enc & LOWPAN_NHC_UDP_CS_P_11) {
-		case LOWPAN_NHC_UDP_CS_P_00:
-			ret += 4;
-			break;
-		case LOWPAN_NHC_UDP_CS_P_01:
-		case LOWPAN_NHC_UDP_CS_P_10:
-			ret += 3;
-			break;
-		case LOWPAN_NHC_UDP_CS_P_11:
-			ret++;
-			break;
-		default:
-			break;
-		}
-
-		if (!(h_enc & LOWPAN_NHC_UDP_CS_C))
-			ret += 2;
-	}
-
-	return ret;
-}
-
-/**
- *	lowpan_uncompress_size - returns skb->len size with uncompressed header
- *	@skb: sk_buff with 6lowpan header inside
- *	@datagram_offset: optional to get the datagram_offset value
- *
- *	Returns the skb->len with uncompressed header
- */
-static inline u16
-lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
-{
-	u16 ret = 2, uncomp_header = sizeof(struct ipv6hdr);
-	u8 iphc0, iphc1, h_enc;
-
-	iphc0 = skb_network_header(skb)[0];
-	iphc1 = skb_network_header(skb)[1];
-
-	switch ((iphc0 & LOWPAN_IPHC_TF) >> 3) {
-	case 0:
-		ret += 4;
-		break;
-	case 1:
-		ret += 3;
-		break;
-	case 2:
-		ret++;
-		break;
-	default:
-		break;
-	}
-
-	if (!(iphc0 & LOWPAN_IPHC_NH_C))
-		ret++;
-
-	if (!(iphc0 & 0x03))
-		ret++;
-
-	ret += lowpan_addr_mode_size((iphc1 & LOWPAN_IPHC_SAM) >>
-				     LOWPAN_IPHC_SAM_BIT);
-
-	if (iphc1 & LOWPAN_IPHC_M) {
-		switch ((iphc1 & LOWPAN_IPHC_DAM_11) >>
-			LOWPAN_IPHC_DAM_BIT) {
-		case LOWPAN_IPHC_DAM_00:
-			ret += 16;
-			break;
-		case LOWPAN_IPHC_DAM_01:
-			ret += 6;
-			break;
-		case LOWPAN_IPHC_DAM_10:
-			ret += 4;
-			break;
-		case LOWPAN_IPHC_DAM_11:
-			ret++;
-			break;
-		default:
-			break;
-		}
-	} else {
-		ret += lowpan_addr_mode_size((iphc1 & LOWPAN_IPHC_DAM_11) >>
-					     LOWPAN_IPHC_DAM_BIT);
-	}
-
-	if (iphc0 & LOWPAN_IPHC_NH_C) {
-		h_enc = skb_network_header(skb)[ret];
-		ret += lowpan_next_hdr_size(h_enc, &uncomp_header);
-	}
-
-	if (dgram_offset)
-		*dgram_offset = uncomp_header;
-
-	return skb->len + uncomp_header - ret;
-}
-
 int
 lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 			 const u8 *saddr, const u8 saddr_type,
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 2349070..102d0ec 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -124,16 +124,14 @@ lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 
 static int
 lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *dev,
-		       const struct ieee802154_hdr *wpan_hdr)
+		       const struct ieee802154_hdr *wpan_hdr, u16 dgram_size,
+		       u16 dgram_offset)
 {
-	u16 dgram_size, dgram_offset;
 	__be16 frag_tag;
 	u8 frag_hdr[5];
 	int frag_cap, frag_len, payload_cap, rc;
 	int skb_unprocessed, skb_offset;
 
-	dgram_size = lowpan_uncompress_size(skb, &dgram_offset) -
-		     skb->mac_len;
 	frag_tag = htons(lowpan_dev_info(dev)->fragment_tag);
 	lowpan_dev_info(dev)->fragment_tag++;
 
@@ -188,7 +186,8 @@ err:
 	return rc;
 }
 
-static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
+static int lowpan_header(struct sk_buff *skb, struct net_device *dev,
+			 u16 *dgram_size, u16 *dgram_offset)
 {
 	struct ieee802154_addr sa, da;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
@@ -201,7 +200,10 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 	daddr = &info.daddr.u.extended_addr;
 	saddr = &info.saddr.u.extended_addr;
 
+	*dgram_size = skb->len;
 	lowpan_header_compress(skb, dev, ETH_P_IPV6, daddr, saddr, skb->len);
+	/* dgram_size = (saved bytes after compression) + lowpan header size */
+	*dgram_offset = (*dgram_size - skb->len) + skb_network_header_len(skb);
 
 	cb->type = IEEE802154_FC_TYPE_DATA;
 
@@ -234,6 +236,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_hdr wpan_hdr;
 	int max_single, ret;
+	u16 dgram_size, dgram_offset;
 
 	pr_debug("package xmit\n");
 
@@ -244,7 +247,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!skb)
 		return NET_XMIT_DROP;
 
-	ret = lowpan_header(skb, dev);
+	ret = lowpan_header(skb, dev, &dgram_size, &dgram_offset);
 	if (ret < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
@@ -264,7 +267,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 		netdev_tx_t rc;
 
 		pr_debug("frame is too big, fragmentation is needed\n");
-		rc = lowpan_xmit_fragmented(skb, dev, &wpan_hdr);
+		rc = lowpan_xmit_fragmented(skb, dev, &wpan_hdr, dgram_size,
+					    dgram_offset);
 
 		return rc < 0 ? NET_XMIT_DROP : rc;
 	}
-- 
2.2.0

