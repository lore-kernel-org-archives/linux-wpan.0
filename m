Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36759 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbbJMLnl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Oct 2015 07:43:41 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/6] 6lowpan: cleanup lowpan_header_decompress
Date: Tue, 13 Oct 2015 13:42:58 +0200
Message-Id: <1444736579-27826-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
References: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch changes the lowpan_header_decompress function by removing
inklayer related information from parameters. This is currently for
supporting short and extended address for iphc handling in 802154.
We don't support short address handling anyway right now, but there
exists already code for handling short addresses in
lowpan_header_decompress.

The address parameters are also changed to a void pointer, so 6LoWPAN
linklayer specific code can put complex structures as these parameters
and cast it again inside the generic code by evaluating linklayer type
before. The order is also changed by destination address at first and
then source address, which is the same like all others functions where
destination is always the first, memcpy, dev_hard_header,
lowpan_header_compress, etc.

This patch also moves the fetching of iphc values from 6LoWPAN linklayer
specific code into the generic branch.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h       |  24 +++++++---
 include/net/mac802154.h     |  10 ++++
 net/6lowpan/iphc.c          | 113 +++++++++++++++++++++++++++-----------------
 net/6lowpan/nhc.c           |   3 +-
 net/6lowpan/nhc.h           |   3 +-
 net/bluetooth/6lowpan.c     |  20 +-------
 net/ieee802154/6lowpan/rx.c |  26 +---------
 7 files changed, 103 insertions(+), 96 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 6f1e0bd..ac30ad3 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -319,12 +319,24 @@ static inline void lowpan_push_hc_data(u8 **hc_ptr, const void *data,
 
 void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype);
 
-int
-lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
-			 const u8 *saddr, const u8 saddr_type,
-			 const u8 saddr_len, const u8 *daddr,
-			 const u8 daddr_type, const u8 daddr_len,
-			 u8 iphc0, u8 iphc1);
+/**
+ * lowpan_header_decompress - replace 6LoWPAN header with IPv6 header
+ *
+ * This function replaces the IPHC 6LoWPAN header which should be pointed at
+ * skb->data and skb_network_header, with the IPv6 header.
+ * It would be nice that the caller have the necessary headroom of IPv6 header
+ * and greatest Transport layer header, this would reduce the overhead for
+ * reallocate headroom.
+ *
+ * @skb: the buffer which should be manipulate.
+ * @dev: the lowpan net device pointer.
+ * @daddr: destination lladdr of mac header which is used for compression
+ *	methods.
+ * @saddr: source lladdr of mac header which is used for compression
+ *	methods.
+ */
+int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
+			     const void *daddr, const void *saddr);
 
 /**
  * lowpan_header_compress - replace IPv6 header with 6LoWPAN header
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 5718765..da574bb 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -277,6 +277,16 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
 }
 
 /**
+ * ieee802154_le16_to_be16 - copies and convert le16 to be16
+ * @be16_dst: be16 destination pointer
+ * @le16_src: le16 source pointer
+ */
+static inline void ieee802154_le16_to_be16(void *be16_dst, const void *le16_src)
+{
+	__put_unaligned_memmove16(swab16p(le16_src), be16_dst);
+}
+
+/**
  * ieee802154_alloc_hw - Allocate a new hardware device
  *
  * This must be called once for each hardware device. The returned pointer
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 4e4af8c..8f967d3 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -49,21 +49,71 @@
 #include <linux/bitops.h>
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
+
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
-#include <net/af_ieee802154.h>
+
+/* special link-layer handling */
+#include <net/mac802154.h>
 
 #include "nhc.h"
 
