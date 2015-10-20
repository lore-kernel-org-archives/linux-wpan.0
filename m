Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34631 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbJTGcG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:06 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/6] 6lowpan: move IPHC functionality defines
Date: Tue, 20 Oct 2015 08:31:22 +0200
Message-Id: <1445322686-2952-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch removes the IPHC related defines for doing bit manipulation
from global 6lowpan header to the iphc file which should the only one
implementation which use these defines.

Also move next header compression defines to their nhc implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h       | 123 --------------------------------------------
 net/6lowpan/iphc.c          |  88 +++++++++++++++++++++++++++++++
 net/6lowpan/nhc_udp.c       |  22 +++++++-
 net/ieee802154/6lowpan/tx.c |   3 ++
 4 files changed, 112 insertions(+), 124 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 4afdbb3..f127a92 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -56,11 +56,6 @@
 #include <net/ipv6.h>
 #include <net/net_namespace.h>
 
-#define UIP_802154_SHORTADDR_LEN	2  /* compressed ipv6 address length */
-#define UIP_IPH_LEN			40 /* ipv6 fixed header size */
-#define UIP_PROTO_UDP			17 /* ipv6 next header value for UDP */
-#define UIP_FRAGH_LEN			8  /* ipv6 fragment header size */
-
 #define EUI64_ADDR_LEN		8
 
 #define LOWPAN_NHC_MAX_ID_LEN	1
@@ -79,61 +74,6 @@
 					 LOWPAN_IPHC_MAX_HEADER_LEN +	\
 					 LOWPAN_NHC_MAX_HDR_LEN)
 
-/*
- * ipv6 address based on mac
- * second bit-flip (Universe/Local) is done according RFC2464
- */
-#define is_addr_mac_addr_based(a, m) \
-	((((a)->s6_addr[8])  == (((m)[0]) ^ 0x02)) &&	\
-	 (((a)->s6_addr[9])  == (m)[1]) &&		\
-	 (((a)->s6_addr[10]) == (m)[2]) &&		\
-	 (((a)->s6_addr[11]) == (m)[3]) &&		\
-	 (((a)->s6_addr[12]) == (m)[4]) &&		\
-	 (((a)->s6_addr[13]) == (m)[5]) &&		\
-	 (((a)->s6_addr[14]) == (m)[6]) &&		\
-	 (((a)->s6_addr[15]) == (m)[7]))
-
-/*
- * check whether we can compress the IID to 16 bits,
- * it's possible for unicast adresses with first 49 bits are zero only.
- */
-#define lowpan_is_iid_16_bit_compressable(a)	\
-	((((a)->s6_addr16[4]) == 0) &&		\
-	 (((a)->s6_addr[10]) == 0) &&		\
-	 (((a)->s6_addr[11]) == 0xff) &&	\
-	 (((a)->s6_addr[12]) == 0xfe) &&	\
-	 (((a)->s6_addr[13]) == 0))
-
-/* check whether the 112-bit gid of the multicast address is mappable to: */
-
-/* 48 bits, FFXX::00XX:XXXX:XXXX */
-#define lowpan_is_mcast_addr_compressable48(a)	\
-	((((a)->s6_addr16[1]) == 0) &&		\
-	 (((a)->s6_addr16[2]) == 0) &&		\
-	 (((a)->s6_addr16[3]) == 0) &&		\
-	 (((a)->s6_addr16[4]) == 0) &&		\
-	 (((a)->s6_addr[10]) == 0))
-
-/* 32 bits, FFXX::00XX:XXXX */
-#define lowpan_is_mcast_addr_compressable32(a)	\
-	((((a)->s6_addr16[1]) == 0) &&		\
-	 (((a)->s6_addr16[2]) == 0) &&		\
-	 (((a)->s6_addr16[3]) == 0) &&		\
-	 (((a)->s6_addr16[4]) == 0) &&		\
-	 (((a)->s6_addr16[5]) == 0) &&		\
-	 (((a)->s6_addr[12]) == 0))
-
-/* 8 bits, FF02::00XX */
-#define lowpan_is_mcast_addr_compressable8(a)	\
-	((((a)->s6_addr[1])  == 2) &&		\
-	 (((a)->s6_addr16[1]) == 0) &&		\
-	 (((a)->s6_addr16[2]) == 0) &&		\
-	 (((a)->s6_addr16[3]) == 0) &&		\
-	 (((a)->s6_addr16[4]) == 0) &&		\
-	 (((a)->s6_addr16[5]) == 0) &&		\
-	 (((a)->s6_addr16[6]) == 0) &&		\
-	 (((a)->s6_addr[14]) == 0))
-
 #define lowpan_is_addr_broadcast(a)	\
 	((((a)[0]) == 0xFF) &&	\
 	 (((a)[1]) == 0xFF) &&	\
@@ -158,69 +98,6 @@ static inline bool lowpan_is_iphc(u8 dispatch)
 	return (dispatch & LOWPAN_DISPATCH_IPHC_MASK) == LOWPAN_DISPATCH_IPHC;
 }
 
