Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35474 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbbKKRPC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Nov 2015 12:15:02 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 3/4] 6lowpan: iphc: remove handling when dam is zero
Date: Wed, 11 Nov 2015 18:14:38 +0100
Message-Id: <1447262079-2509-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1447262079-2509-1-git-send-email-alex.aring@gmail.com>
References: <1447262079-2509-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, Alexander Aring <alex.aring@gmail.com>

This patch removes handling of LOWPAN_IPHC_DAM_00 inside the
lowpan_compress_addr_64 function. The case of LOWPAN_IPHC_DAM_00 can
never occur. there exists a if branch which use LOWPAN_IPHC_DAM_11 and
LOWPAN_IPHC_DAM_10 and inside the else branch LOWPAN_IPHC_DAM_01. So
LOWPAN_IPHC_DAM_00 can never occur.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 13f5424..f7f175c 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -594,7 +594,6 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
 static const u8 lowpan_iphc_dam_to_sam_value[] = {
-	[LOWPAN_IPHC_DAM_00] = LOWPAN_IPHC_SAM_00,
 	[LOWPAN_IPHC_DAM_01] = LOWPAN_IPHC_SAM_01,
 	[LOWPAN_IPHC_DAM_10] = LOWPAN_IPHC_SAM_10,
 	[LOWPAN_IPHC_DAM_11] = LOWPAN_IPHC_SAM_11,
@@ -603,7 +602,7 @@ static const u8 lowpan_iphc_dam_to_sam_value[] = {
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct in6_addr *ipaddr,
 				  const unsigned char *lladdr, bool sam)
 {
-	u8 dam = LOWPAN_IPHC_DAM_00;
+	u8 dam;
 
 	if (is_addr_mac_addr_based(ipaddr, lladdr)) {
 		dam = LOWPAN_IPHC_DAM_11; /* 0-bits */
-- 
2.6.1

