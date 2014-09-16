Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:53553 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaIPLCQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 07:02:16 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in lowpan_rcv
Date: Tue, 16 Sep 2014 12:01:59 +0100
Message-Id: <1410865319-16310-2-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1410865319-16310-1-git-send-email-martin.townsend@xsilon.com>
References: <1410865319-16310-1-git-send-email-martin.townsend@xsilon.com>
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

With the above 2 lowpan_rcv is refacored so eliminate incorrect return values.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         |  9 +++--
 net/6lowpan/iphc.c            | 88 +++++++++++++++++--------------------------
 net/bluetooth/6lowpan.c       | 38 ++++++++++---------
 net/ieee802154/6lowpan_rtnl.c | 61 ++++++++++++++++--------------
 4 files changed, 94 insertions(+), 102 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index d184df1..c28fadb 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -374,10 +374,11 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 
 typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
+struct sk_buff *
+lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+		    const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
+		    const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
+		    u8 iphc0, u8 iphc1);
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			unsigned short type, const void *_daddr,
 			const void *_saddr, unsigned int len);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 142eef5..6ac7765 100644
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
@@ -332,14 +301,16 @@ err:
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
+struct sk_buff *
+lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+		    const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
+		    const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
+		    u8 iphc0, u8 iphc1)
 {
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
 	int err;
+	struct sk_buff *new;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
 		       skb->data, skb->len);
@@ -348,7 +319,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if (iphc1 & LOWPAN_IPHC_CID) {
 		pr_debug("CID flag is set, increase header with one\n");
 		if (lowpan_fetch_skb(skb, &num_context, sizeof(num_context)))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 	}
 
 	hdr.version = 6;
@@ -360,7 +331,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 0: /* 00b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 
 		memcpy(&hdr.flow_lbl, &skb->data[0], 3);
 		skb_pull(skb, 3);
@@ -373,7 +344,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 2: /* 10b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 
 		hdr.priority = ((tmp >> 2) & 0x0f);
 		hdr.flow_lbl[0] = ((tmp << 6) & 0xC0) | ((tmp >> 2) & 0x30);
@@ -383,7 +354,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	 */
 	case 1: /* 01b */
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 
 		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
 		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
@@ -400,7 +371,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	if ((iphc0 & LOWPAN_IPHC_NH_C) == 0) {
 		/* Next header is carried inline */
 		if (lowpan_fetch_skb(skb, &hdr.nexthdr, sizeof(hdr.nexthdr)))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 
 		pr_debug("NH flag is set, next header carried inline: %02x\n",
 			 hdr.nexthdr);
@@ -412,7 +383,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		if (lowpan_fetch_skb(skb, &hdr.hop_limit,
 				     sizeof(hdr.hop_limit)))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 	}
 
 	/* Extract SAM to the tmp variable */
@@ -431,7 +402,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 
 	/* Check on error of previous branch */
 	if (err)
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	/* Extract DAM to the tmp variable */
 	tmp = ((iphc1 & LOWPAN_IPHC_DAM_11) >> LOWPAN_IPHC_DAM_BIT) & 0x03;
@@ -446,7 +417,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 								tmp);
 
 			if (err)
-				goto drop;
+				return ERR_PTR(-EINVAL);
 		}
 	} else {
 		err = uncompress_addr(skb, &hdr.daddr, tmp, daddr,
@@ -454,27 +425,25 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		pr_debug("dest: stateless compression mode %d dest %pI6c\n",
 			 tmp, &hdr.daddr);
 		if (err)
-			goto drop;
+			return ERR_PTR(-EINVAL);
 	}
 
 	/* UDP data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH_C) {
 		struct udphdr uh;
-		struct sk_buff *new;
 
 		if (uncompress_udp_header(skb, &uh))
-			goto drop;
+			return ERR_PTR(-EINVAL);
 
 		/* replace the compressed UDP head by the uncompressed UDP
 		 * header
 		 */
 		new = skb_copy_expand(skb, sizeof(struct udphdr),
 				      skb_tailroom(skb), GFP_ATOMIC);
-		kfree_skb(skb);
-
 		if (!new)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 
+		consume_skb(skb);
 		skb = new;
 
 		skb_push(skb, sizeof(struct udphdr));
@@ -499,11 +468,24 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 
 	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
 
-	return skb_deliver(skb, &hdr, dev, deliver_skb);
+	/* Setup skb with new uncompressed IPv6 header. */
+	new = skb_copy_expand(skb, sizeof(hdr), skb_tailroom(skb),
+			      GFP_ATOMIC);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
 
-drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	consume_skb(skb);
+	skb = new;
+
+	skb_push(skb, sizeof(hdr));
+	skb_reset_network_header(skb);
+	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
+	skb->dev = dev;
+
+	raw_dump_table(__func__, "raw skb data dump before receiving",
+		       skb->data, skb->len);
+
+	return skb;
 }
 EXPORT_SYMBOL_GPL(lowpan_process_data);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 206b65c..a44938b 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -215,8 +215,9 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 	return ret;
 }
 
