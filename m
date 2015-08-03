Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34259 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbbHCGXs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:48 -0400
Received: by wibud3 with SMTP id ud3so121965463wib.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:47 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 05/16] ieee802154: 6lowpan: cleanup pull of iphc bytes
Date: Mon,  3 Aug 2015 08:23:44 +0200
Message-Id: <1438583035-6287-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the pull of the iphc bytes. We don't need to check
if the skb->len contains two bytes, this will be checked by
lowpan_fetch_skb_u8.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 99aeb56..7b6b038 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -33,14 +33,9 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	void *sap, *dap;
 
 	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
-	/* at least two bytes will be used for the encoding */
-	if (skb->len < 2)
-		return -EINVAL;
-
-	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		return -EINVAL;
 
-	if (lowpan_fetch_skb_u8(skb, &iphc1))
+	if (lowpan_fetch_skb_u8(skb, &iphc0) ||
+	    lowpan_fetch_skb_u8(skb, &iphc1))
 		return -EINVAL;
 
 	ieee802154_addr_to_sa(&sa, &hdr->source);
-- 
2.5.0

