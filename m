Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DB6FAF.2090707@xsilon.com>
Date: Fri, 01 Aug 2014 11:45:03 +0100
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
Subject: [Linux-zigbee-devel] [PATCH v2 bluetooth-next] 6lowpan: Remove
 ununsed dev parameter from skb_delivery_cb callback.
To: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>

This parameter is never used by any function implementing this callback.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 include/net/6lowpan.h         | 2 +-
 net/6lowpan/iphc.c            | 2 +-
 net/bluetooth/6lowpan.c       | 4 ++--
 net/ieee802154/6lowpan_rtnl.c | 5 ++---
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index d184df1..d7e9169 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -372,7 +372,7 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
-typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
+typedef int (*skb_delivery_cb)(struct sk_buff *skb);
 
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 350ecfa..92eed6d 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -195,7 +195,7 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
 	raw_dump_table(__func__, "raw skb data dump before receiving",
 		       new->data, new->len);
 
-	stat = deliver_skb(new, dev);
+	stat = deliver_skb(new);
 
 	kfree_skb(new);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5a7f81d..f5df93f 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -197,7 +197,7 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 	return dev;
 }
 
-static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
+static int give_skb_to_upper(struct sk_buff *skb)
 {
 	struct sk_buff *skb_cp;
 	int ret;
@@ -283,7 +283,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 		skb_reset_network_header(local_skb);
 		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
 
-		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
+		if (give_skb_to_upper(local_skb) != NET_RX_SUCCESS) {
 			kfree_skb(local_skb);
 			goto drop;
 		}
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index fe6bd7a..3154775 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -143,8 +143,7 @@ static int lowpan_header_create(struct sk_buff *skb,
 			type, (void *)&da, (void *)&sa, 0);
 }
 
-static int lowpan_give_skb_to_devices(struct sk_buff *skb,
-					struct net_device *dev)
+static int lowpan_give_skb_to_devices(struct sk_buff *skb)
 {
 	struct lowpan_dev_record *entry;
 	struct sk_buff *skb_cp;
@@ -480,7 +479,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
 
-		ret = lowpan_give_skb_to_devices(skb, NULL);
+		ret = lowpan_give_skb_to_devices(skb);
 		if (ret == NET_RX_DROP)
 			goto drop;
 	} else {
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
