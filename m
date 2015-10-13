Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34471 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbbJMLni (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Oct 2015 07:43:38 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/6] 6lowpan: introduce LOWPAN_IPHC_MAX_HC_BUF_LEN
Date: Tue, 13 Oct 2015 13:42:56 +0200
Message-Id: <1444736579-27826-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
References: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch introduces the LOWPAN_IPHC_MAX_HC_BUF_LEN define which
represent the worst-case supported IPHC buffer length. It's used to
allocate the stack buffer space for creating the IPHC header.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h | 8 ++++++++
 net/6lowpan/iphc.c    | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 07db532..aa5a823 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -64,12 +64,20 @@
 #define EUI64_ADDR_LEN		8
 
 #define LOWPAN_NHC_MAX_ID_LEN	1
+/* Maximum next header compression length which we currently support inclusive
+ * possible inline data.
+ */
+#define LOWPAN_NHC_MAX_HDR_LEN	(sizeof(struct udphdr))
 /* Max IPHC Header len without IPv6 hdr specific inline data.
  * Useful for getting the "extra" bytes we need at worst case compression.
  *
  * LOWPAN_IPHC + CID + LOWPAN_NHC_MAX_ID_LEN
  */
 #define LOWPAN_IPHC_MAX_HEADER_LEN	(2 + 1 + LOWPAN_NHC_MAX_ID_LEN)
+/* Maximum worst case IPHC header buffer size */
+#define LOWPAN_IPHC_MAX_HC_BUF_LEN	(sizeof(struct ipv6hdr) +	\
+					 LOWPAN_IPHC_MAX_HEADER_LEN +	\
+					 LOWPAN_NHC_MAX_HDR_LEN)
 
 /*
  * ipv6 address based on mac
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 78c8a49..dd5f27d 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -429,7 +429,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 {
 	u8 tmp, iphc0, iphc1, *hc_ptr;
 	struct ipv6hdr *hdr;
-	u8 head[100] = {};
+	u8 head[LOWPAN_IPHC_MAX_HC_BUF_LEN] = {};
 	int ret, addr_type;
 
 	if (type != ETH_P_IPV6)
-- 
2.6.1

