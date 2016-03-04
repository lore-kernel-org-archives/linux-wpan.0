Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42913 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758923AbcCDJK3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 04:10:29 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 1/2] mac802154: use put and get unaligned functions
Date: Fri,  4 Mar 2016 10:10:20 +0100
Message-Id: <1457082621-20194-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch removes the swap pointer and memmove functionality. Instead
we use the well known put/get unaligned access with specific byte order
handling.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/mac802154.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 2e3cdd20..6cd7a70 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -16,10 +16,10 @@
 #ifndef NET_MAC802154_H
 #define NET_MAC802154_H
 
+#include <asm/unaligned.h>
 #include <net/af_ieee802154.h>
 #include <linux/ieee802154.h>
 #include <linux/skbuff.h>
-#include <linux/unaligned/memmove.h>
 
 #include <net/cfg802154.h>
 
@@ -254,7 +254,7 @@ static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 		return cpu_to_le16(0);
 	}
 
-	return (__force __le16)__get_unaligned_memmove16(skb_mac_header(skb));
+	return get_unaligned_le16(skb_mac_header(skb));
 }
 
 /**
@@ -264,7 +264,7 @@ static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
  */
 static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
 {
-	__put_unaligned_memmove64(swab64p(be64_src), le64_dst);
+	put_unaligned_le64(get_unaligned_be64(be64_src), le64_dst);
 }
 
 /**
@@ -274,7 +274,7 @@ static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
  */
 static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
 {
-	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
+	put_unaligned_be64(get_unaligned_le64(le64_src), be64_dst);
 }
 
 /**
@@ -284,7 +284,7 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
  */
 static inline void ieee802154_le16_to_be16(void *be16_dst, const void *le16_src)
 {
-	__put_unaligned_memmove16(swab16p(le16_src), be16_dst);
+	put_unaligned_be16(get_unaligned_le16(le16_src), be16_dst);
 }
 
 /**
-- 
2.7.2

