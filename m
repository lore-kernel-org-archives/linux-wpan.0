Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34824 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbaJWOlS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Oct 2014 10:41:18 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v5 bluetooth-next 4/4] ieee802154: 6lowpan: rename process_data and lowpan_process_data
Date: Thu, 23 Oct 2014 15:40:56 +0100
Message-Id: <1414075256-9448-5-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
References: <1414075256-9448-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <mtownsend1973@gmail.com>

From: Martin Townsend <mtownsend1973@gmail.com>

As we have decouple decompression from data delivery we can now rename all
occurences of process_data in receive path.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 include/net/6lowpan.h         | 10 ++++++----
 net/6lowpan/iphc.c            | 12 +++++++-----
 net/bluetooth/6lowpan.c       | 15 ++++++++-------
 net/ieee802154/6lowpan_rtnl.c | 15 ++++++++-------
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index abfa359..dc03d77 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -372,10 +372,12 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-		u8 iphc0, u8 iphc1);
+int
+lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
+			 const u8 *saddr, const u8 saddr_type,
+			 const u8 saddr_len, const u8 *daddr,
+			 const u8 daddr_type, const u8 daddr_len,
+			 u8 iphc0, u8 iphc1);
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			unsigned short type, const void *_daddr,
 			const void *_saddr, unsigned int len);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 45714fe..73a7065 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -301,10 +301,12 @@ err:
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-			u8 iphc0, u8 iphc1)
+int
+lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
+			 const u8 *saddr, const u8 saddr_type,
+			 const u8 saddr_len, const u8 *daddr,
+			 const u8 daddr_type, const u8 daddr_len,
+			 u8 iphc0, u8 iphc1)
 {
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
@@ -480,7 +482,7 @@ drop:
 	kfree_skb(skb);
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(lowpan_process_data);
+EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 				  const struct in6_addr *ipaddr,
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 40e2cec..aa6ebbf 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -257,8 +257,8 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 	return netif_rx(skb_cp);
 }
 
-static int process_data(struct sk_buff *skb, struct net_device *netdev,
-			struct l2cap_chan *chan)
+static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
+			   struct l2cap_chan *chan)
 {
 	const u8 *saddr, *daddr;
 	u8 iphc0, iphc1;
@@ -287,10 +287,11 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
 		goto drop;
 
-	return lowpan_process_data(skb, netdev,
-				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
-				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
-				   iphc0, iphc1);
+	return lowpan_header_decompress(skb, netdev,
+					saddr, IEEE802154_ADDR_LONG,
+					EUI64_ADDR_LEN, daddr,
+					IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
+					iphc0, iphc1);
 
 drop:
 	kfree_skb(skb);
@@ -346,7 +347,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 			if (!local_skb)
 				goto drop;
 
-			ret = process_data(local_skb, dev, chan);
+			ret = iphc_decompress(local_skb, dev, chan);
 			if (ret < 0)
 				goto drop;
 
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 577597d..d413a60 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -166,7 +166,8 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
 	return stat;
 }
 
-static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+static int
+iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 {
 	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
@@ -196,9 +197,9 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	else
 		dap = &da.hwaddr;
 
-	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
-				   IEEE802154_ADDR_LEN, dap, da.addr_type,
-				   IEEE802154_ADDR_LEN, iphc0, iphc1);
+	return lowpan_header_decompress(skb, skb->dev, sap, sa.addr_type,
+					IEEE802154_ADDR_LEN, dap, da.addr_type,
+					IEEE802154_ADDR_LEN, iphc0, iphc1);
 
 drop:
 	kfree_skb(skb);
@@ -541,7 +542,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = process_data(skb, &hdr);
+			ret = iphc_decompress(skb, &hdr);
 			if (ret < 0)
 				goto drop;
 
@@ -549,7 +550,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
+				ret = iphc_decompress(skb, &hdr);
 				if (ret < 0)
 					goto drop;
 
@@ -562,7 +563,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
+				ret = iphc_decompress(skb, &hdr);
 				if (ret < 0)
 					goto drop;
 
-- 
1.9.1