-#define LOWPAN_FRAG_TIMEOUT	(HZ * 60)	/* time-out 60 sec */
-
-#define LOWPAN_FRAG1_HEAD_SIZE	0x4
-#define LOWPAN_FRAGN_HEAD_SIZE	0x5
-
-/*
- * Values of fields within the IPHC encoding first byte
- * (C stands for compressed and I for inline)
- */
-#define LOWPAN_IPHC_TF		0x18
-
-#define LOWPAN_IPHC_FL_C	0x10
-#define LOWPAN_IPHC_TC_C	0x08
-#define LOWPAN_IPHC_NH_C	0x04
-#define LOWPAN_IPHC_TTL_1	0x01
-#define LOWPAN_IPHC_TTL_64	0x02
-#define LOWPAN_IPHC_TTL_255	0x03
-#define LOWPAN_IPHC_TTL_I	0x00
-
-
-/* Values of fields within the IPHC encoding second byte */
-#define LOWPAN_IPHC_CID		0x80
-
-#define LOWPAN_IPHC_ADDR_00	0x00
-#define LOWPAN_IPHC_ADDR_01	0x01
-#define LOWPAN_IPHC_ADDR_02	0x02
-#define LOWPAN_IPHC_ADDR_03	0x03
-
-#define LOWPAN_IPHC_SAC		0x40
-#define LOWPAN_IPHC_SAM		0x30
-
-#define LOWPAN_IPHC_SAM_BIT	4
-
-#define LOWPAN_IPHC_M		0x08
-#define LOWPAN_IPHC_DAC		0x04
-#define LOWPAN_IPHC_DAM_00	0x00
-#define LOWPAN_IPHC_DAM_01	0x01
-#define LOWPAN_IPHC_DAM_10	0x02
-#define LOWPAN_IPHC_DAM_11	0x03
-
-#define LOWPAN_IPHC_DAM_BIT	0
-/*
- * LOWPAN_UDP encoding (works together with IPHC)
- */
-#define LOWPAN_NHC_UDP_MASK		0xF8
-#define LOWPAN_NHC_UDP_ID		0xF0
-#define LOWPAN_NHC_UDP_CHECKSUMC	0x04
-#define LOWPAN_NHC_UDP_CHECKSUMI	0x00
-
-#define LOWPAN_NHC_UDP_4BIT_PORT	0xF0B0
-#define LOWPAN_NHC_UDP_4BIT_MASK	0xFFF0
-#define LOWPAN_NHC_UDP_8BIT_PORT	0xF000
-#define LOWPAN_NHC_UDP_8BIT_MASK	0xFF00
-
-/* values for port compression, _with checksum_ ie bit 5 set to 0 */
-#define LOWPAN_NHC_UDP_CS_P_00	0xF0 /* all inline */
-#define LOWPAN_NHC_UDP_CS_P_01	0xF1 /* source 16bit inline,
-					dest = 0xF0 + 8 bit inline */
-#define LOWPAN_NHC_UDP_CS_P_10	0xF2 /* source = 0xF0 + 8bit inline,
-					dest = 16 bit inline */
-#define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
-#define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
-
 #define LOWPAN_PRIV_SIZE(llpriv_size)	\
 	(sizeof(struct lowpan_priv) + llpriv_size)
 
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index afe36aa..fcf583f 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -58,6 +58,94 @@
 
 #include "nhc.h"
 
