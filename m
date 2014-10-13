Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:43854 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaJMKBG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 06:01:06 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC decompression.
Date: Mon, 13 Oct 2014 11:00:56 +0100
Message-Id: <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
In-Reply-To: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, alex.aring@gmail.com, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

Currently there are potentially 2 skb_copy_expand calls in IPHC
decompression.  This patch replaces this with one call to
skb_cow which will check to see if there is enough headroom
first to ensure it's only done if necessary and will handle
alignment issues for cache.
As skb_cow uses pskb_expand_head we ensure the skb isn't shared from
bluetooth and ieee802.15.4 code that use the IPHC decompression.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 net/6lowpan/iphc.c      | 47 +++++++++++++++++++++--------------------------
 net/bluetooth/6lowpan.c |  4 ++++
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 142eef5..747b3cc 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -174,30 +174,22 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
 static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 		       struct net_device *dev, skb_delivery_cb deliver_skb)
 {
-	struct sk_buff *new;
 	int stat;
 
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
+	skb_push(skb, sizeof(struct ipv6hdr));
+	skb_reset_network_header(skb);
+	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
 
-	new->protocol = htons(ETH_P_IPV6);
-	new->pkt_type = PACKET_HOST;
-	new->dev = dev;
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+	skb->dev = dev;
 
 	raw_dump_table(__func__, "raw skb data dump before receiving",
-		       new->data, new->len);
+		       skb->data, skb->len);
 
-	stat = deliver_skb(new, dev);
+	stat = deliver_skb(skb, dev);
 
-	kfree_skb(new);
+	consume_skb(skb);
 
 	return stat;
 }
@@ -460,7 +452,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	/* UDP data uncompression */
 	if (iphc0 & LOWPAN_IPHC_NH_C) {
 		struct udphdr uh;
-		struct sk_buff *new;
+		const int needed = sizeof(struct udphdr) + sizeof(hdr);
 
 		if (uncompress_udp_header(skb, &uh))
 			goto drop;
@@ -468,14 +460,11 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		/* replace the compressed UDP head by the uncompressed UDP
 		 * header
 		 */
-		new = skb_copy_expand(skb, sizeof(struct udphdr),
-				      skb_tailroom(skb), GFP_ATOMIC);
-		kfree_skb(skb);
-
-		if (!new)
-			return -ENOMEM;
-
-		skb = new;
+		err = skb_cow(skb, needed);
+		if (unlikely(err)) {
+			kfree_skb(skb);
+			return err;
+		}
 
 		skb_push(skb, sizeof(struct udphdr));
 		skb_reset_transport_header(skb);
@@ -485,6 +474,12 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 			       (u8 *)&uh, sizeof(uh));
 
 		hdr.nexthdr = UIP_PROTO_UDP;
+	} else {
+		err = skb_cow(skb, sizeof(hdr));
+		if (unlikely(err)) {
+			kfree_skb(skb);
+			return err;
+		}
 	}
 
 	hdr.payload_len = htons(skb->len);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index c2e0d14..4ebc806 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -316,6 +316,10 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 	if (dev->type != ARPHRD_6LOWPAN)
 		goto drop;
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto drop;
+
 	/* check that it's our buffer */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
 		/* Copy the packet so that the IPv6 header is
-- 
1.9.1

