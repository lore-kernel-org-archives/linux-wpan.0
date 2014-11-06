Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35124 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaKFTPX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 14:15:23 -0500
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCHv2 bluetooth-next] 6lowpan: move skb_free from error paths in decompression
Date: Thu,  6 Nov 2014 19:15:13 +0000
Message-Id: <1415301313-32290-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com, jukka.rissanen@linux.intel.com, marcel@holtmann.org, Martin Townsend <mtownsend1973@gmail.com>

Currently we ensure that the skb is freed on every error path in IPHC
decompression which makes it easy to introduce skb leaks.  By centralising
the skb_free into the receive function it makes future decompression routines
easier to maintain.  It does come at the expense of ensuring that the skb
passed into the decompression routine must not be copied.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 net/6lowpan/iphc.c            | 31 ++++++++++++-------------------
 net/bluetooth/6lowpan.c       | 15 +++++++--------
 net/ieee802154/6lowpan_rtnl.c | 16 ++++++----------
 3 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index cd5f8b8..aced97d 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -319,7 +319,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	if (iphc1 & LOWPAN_IPHC_CID) {
 		pr_debug("CID flag is set, increase header with one\n");
 		if (lowpan_fetch_skb(skb, &num_context, sizeof(num_context)))
-			goto drop;
+			return -EINVAL;
 	}
 
 	hdr.version = 6;
@@ -331,7 +331,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 0: /* 00b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return -EINVAL;
 
 		memcpy(&hdr.flow_lbl, &skb->data[0], 3);
 		skb_pull(skb, 3);
@@ -344,7 +344,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 2: /* 10b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return -EINVAL;
 
 		hdr.priority = ((tmp >> 2) & 0x0f);
 		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
@@ -354,7 +354,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 1: /* 01b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return -EINVAL;
 
 		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
 		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
@@ -371,7 +371,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
 		/* Next header is carried inline */
 		if (lowpan_fetch_skb(skb, &hdr.nexthdr, sizeof(hdr.nexthdr)))
-			goto drop;
+			return -EINVAL;
 
 		pr_debug("NH flag is set, next header carried inline: %02x\n",
 			 hdr.nexthdr);
@@ -383,7 +383,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		if (lowpan_fetch_skb(skb, &hdr.hop_limit,
 				     sizeof(hdr.hop_limit)))
-			goto drop;
+			return -EINVAL;
 	}
 
 	/* Extract SAM to the tmp variable */
@@ -402,7 +402,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 
 	/* Check on error of previous branch */
 	if (err)
-		goto drop;
+		return -EINVAL;
 
 	/* Extract DAM to the tmp variable */
 	tmp = ((iphc1 & LOWPAN_IPHC_DAM_11) >> LOWPAN_IPHC_DAM_BIT) & 0x03;
@@ -417,7 +417,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 								tmp);
 
 			if (err)
-				goto drop;
+				return -EINVAL;
 		}
 	} else {
 		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
@@ -425,7 +425,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
 			 tmp, &hdr.daddr);
 		if (err)
-			goto drop;
+			return -EINVAL;
 	}
 
 	/* UDP data uncompression */
@@ -434,16 +434,14 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 		const int needed = sizeof(struct udphdr) + sizeof(hdr);
 
 		if (uncompress_udp_header(skb, &uh))
-			goto drop;
+			return -EINVAL;
 
 		/* replace the compressed UDP head by the uncompressed UDP
 		 * header
 		 */
 		err = skb_cow(skb, needed);
-		if (unlikely(err)) {
-			kfree_skb(skb);
+		if (unlikely(err))
 			return err;
-		}
 
 		skb_push(skb, sizeof(struct udphdr));
 		skb_reset_transport_header(skb);
@@ -455,10 +453,8 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 		hdr.nexthdr = UIP_PROTO_UDP;
 	} else {
 		err = skb_cow(skb, sizeof(hdr));
-		if (unlikely(err)) {
-			kfree_skb(skb);
+		if (unlikely(err))
 			return err;
-		}
 	}
 
 	hdr.payload_len = htons(skb->len);
@@ -478,9 +474,6 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
 
 	return 0;
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(lowpan_header_decompress);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index eef298d..dc23c55 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -294,20 +294,20 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 	peer = __peer_lookup_chan(dev, chan);
 	rcu_read_unlock();
 	if (!peer)
-		goto drop;
+		return -EINVAL;
 
 	saddr = peer->eui64_addr;
 	daddr = dev->netdev->dev_addr;
 
 	/* at least two bytes will be used for the encoding */
 	if (skb->len < 2)
-		goto drop;
+		return -EINVAL;
 
 	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		goto drop;
+		return -EINVAL;
 
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
-		goto drop;
+		return -EINVAL;
 
 	return lowpan_header_decompress(skb, netdev,
 					saddr, IEEE802154_ADDR_LONG,
@@ -315,9 +315,6 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 					IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 					iphc0, iphc1);
 
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
 }
 
 static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
@@ -370,8 +367,10 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 				goto drop;
 
 			ret = iphc_decompress(local_skb, dev, chan);
-			if (ret < 0)
+			if (ret < 0) {
+				kfree_skb(local_skb);
 				goto drop;
+			}
 
 			local_skb->protocol = htons(ETH_P_IPV6);
 			local_skb->pkt_type = PACKET_HOST;
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index a96b64c..290e14f 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -176,13 +176,13 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
 	/* at least two bytes will be used for the encoding */
 	if (skb->len < 2)
-		goto drop;
+		return -EINVAL;
 
 	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		goto drop;
+		return -EINVAL;
 
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
-		goto drop;
+		return -EINVAL;
 
 	ieee802154_addr_to_sa(&sa, &hdr->source);
 	ieee802154_addr_to_sa(&da, &hdr->dest);
@@ -200,10 +200,6 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	return lowpan_header_decompress(skb, skb->dev, sap, sa.addr_type,
 					IEEE802154_ADDR_LEN, dap, da.addr_type,
 					IEEE802154_ADDR_LEN, iphc0, iphc1);
-
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
 }
 
 static struct sk_buff*
@@ -522,7 +518,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
 			ret = iphc_decompress(skb, &hdr);
 			if (ret < 0)
-				goto drop;
+				goto drop_skb;
 
 			return lowpan_give_skb_to_devices(skb, NULL);
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
@@ -530,7 +526,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 			if (ret == 1) {
 				ret = iphc_decompress(skb, &hdr);
 				if (ret < 0)
-					goto drop;
+					goto drop_skb;
 
 				return lowpan_give_skb_to_devices(skb, NULL);
 			} else if (ret == -1) {
@@ -543,7 +539,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 			if (ret == 1) {
 				ret = iphc_decompress(skb, &hdr);
 				if (ret < 0)
-					goto drop;
+					goto drop_skb;
 
 				return lowpan_give_skb_to_devices(skb, NULL);
 			} else if (ret == -1) {
-- 
1.9.1

