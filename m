Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33873 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaJRHJa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 18 Oct 2014 03:09:30 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth-next 1/5] Remove skb_deliver from IPHC.
Date: Sat, 18 Oct 2014 08:09:09 +0100
Message-Id: <1413616153-7562-2-git-send-email-mtownsend1973@gmail.com>
In-Reply-To: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <mtownsend1973@gmail.com>

Separating skb delivery from decompression ensures that we can support further
decompression schemes and removes the mixed return value of error codes with
NET_RX_FOO.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 include/net/6lowpan.h         |  2 +-
 net/6lowpan/iphc.c            | 32 ++++++--------------------------
 net/bluetooth/6lowpan.c       | 12 +++++++++++-
 net/ieee802154/6lowpan_rtnl.c | 15 +++++----------
 4 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index d184df1..99aa7e3 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -377,7 +377,7 @@ typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
+		u8 iphc0, u8 iphc1);
 int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 			unsigned short type, const void *_daddr,
 			const void *_saddr, unsigned int len);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 747b3cc..45714fe 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -171,29 +171,6 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
 	return 0;
 }
 
-static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
-		       struct net_device *dev, skb_delivery_cb deliver_skb)
-{
-	int stat;
-
-	skb_push(skb, sizeof(struct ipv6hdr));
-	skb_reset_network_header(skb);
-	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
-
-	skb->protocol = htons(ETH_P_IPV6);
-	skb->pkt_type = PACKET_HOST;
-	skb->dev = dev;
-
-	raw_dump_table(__func__, "raw skb data dump before receiving",
-		       skb->data, skb->len);
-
-	stat = deliver_skb(skb, dev);
-
-	consume_skb(skb);
-
-	return stat;
-}
-
 /* Uncompress function for multicast destination address,
  * when M bit is set.
  */
@@ -327,7 +304,7 @@ static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
+			u8 iphc0, u8 iphc1)
 {
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
@@ -492,10 +469,13 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		hdr.version, ntohs(hdr.payload_len), hdr.nexthdr,
 		hdr.hop_limit, &hdr.daddr);
 
-	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
+	skb_push(skb, sizeof(hdr));
+	skb_reset_network_header(skb);
+	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
 
-	return skb_deliver(skb, &hdr, dev, deliver_skb);
+	raw_dump_table(__func__, "raw header dump", (u8 *)&hdr, sizeof(hdr));
 
+	return 0;
 drop:
 	kfree_skb(skb);
 	return -EINVAL;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 6c5c2ef..03787e0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -290,7 +290,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	return lowpan_process_data(skb, netdev,
 				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
-				   iphc0, iphc1, give_skb_to_upper);
+				   iphc0, iphc1);
 
 drop:
 	kfree_skb(skb);
@@ -350,6 +350,16 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 			if (ret != NET_RX_SUCCESS)
 				goto drop;
 
+			local_skb->protocol = htons(ETH_P_IPV6);
+			local_skb->pkt_type = PACKET_HOST;
+			local_skb->dev = dev;
+
+			if (give_skb_to_upper(local_skb, dev)
+					!= NET_RX_SUCCESS) {
+				kfree_skb(local_skb);
+				goto drop;
+			}
+
 			dev->stats.rx_bytes += skb->len;
 			dev->stats.rx_packets++;
 
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 0c1a49b..82ef0df 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -190,8 +190,7 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 
 	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
 				   IEEE802154_ADDR_LEN, dap, da.addr_type,
-				   IEEE802154_ADDR_LEN, iphc0, iphc1,
-				   lowpan_give_skb_to_devices);
+				   IEEE802154_ADDR_LEN, iphc0, iphc1);
 
 drop:
 	kfree_skb(skb);
@@ -528,15 +527,8 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	/* check that it's our buffer */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
-		skb->protocol = htons(ETH_P_IPV6);
-		skb->pkt_type = PACKET_HOST;
-
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
-
-		ret = lowpan_give_skb_to_devices(skb, NULL);
-		if (ret == NET_RX_DROP)
-			goto drop;
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
@@ -565,7 +557,10 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	return NET_RX_SUCCESS;
+	/* Pass IPv6 packet up to the next layer */
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+	return lowpan_give_skb_to_devices(skb, NULL);
 drop_skb:
 	kfree_skb(skb);
 drop:
-- 
1.9.1

