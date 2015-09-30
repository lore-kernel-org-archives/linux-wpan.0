Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34804 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbbI3IUW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 04:20:22 -0400
Received: by wicfx3 with SMTP id fx3so184948902wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2015 01:20:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] ieee802154: 6lowpan: don't skip first dsn while fragmentation
Date: Wed, 30 Sep 2015 10:20:10 +0200
Message-Id: <1443601211-27790-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
References: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixes the data frame sequence numer (dsn) while 6lowpan
fragmentation for frag1. Currently we create one 802.15.4 header at
first, then check if it's match into one frame and at the end construct
many fragments and calling wpan_dev_hard_header for each of them,
inclusive for the first fragment. This will make the first generated
header to garbage, instead we copying this header for frag1 instead of
generate a new one which skips one dsn.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/tx.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 5ecf8af..3b665e1 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -79,7 +79,7 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 
 static struct sk_buff*
 lowpan_alloc_frag(struct sk_buff *skb, int size,
-		  const struct ieee802154_hdr *master_hdr)
+		  const struct ieee802154_hdr *master_hdr, bool frag1)
 {
 	struct net_device *wdev = lowpan_dev_info(skb->dev)->wdev;
 	struct sk_buff *frag;
@@ -95,11 +95,17 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 		skb_reset_network_header(frag);
 		*mac_cb(frag) = *mac_cb(skb);
 
-		rc = wpan_dev_hard_header(frag, wdev, &master_hdr->dest,
-					  &master_hdr->source, size);
-		if (rc < 0) {
-			kfree_skb(frag);
-			return ERR_PTR(rc);
+		if (frag1) {
+			memcpy(skb_put(frag, skb->mac_len),
+			       skb_mac_header(skb), skb->mac_len);
+		} else {
+			rc = wpan_dev_hard_header(frag, wdev,
+						  &master_hdr->dest,
+						  &master_hdr->source, size);
+			if (rc < 0) {
+				kfree_skb(frag);
+				return ERR_PTR(rc);
+			}
 		}
 	} else {
 		frag = ERR_PTR(-ENOMEM);
@@ -111,13 +117,13 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 static int
 lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 		     u8 *frag_hdr, int frag_hdrlen,
-		     int offset, int len)
+		     int offset, int len, bool frag1)
 {
 	struct sk_buff *frag;
 
 	raw_dump_inline(__func__, " fragment header", frag_hdr, frag_hdrlen);
 
-	frag = lowpan_alloc_frag(skb, frag_hdrlen + len, wpan_hdr);
+	frag = lowpan_alloc_frag(skb, frag_hdrlen + len, wpan_hdr, frag1);
 	if (IS_ERR(frag))
 		return PTR_ERR(frag);
 
@@ -156,7 +162,8 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
 
 	rc = lowpan_xmit_fragment(skb, wpan_hdr, frag_hdr,
 				  LOWPAN_FRAG1_HEAD_SIZE, 0,
-				  frag_len + skb_network_header_len(skb));
+				  frag_len + skb_network_header_len(skb),
+				  true);
 	if (rc) {
 		pr_debug("%s unable to send FRAG1 packet (tag: %d)",
 			 __func__, ntohs(frag_tag));
@@ -177,7 +184,7 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
 
 		rc = lowpan_xmit_fragment(skb, wpan_hdr, frag_hdr,
 					  LOWPAN_FRAGN_HEAD_SIZE, skb_offset,
-					  frag_len);
+					  frag_len, false);
 		if (rc) {
 			pr_debug("%s unable to send a FRAGN packet. (tag: %d, offset: %d)\n",
 				 __func__, ntohs(frag_tag), skb_offset);
-- 
2.6.0

