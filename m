Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37488 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbbJMLnm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Oct 2015 07:43:42 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/6] 6lowpan: remove lowpan_fetch_skb_u8
Date: Tue, 13 Oct 2015 13:42:59 +0200
Message-Id: <1444736579-27826-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
References: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch removes the lowpan_fetch_skb_u8 function for getting the iphc
bytes. Instead we using the generic which has a len parameter to tell
the amount of bytes to fetch.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h | 27 ++++++++++++++-------------
 net/6lowpan/iphc.c    |  4 ++--
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index ac30ad3..4afdbb3 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -287,19 +287,20 @@ static inline void raw_dump_inline(const char *caller, char *msg,
 				   const unsigned char *buf, int len) { }
 #endif
 
-static inline int lowpan_fetch_skb_u8(struct sk_buff *skb, u8 *val)
-{
-	if (unlikely(!pskb_may_pull(skb, 1)))
-		return -EINVAL;
-
-	*val = skb->data[0];
-	skb_pull(skb, 1);
-
-	return 0;
-}
-
-static inline bool lowpan_fetch_skb(struct sk_buff *skb,
-		void *data, const unsigned int len)
+/**
+ * lowpan_fetch_skb - getting inline data from 6LoWPAN header
+ *
+ * This function will pull data from sk buffer and put it into data to
+ * remove the 6LoWPAN inline data. This function returns true if the
+ * sk buffer is too small to pull the amount of data which is specified
+ * by len.
+ *
+ * @skb: the buffer where the inline data should be pulled from.
+ * @data: destination buffer for the inline data.
+ * @len: amount of data which should be pulled in bytes.
+ */
+static inline bool lowpan_fetch_skb(struct sk_buff *skb, void *data,
+				    unsigned int len)
 {
 	if (unlikely(!pskb_may_pull(skb, len)))
 		return true;
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 8f967d3..87d8f1f 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -265,8 +265,8 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
 		       skb->data, skb->len);
 
-	if (lowpan_fetch_skb_u8(skb, &iphc0) ||
-	    lowpan_fetch_skb_u8(skb, &iphc1))
+	if (lowpan_fetch_skb(skb, &iphc0, sizeof(iphc0)) ||
+	    lowpan_fetch_skb(skb, &iphc1, sizeof(iphc1)))
 		return -EINVAL;
 
 	/* another if the CID flag is set */
-- 
2.6.1