+static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
+						const void *lladdr)
+{
+	/* fe:80::XXXX:XXXX:XXXX:XXXX
+	 *        \_________________/
+	 *              hwaddr
+	 */
+	ipaddr->s6_addr[0] = 0xFE;
+	ipaddr->s6_addr[1] = 0x80;
+	memcpy(&ipaddr->s6_addr[8], lladdr, EUI64_ADDR_LEN);
+	/* second bit-flip (Universe/Local)
+	 * is done according RFC2464
+	 */
+	ipaddr->s6_addr[8] ^= 0x02;
+}
+
+static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
+						 const void *lladdr)
+{
+	const struct ieee802154_addr *addr = lladdr;
+	u8 eui64[EUI64_ADDR_LEN] = { };
+
+	switch (addr->mode) {
+	case IEEE802154_ADDR_LONG:
+		ieee802154_le64_to_be64(eui64, &addr->extended_addr);
+		iphc_uncompress_eui64_lladdr(ipaddr, eui64);
+		break;
+	case IEEE802154_ADDR_SHORT:
+		/* fe:80::ff:fe00:XXXX
+		 *                \__/
+		 *             short_addr
+		 *
+		 * Universe/Local bit is zero.
+		 */
+		ipaddr->s6_addr[0] = 0xFE;
+		ipaddr->s6_addr[1] = 0x80;
+		ipaddr->s6_addr[11] = 0xFF;
+		ipaddr->s6_addr[12] = 0xFE;
+		ieee802154_le16_to_be16(&ipaddr->s6_addr16[7],
+					&addr->short_addr);
+		break;
+	default:
+		/* should never handled and filtered by 802154 6lowpan */
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
  * address_mode is sam value or dam value.
  */
-static int uncompress_addr(struct sk_buff *skb,
-			   struct in6_addr *ipaddr, const u8 address_mode,
-			   const u8 *lladdr, const u8 addr_type,
-			   const u8 addr_len)
+static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
+			   struct in6_addr *ipaddr, u8 address_mode,
+			   const void *lladdr)
 {
 	bool fail;
 
@@ -88,36 +138,13 @@ static int uncompress_addr(struct sk_buff *skb,
 		break;
 	case LOWPAN_IPHC_ADDR_03:
 		fail = false;
-		switch (addr_type) {
-		case IEEE802154_ADDR_LONG:
-			/* fe:80::XXXX:XXXX:XXXX:XXXX
-			 *        \_________________/
-			 *              hwaddr
-			 */
-			ipaddr->s6_addr[0] = 0xFE;
-			ipaddr->s6_addr[1] = 0x80;
-			memcpy(&ipaddr->s6_addr[8], lladdr, addr_len);
-			/* second bit-flip (Universe/Local)
-			 * is done according RFC2464
-			 */
-			ipaddr->s6_addr[8] ^= 0x02;
-			break;
-		case IEEE802154_ADDR_SHORT:
-			/* fe:80::ff:fe00:XXXX
-			 *		  \__/
-			 *	       short_addr
-			 *
-			 * Universe/Local bit is zero.
-			 */
-			ipaddr->s6_addr[0] = 0xFE;
-			ipaddr->s6_addr[1] = 0x80;
-			ipaddr->s6_addr[11] = 0xFF;
-			ipaddr->s6_addr[12] = 0xFE;
-			ipaddr->s6_addr16[7] = htons(*((u16 *)lladdr));
+		switch (lowpan_priv(dev)->lltype) {
+		case LOWPAN_LLTYPE_IEEE802154:
+			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
 		default:
-			pr_debug("Invalid addr_type set\n");
-			return -EINVAL;
+			iphc_uncompress_eui64_lladdr(ipaddr, lladdr);
+			break;
 		}
 		break;
 	default:
@@ -228,20 +255,20 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int
-lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
-			 const u8 *saddr, const u8 saddr_type,
-			 const u8 saddr_len, const u8 *daddr,
-			 const u8 daddr_type, const u8 daddr_len,
-			 u8 iphc0, u8 iphc1)
+int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
+			     const void *daddr, const void *saddr)
 {
 	struct ipv6hdr hdr = {};
-	u8 tmp, num_context = 0;
+	u8 iphc0, iphc1, tmp, num_context = 0;
 	int err;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
 		       skb->data, skb->len);
 
+	if (lowpan_fetch_skb_u8(skb, &iphc0) ||
+	    lowpan_fetch_skb_u8(skb, &iphc1))
+		return -EINVAL;
+
 	/* another if the CID flag is set */
 	if (iphc1 & LOWPAN_IPHC_CID) {
 		pr_debug("CID flag is set, increase header with one\n");
@@ -323,8 +350,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
-		err = uncompress_addr(skb, &hdr.saddr, tmp, saddr,
-				      saddr_type, saddr_len);
+		err = uncompress_addr(skb, dev, &hdr.saddr, tmp, saddr);
 	}
 
 	/* Check on error of previous branch */
@@ -347,8 +373,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 				return -EINVAL;
 		}
 	} else {
-		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
-				      daddr_type, daddr_len);
+		err = uncompress_addr(skb, dev, &hdr.daddr, tmp, daddr);
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
 			 tmp, &hdr.daddr);
 		if (err)
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index fd20fc5..589224e 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -157,7 +157,8 @@ out:
 	return ret;
 }
 
