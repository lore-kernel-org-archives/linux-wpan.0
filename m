Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35730 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbbIRJa6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 05:30:58 -0400
Received: by wicge5 with SMTP id ge5so24501847wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 18 Sep 2015 02:30:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/5] ieee802154: change needed headroom/tailroom
Date: Fri, 18 Sep 2015 11:30:43 +0200
Message-Id: <1442568644-2158-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
References: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups needed_headroom, needed_tailroom and hard_header_len
fields for wpan and lowpan interfaces.

For wpan interfaces the worst case mac header len should be part of
needed_headroom, currently this is set as hard_header_len, but
hard_header_len should be set to the minimum header length which xmit
call assumes and this is the minimum frame length of 802.15.4.
The hard_header_len value will check inside send callbacl of AF_PACKET
raw sockets.

For lowpan interfaces, if fragmentation isn't needed the skb will
call dev_hard_header for 802154 layer and queue it afterwards. This
happens without new skb allocation, so we need the same headroom and
tailroom lengths like 802154 inside 802154 6lowpan layer. At least we
assume as minimum header length an ipv6 header size.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h    | 11 +++++++++++
 include/net/6lowpan.h         |  8 ++++++++
 include/net/mac802154.h       |  8 --------
 net/6lowpan/nhc.h             |  2 --
 net/ieee802154/6lowpan/core.c | 14 +++++++++++---
 net/ieee802154/6lowpan/tx.c   | 12 ++++++++++--
 net/ieee802154/header_ops.c   |  2 +-
 net/mac802154/iface.c         | 17 ++++++++++++++---
 net/mac802154/tx.c            |  3 ---
 9 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index db01492..205ce4e 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -31,6 +31,17 @@
 #define IEEE802154_ACK_PSDU_LEN		5
 #define IEEE802154_MIN_PSDU_LEN		9
 #define IEEE802154_FCS_LEN		2
+#define IEEE802154_MAX_AUTH_TAG_LEN	16
+
+/*  General MAC frame format:
+ *  2 bytes: Frame Control
+ *  1 byte:  Sequence Number
+ * 20 bytes: Addressing fields
+ * 14 bytes: Auxiliary Security Header
+ */
+#define IEEE802154_MAX_HEADER_LEN	(2 + 1 + 20 + 14)
+#define IEEE802154_MIN_HEADER_LEN	(IEEE802154_ACK_PSDU_LEN - \
+					 IEEE802154_FCS_LEN)
 
 #define IEEE802154_PAN_ID_BROADCAST	0xffff
 #define IEEE802154_ADDR_SHORT_BROADCAST	0xffff
diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index eeae5eb..c17f556 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -61,6 +61,14 @@
 #define UIP_PROTO_UDP			17 /* ipv6 next header value for UDP */
 #define UIP_FRAGH_LEN			8  /* ipv6 fragment header size */
 
+#define LOWPAN_NHC_MAX_ID_LEN	1
+/* Max IPHC Header len without IPv6 hdr specific inline data.
+ * Useful for getting the "extra" bytes we need at worst case compression.
+ *
+ * LOWPAN_IPHC + CID + LOWPAN_NHC_MAX_ID_LEN
+ */
+#define LOWPAN_IPHC_MAX_HEADER_LEN	(2 + 1 + LOWPAN_NHC_MAX_ID_LEN)
+
 /*
  * ipv6 address based on mac
  * second bit-flip (Universe/Local) is done according RFC2464
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 32bd7c0..2c47850 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -23,14 +23,6 @@
 
 #include <net/cfg802154.h>
 
-/* General MAC frame format:
- *  2 bytes: Frame Control
- *  1 byte:  Sequence Number
- * 20 bytes: Addressing fields
- * 14 bytes: Auxiliary Security Header
- */
-#define MAC802154_FRAME_HARD_HEADER_LEN		(2 + 1 + 20 + 14)
-
 /**
  * enum ieee802154_hw_addr_filt_flags - hardware address filtering flags
  *
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index ed44938..c249f17 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -8,8 +8,6 @@
 #include <net/6lowpan.h>
 #include <net/ipv6.h>
 
-#define LOWPAN_NHC_MAX_ID_LEN	1
-
 /**
  * LOWPAN_NHC - helper macro to generate nh id fields and lowpan_nhc struct
  *
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 9f0cfa5..44420ed 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -104,9 +104,8 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->addr_len		= IEEE802154_ADDR_LEN;
 	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
 	ldev->type		= ARPHRD_6LOWPAN;
-	/* Frame Control + Sequence Number + Address fields + Security Header */
-	ldev->hard_header_len	= 2 + 1 + 20 + 14;
-	ldev->needed_tailroom	= 2; /* FCS */
+	/* We need an ipv6hdr as minimum len when calling xmit */
+	ldev->hard_header_len	= sizeof(struct ipv6hdr);
 	ldev->mtu		= IPV6_MIN_MTU;
 	ldev->priv_flags	|= IFF_NO_QUEUE;
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
@@ -156,6 +155,15 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	lowpan_dev_info(ldev)->wdev = wdev;
 	/* Set the lowpan hardware address to the wpan hardware address. */
 	memcpy(ldev->dev_addr, wdev->dev_addr, IEEE802154_ADDR_LEN);
