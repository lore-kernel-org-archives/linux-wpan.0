Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54806 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbaJFJBq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 05:01:46 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so3837438wiv.17
        for <linux-wpan@vger.kernel.org>; Mon, 06 Oct 2014 02:01:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-next 1/3] ieee802154: 6lowpan: fix byteorder for frag tag
Date: Mon,  6 Oct 2014 11:00:50 +0200
Message-Id: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch fix byteorder issues with fragment tag of generation 802.15.4
6LoWPAN fragment header.

net/ieee802154/6lowpan_rtnl.c:278:54: warning restricted __be16 degrades to integer
net/ieee802154/6lowpan_rtnl.c:278:18: warning: incorrect type in assignment (different base types)
net/ieee802154/6lowpan_rtnl.c:278:18:    expected restricted __be16 [usertype] frag_tag
net/ieee802154/6lowpan_rtnl.c:278:18:    got unsigned short

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/ieee802154/6lowpan_rtnl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 4413629..8631206 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -63,7 +63,7 @@ static LIST_HEAD(lowpan_devices);
 struct lowpan_dev_info {
 	struct net_device	*real_dev; /* real WPAN device ptr */
 	struct mutex		dev_list_mtx; /* mutex for list ops */
-	__be16			fragment_tag;
+	u16			fragment_tag;
 };
 
 struct lowpan_dev_record {
@@ -275,7 +275,8 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *dev,
 
 	dgram_size = lowpan_uncompress_size(skb, &dgram_offset) -
 		     skb->mac_len;
-	frag_tag = lowpan_dev_info(dev)->fragment_tag++;
+	frag_tag = htons(lowpan_dev_info(dev)->fragment_tag);
+	lowpan_dev_info(dev)->fragment_tag++;
 
 	frag_hdr[0] = LOWPAN_DISPATCH_FRAG1 | ((dgram_size >> 8) & 0x07);
 	frag_hdr[1] = dgram_size & 0xff;
@@ -294,7 +295,7 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *dev,
 				  frag_len + skb_network_header_len(skb));
 	if (rc) {
 		pr_debug("%s unable to send FRAG1 packet (tag: %d)",
-			 __func__, frag_tag);
+			 __func__, ntohs(frag_tag));
 		goto err;
 	}
 
@@ -315,7 +316,7 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *dev,
 					  frag_len);
 		if (rc) {
 			pr_debug("%s unable to send a FRAGN packet. (tag: %d, offset: %d)\n",
-				 __func__, frag_tag, skb_offset);
+				 __func__, ntohs(frag_tag), skb_offset);
 			goto err;
 		}
 	} while (skb_unprocessed > frag_cap);
-- 
2.1.2