-int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct net_device *dev,
+int lowpan_nhc_do_uncompression(struct sk_buff *skb,
+				const struct net_device *dev,
 				struct ipv6hdr *hdr)
 {
 	struct lowpan_nhc *nhc;
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index c249f17..e3a5644 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -119,7 +119,8 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
  * @dev: netdevice for print logging information.
  * @hdr: ipv6hdr for setting nexthdr value.
  */
-int lowpan_nhc_do_uncompression(struct sk_buff *skb, struct net_device *dev,
+int lowpan_nhc_do_uncompression(struct sk_buff *skb,
+				const struct net_device *dev,
 				struct ipv6hdr *hdr);
 
 /**
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index e2b66f3..4057d6e 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -21,8 +21,6 @@
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 
-#include <net/af_ieee802154.h> /* to get the address type */
-
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
@@ -272,7 +270,6 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 			   struct l2cap_chan *chan)
 {
 	const u8 *saddr, *daddr;
-	u8 iphc0, iphc1;
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
 
@@ -287,22 +284,7 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 	saddr = peer->eui64_addr;
 	daddr = dev->netdev->dev_addr;
 
-	/* at least two bytes will be used for the encoding */
-	if (skb->len < 2)
-		return -EINVAL;
-
-	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		return -EINVAL;
-
-	if (lowpan_fetch_skb_u8(skb, &iphc1))
-		return -EINVAL;
-
-	return lowpan_header_decompress(skb, netdev,
-					saddr, IEEE802154_ADDR_LONG,
-					EUI64_ADDR_LEN, daddr,
-					IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
-					iphc0, iphc1);
-
+	return lowpan_header_decompress(skb, netdev, daddr, saddr);
 }
 
 static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 65d55e0..403f171 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -90,36 +90,12 @@ static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
 
 int lowpan_iphc_decompress(struct sk_buff *skb)
 {
-	struct ieee802154_addr_sa sa, da;
 	struct ieee802154_hdr hdr;
-	u8 iphc0, iphc1;
-	void *sap, *dap;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
 		return -EINVAL;
 
-	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
-
-	if (lowpan_fetch_skb_u8(skb, &iphc0) ||
-	    lowpan_fetch_skb_u8(skb, &iphc1))
-		return -EINVAL;
-
-	ieee802154_addr_to_sa(&sa, &hdr.source);
-	ieee802154_addr_to_sa(&da, &hdr.dest);
-
-	if (sa.addr_type == IEEE802154_ADDR_SHORT)
-		sap = &sa.short_addr;
-	else
-		sap = &sa.hwaddr;
-
-	if (da.addr_type == IEEE802154_ADDR_SHORT)
-		dap = &da.short_addr;
-	else
-		dap = &da.hwaddr;
-
-	return lowpan_header_decompress(skb, skb->dev, sap, sa.addr_type,
-					IEEE802154_ADDR_LEN, dap, da.addr_type,
-					IEEE802154_ADDR_LEN, iphc0, iphc1);
+	return lowpan_header_decompress(skb, skb->dev, &hdr.dest, &hdr.source);
 }
 
 static lowpan_rx_result lowpan_rx_h_iphc(struct sk_buff *skb)
-- 
2.6.1

