Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35346 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbbJMLnk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 13 Oct 2015 07:43:40 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/6] 6lowpan: cleanup lowpan_header_compress
Date: Tue, 13 Oct 2015 13:42:57 +0200
Message-Id: <1444736579-27826-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
References: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch changes the lowpan_header_compress function by removing
unused parameters like "len" and drop static value parameters of
protocol type. Instead we really check the protocol type inside inside
the skb structure. Also we drop the use of IEEE802154_ADDR_LEN which is
link-layer specific. Instead we using EUI64_ADDR_LEN which should always
the default case for now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h       | 30 +++++++++++++++++++++++-------
 net/6lowpan/iphc.c          | 17 +++++++----------
 net/bluetooth/6lowpan.c     |  3 +--
 net/ieee802154/6lowpan/tx.c |  2 +-
 4 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index aa5a823..6f1e0bd 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -258,7 +258,7 @@ struct lowpan_802154_cb *lowpan_802154_cb(const struct sk_buff *skb)
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
-				   unsigned char *buf, int len)
+				   const unsigned char *buf, int len)
 {
 	if (msg)
 		pr_debug("%s():%s: ", caller, msg);
@@ -273,7 +273,7 @@ static inline void raw_dump_inline(const char *caller, char *msg,
  * ...
  */
 static inline void raw_dump_table(const char *caller, char *msg,
-				  unsigned char *buf, int len)
+				  const unsigned char *buf, int len)
 {
 	if (msg)
 		pr_debug("%s():%s:\n", caller, msg);
@@ -282,9 +282,9 @@ static inline void raw_dump_table(const char *caller, char *msg,
 }
 #else
 static inline void raw_dump_table(const char *caller, char *msg,
-				  unsigned char *buf, int len) { }
+				  const unsigned char *buf, int len) { }
 static inline void raw_dump_inline(const char *caller, char *msg,
-				   unsigned char *buf, int len) { }
+				   const unsigned char *buf, int len) { }
 #endif
 
 static inline int lowpan_fetch_skb_u8(struct sk_buff *skb, u8 *val)
@@ -325,8 +325,24 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 			 const u8 saddr_len, const u8 *daddr,
 			 const u8 daddr_type, const u8 daddr_len,
 			 u8 iphc0, u8 iphc1);
-int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
-			unsigned short type, const void *_daddr,
-			const void *_saddr, unsigned int len);
+
+/**
+ * lowpan_header_compress - replace IPv6 header with 6LoWPAN header
+ *
+ * This function replaces the IPv6 header which should be pointed at
+ * skb->data and skb_network_header, with the IPHC 6LoWPAN header.
+ * The caller need to be sure that the sk buffer is not shared and at have
+ * at least a headroom which is smaller or equal LOWPAN_IPHC_MAX_HEADER_LEN,
+ * which is the IPHC "more bytes than IPv6 header" at worst case.
+ *
+ * @skb: the buffer which should be manipulate.
+ * @dev: the lowpan net device pointer.
+ * @daddr: destination lladdr of mac header which is used for compression
+ *	methods.
+ * @saddr: source lladdr of mac header which is used for compression
+ *	methods.
+ */
+int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
+			   const void *daddr, const void *saddr);
 
 #endif /* __6LOWPAN_H__ */
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index dd5f27d..4e4af8c 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -423,16 +423,15 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 	return rol8(val, shift);
 }
 
-int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
-			   unsigned short type, const void *_daddr,
-			   const void *_saddr, unsigned int len)
+int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
+			   const void *daddr, const void *saddr)
 {
 	u8 tmp, iphc0, iphc1, *hc_ptr;
 	struct ipv6hdr *hdr;
 	u8 head[LOWPAN_IPHC_MAX_HC_BUF_LEN] = {};
 	int ret, addr_type;
 
-	if (type != ETH_P_IPV6)
+	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
 
 	hdr = ipv6_hdr(skb);
@@ -456,10 +455,8 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 
 	/* TODO: context lookup */
 
-	raw_dump_inline(__func__, "saddr",
-			(unsigned char *)_saddr, IEEE802154_ADDR_LEN);
-	raw_dump_inline(__func__, "daddr",
-			(unsigned char *)_daddr, IEEE802154_ADDR_LEN);
+	raw_dump_inline(__func__, "saddr", saddr, EUI64_ADDR_LEN);
+	raw_dump_inline(__func__, "daddr", daddr, EUI64_ADDR_LEN);
 
 	raw_dump_table(__func__, "sending raw skb network uncompressed packet",
 		       skb->data, skb->len);
@@ -544,7 +541,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		if (addr_type & IPV6_ADDR_LINKLOCAL) {
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
 							 LOWPAN_IPHC_SAM_BIT,
-							 &hdr->saddr, _saddr);
+							 &hdr->saddr, saddr);
 			pr_debug("source address unicast link-local %pI6c iphc1 0x%02x\n",
 				 &hdr->saddr, iphc1);
 		} else {
@@ -589,7 +586,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 		if (addr_type & IPV6_ADDR_LINKLOCAL) {
 			/* TODO: context lookup */
 			iphc1 |= lowpan_compress_addr_64(&hc_ptr,
-				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, _daddr);
+				LOWPAN_IPHC_DAM_BIT, &hdr->daddr, daddr);
 			pr_debug("dest address unicast link-local %pI6c "
 				 "iphc1 0x%02x\n", &hdr->daddr, iphc1);
 		} else {
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 665bf38..e2b66f3 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -489,8 +489,7 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 		status = 1;
 	}
 
-	lowpan_header_compress(skb, netdev, ETH_P_IPV6, daddr,
-			       dev->netdev->dev_addr, skb->len);
+	lowpan_header_compress(skb, netdev, daddr, dev->netdev->dev_addr);
 
 	err = dev_hard_header(skb, netdev, ETH_P_IPV6, NULL, NULL, 0);
 	if (err < 0)
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 62a21f6..2a5b2c2 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -218,7 +218,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 	saddr = &info.saddr.u.extended_addr;
 
 	*dgram_size = skb->len;
-	lowpan_header_compress(skb, ldev, ETH_P_IPV6, daddr, saddr, skb->len);
+	lowpan_header_compress(skb, ldev, daddr, saddr);
 	/* dgram_offset = (saved bytes after compression) + lowpan header len */
 	*dgram_offset = (*dgram_size - skb->len) + skb_network_header_len(skb);
 
-- 
2.6.1

