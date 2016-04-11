Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37839 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753835AbcDKJE3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:29 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 09/11] 6lowpan: move eui64 uncompress function
Date: Mon, 11 Apr 2016 11:04:22 +0200
Message-Id: <1460365464-12435-10-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This function will be use in later functionality in other branches than
generic 6lowpan, so we move it to the global 6lowpan header.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h | 16 ++++++++++++++++
 net/6lowpan/iphc.c    | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index a0c01f5..04b877c 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -169,6 +169,22 @@ struct lowpan_802154_cb *lowpan_802154_cb(const struct sk_buff *skb)
 	return (struct lowpan_802154_cb *)skb->cb;
 }
 
+static inline void lowpan_iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
+						       const void *lladdr)
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
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 2999240..dff1591 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -156,22 +156,6 @@
 #define LOWPAN_IPHC_CID_DCI(cid)	(cid & 0x0f)
 #define LOWPAN_IPHC_CID_SCI(cid)	((cid & 0xf0) >> 4)
 
-static inline void lowpan_iphc_uncompress_eui64_lladdr(struct in6_addr *ipaddr,
-						       const void *lladdr)
-{
-	/* fe:80::XXXX:XXXX:XXXX:XXXX
-	 *        \_________________/
-	 *              hwaddr
-	 */
-	ipaddr->s6_addr[0] = 0xFE;
-	ipaddr->s6_addr[1] = 0x80;
-	memcpy(&ipaddr->s6_addr[8], lladdr, EUI64_ADDR_LEN);
-	/* second bit-flip (Universe/Local)
-	 * is done according RFC2464
-	 */
-	ipaddr->s6_addr[8] ^= 0x02;
-}
-
 static inline void
 lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 				     const void *lladdr)
-- 
2.8.0

