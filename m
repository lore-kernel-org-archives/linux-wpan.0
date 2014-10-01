Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64829 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAMKh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 08:10:37 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in lowpan_rcv
Date: Wed,  1 Oct 2014 13:10:22 +0100
Message-Id: <1412165422-31063-2-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, Martin Townsend <martin.townsend@xsilon.com>

Currently there are a number of error paths in the lowpan_rcv function that
free the skb before returning, the patch simplifies the receive path by
ensuring that the skb is only freed from this function.

Passing the skb from 6lowpan up to the higher layers is not a
function of IPHC.  By moving it out of IPHC we also remove the
need to support error code returns with NET_RX codes.
It also makes the lowpan_rcv function more extendable as we
can support more compression schemes.

With the above 2 lowpan_rcv is refactored so eliminate incorrect return values.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         |  9 +++--
 net/6lowpan/iphc.c            | 92 ++++++++++++++++---------------------------
 net/bluetooth/6lowpan.c       | 52 ++++++++++++++++--------
 net/ieee802154/6lowpan_rtnl.c | 66 ++++++++++++++++++++-----------
 4 files changed, 117 insertions(+), 102 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index d184df1..05ff67e 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -374,10 +374,11 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 
 typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
+int
+lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+		    const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
+		    const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
+		    u8 iphc0, u8 iphc1);
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			unsigned short type, const void *_daddr,
 			const void *_saddr, unsigned int len);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 142eef5..3888357 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -171,37 +171,6 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
 	return 0;
 }
 
-static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
-		       struct net_device *dev, skb_delivery_cb deliver_skb)
-{
-	struct sk_buff *new;
-	int stat;
-
-	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
-			      GFP_ATOMIC);
-	kfree_skb(skb);
-
-	if (!new)
-		return -ENOMEM;
-
-	skb_push(new, sizeof(struct ipv6hdr));
-	skb_reset_network_header(new);
-	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
-
-	new->protocol = htons(ETH_P_IPV6);
-	new->pkt_type = PACKET_HOST;
-	new->dev = dev;
-
-	raw_dump_table(__func__, "raw skb data dump before receiving",
-		       new->data, new->len);
-
-	stat = deliver_skb(new, dev);
-
-	kfree_skb(new);
-
-	return stat;
-}
-
 /* Uncompress function for multicast destination address,
  * when M bit is set.
  */
@@ -332,10 +301,11 @@ err:
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
+int
+lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+		    const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
+		    const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
+		    u8 iphc0, u8 iphc1)
 {
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
@@ -348,7 +318,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if (iphc1 & LOWPAN_IPHC_CID) {
 		pr_debug("CID flag is set, increase header with one\n");
 		if (lowpan_fetch_skb(skb, &num_context, sizeof(num_context)))
-			goto drop;
+			return -EINVAL;
 	}
 
 	hdr.version = 6;
@@ -360,7 +330,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 0: /* 00b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return -EINVAL;
 
 		memcpy(&hdr.flow_lbl, &skb->data[0], 3);
 		skb_pull(skb, 3);
@@ -373,7 +343,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 2: /* 10b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return -EINVAL;
 
 		hdr.priority = ((tmp >> 2) & 0x0f);
 		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
@@ -383,7 +353,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 1: /* 01b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return -EINVAL;
 
 		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
 		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
@@ -400,7 +370,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
 		/* Next header is carried inline */
 		if (lowpan_fetch_skb(skb, &hdr.nexthdr, sizeof(hdr.nexthdr)))
-			goto drop;
+			return -EINVAL;
 
 		pr_debug("NH flag is set, next header carried inline: %02x\n",
 			 hdr.nexthdr);
@@ -412,7 +382,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		if (lowpan_fetch_skb(skb, &hdr.hop_limit,
 				     sizeof(hdr.hop_limit)))
-			goto drop;
+			return -EINVAL;
 	}
 
 	/* Extract SAM to the tmp variable */
