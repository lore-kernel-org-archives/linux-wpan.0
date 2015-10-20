Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34610 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbJTGcF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:05 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/6] 6lowpan: nhc: move iphc manipulation out of nhc
Date: Tue, 20 Oct 2015 08:31:21 +0200
Message-Id: <1445322686-2952-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch moves the iphc setting of next header commpression bit inside
iphc functionality. Setting of IPHC bits should be happen at iphc.c file
only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c |  9 ++++++---
 net/6lowpan/nhc.c  | 13 +++++--------
 net/6lowpan/nhc.h  |  9 +++------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 87d8f1f..afe36aa 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -532,9 +532,12 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 	/* Check if we provide the nhc format for nexthdr and compression
 	 * functionality. If not nexthdr is handled inline and not compressed.
 	 */
-	ret = lowpan_nhc_check_compression(skb, hdr, &hc_ptr, &iphc0);
-	if (ret < 0)
-		return ret;
+	ret = lowpan_nhc_check_compression(skb, hdr, &hc_ptr);
+	if (ret == -ENOENT)
+		lowpan_push_hc_data(&hc_ptr, &hdr->nexthdr,
+				    sizeof(hdr->nexthdr));
+	else
+		iphc0 |= LOWPAN_IPHC_NH_C;
 
 	/* Hop limit
 	 * if 1:   compress, encoding is 01
diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 589224e..7008d53 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -95,23 +95,20 @@ static struct lowpan_nhc *lowpan_nhc_by_nhcid(const struct sk_buff *skb)
 }
 
 int lowpan_nhc_check_compression(struct sk_buff *skb,
-				 const struct ipv6hdr *hdr, u8 **hc_ptr,
-				 u8 *iphc0)
+				 const struct ipv6hdr *hdr, u8 **hc_ptr)
 {
 	struct lowpan_nhc *nhc;
+	int ret = 0;
 
 	spin_lock_bh(&lowpan_nhc_lock);
 
 	nhc = lowpan_nexthdr_nhcs[hdr->nexthdr];
-	if (nhc && nhc->compress)
-		*iphc0 |= LOWPAN_IPHC_NH_C;
-	else
-		lowpan_push_hc_data(hc_ptr, &hdr->nexthdr,
-				    sizeof(hdr->nexthdr));
+	if (!(nhc && nhc->compress))
+		ret = -ENOENT;
 
 	spin_unlock_bh(&lowpan_nhc_lock);
 
-	return 0;
+	return ret;
 }
 
 int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index e3a5644..8030414 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -86,19 +86,16 @@ struct lowpan_nhc *lowpan_nhc_by_nexthdr(u8 nexthdr);
 
 /**
  * lowpan_nhc_check_compression - checks if we support compression format. If
- *	we support the nhc by nexthdr field, the 6LoWPAN iphc NHC bit will be
- *	set. If we don't support nexthdr will be added as inline data to the
- *	6LoWPAN header.
+ *	we support the nhc by nexthdr field, the function will return 0. If we
+ *	don't support the nhc by nexthdr this function will return -ENOENT.
  *
  * @skb: skb of 6LoWPAN header to read nhc and replace header.
  * @hdr: ipv6hdr to check the nexthdr value
  * @hc_ptr: pointer for 6LoWPAN header which should increment at the end of
  *	    replaced header.
- * @iphc0: iphc0 pointer to set the 6LoWPAN NHC bit
  */
 int lowpan_nhc_check_compression(struct sk_buff *skb,
-				 const struct ipv6hdr *hdr, u8 **hc_ptr,
-				 u8 *iphc0);
+				 const struct ipv6hdr *hdr, u8 **hc_ptr);
 
 /**
  * lowpan_nhc_do_compression - calling compress callback for nhc
-- 
2.6.1

