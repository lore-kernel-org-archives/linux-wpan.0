Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36417 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbJTGcL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:11 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/6] 6lowpan: put mcast compression in an own function
Date: Tue, 20 Oct 2015 08:31:26 +0200
Message-Id: <1445322686-2952-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch moves the mcast compression algorithmn to an own function
like all other compression/decompression methods in iphc.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 59 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index e6cdfc9..346b5c1 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -708,6 +708,37 @@ static u8 lowpan_iphc_tf_compress(u8 **hc_ptr, const struct ipv6hdr *hdr)
 	return val;
 }
 
+static u8 lowpan_iphc_mcast_addr_compress(u8 **hc_ptr,
+					  const struct in6_addr *ipaddr)
+{
+	u8 val;
+
+	if (lowpan_is_mcast_addr_compressable8(ipaddr)) {
+		pr_debug("compressed to 1 octet\n");
+		/* use last byte */
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[15], 1);
+		val = LOWPAN_IPHC_DAM_11;
+	} else if (lowpan_is_mcast_addr_compressable32(ipaddr)) {
+		pr_debug("compressed to 4 octets\n");
+		/* second byte + the last three */
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[1], 1);
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[13], 3);
+		val = LOWPAN_IPHC_DAM_10;
+	} else if (lowpan_is_mcast_addr_compressable48(ipaddr)) {
+		pr_debug("compressed to 6 octets\n");
+		/* second byte + the last five */
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[1], 1);
+		lowpan_push_hc_data(hc_ptr, &ipaddr->s6_addr[11], 5);
+		val = LOWPAN_IPHC_DAM_01;
+	} else {
+		pr_debug("using full address\n");
+		lowpan_push_hc_data(hc_ptr, ipaddr->s6_addr, 16);
+		val = LOWPAN_IPHC_DAM_00;
+	}
+
+	return val;
+}
+
 int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 			   const void *daddr, const void *saddr)
 {
@@ -804,33 +835,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	if (addr_type & IPV6_ADDR_MULTICAST) {
 		pr_debug("destination address is multicast: ");
 		iphc1 |= LOWPAN_IPHC_M;
-		if (lowpan_is_mcast_addr_compressable8(&hdr->daddr)) {
-			pr_debug("compressed to 1 octet\n");
-			iphc1 |= LOWPAN_IPHC_DAM_11;
-			/* use last byte */
-			lowpan_push_hc_data(&hc_ptr,
-					    &hdr->daddr.s6_addr[15], 1);
-		} else if (lowpan_is_mcast_addr_compressable32(&hdr->daddr)) {
-			pr_debug("compressed to 4 octets\n");
-			iphc1 |= LOWPAN_IPHC_DAM_10;
-			/* second byte + the last three */
-			lowpan_push_hc_data(&hc_ptr,
-					    &hdr->daddr.s6_addr[1], 1);
-			lowpan_push_hc_data(&hc_ptr,
-					    &hdr->daddr.s6_addr[13], 3);
-		} else if (lowpan_is_mcast_addr_compressable48(&hdr->daddr)) {
-			pr_debug("compressed to 6 octets\n");
-			iphc1 |= LOWPAN_IPHC_DAM_01;
-			/* second byte + the last five */
-			lowpan_push_hc_data(&hc_ptr,
-					    &hdr->daddr.s6_addr[1], 1);
-			lowpan_push_hc_data(&hc_ptr,
-					    &hdr->daddr.s6_addr[11], 5);
-		} else {
-			pr_debug("using full address\n");
-			iphc1 |= LOWPAN_IPHC_DAM_00;
-			lowpan_push_hc_data(&hc_ptr, hdr->daddr.s6_addr, 16);
-		}
+		iphc1 |= lowpan_iphc_mcast_addr_compress(&hc_ptr, &hdr->daddr);
 	} else {
 		if (addr_type & IPV6_ADDR_LINKLOCAL) {
 			/* TODO: context lookup */
-- 
2.6.1