@@ -431,7 +401,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 
 	/* Check on error of previous branch */
 	if (err)
-		goto drop;
+		return -EINVAL;
 
 	/* Extract DAM to the tmp variable */
 	tmp = ((iphc1 & LOWPAN_IPHC_DAM_11) >> LOWPAN_IPHC_DAM_BIT) & 0x03;
@@ -446,7 +416,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 								tmp);
 
 			if (err)
-				goto drop;
+				return -EINVAL;
 		}
 	} else {
 		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
@@ -454,28 +424,26 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
 			 tmp, &hdr.daddr);
 		if (err)
-			goto drop;
+			return -EINVAL;
 	}
 
 	/* UDP data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH_C) {
 		struct udphdr uh;
-		struct sk_buff *new;
 
 		if (uncompress_udp_header(skb, &uh))
-			goto drop;
+			return -EINVAL;
 
 		/* replace the compressed UDP head by the uncompressed UDP
 		 * header
 		 */
-		new = skb_copy_expand(skb, sizeof(struct udphdr),
-				      skb_tailroom(skb), GFP_ATOMIC);
-		kfree_skb(skb);
-
-		if (!new)
-			return -ENOMEM;
+		if (skb_headroom(skb) < sizeof(struct udphdr) + sizeof(hdr)) {
+			int n = sizeof(struct udphdr) + sizeof(hdr);
 
-		skb = new;
+			err = pskb_expand_head(skb, n, 0, GFP_ATOMIC);
+			if (unlikely(err))
+				return err;
+		}
 
 		skb_push(skb, sizeof(struct udphdr));
 		skb_reset_transport_header(skb);
@@ -485,6 +453,13 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 			       (u8 *)&uh, sizeof(uh));
 
 		hdr.nexthdr = UIP_PROTO_UDP;
+	} else {
+		if (skb_headroom(skb) < sizeof(hdr)) {
+			err = pskb_expand_head(skb, sizeof(hdr), 0, GFP_ATOMIC);
+
+			if (unlikely(err))
+				return err;
+		}
 	}
 
 	hdr.payload_len = htons(skb->len);
@@ -499,11 +474,14 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 
 	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
 
-	return skb_deliver(skb, &hdr, dev, deliver_skb);
+	skb_push(skb, sizeof(hdr));
+	skb_reset_network_header(skb);
+	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
 
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	raw_dump_table(__func__, "raw skb data dump before receiving",
+		       skb->data, skb->len);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(lowpan_process_data);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 206b65c..adfd361 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -230,36 +230,31 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	peer = peer_lookup_chan(dev, chan);
 	read_unlock_irqrestore(&devices_lock, flags);
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
 
 	return lowpan_process_data(skb, netdev,
 				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
-				   iphc0, iphc1, give_skb_to_upper);
-
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
+				   iphc0, iphc1);
 }
 
 static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		    struct l2cap_chan *chan)
 {
 	struct sk_buff *local_skb;
-	int ret;
 
 	if (!netif_running(dev))
 		goto drop;
@@ -280,12 +275,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		local_skb->protocol = htons(ETH_P_IPV6);
 		local_skb->pkt_type = PACKET_HOST;
 
-		skb_reset_network_header(local_skb);
-		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
-
 		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
-			kfree_skb(local_skb);
-			goto drop;
+			goto drop_local_skb;
 		}
 
 		dev->stats.rx_bytes += skb->len;