+	/* We need headroom for possible wpan_dev_hard_header call and tailroom
+	 * for encryption/fcs handling. The lowpan interface will replace
+	 * the IPv6 header with 6LoWPAN header. At worst case the 6LoWPAN
+	 * header has LOWPAN_IPHC_MAX_HEADER_LEN more bytes than the IPv6
+	 * header.
+	 */
+	ldev->needed_headroom = LOWPAN_IPHC_MAX_HEADER_LEN +
+				wdev->needed_headroom;
+	ldev->needed_tailroom = wdev->needed_tailroom;
 
 	lowpan_netdev_setup(ldev, LOWPAN_LLTYPE_IEEE802154);
 
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 6067e06..7e0563e 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -10,6 +10,7 @@
 
 #include <net/6lowpan.h>
 #include <net/ieee802154_netdev.h>
+#include <net/mac802154.h>
 
 #include "6lowpan_i.h"
 
@@ -36,6 +37,13 @@ lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
 			sizeof(struct lowpan_addr_info));
 }
 
+/* This callback will be called from AF_PACKET and IPv6 stack, the AF_PACKET
+ * sockets gives an 8 byte array for addresses only!
+ *
+ * TODO I think AF_PACKET DGRAM (sending/receiving) RAW (sending) makes no
+ * sense here. We should disable it, the right use-case would be AF_INET6
+ * RAW/DGRAM sockets.
+ */
 int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 			 unsigned short type, const void *_daddr,
 			 const void *_saddr, unsigned int len)
@@ -77,13 +85,13 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 	struct sk_buff *frag;
 	int rc;
 
-	frag = alloc_skb(wdev->hard_header_len + wdev->needed_tailroom + size,
+	frag = alloc_skb(wdev->needed_headroom + wdev->needed_tailroom + size,
 			 GFP_ATOMIC);
 
 	if (likely(frag)) {
 		frag->dev = wdev;
 		frag->priority = skb->priority;
-		skb_reserve(frag, wdev->hard_header_len);
+		skb_reserve(frag, wdev->needed_headroom);
 		skb_reset_network_header(frag);
 		*mac_cb(frag) = *mac_cb(skb);
 
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index d8443b0..c7439f0 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -85,7 +85,7 @@ ieee802154_hdr_push_sechdr(u8 *buf, const struct ieee802154_sechdr *hdr)
 int
 ieee802154_hdr_push(struct sk_buff *skb, struct ieee802154_hdr *hdr)
 {
-	u8 buf[MAC802154_FRAME_HARD_HEADER_LEN];
+	u8 buf[IEEE802154_MAX_HEADER_LEN];
 	int pos = 2;
 	int rc;
 	struct ieee802154_hdr_fc *fc = &hdr->fc;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 8afe26d..b5a0936 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -537,8 +537,18 @@ static void ieee802154_if_setup(struct net_device *dev)
 	dev->addr_len		= IEEE802154_EXTENDED_ADDR_LEN;
 	memset(dev->broadcast, 0xff, IEEE802154_EXTENDED_ADDR_LEN);
 
-	dev->hard_header_len	= MAC802154_FRAME_HARD_HEADER_LEN;
-	dev->needed_tailroom	= 2 + 16; /* FCS + MIC */
+	/* Let hard_header_len set to IEEE802154_MIN_HEADER_LEN. AF_PACKET
+	 * will not send frames without any payload, but ack frames
+	 * has no payload, so substract one that we can send a 3 bytes
+	 * frame. The xmit callback assumes at least a hard header where two
+	 * bytes fc and sequence field are set.
+	 */
+	dev->hard_header_len	= IEEE802154_MIN_HEADER_LEN - 1;
+	/* The auth_tag header is for security and places in private payload
+	 * room of mac frame which stucks between payload and FCS field.
+	 */
+	dev->needed_tailroom	= IEEE802154_MAX_AUTH_TAG_LEN +
+				  IEEE802154_FCS_LEN;
 	dev->mtu		= IEEE802154_MTU;
 	dev->tx_queue_len	= 300;
 	dev->flags		= IFF_NOARP | IFF_BROADCAST;
@@ -617,7 +627,8 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (!ndev)
 		return ERR_PTR(-ENOMEM);
 
-	ndev->needed_headroom = local->hw.extra_tx_headroom;
+	ndev->needed_headroom = local->hw.extra_tx_headroom +
+				IEEE802154_MAX_HEADER_LEN;
 
 	ret = dev_alloc_name(ndev, ndev->name);
 	if (ret < 0)
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 7ed4391..66d7ecb 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -77,9 +77,6 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
-	if (skb_cow_head(skb, local->hw.extra_tx_headroom))
-		goto err_tx;
-
 	/* Stop the netif queue on each sub_if_data object. */
 	ieee802154_stop_queue(&local->hw);
 
-- 
2.5.2

