Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:43133 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeDTSyf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Apr 2018 14:54:35 -0400
Received: by mail-io0-f196.google.com with SMTP id q84-v6so11645661iod.10
        for <linux-wpan@vger.kernel.org>; Fri, 20 Apr 2018 11:54:35 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan] net: ieee802154: 6lowpan: fix frag reassembly
Date: Fri, 20 Apr 2018 14:54:13 -0400
Message-Id: <20180420185413.8818-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, eric.dumazet@gmail.com, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch initialize stack variables which are used in
frag_lowpan_compare_key to zero. In my case there are padding bytes in the
structures ieee802154_addr as well in frag_lowpan_compare_key. Otherwise
the key variable contains random bytes. The result is that a compare of
two keys by memcmp works incorrect.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reported-by: Stefan Schmidt <stefan@osg.samsung.com>
---
So far I see it's a case of 32 alignment in frag_v4_compare_key and
frag_v6_compare_key and I am not sure about if this works on all arch
correctly.

 net/ieee802154/6lowpan/6lowpan_i.h  |  4 ++--
 net/ieee802154/6lowpan/reassembly.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index b8d95cb71c25..44a7e16bf3b5 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -20,8 +20,8 @@ typedef unsigned __bitwise lowpan_rx_result;
 struct frag_lowpan_compare_key {
 	u16 tag;
 	u16 d_size;
-	const struct ieee802154_addr src;
-	const struct ieee802154_addr dst;
+	struct ieee802154_addr src;
+	struct ieee802154_addr dst;
 };
 
 /* Equivalent of ipv4 struct ipq
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 1790b65944b3..2cc224106b69 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -75,14 +75,14 @@ fq_find(struct net *net, const struct lowpan_802154_cb *cb,
 {
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
-	struct frag_lowpan_compare_key key = {
-		.tag = cb->d_tag,
-		.d_size = cb->d_size,
-		.src = *src,
-		.dst = *dst,
-	};
+	struct frag_lowpan_compare_key key = {};
 	struct inet_frag_queue *q;
 
+	key.tag = cb->d_tag;
+	key.d_size = cb->d_size;
+	key.src = *src;
+	key.dst = *dst;
+
 	q = inet_frag_find(&ieee802154_lowpan->frags, &key);
 	if (!q)
 		return NULL;
@@ -372,7 +372,7 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 	struct lowpan_frag_queue *fq;
 	struct net *net = dev_net(skb->dev);
 	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = {};
 	int err;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-- 
2.11.0