+/* Values of fields within the IPHC encoding first byte
+ * (C stands for compressed and I for inline)
+ */
+#define LOWPAN_IPHC_TF		0x18
+
+#define LOWPAN_IPHC_FL_C	0x10
+#define LOWPAN_IPHC_TC_C	0x08
+#define LOWPAN_IPHC_NH_C	0x04
+#define LOWPAN_IPHC_TTL_1	0x01
+#define LOWPAN_IPHC_TTL_64	0x02
+#define LOWPAN_IPHC_TTL_255	0x03
+#define LOWPAN_IPHC_TTL_I	0x00
+
+/* Values of fields within the IPHC encoding second byte */
+#define LOWPAN_IPHC_CID		0x80
+
+#define LOWPAN_IPHC_ADDR_00	0x00
+#define LOWPAN_IPHC_ADDR_01	0x01
+#define LOWPAN_IPHC_ADDR_02	0x02
+#define LOWPAN_IPHC_ADDR_03	0x03
+
+#define LOWPAN_IPHC_SAC		0x40
+#define LOWPAN_IPHC_SAM		0x30
+
+#define LOWPAN_IPHC_SAM_BIT	4
+
+#define LOWPAN_IPHC_M		0x08
+#define LOWPAN_IPHC_DAC		0x04
+#define LOWPAN_IPHC_DAM_00	0x00
+#define LOWPAN_IPHC_DAM_01	0x01
+#define LOWPAN_IPHC_DAM_10	0x02
+#define LOWPAN_IPHC_DAM_11	0x03
+
+#define LOWPAN_IPHC_DAM_BIT	0
+
+/* ipv6 address based on mac
+ * second bit-flip (Universe/Local) is done according RFC2464
+ */
+#define is_addr_mac_addr_based(a, m) \
+	((((a)->s6_addr[8])  == (((m)[0]) ^ 0x02)) &&	\
+	 (((a)->s6_addr[9])  == (m)[1]) &&		\
+	 (((a)->s6_addr[10]) == (m)[2]) &&		\
+	 (((a)->s6_addr[11]) == (m)[3]) &&		\
+	 (((a)->s6_addr[12]) == (m)[4]) &&		\
+	 (((a)->s6_addr[13]) == (m)[5]) &&		\
+	 (((a)->s6_addr[14]) == (m)[6]) &&		\
+	 (((a)->s6_addr[15]) == (m)[7]))
+
+/* check whether we can compress the IID to 16 bits,
+ * it's possible for unicast addresses with first 49 bits are zero only.
+ */
+#define lowpan_is_iid_16_bit_compressable(a)	\
+	((((a)->s6_addr16[4]) == 0) &&		\
+	 (((a)->s6_addr[10]) == 0) &&		\
+	 (((a)->s6_addr[11]) == 0xff) &&	\
+	 (((a)->s6_addr[12]) == 0xfe) &&	\
+	 (((a)->s6_addr[13]) == 0))
+
+/* check whether the 112-bit gid of the multicast address is mappable to: */
+
+/* 48 bits, FFXX::00XX:XXXX:XXXX */
+#define lowpan_is_mcast_addr_compressable48(a)	\
+	((((a)->s6_addr16[1]) == 0) &&		\
+	 (((a)->s6_addr16[2]) == 0) &&		\
+	 (((a)->s6_addr16[3]) == 0) &&		\
+	 (((a)->s6_addr16[4]) == 0) &&		\
+	 (((a)->s6_addr[10]) == 0))
+
+/* 32 bits, FFXX::00XX:XXXX */
+#define lowpan_is_mcast_addr_compressable32(a)	\
+	((((a)->s6_addr16[1]) == 0) &&		\
+	 (((a)->s6_addr16[2]) == 0) &&		\
+	 (((a)->s6_addr16[3]) == 0) &&		\
+	 (((a)->s6_addr16[4]) == 0) &&		\
+	 (((a)->s6_addr16[5]) == 0) &&		\
+	 (((a)->s6_addr[12]) == 0))
+
+/* 8 bits, FF02::00XX */
+#define lowpan_is_mcast_addr_compressable8(a)	\
+	((((a)->s6_addr[1])  == 2) &&		\
+	 (((a)->s6_addr16[1]) == 0) &&		\
+	 (((a)->s6_addr16[2]) == 0) &&		\
+	 (((a)->s6_addr16[3]) == 0) &&		\
+	 (((a)->s6_addr16[4]) == 0) &&		\
+	 (((a)->s6_addr16[5]) == 0) &&		\
+	 (((a)->s6_addr16[6]) == 0) &&		\
+	 (((a)->s6_addr[14]) == 0))
+
 static inline void iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
 						const void *lladdr)
 {
diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
index 72d0b57..69537a2 100644
--- a/net/6lowpan/nhc_udp.c
+++ b/net/6lowpan/nhc_udp.c
@@ -17,7 +17,27 @@
 
 #include "nhc.h"
 
-#define LOWPAN_NHC_UDP_IDLEN	1
+#define LOWPAN_NHC_UDP_MASK		0xF8
+#define LOWPAN_NHC_UDP_ID		0xF0
+#define LOWPAN_NHC_UDP_IDLEN		1
+
+#define LOWPAN_NHC_UDP_4BIT_PORT	0xF0B0
+#define LOWPAN_NHC_UDP_4BIT_MASK	0xFFF0
+#define LOWPAN_NHC_UDP_8BIT_PORT	0xF000
+#define LOWPAN_NHC_UDP_8BIT_MASK	0xFF00
+
+/* values for port compression, _with checksum_ ie bit 5 set to 0 */
+
+/* all inline */
+#define LOWPAN_NHC_UDP_CS_P_00	0xF0
+/* source 16bit inline, dest = 0xF0 + 8 bit inline */
+#define LOWPAN_NHC_UDP_CS_P_01	0xF1
+/* source = 0xF0 + 8bit inline, dest = 16 bit inline */
+#define LOWPAN_NHC_UDP_CS_P_10	0xF2
+/* source & dest = 0xF0B + 4bit inline */
+#define LOWPAN_NHC_UDP_CS_P_11	0xF3
+/* checksum elided */
+#define LOWPAN_NHC_UDP_CS_C	0x04
 
 static int udp_uncompress(struct sk_buff *skb, size_t needed)
 {
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 2a5b2c2..f6594a8 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -14,6 +14,9 @@
 
 #include "6lowpan_i.h"
 
+#define LOWPAN_FRAG1_HEAD_SIZE	0x4
+#define LOWPAN_FRAGN_HEAD_SIZE	0x5
+
 /* don't save pan id, it's intra pan */
 struct lowpan_addr {
 	u8 mode;
-- 
2.6.1

