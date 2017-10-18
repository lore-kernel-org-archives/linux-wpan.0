Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933903AbdJRMGS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Oct 2017 08:06:18 -0400
From: Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: [RFC 1/3] 6lowpan: Use struct lowpan_dev instead of net_device
Date: Wed, 18 Oct 2017 15:06:13 +0300
Message-Id: <20171018120615.24126-2-patrik.flykt@linux.intel.com>
In-Reply-To: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
References: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: luiz.von.dentz@intel.com

Use struct lowpan_dev instead of struct net_device when accessing
6lo header compression funcitons. With this change the caller needs
to cast its private data pointer with the help of the lowpan_dev()
function and not the 6lo header compression code.

All users of 6lo header compression are also updated.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 include/net/6lowpan.h       |   8 +--
 net/6lowpan/iphc.c          | 121 +++++++++++++++++++-------------------------
 net/6lowpan/nhc.c           |   8 +--
 net/6lowpan/nhc.h           |   2 +-
 net/bluetooth/6lowpan.c     |   6 ++-
 net/ieee802154/6lowpan/rx.c |   3 +-
 net/ieee802154/6lowpan/tx.c |   2 +-
 7 files changed, 69 insertions(+), 81 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index a71378007e61..7f21e156c9d6 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -299,13 +299,13 @@ void lowpan_unregister_netdev(struct net_device *dev);
  * reallocate headroom.
  *
  * @skb: the buffer which should be manipulate.
- * @dev: the lowpan net device pointer.
+ * @ldev: the lowpan device pointer.
  * @daddr: destination lladdr of mac header which is used for compression
  *	methods.
  * @saddr: source lladdr of mac header which is used for compression
  *	methods.
  */
-int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
+int lowpan_header_decompress(struct sk_buff *skb, struct lowpan_dev *ldev,
 			     const void *daddr, const void *saddr);
 
 /**
@@ -318,13 +318,13 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
  * which is the IPHC "more bytes than IPv6 header" at worst case.
  *
  * @skb: the buffer which should be manipulate.
- * @dev: the lowpan net device pointer.
+ * @ldev: the lowpan device pointer.
  * @daddr: destination lladdr of mac header which is used for compression
  *	methods.
  * @saddr: source lladdr of mac header which is used for compression
  *	methods.
  */
-int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
+int lowpan_header_compress(struct sk_buff *skb, struct lowpan_dev *ldev,
 			   const void *daddr, const void *saddr);
 
 #endif /* __6LOWPAN_H__ */
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 6b1042e21656..0485f1744016 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -48,7 +48,6 @@
 
 #include <linux/bitops.h>
 #include <linux/if_arp.h>
-#include <linux/netdevice.h>
 
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
@@ -187,9 +186,9 @@ lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 }
 
 static struct lowpan_iphc_ctx *
-lowpan_iphc_ctx_get_by_id(const struct net_device *dev, u8 id)
+lowpan_iphc_ctx_get_by_id(struct lowpan_dev *ldev, u8 id)
 {
-	struct lowpan_iphc_ctx *ret = &lowpan_dev(dev)->ctx.table[id];
+	struct lowpan_iphc_ctx *ret = &ldev->ctx.table[id];
 
 	if (!lowpan_iphc_ctx_is_active(ret))
 		return NULL;
@@ -198,10 +197,10 @@ lowpan_iphc_ctx_get_by_id(const struct net_device *dev, u8 id)
 }
 
 static struct lowpan_iphc_ctx *
