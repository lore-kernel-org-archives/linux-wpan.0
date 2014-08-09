Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:45457 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbaHITCn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:43 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:17 +0200
Message-Id: <1407610943-27701-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
References: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 2/8] 6lowpan: nhc layer udp compression
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch move UDP header compression and uncompression into the
generic 6LoWPAN nhc header compression layer and activate the nhc compression
via the new nhc layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c       | 184 ++++++-----------------------------------------
 net/6lowpan/nhc/Makefile |   3 +-
 net/6lowpan/nhc/core.c   |   4 +-
 net/6lowpan/nhc/udp.c    | 173 ++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/udp.h    |   9 +++
 5 files changed, 208 insertions(+), 165 deletions(-)
 create mode 100644 net/6lowpan/nhc/udp.c
 create mode 100644 net/6lowpan/nhc/udp.h

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 142eef5..a2ed820 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -57,6 +57,8 @@
 #include <net/ipv6.h>
 #include <net/af_ieee802154.h>
 
+#include "nhc/core.h"
+
 /* Uncompress address function for source and
  * destination address(non-multicast).
  *
@@ -258,77 +260,6 @@ static int lowpan_uncompress_multicast_daddr(struct sk_buff *skb,
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
 
@@ -457,34 +388,10 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 			goto drop;
 	}
 
-	/* UDP data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH_C) {
-		struct udphdr uh;
-		struct sk_buff *new;
-
-		if (uncompress_udp_header(skb, &uh))
+		err = lowpan_nhc_do_uncompression(&skb, &hdr);
+		if (err < 0)
 			goto drop;
-
-		/* replace the compressed UDP head by the uncompressed UDP
-		 * header
-		 */
-		new = skb_copy_expand(skb, sizeof(struct udphdr),
-				      skb_tailroom(skb), GFP_ATOMIC);
-		kfree_skb(skb);
-
-		if (!new)
-			return -ENOMEM;
-
-		skb = new;
-
-		skb_push(skb, sizeof(struct udphdr));
-		skb_reset_transport_header(skb);
-		skb_copy_to_linear_data(skb, &uh, sizeof(struct udphdr));
-
-		raw_dump_table(__func__, "raw UDP header dump",
-			       (u8 *)&uh, sizeof(uh));
-
-		hdr.nexthdr = UIP_PROTO_UDP;
 	}
 
 	hdr.payload_len = htons(skb->len);
@@ -533,68 +440,12 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 	return rol8(val, shift);
 }
 
-static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
-{
-	struct udphdr *uh = udp_hdr(skb);
-	u8 tmp;
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
 	int addr_type;
@@ -672,13 +523,10 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	/* NOTE: payload length is always compressed */
-
-	/* Next Header is compress if UDP */
-	if (hdr->nexthdr == UIP_PROTO_UDP)
+	nhc = lowpan_search_nhc_by_nexthdr(hdr->nexthdr);
+	if (nhc)
 		iphc0 |= LOWPAN_IPHC_NH_C;
-
-	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0)
+	else
 		lowpan_push_hc_data(&hc_ptr, &hdr->nexthdr,
 				    sizeof(hdr->nexthdr));
 
@@ -766,9 +614,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	/* UDP header compression */
-	if (hdr->nexthdr == UIP_PROTO_UDP)
-		compress_udp_header(&hc_ptr, skb);
+	lowpan_nhc_do_compression(nhc, skb, &hc_ptr, &iphc0);
 
 	head[0] = iphc0;
 	head[1] = iphc1;
@@ -786,4 +632,16 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(lowpan_header_compress);
 
+static int __init iphc_init_module(void)
+{
+	return lowpan_init_nhc();
+}
+
+static void __exit iphc_cleanup_module(void)
+{
+	lowpan_cleanup_nhc();
+}
+
 MODULE_LICENSE("GPL");
+module_init(iphc_init_module);
+module_exit(iphc_cleanup_module);
diff --git a/net/6lowpan/nhc/Makefile b/net/6lowpan/nhc/Makefile
index 5fe76e47..07431c2 100644
--- a/net/6lowpan/nhc/Makefile
+++ b/net/6lowpan/nhc/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_6LOWPAN) += nhc.o
 
-nhc-y := core.o
+nhc-y := core.o \
+	 udp.o
diff --git a/net/6lowpan/nhc/core.c b/net/6lowpan/nhc/core.c
index 0bf103d..0f98132 100644
--- a/net/6lowpan/nhc/core.c
+++ b/net/6lowpan/nhc/core.c
@@ -15,6 +15,7 @@
 #include <net/ipv6.h>
 
 #include "core.h"
+#include "udp.h"
 
 static struct rb_root rb_root = RB_ROOT;
 static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
@@ -172,9 +173,10 @@ EXPORT_SYMBOL(lowpan_del_nhc);
 
 int lowpan_init_nhc(void)
 {
-	return 0;
+	return lowpan_init_nhc_udp();
 }
 
 void lowpan_cleanup_nhc(void)
 {
+	lowpan_cleanup_nhc_udp();
 }
