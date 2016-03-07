Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48391 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762AbcCGTHh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Mar 2016 14:07:37 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next] 6lowpan: iphc: fix SAM/DAM bit comment
Date: Mon,  7 Mar 2016 20:07:31 +0100
Message-Id: <1457377651-13274-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch fixes the comments for SAM/DAM value.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 7217251..99bb22a 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -788,7 +788,7 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct in6_addr *ipaddr,
 	}
 
 	memset(&tmp, 0, sizeof(tmp));
-	/* check for SAM/DAM = 01 */
+	/* check for SAM/DAM = 10 */
 	tmp.s6_addr[11] = 0xFF;
 	tmp.s6_addr[12] = 0xFE;
 	memcpy(&tmp.s6_addr[14], &ipaddr->s6_addr[14], 2);
@@ -801,7 +801,7 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct in6_addr *ipaddr,
 	}
 
 	memset(&tmp, 0, sizeof(tmp));
-	/* check for SAM/DAM = 10, should always match */
+	/* check for SAM/DAM = 01, should always match */
 	memcpy(&tmp.s6_addr[8], &ipaddr->s6_addr[8], 8);
 	/* context information are always used */
 	ipv6_addr_prefix_copy(&tmp, &ctx->pfx, ctx->plen);
-- 
2.7.2

