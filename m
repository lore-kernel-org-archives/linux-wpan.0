Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50397 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaIJOGp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Sep 2014 10:06:45 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH][linux-bluetooth 2/3] 6lowpan: Move skb delivery from IPHC.
Date: Wed, 10 Sep 2014 15:06:07 +0100
Message-Id: <1410357968-27051-4-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, Martin Townsend <martin.townsend@xsilon.com>

Passing the skb from 6lowpan up to the higher layers is not a
function of IPHC.  By moving it out of IPHC we also remove the
need to support error code returns with NET_RX codes.
It also makes the lowpan_rcv function more extendable as we
can support more compression schemes.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         |  5 ++--
 net/6lowpan/iphc.c            | 63 +++++++++++++++++--------------------------
 net/bluetooth/6lowpan.c       | 16 ++++++-----
 net/ieee802154/6lowpan_rtnl.c | 43 +++++++++++++++++------------
 4 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 883e7a2..d71c062 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -374,10 +374,11 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 
 typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
 
-int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
+int lowpan_iphc_header_uncompress(
+		struct sk_buff **skb_inout, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
+		u8 iphc0, u8 iphc1);
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			unsigned short type, const void *_daddr,
 			const void *_saddr, unsigned int len);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index eca24bf..33985b9 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -171,39 +171,6 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
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
-	if (!new)
-		return -ENOMEM;
-
-	kfree_skb(skb);
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
-	if (stat < 0)
-		stat = NET_RX_DROP;
-
-	kfree_skb(new);
-
-	return stat;
-}
-
 /* Uncompress function for multicast destination address,
  * when M bit is set.
  */
@@ -334,10 +301,11 @@ err:
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
-			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
-			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
+int lowpan_iphc_header_uncompress(struct sk_buff **skb_inout,
+				  struct net_device *dev, const u8 *saddr,
+				  const u8 saddr_type, const u8 saddr_len,
+				  const u8 *daddr, const u8 daddr_type,
+				  const u8 daddr_len, u8 iphc0, u8 iphc1)
 {
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
@@ -503,12 +471,29 @@ int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
 
 	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
 
-	return skb_deliver(skb, &hdr, dev, deliver_skb);
+	/* Setup skb with new uncompressed IPv6 header. */
+	skb = skb_copy_expand(skb, sizeof(hdr), skb_tailroom(skb),
+			      GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	kfree_skb(*skb_inout);
+	*skb_inout = skb;
+
+	skb_push(skb, sizeof(hdr));
+	skb_reset_network_header(skb);
+	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
+	skb->dev = dev;
+
+	raw_dump_table(__func__, "raw skb data dump before receiving",
+		       skb->data, skb->len);
+
+	return 0;
 
 drop:
 	return err_ret;
 }
-EXPORT_SYMBOL_GPL(lowpan_process_data);
+EXPORT_SYMBOL_GPL(lowpan_iphc_header_uncompress);
 
 static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
 				  const struct in6_addr *ipaddr,
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f5f7ee0..6a76d44 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -246,10 +246,10 @@ static int process_data(struct sk_buff **skb_inout, struct net_device *netdev,
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
 		goto drop;
 
-	return lowpan_process_data(skb_inout, netdev,
+	return lowpan_iphc_header_uncompress(skb_inout, netdev,
 				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
-				   iphc0, iphc1, give_skb_to_upper);
+				   iphc0, iphc1);
 
 drop:
 	return -EINVAL;
@@ -280,9 +280,6 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		local_skb->protocol = htons(ETH_P_IPV6);
 		local_skb->pkt_type = PACKET_HOST;
 
-		skb_reset_network_header(local_skb);
-		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
-
 		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
 			kfree_skb(local_skb);
 			goto drop;
@@ -305,8 +302,15 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 				kfree_skb(local_skb);
 				goto drop;
 			}
-			if (ret != NET_RX_SUCCESS)
+
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
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index fdb6c10..4f4b02d 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -167,7 +167,8 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb,
 	return stat;
 }
 
-static int process_data(struct sk_buff **skb_inout, const struct ieee802154_hdr *hdr)
+static int iphc_uncompress_hdr(struct sk_buff **skb_inout,
+			       const struct ieee802154_hdr *hdr)
 {
 	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
@@ -198,10 +199,10 @@ static int process_data(struct sk_buff **skb_inout, const struct ieee802154_hdr
 	else
 		dap = &da.hwaddr;
 
-	return lowpan_process_data(skb_inout, skb->dev, sap, sa.addr_type,
+	return lowpan_iphc_header_uncompress(skb_inout, skb->dev,
+				   sap, sa.addr_type,
 				   IEEE802154_ADDR_LEN, dap, da.addr_type,
-				   IEEE802154_ADDR_LEN, iphc0, iphc1,
-				   lowpan_give_skb_to_devices);
+				   IEEE802154_ADDR_LEN, iphc0, iphc1);
 
 drop:
 	return -EINVAL;
@@ -478,36 +479,35 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 
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
+		ret = NET_RX_SUCCESS;
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = process_data(&skb, &hdr);
-			if (ret == NET_RX_DROP)
+			ret = iphc_uncompress_hdr(&skb, &hdr);
+			if (ret < 0)
 				goto drop;
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
-				ret = process_data(&skb, &hdr);
-				if (ret == NET_RX_DROP)
+				ret = iphc_uncompress_hdr(&skb, &hdr);
+				if (ret < 0)
 					goto drop;
+			} else {
+				return NET_RX_SUCCESS;
 			}
 			break;
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
-				ret = process_data(&skb, &hdr);
-				if (ret == NET_RX_DROP)
+				ret = iphc_uncompress_hdr(&skb, &hdr);
+				if (ret < 0)
 					goto drop;
+			} else {
+				return NET_RX_SUCCESS;
 			}
 			break;
 		default:
@@ -515,7 +515,16 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	return NET_RX_SUCCESS;
+	/* Pass IPv6 packet up to next layer */
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+	ret = lowpan_give_skb_to_devices(skb, NULL);
+	if (ret < 0)
+		goto drop_skb;
+
+	kfree_skb(skb);
+	return ret;
+
 drop_skb:
 	kfree_skb(skb);
 drop:
-- 
1.9.1

