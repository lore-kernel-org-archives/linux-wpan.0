Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56975 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbaJFJBr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 05:01:47 -0400
Received: by mail-wi0-f182.google.com with SMTP id n3so3845633wiv.15
        for <linux-wpan@vger.kernel.org>; Mon, 06 Oct 2014 02:01:45 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-next 2/3] ieee802154: reassembly: fix tag byteorder
Date: Mon,  6 Oct 2014 11:00:51 +0200
Message-Id: <1412586052-27299-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch fix byte order handling in reassembly code of 802.15.4
6LoWPAN fragmentation handling.

net/ieee802154/reassembly.c:58:43: warning: restricted __be16 degrades to integer

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/ieee802154/reassembly.c | 8 +++++---
 net/ieee802154/reassembly.h | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
index 32755cb..43c4163 100644
--- a/net/ieee802154/reassembly.c
+++ b/net/ieee802154/reassembly.c
@@ -33,7 +33,7 @@
 static const char lowpan_frags_cache_name[] = "lowpan-frags";
 
 struct lowpan_frag_info {
-	__be16 d_tag;
+	u16 d_tag;
 	u16 d_size;
 	u8 d_offset;
 };
@@ -48,7 +48,7 @@ static struct inet_frags lowpan_frags;
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
 			     struct sk_buff *prev, struct net_device *dev);
 
-static unsigned int lowpan_hash_frag(__be16 tag, u16 d_size,
+static unsigned int lowpan_hash_frag(u16 tag, u16 d_size,
 				     const struct ieee802154_addr *saddr,
 				     const struct ieee802154_addr *daddr)
 {
@@ -330,11 +330,13 @@ static int lowpan_get_frag_info(struct sk_buff *skb, const u8 frag_type,
 {
 	bool fail;
 	u8 pattern = 0, low = 0;
+	__be16 d_tag = 0;
 
 	fail = lowpan_fetch_skb(skb, &pattern, 1);
 	fail |= lowpan_fetch_skb(skb, &low, 1);
 	frag_info->d_size = (pattern & 7) << 8 | low;
-	fail |= lowpan_fetch_skb(skb, &frag_info->d_tag, 2);
+	fail |= lowpan_fetch_skb(skb, &d_tag, 2);
+	frag_info->d_tag = ntohs(d_tag);
 
 	if (frag_type == LOWPAN_DISPATCH_FRAGN) {
 		fail |= lowpan_fetch_skb(skb, &frag_info->d_offset, 1);
diff --git a/net/ieee802154/reassembly.h b/net/ieee802154/reassembly.h
index 74e4a7c..836b16f 100644
--- a/net/ieee802154/reassembly.h
+++ b/net/ieee802154/reassembly.h
@@ -4,7 +4,7 @@
 #include <net/inet_frag.h>
 
 struct lowpan_create_arg {
-	__be16 tag;
+	u16 tag;
 	u16 d_size;
 	const struct ieee802154_addr *src;
 	const struct ieee802154_addr *dst;
@@ -15,7 +15,7 @@ struct lowpan_create_arg {
 struct lowpan_frag_queue {
 	struct inet_frag_queue	q;
 
-	__be16			tag;
+	u16			tag;
 	u16			d_size;
 	struct ieee802154_addr	saddr;
 	struct ieee802154_addr	daddr;
-- 
2.1.2

