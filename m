Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:53472 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeFAP7B (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jun 2018 11:59:01 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so2294472itd.3
        for <linux-wpan@vger.kernel.org>; Fri, 01 Jun 2018 08:59:00 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH RFC wpan] net: 6lowpan: fix reserved space for single frames
Date: Fri,  1 Jun 2018 11:58:43 -0400
Message-Id: <20180601155843.29724-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch fixes patch add handling to take care tail and headroom for
single 6lowpan frames. We need to be sure we have a skb with the right
head and tailroom for single frames. This patch do it by using
skb_copy_expand().

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
I hope the refcounting doesn't change here... anyway it also copy skb.
Anyway, it fix something... we can think about perfomance later.

Also I thought the upper layer would allocate the right needed_headroom
and needed_tailroom for me, so I don't need to realloc in transmit.
Maybe this is a bigger issue in the upper layer? I am pretty sure these
extra bytes should be allocated when skb is created according the
net_device which ndo_xmit() will be called from.

I will ask this question to netdev mailinglist..., if no answer then
simple apply this patch @stefan. (If it's looking okay for you).

 net/ieee802154/6lowpan/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index e6ff5128e61a..2d74918431e3 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -265,7 +265,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-	skb = skb_unshare(skb, GFP_ATOMIC);
+	skb = skb_copy_expand(skb, ldev->needed_headroom,
+			      ldev->needed_tailroom, GFP_ATOMIC);
 	if (!skb)
 		return NET_XMIT_DROP;
 
-- 
2.11.0

