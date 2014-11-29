Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:42327 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaK2OZ4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 29 Nov 2014 09:25:56 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] 6lowpan: add udp compression via nhc layer
Date: Sat, 29 Nov 2014 15:24:42 +0100
Message-Id: <1417271082-10068-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1417271082-10068-1-git-send-email-alex.aring@gmail.com>
References: <1417271082-10068-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

This patch move UDP header compression and uncompression into the
generic 6LoWPAN nhc header compression layer. Moreover this patch
activates the nhc layer compression in iphc compression and
uncompression functions.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>
---
 net/6lowpan/Makefile  |   3 +-
 net/6lowpan/iphc.c    | 188 +++++++-------------------------------------------
 net/6lowpan/nhc.c     |   3 +-
 net/6lowpan/nhc.h     |   4 ++
 net/6lowpan/nhc_udp.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 205 insertions(+), 166 deletions(-)
 create mode 100644 net/6lowpan/nhc_udp.c

diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index ba6bf47..172045e 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_6LOWPAN) := 6lowpan.o
 
 6lowpan-y := \
 	iphc.o \
-	nhc.o
+	nhc.o \
+	nhc_udp.o
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index aced97d..40ed0aa 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -57,6 +57,8 @@
 #include <net/ipv6.h>
 #include <net/af_ieee802154.h>
 
+#include "nhc.h"
+
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
@@ -227,77 +229,6 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
 	return 0;
 }
 
-static int uncompress_udp_header(struct sk_buff *skb, struct udphdr *uh)
-{
-	bool fail;
-	u8 tmp = 0, val = 0;
-
-	fail = lowpan_fetch_skb(skb, &tmp, sizeof(tmp));
-
-	if ((tmp & LOWPAN_NHC_UDP_MASK) == LOWPAN_NHC_UDP_ID) {
-		pr_debug("UDP header uncompression\n");
-		switch (tmp & LOWPAN_NHC_UDP_CS_P_11) {
-		case LOWPAN_NHC_UDP_CS_P_00:
-			fail |= lowpan_fetch_skb(skb, &uh->source,
-						 sizeof(uh->source));
-			fail |= lowpan_fetch_skb(skb, &uh->dest,
-						 sizeof(uh->dest));
-			break;
-		case LOWPAN_NHC_UDP_CS_P_01:
-			fail |= lowpan_fetch_skb(skb, &uh->source,
-						 sizeof(uh->source));
-			fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
-			uh->dest = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
-			break;
-		case LOWPAN_NHC_UDP_CS_P_10:
-			fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
-			uh->source = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
-			fail |= lowpan_fetch_skb(skb, &uh->dest,
-						 sizeof(uh->dest));
-			break;
-		case LOWPAN_NHC_UDP_CS_P_11:
-			fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
-			uh->source = htons(LOWPAN_NHC_UDP_4BIT_PORT +
-					   (val >> 4));
-			uh->dest = htons(LOWPAN_NHC_UDP_4BIT_PORT +
-					 (val & 0x0f));
-			break;
-		default:
-			pr_debug("ERROR: unknown UDP format\n");
-			goto err;
-		}
-
-		pr_debug("uncompressed UDP ports: src = %d, dst = %d\n",
-			 ntohs(uh->source), ntohs(uh->dest));
-
-		/* checksum */
-		if (tmp & LOWPAN_NHC_UDP_CS_C) {
-			pr_debug_ratelimited("checksum elided currently not supported\n");
-			goto err;
-		} else {
-			fail |= lowpan_fetch_skb(skb, &uh->check,
-						 sizeof(uh->check));
-		}
-
-		/* UDP length needs to be infered from the lower layers
-		 * here, we obtain the hint from the remaining size of the
-		 * frame
-		 */
-		uh->len = htons(skb->len + sizeof(struct udphdr));
-		pr_debug("uncompressed UDP length: src = %d", ntohs(uh->len));
-	} else {
-		pr_debug("ERROR: unsupported NH format\n");
-		goto err;
-	}
-
-	if (fail)
-		goto err;
-
-	return 0;
-err:
-	return -EINVAL;
-}
-
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
@@ -430,27 +361,9 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 
 	/* UDP data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH_C) {
-		struct udphdr uh;
-		const int needed = sizeof(struct udphdr) + sizeof(hdr);
-
-		if (uncompress_udp_header(skb, &uh))
-			return -EINVAL;
-
-		/* replace the compressed UDP head by the uncompressed UDP
-		 * header
-		 */
-		err = skb_cow(skb, needed);
-		if (unlikely(err))
+		err = lowpan_nhc_do_uncompression(skb, &hdr);
+		if (err < 0)
 			return err;
