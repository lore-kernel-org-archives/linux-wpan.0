Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35463 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbJTGcH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:07 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/6] 6lowpan: remove lowpan_is_addr_broadcast
Date: Tue, 20 Oct 2015 08:31:23 +0200
Message-Id: <1445322686-2952-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This macro is used at 802.15.4 6LoWPAN only and can be replaced by
memcmp with the interface broadcast address.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h       | 10 ----------
 net/ieee802154/6lowpan/tx.c |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index f127a92..cf3bc56 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -74,16 +74,6 @@
 					 LOWPAN_IPHC_MAX_HEADER_LEN +	\
 					 LOWPAN_NHC_MAX_HDR_LEN)
 
-#define lowpan_is_addr_broadcast(a)	\
-	((((a)[0]) == 0xFF) &&	\
-	 (((a)[1]) == 0xFF) &&	\
-	 (((a)[2]) == 0xFF) &&	\
-	 (((a)[3]) == 0xFF) &&	\
-	 (((a)[4]) == 0xFF) &&	\
-	 (((a)[5]) == 0xFF) &&	\
-	 (((a)[6]) == 0xFF) &&	\
-	 (((a)[7]) == 0xFF))
-
 #define LOWPAN_DISPATCH_IPV6		0x41 /* 01000001 = 65 */
 #define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
 #define LOWPAN_DISPATCH_IPHC_MASK	0xe0
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index f6594a8..d4353fa 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -238,7 +238,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 	/* if the destination address is the broadcast address, use the
 	 * corresponding short address
 	 */
-	if (lowpan_is_addr_broadcast((const u8 *)daddr)) {
+	if (!memcmp(daddr, ldev->broadcast, EUI64_ADDR_LEN)) {
 		da.mode = IEEE802154_ADDR_SHORT;
 		da.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 		cb->ackreq = false;
-- 
2.6.1

