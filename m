Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36951 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNRL5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Jul 2018 13:11:57 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so33958511ioh.4
        for <linux-wpan@vger.kernel.org>; Sat, 14 Jul 2018 09:52:18 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCHv2 wpan] net: 6lowpan: fix reserved space for single frames
Date: Sat, 14 Jul 2018 12:52:10 -0400
Message-Id: <20180714165210.20517-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, david.palma@ntnu.no, rabinarayans0828@gmail.com, Alexander Aring <aring@mojatatu.com>

This patch fixes patch add handling to take care tail and headroom for
single 6lowpan frames. We need to be sure we have a skb with the right
head and tailroom for single frames. This patch do it by using
skb_copy_expand() if head and tailroom is not enough allocated by upper
layer.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
Reported-by: David Palma <david.palma@ntnu.no>
Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
changes since v2:
 skb to nskb, pointed out by stefan

 net/ieee802154/6lowpan/tx.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index e6ff5128e61a..ca53efa17be1 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -265,9 +265,24 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-	skb = skb_unshare(skb, GFP_ATOMIC);
-	if (!skb)
-		return NET_XMIT_DROP;
+	if (unlikely(skb_headroom(skb) < ldev->needed_headroom ||
+		     skb_tailroom(skb) < ldev->needed_tailroom)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy_expand(skb, ldev->needed_headroom,
+				       ldev->needed_tailroom, GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb = nskb;
+		} else {
+			kfree_skb(skb);
+			return NET_XMIT_DROP;
+		}
+	} else {
+		skb = skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_XMIT_DROP;
+	}
 
 	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
 	if (ret < 0) {
-- 
2.11.0