-static int process_data(struct sk_buff *skb, struct net_device *netdev,
-			struct l2cap_chan *chan)
+static struct sk_buff *
+process_data(struct sk_buff *skb, struct net_device *netdev,
+	     struct l2cap_chan *chan)
 {
 	const u8 *saddr, *daddr;
 	u8 iphc0, iphc1;
@@ -230,36 +231,31 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	peer = peer_lookup_chan(dev, chan);
 	read_unlock_irqrestore(&devices_lock, flags);
 	if (!peer)
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	saddr = peer->eui64_addr;
 	daddr = dev->netdev->dev_addr;
 
 	/* at least two bytes will be used for the encoding */
 	if (skb->len < 2)
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
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
@@ -280,9 +276,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		local_skb->protocol = htons(ETH_P_IPV6);
 		local_skb->pkt_type = PACKET_HOST;
 
-		skb_reset_network_header(local_skb);
-		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
-
 		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
 			kfree_skb(local_skb);
 			goto drop;
@@ -300,9 +293,20 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 			if (!local_skb)
 				goto drop;
 
-			ret = process_data(local_skb, dev, chan);
-			if (ret != NET_RX_SUCCESS)
+			skb = process_data(local_skb, dev, chan);
+			if (IS_ERR(skb)) {
+				kfree_skb(local_skb);
 				goto drop;
+			}
+
+			local_skb->protocol = htons(ETH_P_IPV6);
+			local_skb->pkt_type = PACKET_HOST;
+
+			if (give_skb_to_upper(local_skb, dev)
+							!= NET_RX_SUCCESS) {
+				kfree_skb(local_skb);
+				goto drop;
+			}
 
 			dev->stats.rx_bytes += skb->len;
 			dev->stats.rx_packets++;
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 6591d27..a0804df 100644
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
@@ -164,10 +165,13 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
 		}
 	rcu_read_unlock();
 
+	consume_skb(skb);
+
 	return stat;
 }
 
-static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+static struct sk_buff *
+process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 {
 	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
@@ -176,13 +180,13 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
 	/* at least two bytes will be used for the encoding */
 	if (skb->len < 2)
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
-		goto drop;
+		return ERR_PTR(-EINVAL);
 
 	ieee802154_addr_to_sa(&sa, &hdr->source);
 	ieee802154_addr_to_sa(&da, &hdr->dest);
@@ -199,12 +203,7 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 
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
@@ -478,36 +477,38 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 
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
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = process_data(skb, &hdr);
-			if (ret == NET_RX_DROP)
-				goto drop;
+			skb = process_data(skb, &hdr);
+			if (IS_ERR(skb))
+				goto drop_skb;
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
-					goto drop;
+				skb = process_data(skb, &hdr);
+				if (IS_ERR(skb))
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
-				ret = process_data(skb, &hdr);
-				if (ret == NET_RX_DROP)
-					goto drop;
+				skb = process_data(skb, &hdr);
+				if (IS_ERR(skb))
+					goto drop_skb;
+			} else if (ret < 0) {
+				goto drop;
+			} else {
+				return NET_RX_SUCCESS;
 			}
 			break;
 		default:
@@ -515,7 +516,11 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
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