@@ -294,15 +285,40 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		kfree_skb(local_skb);
 		kfree_skb(skb);
 	} else {
+		int ret;
+
+		if (skb_cloned(skb)) {
+			struct sk_buff *new;
+			int new_headroom = sizeof(struct ipv6hdr) +
+					   sizeof(struct udphdr);
+
+			new = skb_copy_expand(skb, new_headroom,
+					      skb_tailroom(skb), GFP_ATOMIC);
+			if (!new)
+				return -ENOMEM;
+			consume_skb(skb);
+			skb = new;
+		}
+
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
+
+			ret = process_data(skb, dev, chan);
+			if (ret < 0)
+				goto drop;
+
 			local_skb = skb_clone(skb, GFP_ATOMIC);
 			if (!local_skb)
 				goto drop;
 
-			ret = process_data(local_skb, dev, chan);
-			if (ret != NET_RX_SUCCESS)
+			local_skb->protocol = htons(ETH_P_IPV6);
+			local_skb->pkt_type = PACKET_HOST;
+
+			if (give_skb_to_upper(local_skb, dev)
+							!= NET_RX_SUCCESS) {
+				kfree_skb(local_skb);
 				goto drop;
+			}
 
 			dev->stats.rx_bytes += skb->len;
 			dev->stats.rx_packets++;
@@ -316,6 +332,8 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 
 	return NET_RX_SUCCESS;
 
+drop_local_skb:
+	kfree_skb(local_skb);
 drop:
 	dev->stats.rx_dropped++;
 	kfree_skb(skb);
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 6591d27..c64baa3 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -155,8 +155,9 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
 		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
 			skb_cp = skb_copy(skb, GFP_ATOMIC);
 			if (!skb_cp) {
-				stat = -ENOMEM;
-				break;
+				kfree_skb(skb);
+				rcu_read_unlock();
+				return NET_RX_DROP;
 			}
 
 			skb_cp->dev = entry->ldev;
@@ -164,6 +165,8 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
 		}
 	rcu_read_unlock();
 
+	consume_skb(skb);
+
 	return stat;
 }
 
@@ -176,13 +179,13 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
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
@@ -199,12 +202,7 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 
 	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
 				   IEEE802154_ADDR_LEN, dap, da.addr_type,
-				   IEEE802154_ADDR_LEN, iphc0, iphc1,
-				   lowpan_give_skb_to_devices);
-
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
+				   IEEE802154_ADDR_LEN, iphc0, iphc1);
 }
 
 static int lowpan_set_address(struct net_device *dev, void *p)
@@ -478,36 +476,52 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	/* check that it's our buffer */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
-		skb->protocol = htons(ETH_P_IPV6);
-		skb->pkt_type = PACKET_HOST;
-
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
 
-		ret = lowpan_give_skb_to_devices(skb, NULL);
-		if (ret == NET_RX_DROP)
-			goto drop;
 	} else {
+		/* Decompression may use pskb_expand_head, ensure skb unique */
+		if (skb_cloned(skb)) {
+			struct sk_buff *new;
+			int new_headroom = sizeof(struct ipv6hdr) +
+					   sizeof(struct udphdr);
+
+			new = skb_copy_expand(skb, new_headroom,
+					      skb_tailroom(skb), GFP_ATOMIC);
+			if (!new)
+				return -ENOMEM;
+			consume_skb(skb);
+			skb = new;
+		}
+
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
 			ret = process_data(skb, &hdr);
-			if (ret == NET_RX_DROP)
-				goto drop;
+			if (ret < 0)
+				goto drop_skb;
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
 				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
-					goto drop;
+				if (ret < 0)
+					goto drop_skb;
+			} else if (ret < 0) {
+				goto drop;
+			} else {
+				return NET_RX_SUCCESS;
 			}
 			break;
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
 				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
-					goto drop;
+				if (ret < 0)
+					goto drop_skb;
+			} else if (ret < 0) {
+				goto drop;
+			} else {
+				return NET_RX_SUCCESS;
 			}
 			break;
 		default:
@@ -515,7 +529,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	return NET_RX_SUCCESS;
+	/* Pass IPv6 packet up to next layer */
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+	return lowpan_give_skb_to_devices(skb, NULL);
+
 drop_skb:
 	kfree_skb(skb);
 drop:
-- 
1.9.1

