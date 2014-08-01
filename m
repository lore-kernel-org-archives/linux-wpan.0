Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DBB278.7090106@xsilon.com>
Date: Fri, 01 Aug 2014 16:30:00 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: [Linux-zigbee-devel] [PATCH bluetooth-next] Simplify lowpan receive
 path so skb is freed in lowpan_rcv when dropped.
To: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-wpan.vger.kernel.org>

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         |  2 +-
 net/6lowpan/iphc.c            | 22 +++++++++++++---------
 net/bluetooth/6lowpan.c       | 12 ++++++++----
 net/ieee802154/6lowpan_rtnl.c | 12 ++++++------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index d7e9169..aa0381e 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -374,7 +374,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 
 typedef int (*skb_delivery_cb)(struct sk_buff *skb);
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
 		u8 iphc0, u8 iphc1, skb_delivery_cb skb_deliver);
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 92eed6d..ba47c01 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -179,11 +179,11 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 
 	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
 			      GFP_ATOMIC);
-	kfree_skb(skb);
-
 	if (!new)
 		return -ENOMEM;
 
+	kfree_skb(skb);
+
 	skb_push(new, sizeof(struct ipv6hdr));
 	skb_reset_network_header(new);
 	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
@@ -196,6 +196,8 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 		       new->data, new->len);
 
 	stat = deliver_skb(new);
+	if (stat < 0)
+		stat = NET_RX_DROP;
 
 	kfree_skb(new);
 
@@ -333,7 +335,7 @@ err:
 /* TTL uncompression values */
 static const u8 lowpan_ttl_values[] = { 0, 1, 64, 255 };
 
-int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
+int lowpan_process_data(struct sk_buff **skb_inout, struct net_device *dev,
 			const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 			const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
 			u8 iphc0, u8 iphc1, skb_delivery_cb deliver_skb)
@@ -341,6 +343,8 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	struct ipv6hdr hdr = {};
 	u8 tmp, num_context = 0;
 	int err;
+	int err_ret = -EINVAL;
+	struct sk_buff *skb = *skb_inout;
 
 	raw_dump_table(__func__, "raw skb data dump uncompressed",
 		       skb->data, skb->len);
@@ -471,11 +475,12 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		 */
 		new = skb_copy_expand(skb, sizeof(struct udphdr),
 				      skb_tailroom(skb), GFP_ATOMIC);
+		if (!new) {
+			err_ret = -ENOMEM;
+			goto drop;
+		}
+		
 		kfree_skb(skb);
-
-		if (!new)
-			return -ENOMEM;
-
 		skb = new;
 
 		skb_push(skb, sizeof(struct udphdr));
@@ -503,8 +508,7 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 	return skb_deliver(skb, &hdr, dev, deliver_skb);
 
 drop:
-	kfree_skb(skb);
-	return -EINVAL;
+	return err_ret;
 }
 EXPORT_SYMBOL_GPL(lowpan_process_data);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index f5df93f..38a2987 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -215,7 +215,7 @@ static int give_skb_to_upper(struct sk_buff *skb)
 	return ret;
 }
 
-static int process_data(struct sk_buff *skb, struct net_device *netdev,
+static int process_data(struct sk_buff **skb_inout, struct net_device *netdev,
 			struct l2cap_chan *chan)
 {
 	const u8 *saddr, *daddr;
@@ -223,6 +223,7 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	struct lowpan_dev *dev;
 	struct lowpan_peer *peer;
 	unsigned long flags;
+	struct sk_buff *skb = *skb_inout;
 
 	dev = lowpan_dev(netdev);
 
@@ -245,13 +246,12 @@ static int process_data(struct sk_buff *skb, struct net_device *netdev,
 	if (lowpan_fetch_skb_u8(skb, &iphc1))
 		goto drop;
 
-	return lowpan_process_data(skb, netdev,
+	return lowpan_process_data(skb_inout, netdev,
 				   saddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   daddr, IEEE802154_ADDR_LONG, EUI64_ADDR_LEN,
 				   iphc0, iphc1, give_skb_to_upper);
 
 drop:
-	kfree_skb(skb);
 	return -EINVAL;
 }
 
@@ -300,7 +300,11 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 			if (!local_skb)
 				goto drop;
 
-			ret = process_data(local_skb, dev, chan);
+			ret = process_data(&local_skb, dev, chan);
+			if (ret < 0) {
+				kfree_skb(local_skb);
+				goto drop;
+			}
 			if (ret != NET_RX_SUCCESS)
 				goto drop;
 
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 3154775..3ae7646 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -166,11 +166,12 @@ static int lowpan_give_skb_to_devices(struct sk_buff *skb)
 	return stat;
 }
 
-static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+static int process_data(struct sk_buff **skb_inout, const struct ieee802154_hdr *hdr)
 {
 	u8 iphc0, iphc1;
 	struct ieee802154_addr_sa sa, da;
 	void *sap, *dap;
+	struct sk_buff *skb = *skb_inout;
 
 	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
 	/* at least two bytes will be used for the encoding */
@@ -196,13 +197,12 @@ static int process_data(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 	else
 		dap = &da.hwaddr;
 
-	return lowpan_process_data(skb, skb->dev, sap, sa.addr_type,
+	return lowpan_process_data(skb_inout, skb->dev, sap, sa.addr_type,
 				   IEEE802154_ADDR_LEN, dap, da.addr_type,
 				   IEEE802154_ADDR_LEN, iphc0, iphc1,
 				   lowpan_give_skb_to_devices);
 
 drop:
-	kfree_skb(skb);
 	return -EINVAL;
 }
 
@@ -485,14 +485,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = process_data(skb, &hdr);
+			ret = process_data(&skb, &hdr);
 			if (ret == NET_RX_DROP)
 				goto drop;
 			break;
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
+				ret = process_data(&skb, &hdr);
 				if (ret == NET_RX_DROP)
 					goto drop;
 			}
@@ -500,7 +500,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
 			if (ret == 1) {
-				ret = process_data(skb, &hdr);
+				ret = process_data(&skb, &hdr);
 				if (ret == NET_RX_DROP)
 					goto drop;
 			}
-- 
1.9.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel
