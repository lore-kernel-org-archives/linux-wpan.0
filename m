Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:37743 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeGBUcQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jul 2018 16:32:16 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so114056itc.2
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jul 2018 13:32:16 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan 1/2] net: 6lowpan: fix reserved space for single frames
Date: Mon,  2 Jul 2018 16:32:02 -0400
Message-Id: <20180702203203.21316-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

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
 net/ieee802154/6lowpan/tx.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index e6ff5128e61a..d0c4d220de08 100644
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
+		if (likely(skb)) {
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

