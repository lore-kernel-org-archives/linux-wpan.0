Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35406 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771AbbJAGDP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Oct 2015 02:03:15 -0400
Received: by wicge5 with SMTP id ge5so13017830wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2015 23:03:14 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: handle datagram variables as u16
Date: Thu,  1 Oct 2015 08:03:06 +0200
Message-Id: <1443679386-16825-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This reverts commit 9abc378c66e3d6f437eed77c1c534cbc183523f7
("ieee802154: 6lowpan: change datagram var types").

The reason is that I forgot the IPv6 fragmentation here. Our MTU of
lowpan interface is 1280 and skb->len should not above of that. If we
reach a payload above 1280 in IPv6 header then we have a IPv6
fragmentation above 802.15.4 6LoWPAN fragmentation. The type "u16" was
fine, instead I added now a WARN_ON_ONCE if skb->len is above MTU which
should never happen otherwise IPv6 on minimum MTU size is broken.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/6lowpan_i.h  |  4 ++--
 net/ieee802154/6lowpan/reassembly.c |  2 +-
 net/ieee802154/6lowpan/tx.c         | 10 ++++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index 10d44d0..b4e17a7 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -18,7 +18,7 @@ typedef unsigned __bitwise__ lowpan_rx_result;
 
 struct lowpan_create_arg {
 	u16 tag;
-	unsigned int d_size;
+	u16 d_size;
 	const struct ieee802154_addr *src;
 	const struct ieee802154_addr *dst;
 };
@@ -29,7 +29,7 @@ struct lowpan_frag_queue {
 	struct inet_frag_queue	q;
 
 	u16			tag;
-	unsigned int		d_size;
+	u16			d_size;
 	struct ieee802154_addr	saddr;
 	struct ieee802154_addr	daddr;
 };
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index af663cb..12e8cf4 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -37,7 +37,7 @@ static struct inet_frags lowpan_frags;
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
 			     struct sk_buff *prev, struct net_device *ldev);
 
-static unsigned int lowpan_hash_frag(u16 tag, unsigned int d_size,
+static unsigned int lowpan_hash_frag(u16 tag, u16 d_size,
 				     const struct ieee802154_addr *saddr,
 				     const struct ieee802154_addr *daddr)
 {
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 5736302..62a21f6 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -137,8 +137,8 @@ lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 
 static int
 lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
-		       const struct ieee802154_hdr *wpan_hdr,
-		       unsigned int dgram_size, unsigned int dgram_offset)
+		       const struct ieee802154_hdr *wpan_hdr, u16 dgram_size,
+		       u16 dgram_offset)
 {
 	__be16 frag_tag;
 	u8 frag_hdr[5];
@@ -203,7 +203,7 @@ err:
 }
 
 static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
-			 unsigned int *dgram_size, unsigned int *dgram_offset)
+			 u16 *dgram_size, u16 *dgram_offset)
 {
 	struct wpan_dev *wpan_dev = lowpan_dev_info(ldev)->wdev->ieee802154_ptr;
 	struct ieee802154_addr sa, da;
@@ -253,10 +253,12 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 {
 	struct ieee802154_hdr wpan_hdr;
 	int max_single, ret;
-	unsigned int dgram_size, dgram_offset;
+	u16 dgram_size, dgram_offset;
 
 	pr_debug("package xmit\n");
 
+	WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
+
 	/* We must take a copy of the skb before we modify/replace the ipv6
 	 * header as the header could be used elsewhere
 	 */
-- 
2.6.0