diff --git a/net/6lowpan/nhc/udp.c b/net/6lowpan/nhc/udp.c
new file mode 100644
index 0000000..42368b8
--- /dev/null
+++ b/net/6lowpan/nhc/udp.c
@@ -0,0 +1,173 @@
+/*	6LoWPAN IPv6 UDP compression
+ *
+ *
+ *	Authors:
+ *	Alexander Aring		<aar@pengutronix.de>
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
+#include <net/6lowpan.h>
+#include <linux/skbuff.h>
+
+#include "core.h"
+#include "udp.h"
+
+static int udp_uncompress(struct sk_buff **skb)
+{
+	struct udphdr uh;
+	struct sk_buff *new;
+	bool fail;
+	u8 tmp = 0, val = 0;
+
+	fail = lowpan_fetch_skb(*skb, &tmp, sizeof(tmp));
+
+	pr_debug("UDP header uncompression\n");
+	switch (tmp & LOWPAN_NHC_UDP_CS_P_11) {
+	case LOWPAN_NHC_UDP_CS_P_00:
+		fail |= lowpan_fetch_skb(*skb, &uh.source, sizeof(uh.source));
+		fail |= lowpan_fetch_skb(*skb, &uh.dest, sizeof(uh.dest));
+		break;
+	case LOWPAN_NHC_UDP_CS_P_01:
+		fail |= lowpan_fetch_skb(*skb, &uh.source, sizeof(uh.source));
+		fail |= lowpan_fetch_skb(*skb, &val, sizeof(val));
+		uh.dest = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
+		break;
+	case LOWPAN_NHC_UDP_CS_P_10:
+		fail |= lowpan_fetch_skb(*skb, &val, sizeof(val));
+		uh.source = htons(val + LOWPAN_NHC_UDP_8BIT_PORT);
+		fail |= lowpan_fetch_skb(*skb, &uh.dest, sizeof(uh.dest));
+		break;
+	case LOWPAN_NHC_UDP_CS_P_11:
+		fail |= lowpan_fetch_skb(*skb, &val, sizeof(val));
+		uh.source = htons(LOWPAN_NHC_UDP_4BIT_PORT + (val >> 4));
+		uh.dest = htons(LOWPAN_NHC_UDP_4BIT_PORT + (val & 0x0f));
+		break;
+	default:
+		pr_debug("ERROR: unknown UDP format\n");
+		return -EINVAL;
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
+		fail |= lowpan_fetch_skb(*skb, &uh.check, sizeof(uh.check));
+	}
+
+	if (fail)
+		return -EINVAL;
+
+	/* UDP lenght needs to be infered from the lower layers
+	 * here, we obtain the hint from the remaining size of the
+	 * frame
+	 */
+	uh.len = htons((*skb)->len + sizeof(struct udphdr));
+	pr_debug("uncompressed UDP length: src = %d", ntohs(uh.len));
+
+	/* replace the compressed UDP head by the uncompressed UDP
+	 * header
+	 */
+	new = skb_copy_expand(*skb, sizeof(struct udphdr),
+			      skb_tailroom(*skb), GFP_ATOMIC);
+	kfree_skb(*skb);
+	if (!new)
+		return -ENOMEM;
+	*skb = new;
+
+	skb_push(*skb, sizeof(uh));
+	skb_copy_to_linear_data(*skb, &uh, sizeof(struct udphdr));
+
+	return 0;
+}
+
+static int udp_compress(struct sk_buff *skb, u8 **hc_ptr)
+{
+	struct udphdr *uh = udp_hdr(skb);
+	u8 tmp;
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
+		   LOWPAN_NHC_UDP_8BIT_PORT) {
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
+		   LOWPAN_NHC_UDP_8BIT_PORT) {
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
+LOWPAN_NHC(udp_nhc, "IPv6 UDP Header", NEXTHDR_UDP,  udp_nhid_setup,
+	   LOWPAN_NHC_UDP_LEN, udp_uncompress, udp_compress);
+
+int lowpan_init_nhc_udp(void)
+{
+	return lowpan_add_nhc(&udp_nhc);
+}
+EXPORT_SYMBOL(lowpan_init_nhc_udp);
+
+void lowpan_cleanup_nhc_udp(void)
+{
+	lowpan_del_nhc(&udp_nhc);
+}
+EXPORT_SYMBOL(lowpan_cleanup_nhc_udp);
diff --git a/net/6lowpan/nhc/udp.h b/net/6lowpan/nhc/udp.h
new file mode 100644
index 0000000..ae99448
--- /dev/null
+++ b/net/6lowpan/nhc/udp.h
@@ -0,0 +1,9 @@
+#ifndef __6LOWPAN_NHC_UDP_H
+#define __6LOWPAN_NHC_UDP_H
+
+#define LOWPAN_NHC_UDP_LEN	1
+
+int lowpan_init_nhc_udp(void);
+void lowpan_cleanup_nhc_udp(void);
+
+#endif /* __6LOWPAN_NHC_UDP_H */
-- 
2.0.3