-
-		skb_push(skb, sizeof(struct udphdr));
-		skb_reset_transport_header(skb);
-		skb_copy_to_linear_data(skb, &uh, sizeof(struct udphdr));
-
-		raw_dump_table(__func__, "raw UDP header dump",
-			       (u8 *)&uh, sizeof(uh));
-
-		hdr.nexthdr = UIP_PROTO_UDP;
 	} else {
 		err = skb_cow(skb, sizeof(hdr));
 		if (unlikely(err))
@@ -503,79 +416,15 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 	return rol8(val, shift);
 }
 
-static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
-{
-	struct udphdr *uh;
-	u8 tmp;
-
-	/* In the case of RAW sockets the transport header is not set by
-	 * the ip6 stack so we must set it ourselves
-	 */
-	if (skb->transport_header == skb->network_header)
-		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
-
-	uh = udp_hdr(skb);
-
-	if (((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_MASK) ==
-	     LOWPAN_NHC_UDP_4BIT_PORT) &&
-	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==
-	     LOWPAN_NHC_UDP_4BIT_PORT)) {
-		pr_debug("UDP header: both ports compression to 4 bits\n");
-		/* compression value */
-		tmp = LOWPAN_NHC_UDP_CS_P_11;
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-		/* source and destination port */
-		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT +
-		      ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4);
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
-			LOWPAN_NHC_UDP_8BIT_PORT) {
-		pr_debug("UDP header: remove 8 bits of dest\n");
-		/* compression value */
-		tmp = LOWPAN_NHC_UDP_CS_P_01;
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-		/* source port */
-		lowpan_push_hc_data(hc_ptr, &uh->source, sizeof(uh->source));
-		/* destination port */
-		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_8BIT_PORT;
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-	} else if ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) ==
-			LOWPAN_NHC_UDP_8BIT_PORT) {
-		pr_debug("UDP header: remove 8 bits of source\n");
-		/* compression value */
-		tmp = LOWPAN_NHC_UDP_CS_P_10;
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-		/* source port */
-		tmp = ntohs(uh->source) - LOWPAN_NHC_UDP_8BIT_PORT;
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-		/* destination port */
-		lowpan_push_hc_data(hc_ptr, &uh->dest, sizeof(uh->dest));
-	} else {
-		pr_debug("UDP header: can't compress\n");
-		/* compression value */
-		tmp = LOWPAN_NHC_UDP_CS_P_00;
-		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
-		/* source port */
-		lowpan_push_hc_data(hc_ptr, &uh->source, sizeof(uh->source));
-		/* destination port */
-		lowpan_push_hc_data(hc_ptr, &uh->dest, sizeof(uh->dest));
-	}
-
-	/* checksum is always inline */
-	lowpan_push_hc_data(hc_ptr, &uh->check, sizeof(uh->check));
-
-	/* skip the UDP header */
-	skb_pull(skb, sizeof(struct udphdr));
-}
-
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			   unsigned short type, const void *_daddr,
 			   const void *_saddr, unsigned int len)
 {
 	u8 tmp, iphc0, iphc1, *hc_ptr;
+	struct lowpan_nhc *nhc;
 	struct ipv6hdr *hdr;
 	u8 head[100] = {};
-	int addr_type;
+	int ret, addr_type;
 
 	if (type != ETH_P_IPV6)
 		return -EINVAL;
@@ -652,11 +501,10 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 
 	/* NOTE: payload length is always compressed */
 
-	/* Next Header is compress if UDP */
-	if (hdr->nexthdr == UIP_PROTO_UDP)
+	nhc = lowpan_nhc_by_nexthdr(hdr->nexthdr);
+	if (nhc)
 		iphc0 |= LOWPAN_IPHC_NH_C;
-
-	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0)
+	else
 		lowpan_push_hc_data(&hc_ptr, &hdr->nexthdr,
 				    sizeof(hdr->nexthdr));
 
