Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38074 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbbI3IUU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 04:20:20 -0400
Received: by wiclk2 with SMTP id lk2so49748263wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2015 01:20:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154: 6lowpan: change datagram var types
Date: Wed, 30 Sep 2015 10:20:09 +0200
Message-Id: <1443601211-27790-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes datagram size variable from u16 type to unsigned int.
The reason is that an IPv6 header has an MAX_UIN16 payload length, but
the datagram size is payload + IPv6 header length. This avoids overflows
at some places.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/6lowpan_i.h  | 4 ++--
 net/ieee802154/6lowpan/reassembly.c | 2 +-
 net/ieee802154/6lowpan/tx.c         | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index b4e17a7..10d44d0 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -18,7 +18,7 @@ typedef unsigned __bitwise__ lowpan_rx_result;
 
 struct lowpan_create_arg {
 	u16 tag;
-	u16 d_size;
+	unsigned int d_size;
 	const struct ieee802154_addr *src;
 	const struct ieee802154_addr *dst;
 };
@@ -29,7 +29,7 @@ struct lowpan_frag_queue {
 	struct inet_frag_queue	q;
 
 	u16			tag;
-	u16			d_size;
+	unsigned int		d_size;
 	struct ieee802154_addr	saddr;
 	struct ieee802154_addr	daddr;
 };
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 12e8cf4..af663cb 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -37,7 +37,7 @@ static struct inet_frags lowpan_frags;
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
 			     struct sk_buff *prev, struct net_device *ldev);
 
-static unsigned int lowpan_hash_frag(u16 tag, u16 d_size,
+static unsigned int lowpan_hash_frag(u16 tag, unsigned int d_size,
 				     const struct ieee802154_addr *saddr,
 				     const struct ieee802154_addr *daddr)
 {
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 7e0563e..5ecf8af 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -131,8 +131,8 @@ lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 
 static int
 lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
-		       const struct ieee802154_hdr *wpan_hdr, u16 dgram_size,
-		       u16 dgram_offset)
+		       const struct ieee802154_hdr *wpan_hdr,
+		       unsigned int dgram_size, unsigned int dgram_offset)
 {
 	__be16 frag_tag;
 	u8 frag_hdr[5];
@@ -194,7 +194,7 @@ err:
 }
 
 static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
-			 u16 *dgram_size, u16 *dgram_offset)
+			 unsigned int *dgram_size, unsigned int *dgram_offset)
 {
 	struct wpan_dev *wpan_dev = lowpan_dev_info(ldev)->wdev->ieee802154_ptr;
 	struct ieee802154_addr sa, da;
@@ -244,7 +244,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 {
 	struct ieee802154_hdr wpan_hdr;
 	int max_single, ret;
-	u16 dgram_size, dgram_offset;
+	unsigned int dgram_size, dgram_offset;
 
 	pr_debug("package xmit\n");
 
-- 
2.6.0