-lowpan_iphc_ctx_get_by_addr(const struct net_device *dev,
+lowpan_iphc_ctx_get_by_addr(struct lowpan_dev *ldev,
 			    const struct in6_addr *addr)
 {
-	struct lowpan_iphc_ctx *table = lowpan_dev(dev)->ctx.table;
+	struct lowpan_iphc_ctx *table = ldev->ctx.table;
 	struct lowpan_iphc_ctx *ret = NULL;
 	struct in6_addr addr_pfx;
 	u8 addr_plen;
@@ -242,10 +241,10 @@ lowpan_iphc_ctx_get_by_addr(const struct net_device *dev,
 }
 
 static struct lowpan_iphc_ctx *
-lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
+lowpan_iphc_ctx_get_by_mcast_addr(struct lowpan_dev *ldev,
 				  const struct in6_addr *addr)
 {
-	struct lowpan_iphc_ctx *table = lowpan_dev(dev)->ctx.table;
+	struct lowpan_iphc_ctx *table = ldev->ctx.table;
 	struct lowpan_iphc_ctx *ret = NULL;
 	struct in6_addr addr_mcast, network_pfx = {};
 	int i;
@@ -278,15 +277,15 @@ lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
 	return ret;
 }
 
-static void lowpan_iphc_uncompress_lladdr(const struct net_device *dev,
+static void lowpan_iphc_uncompress_lladdr(const struct lowpan_dev *ldev,
 					  struct in6_addr *ipaddr,
 					  const void *lladdr)
 {
-	switch (dev->addr_len) {
-	case ETH_ALEN:
+	switch (ldev->lltype) {
+	case LOWPAN_LLTYPE_BTLE:
 		lowpan_iphc_uncompress_eui48_lladdr(ipaddr, lladdr);
 		break;
-	case EUI64_ADDR_LEN:
+	case LOWPAN_LLTYPE_IEEE802154:
 		lowpan_iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
 		break;
 	default:
@@ -301,7 +300,7 @@ static void lowpan_iphc_uncompress_lladdr(const struct net_device *dev,
  * address_mode is the masked value for sam or dam value
  */
 static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
-				       const struct net_device *dev,
+				       const struct lowpan_dev *ldev,
 				       struct in6_addr *ipaddr,
 				       u8 address_mode, const void *lladdr)
 {
@@ -332,14 +331,7 @@ static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
 	case LOWPAN_IPHC_SAM_11:
 	case LOWPAN_IPHC_DAM_11:
 		fail = false;
-		switch (lowpan_dev(dev)->lltype) {
-		case LOWPAN_LLTYPE_IEEE802154:
-			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
-			break;
-		default:
-			lowpan_iphc_uncompress_lladdr(dev, ipaddr, lladdr);
-			break;
-		}
+		lowpan_iphc_uncompress_lladdr(ldev, ipaddr, lladdr);
 		break;
 	default:
 		pr_debug("Invalid address mode value: 0x%x\n", address_mode);
@@ -361,7 +353,7 @@ static int lowpan_iphc_uncompress_addr(struct sk_buff *skb,
  * based address(non-multicast).
  */
 static int lowpan_iphc_uncompress_ctx_addr(struct sk_buff *skb,
-					   const struct net_device *dev,
+					   const struct lowpan_dev *ldev,
 					   const struct lowpan_iphc_ctx *ctx,
 					   struct in6_addr *ipaddr,
 					   u8 address_mode, const void *lladdr)
@@ -393,14 +385,7 @@ static int lowpan_iphc_uncompress_ctx_addr(struct sk_buff *skb,
 	case LOWPAN_IPHC_SAM_11:
 	case LOWPAN_IPHC_DAM_11:
 		fail = false;
-		switch (lowpan_dev(dev)->lltype) {
-		case LOWPAN_LLTYPE_IEEE802154:
-			lowpan_iphc_uncompress_802154_lladdr(ipaddr, lladdr);
-			break;
-		default:
-			lowpan_iphc_uncompress_lladdr(dev, ipaddr, lladdr);
-			break;
-		}
+		lowpan_iphc_uncompress_lladdr(ldev, ipaddr, lladdr);
 		ipv6_addr_prefix_copy(ipaddr, &ctx->pfx, ctx->plen);
 		break;
 	default:
@@ -609,7 +594,7 @@ static const u8 lowpan_ttl_values[] = {
 	[LOWPAN_IPHC_HLIM_11] = 255,
 };
 
-int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
+int lowpan_header_decompress(struct sk_buff *skb, struct lowpan_dev *ldev,
 			     const void *daddr, const void *saddr)
 {
 	struct ipv6hdr hdr = {};
@@ -657,22 +642,22 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	}
 
 	if (iphc1 & LOWPAN_IPHC_SAC) {
-		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
-		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_SCI(cid));
+		spin_lock_bh(&ldev->ctx.lock);
+		ci = lowpan_iphc_ctx_get_by_id(ldev, LOWPAN_IPHC_CID_SCI(cid));
 		if (!ci) {
-			spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+			spin_unlock_bh(&ldev->ctx.lock);
 			return -EINVAL;
 		}
 
 		pr_debug("SAC bit is set. Handle context based source address.\n");
-		err = lowpan_iphc_uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
+		err = lowpan_iphc_uncompress_ctx_addr(skb, ldev, ci, &hdr.saddr,
 						      iphc1 & LOWPAN_IPHC_SAM_MASK,
 						      saddr);
-		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+		spin_unlock_bh(&ldev->ctx.lock);
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
-		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.saddr,
+		err = lowpan_iphc_uncompress_addr(skb, ldev, &hdr.saddr,
 						  iphc1 & LOWPAN_IPHC_SAM_MASK,
 						  saddr);
 	}
@@ -685,10 +670,10 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	case LOWPAN_IPHC_M | LOWPAN_IPHC_DAC:
 		skb->pkt_type = PACKET_BROADCAST;
 
-		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
-		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
+		spin_lock_bh(&ldev->ctx.lock);
+		ci = lowpan_iphc_ctx_get_by_id(ldev, LOWPAN_IPHC_CID_DCI(cid));
 		if (!ci) {
-			spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+			spin_unlock_bh(&ldev->ctx.lock);
 			return -EINVAL;
 		}
 
@@ -697,7 +682,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		err = lowpan_uncompress_multicast_ctx_daddr(skb, ci,
 							    &hdr.daddr,
 							    iphc1 & LOWPAN_IPHC_DAM_MASK);
-		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+		spin_unlock_bh(&ldev->ctx.lock);
 		break;
 	case LOWPAN_IPHC_M:
 		skb->pkt_type = PACKET_BROADCAST;
@@ -709,24 +694,24 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	case LOWPAN_IPHC_DAC:
 		skb->pkt_type = PACKET_HOST;
 
-		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
-		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
+		spin_lock_bh(&ldev->ctx.lock);
+		ci = lowpan_iphc_ctx_get_by_id(ldev, LOWPAN_IPHC_CID_DCI(cid));
 		if (!ci) {
-			spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+			spin_unlock_bh(&ldev->ctx.lock);
 			return -EINVAL;
 		}
 
 		/* Destination address context based uncompression */
 		pr_debug("DAC bit is set. Handle context based destination address.\n");
-		err = lowpan_iphc_uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
+		err = lowpan_iphc_uncompress_ctx_addr(skb, ldev, ci, &hdr.daddr,
 						      iphc1 & LOWPAN_IPHC_DAM_MASK,
 						      daddr);
-		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+		spin_unlock_bh(&ldev->ctx.lock);
 		break;
 	default:
 		skb->pkt_type = PACKET_HOST;
 
-		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.daddr,
+		err = lowpan_iphc_uncompress_addr(skb, ldev, &hdr.daddr,
 						  iphc1 & LOWPAN_IPHC_DAM_MASK,
 						  daddr);
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
@@ -739,7 +724,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 
 	/* Next header data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH) {
-		err = lowpan_nhc_do_uncompression(skb, dev, &hdr);
+		err = lowpan_nhc_do_uncompression(skb, ldev, &hdr);
 		if (err < 0)
 			return err;
 	} else {
@@ -748,7 +733,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 			return err;
 	}
 
-	switch (lowpan_dev(dev)->lltype) {
+	switch (ldev->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_802154_cb(skb)->d_size)
 			hdr.payload_len = htons(lowpan_802154_cb(skb)->d_size -
@@ -827,14 +812,14 @@ lowpan_iphc_compress_ctx_802154_lladdr(const struct in6_addr *ipaddr,
 	return lladdr_compress;
 }
 
-static bool lowpan_iphc_addr_equal(const struct net_device *dev,
+static bool lowpan_iphc_addr_equal(const struct lowpan_dev *ldev,
 				   const struct lowpan_iphc_ctx *ctx,
 				   const struct in6_addr *ipaddr,
 				   const void *lladdr)
 {
 	struct in6_addr tmp = {};
 
-	lowpan_iphc_uncompress_lladdr(dev, &tmp, lladdr);
+	lowpan_iphc_uncompress_lladdr(ldev, &tmp, lladdr);
 
 	if (ctx)
 		ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
@@ -842,7 +827,7 @@ static bool lowpan_iphc_addr_equal(const struct net_device *dev,
 	return ipv6_addr_equal(&tmp, ipaddr);
 }
 
-static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
+static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct lowpan_dev *ldev,
 				   const struct in6_addr *ipaddr,
 				   const struct lowpan_iphc_ctx *ctx,
 				   const unsigned char *lladdr, bool sam)
@@ -850,7 +835,7 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
 	struct in6_addr tmp = {};
 	u8 dam;
 
-	switch (lowpan_dev(dev)->lltype) {
+	switch (ldev->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_iphc_compress_ctx_802154_lladdr(ipaddr, ctx,
 							   lladdr)) {
@@ -859,7 +844,7 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
 		}
 		break;
 	default:
-		if (lowpan_iphc_addr_equal(dev, ctx, ipaddr, lladdr)) {
+		if (lowpan_iphc_addr_equal(ldev, ctx, ipaddr, lladdr)) {
 			dam = LOWPAN_IPHC_DAM_11;
 			goto out;
 		}
@@ -940,13 +925,13 @@ lowpan_iphc_compress_802154_lladdr(const struct in6_addr *ipaddr,
 	return lladdr_compress;
 }
 
-static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct net_device *dev,
+static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct lowpan_dev *ldev,
 				  const struct in6_addr *ipaddr,
 				  const unsigned char *lladdr, bool sam)
 {
 	u8 dam = LOWPAN_IPHC_DAM_01;
 
-	switch (lowpan_dev(dev)->lltype) {
+	switch (ldev->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_iphc_compress_802154_lladdr(ipaddr, lladdr)) {
 			dam = LOWPAN_IPHC_DAM_11; /* 0-bits */
@@ -955,7 +940,7 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct net_device *dev,
 		}
 		break;
 	default:
-		if (lowpan_iphc_addr_equal(dev, NULL, ipaddr, lladdr)) {
+		if (lowpan_iphc_addr_equal(ldev, NULL, ipaddr, lladdr)) {
 			dam = LOWPAN_IPHC_DAM_11;
 			pr_debug("address compression 0 bits\n");
 			goto out;
@@ -1127,7 +1112,7 @@ static u8 lowpan_iphc_mcast_addr_compress(u8 **hc_ptr,
 	return val;
 }
 
-int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
+int lowpan_header_compress(struct sk_buff *skb, struct lowpan_dev *ldev,
 			   const void *daddr, const void *saddr)
 {
 	u8 iphc0, iphc1, *hc_ptr, cid = 0;
@@ -1162,24 +1147,24 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		       skb->data, skb->len);
 
 	ipv6_daddr_type = ipv6_addr_type(&hdr->daddr);
-	spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
+	spin_lock_bh(&ldev->ctx.lock);
 	if (ipv6_daddr_type & IPV6_ADDR_MULTICAST)
-		dci = lowpan_iphc_ctx_get_by_mcast_addr(dev, &hdr->daddr);
+		dci = lowpan_iphc_ctx_get_by_mcast_addr(ldev, &hdr->daddr);
 	else
-		dci = lowpan_iphc_ctx_get_by_addr(dev, &hdr->daddr);
+		dci = lowpan_iphc_ctx_get_by_addr(ldev, &hdr->daddr);
 	if (dci) {
 		memcpy(&dci_entry, dci, sizeof(*dci));
 		cid |= dci->id;
 	}
-	spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+	spin_unlock_bh(&ldev->ctx.lock);
 
-	spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
-	sci = lowpan_iphc_ctx_get_by_addr(dev, &hdr->saddr);
+	spin_lock_bh(&ldev->ctx.lock);
+	sci = lowpan_iphc_ctx_get_by_addr(ldev, &hdr->saddr);
 	if (sci) {
 		memcpy(&sci_entry, sci, sizeof(*sci));
 		cid |= (sci->id << 4);
 	}
-	spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
+	spin_unlock_bh(&ldev->ctx.lock);
 
 	/* if cid is zero it will be compressed */
 	if (cid) {
@@ -1230,7 +1215,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		iphc1 |= LOWPAN_IPHC_SAC;
 	} else {
 		if (sci) {
-			iphc1 |= lowpan_compress_ctx_addr(&hc_ptr, dev,
+			iphc1 |= lowpan_compress_ctx_addr(&hc_ptr, ldev,
 							  &hdr->saddr,
 							  &sci_entry, saddr,
 							  true);
@@ -1238,7 +1223,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		} else {
 			if (ipv6_saddr_type & IPV6_ADDR_LINKLOCAL &&
 			    lowpan_is_linklocal_zero_padded(hdr->saddr)) {
-				iphc1 |= lowpan_compress_addr_64(&hc_ptr, dev,
+				iphc1 |= lowpan_compress_addr_64(&hc_ptr, ldev,
 								 &hdr->saddr,
 								 saddr, true);
 				pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
@@ -1266,7 +1251,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		}
 	} else {
 		if (dci) {
-			iphc1 |= lowpan_compress_ctx_addr(&hc_ptr, dev,
+			iphc1 |= lowpan_compress_ctx_addr(&hc_ptr, ldev,
 							  &hdr->daddr,
 							  &dci_entry, daddr,
 							  false);
@@ -1274,7 +1259,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		} else {
 			if (ipv6_daddr_type & IPV6_ADDR_LINKLOCAL &&
 			    lowpan_is_linklocal_zero_padded(hdr->daddr)) {
-				iphc1 |= lowpan_compress_addr_64(&hc_ptr, dev,
+				iphc1 |= lowpan_compress_addr_64(&hc_ptr, ldev,
 								 &hdr->daddr,
 								 daddr, false);
 				pr_debug("dest address unicast link-local %pI6c iphc1 0x%02x\n",
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 4fa2fdda174d..7d695bbd4bb5 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -155,7 +155,7 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
 }
 
 int lowpan_nhc_do_uncompression(struct sk_buff *skb,
-				const struct net_device *dev,
+				const struct lowpan_dev *ldev,
 				struct ipv6hdr *hdr)
 {
 	struct lowpan_nhc *nhc;
@@ -174,13 +174,13 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
 			}
 		} else {
 			spin_unlock_bh(&lowpan_nhc_lock);
-			netdev_warn(dev, "received nhc id for %s which is not implemented.\n",
-				    nhc->name);
+			/* netdev_warn(dev, "received nhc id for %s which is not implemented.\n", */
+			/* 	    nhc->name); */
 			return -ENOTSUPP;
 		}
 	} else {
 		spin_unlock_bh(&lowpan_nhc_lock);
-		netdev_warn(dev, "received unknown nhc id which was not found.\n");
+		/* netdev_warn(dev, "received unknown nhc id which was not found.\n"); */
 		return -ENOENT;
 	}
 
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index 803041400136..d2e594ea89f1 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -117,7 +117,7 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
  * @hdr: ipv6hdr for setting nexthdr value.
  */
 int lowpan_nhc_do_uncompression(struct sk_buff *skb,
-				const struct net_device *dev,
+				const struct lowpan_dev *ldev,
 				struct ipv6hdr *hdr);
 
 /**
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4e2576fc0c59..6b45c890aa47 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -276,7 +276,8 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 
 	saddr = peer->lladdr;
 
-	return lowpan_header_decompress(skb, netdev, netdev->dev_addr, saddr);
+	return lowpan_header_decompress(skb, lowpan_dev(netdev),
+					netdev->dev_addr, saddr);
 }
 
 static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
@@ -431,7 +432,8 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 		status = 1;
 	}
 
-	lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr);
+	lowpan_header_compress(skb, lowpan_dev(netdev), daddr,
+			dev->netdev->dev_addr);
 
 	err = dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
 	if (err < 0)
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 649e7d45e88f..c29249be3114 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -95,7 +95,8 @@ int lowpan_iphc_decompress(struct sk_buff *skb)
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		return -EINVAL;
 
-	return lowpan_header_decompress(skb, skb->dev, &hdr.dest, &hdr.source);
+	return lowpan_header_decompress(skb, lowpan_dev(skb->dev), &hdr.dest,
+					&hdr.source);
 }
 
 static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index e6ff5128e61a..b748efba4fba 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -236,7 +236,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
 
 	*dgram_size = skb->len;
-	lowpan_header_compress(skb, ldev, &info.daddr, &info.saddr);
+	lowpan_header_compress(skb, lowpan_dev(ldev), &info.daddr, &info.saddr);
 	/* dgram_offset = (saved bytes after compression) + lowpan header len */
 	*dgram_offset = (*dgram_size - skb->len) + skb_network_header_len(skb);
 
-- 
2.11.0