@@ -744,9 +592,9 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	/* UDP header compression */
-	if (hdr->nexthdr == UIP_PROTO_UDP)
-		compress_udp_header(&hc_ptr, skb);
+	ret = lowpan_nhc_do_compression(nhc, skb, &hc_ptr, &iphc0);
+	if (ret < 0)
+		return ret;
 
 	head[0] = iphc0;
 	head[1] = iphc1;
@@ -764,4 +612,16 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(lowpan_header_compress);
 
+static int __init iphc_init(void)
+{
+	return lowpan_nhc_init();
+}
+
+static void __exit iphc_cleanup(void)
+{
+	lowpan_nhc_cleanup();
+}
+
 MODULE_LICENSE("GPL");
+module_init(iphc_init);
+module_exit(iphc_cleanup);
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index e0b2bd1..fca7e4d 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -174,9 +174,10 @@ void lowpan_nhc_del(struct lowpan_nhc *nhc)
 
 int lowpan_nhc_init(void)
 {
-	return 0;
+	return lowpan_nhc_udp_init();
 }
 
 void lowpan_nhc_cleanup(void)
 {
+	lowpan_nhc_udp_cleanup();
 }
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index f83f06e..39a4fc0 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -125,4 +125,8 @@ int lowpan_nhc_init(void);
  */
 void lowpan_nhc_cleanup(void);
 
+/* next header compressions */
+int lowpan_nhc_udp_init(void);
+void lowpan_nhc_udp_cleanup(void);
+
 #endif /* __6LOWPAN_NHC_H */
diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
new file mode 100644
index 0000000..6142539
--- /dev/null
+++ b/net/6lowpan/nhc_udp.c
@@ -0,0 +1,173 @@
+/*	6LoWPAN IPv6 UDP compression
+ *
+ *
+ *	Authors:
+ *	Alexander Aring	<aar@pengutronix.de>
+ *
+ *	Orignal written by:
+ *	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
+ *	Jon Smirl <jonsmirl@gmail.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include "nhc.h"
+
+#define LOWPAN_NHC_UDP_IDLEN	1
+
+static int udp_uncompress(struct sk_buff *skb, size_t needed)
+{
+	u8 tmp = 0, val = 0;
+	struct udphdr uh;
+	bool fail;
+	int err;
+
+	fail = lowpan_fetch_skb(skb, &tmp, sizeof(tmp));
+
+	pr_debug("UDP header uncompression\n");
+	switch (tmp & LOWPAN_NHC_UDP_CS_P_11) {
+	case LOWPAN_NHC_UDP_CS_P_00:
+		fail |= lowpan_fetch_skb(skb, &uh.source, sizeof(uh.source));
+		fail |= lowpan_fetch_skb(skb, &uh.dest, sizeof(uh.dest));
+		break;
+	case LOWPAN_NHC_UDP_CS_P_01:
+		fail |= lowpan_fetch_skb(skb, &uh.source, sizeof(uh.source));
+		fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
+		uh.dest = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
+		break;
+	case LOWPAN_NHC_UDP_CS_P_10:
+		fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
+		uh.source = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
+		fail |= lowpan_fetch_skb(skb, &uh.dest, sizeof(uh.dest));
+		break;
+	case LOWPAN_NHC_UDP_CS_P_11:
+		fail |= lowpan_fetch_skb(skb, &val, sizeof(val));
+		uh.source = htons(LOWPAN_NHC_UDP_4BIT_PORT + (val >> 4));
+		uh.dest = htons(LOWPAN_NHC_UDP_4BIT_PORT + (val & 0x0f));
+		break;
+	default:
+		BUG();
+	}
+
+	pr_debug("uncompressed UDP ports: src = %d, dst = %d\n",
+		 ntohs(uh.source), ntohs(uh.dest));
+
+	/* checksum */
+	if (tmp & LOWPAN_NHC_UDP_CS_C) {
+		pr_debug_ratelimited("checksum elided currently not supported\n");
+		fail = true;
+	} else {
+		fail |= lowpan_fetch_skb(skb, &uh.check, sizeof(uh.check));
+	}
+
+	if (fail)
+		return -EINVAL;
+
+	/* UDP length needs to be infered from the lower layers
+	 * here, we obtain the hint from the remaining size of the
+	 * frame
+	 */
+	uh.len = htons(skb->len + sizeof(struct udphdr));
+	pr_debug("uncompressed UDP length: src = %d", ntohs(uh.len));
+
+	/* replace the compressed UDP head by the uncompressed UDP
+	 * header
+	 */
+	err = skb_cow(skb, needed);
+	if (unlikely(err))
+		return err;
+
+	skb_push(skb, sizeof(struct udphdr));
+	skb_copy_to_linear_data(skb, &uh, sizeof(struct udphdr));
+
+	return 0;
+}
+
+static int udp_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	struct udphdr *uh;
+	u8 tmp;
+
+	/* In the case of RAW sockets the transport header is not set by
+	 * the ip6 stack so we must set it ourselves
+	 */
+	if (skb->transport_header == skb->network_header)
+		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+
+	uh = udp_hdr(skb);
+
+	if (((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_MASK) ==
+	     LOWPAN_NHC_UDP_4BIT_PORT) &&
+	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==
+	     LOWPAN_NHC_UDP_4BIT_PORT)) {
+		pr_debug("UDP header: both ports compression to 4 bits\n");
+		/* compression value */
+		tmp = LOWPAN_NHC_UDP_CS_P_11;
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+		/* source and destination port */
+		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_4BIT_PORT +
+		      ((ntohs(uh->source) - LOWPAN_NHC_UDP_4BIT_PORT) << 4);
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+	} else if ((ntohs(uh->dest) & LOWPAN_NHC_UDP_8BIT_MASK) ==
+			LOWPAN_NHC_UDP_8BIT_PORT) {
+		pr_debug("UDP header: remove 8 bits of dest\n");
+		/* compression value */
+		tmp = LOWPAN_NHC_UDP_CS_P_01;
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+		/* source port */
+		lowpan_push_hc_data(hc_ptr, &uh->source, sizeof(uh->source));
+		/* destination port */
+		tmp = ntohs(uh->dest) - LOWPAN_NHC_UDP_8BIT_PORT;
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+	} else if ((ntohs(uh->source) & LOWPAN_NHC_UDP_8BIT_MASK) ==
+			LOWPAN_NHC_UDP_8BIT_PORT) {
+		pr_debug("UDP header: remove 8 bits of source\n");
+		/* compression value */
+		tmp = LOWPAN_NHC_UDP_CS_P_10;
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+		/* source port */
+		tmp = ntohs(uh->source) - LOWPAN_NHC_UDP_8BIT_PORT;
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+		/* destination port */
+		lowpan_push_hc_data(hc_ptr, &uh->dest, sizeof(uh->dest));
+	} else {
+		pr_debug("UDP header: can't compress\n");
+		/* compression value */
+		tmp = LOWPAN_NHC_UDP_CS_P_00;
+		lowpan_push_hc_data(hc_ptr, &tmp, sizeof(tmp));
+		/* source port */
+		lowpan_push_hc_data(hc_ptr, &uh->source, sizeof(uh->source));
+		/* destination port */
+		lowpan_push_hc_data(hc_ptr, &uh->dest, sizeof(uh->dest));
+	}
+
+	/* checksum is always inline */
+	lowpan_push_hc_data(hc_ptr, &uh->check, sizeof(uh->check));
+
+	/* skip the UDP header */
+	skb_pull(skb, sizeof(struct udphdr));
+
+	return 0;
+}
+
+static void udp_nhid_setup(struct lowpan_nhc *nhc)
+{
+	nhc->id[0] = LOWPAN_NHC_UDP_ID;
+	nhc->idmask[0] = LOWPAN_NHC_UDP_MASK;
+}
+
+LOWPAN_NHC(udp_nhc, "IPv6 UDP Header", NEXTHDR_UDP, sizeof(struct udphdr),
+	   udp_nhid_setup, LOWPAN_NHC_UDP_IDLEN, udp_uncompress, udp_compress);
+
+int lowpan_nhc_udp_init(void)
+{
+	return lowpan_nhc_add(&udp_nhc);
+}
+
+void lowpan_nhc_udp_cleanup(void)
+{
+	lowpan_nhc_del(&udp_nhc);
+}
-- 
2.1.3

