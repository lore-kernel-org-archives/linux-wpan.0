Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34969 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbaLWKax (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 05:30:53 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so10404348wiw.8
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 02:30:52 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154: 6lowpan: move receive functionality
Date: Tue, 23 Dec 2014 11:30:09 +0100
Message-Id: <1419330611-29410-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
References: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves all relevant receive functionality into a separate rx.c
file. We can simple separate this functionality like we did it in mac802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/6lowpan_i.h    |  25 +++++
 net/ieee802154/6lowpan/6lowpan_rtnl.c | 169 +--------------------------------
 net/ieee802154/6lowpan/Makefile       |   2 +-
 net/ieee802154/6lowpan/rx.c           | 171 ++++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+), 167 deletions(-)
 create mode 100644 net/ieee802154/6lowpan/rx.c

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index edbe803..29ec61b 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -1,6 +1,8 @@
 #ifndef __IEEE802154_6LOWPAN_I_H__
 #define __IEEE802154_6LOWPAN_I_H__
 
+#include <linux/list.h>
+
 #include <net/inet_frag.h>
 
 struct lowpan_create_arg {
@@ -34,8 +36,31 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
 	}
 }
 
+struct lowpan_dev_record {
+	struct net_device *ldev;
+	struct list_head list;
+};
+
+/* private device info */
+struct lowpan_dev_info {
+	struct net_device	*real_dev; /* real WPAN device ptr */
+	struct mutex		dev_list_mtx; /* mutex for list ops */
+	u16			fragment_tag;
+};
+
+static inline struct
+lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
+
+extern struct list_head lowpan_devices;
+
 int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
 void lowpan_net_frag_exit(void);
 int lowpan_net_frag_init(void);
 
+void lowpan_rx_init(void);
+void lowpan_rx_exit(void);
+
 #endif /* __IEEE802154_6LOWPAN_I_H__ */
diff --git a/net/ieee802154/6lowpan/6lowpan_rtnl.c b/net/ieee802154/6lowpan/6lowpan_rtnl.c
index 1918c43..9dce20e 100644
--- a/net/ieee802154/6lowpan/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan/6lowpan_rtnl.c
@@ -57,21 +57,9 @@
 
 #include "6lowpan_i.h"
 
-static LIST_HEAD(lowpan_devices);
+LIST_HEAD(lowpan_devices);
 static int lowpan_open_count;
 
-/* private device info */
-struct lowpan_dev_info {
-	struct net_device	*real_dev; /* real WPAN device ptr */
-	struct mutex		dev_list_mtx; /* mutex for list ops */
-	u16			fragment_tag;
-};
-
-struct lowpan_dev_record {
-	struct net_device *ldev;
-	struct list_head list;
-};
-
 /* don't save pan id, it's intra pan */
 struct lowpan_addr {
 	u8 mode;
@@ -88,12 +76,6 @@ struct lowpan_addr_info {
 };
 
 static inline struct
-lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
-{
-	return netdev_priv(dev);
-}
-
-static inline struct
 lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
 {
 	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
@@ -134,74 +116,6 @@ static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 }
 
-static int lowpan_give_skb_to_devices(struct sk_buff *skb,
-				      struct net_device *dev)
-{
-	struct lowpan_dev_record *entry;
-	struct sk_buff *skb_cp;
-	int stat = NET_RX_SUCCESS;
-
-	skb->protocol = htons(ETH_P_IPV6);
-	skb->pkt_type = PACKET_HOST;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &lowpan_devices, list)
-		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
-			skb_cp = skb_copy(skb, GFP_ATOMIC);
-			if (!skb_cp) {
-				kfree_skb(skb);
-				rcu_read_unlock();
-				return NET_RX_DROP;
-			}
-
-			skb_cp->dev = entry->ldev;
-			stat = netif_rx(skb_cp);
-			if (stat == NET_RX_DROP)
-				break;
-		}
-	rcu_read_unlock();
-
-	consume_skb(skb);
-
-	return stat;
-}
-
-static int
-iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
-{
-	u8 iphc0, iphc1;
-	struct ieee802154_addr_sa sa, da;
-	void *sap, *dap;
-
-	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
-	/* at least two bytes will be used for the encoding */
-	if (skb->len < 2)
-		return -EINVAL;
-
-	if (lowpan_fetch_skb_u8(skb, &iphc0))
-		return -EINVAL;
-
-	if (lowpan_fetch_skb_u8(skb, &iphc1))
-		return -EINVAL;
-
-	ieee802154_addr_to_sa(&sa, &hdr->source);
-	ieee802154_addr_to_sa(&da, &hdr->dest);
-
-	if (sa.addr_type == IEEE802154_ADDR_SHORT)
-		sap = &sa.short_addr;
-	else
-		sap = &sa.hwaddr;
-
-	if (da.addr_type == IEEE802154_ADDR_SHORT)
-		dap = &da.short_addr;
-	else
-		dap = &da.hwaddr;
-
-	return lowpan_header_decompress(skb, skb->dev, sap, sa.addr_type,
-					IEEE802154_ADDR_LEN, dap, da.addr_type,
-					IEEE802154_ADDR_LEN, iphc0, iphc1);
-}
-
 static struct sk_buff*
 lowpan_alloc_frag(struct sk_buff *skb, int size,
 		  const struct ieee802154_hdr *master_hdr)
@@ -485,83 +399,6 @@ static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
 	return 0;
 }
 
-static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
-		      struct packet_type *pt, struct net_device *orig_dev)
-{
-	struct ieee802154_hdr hdr;
-	int ret;
-
-	skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!skb)
-		goto drop;
-
-	if (!netif_running(dev))
-		goto drop_skb;
-
-	if (skb->pkt_type == PACKET_OTHERHOST)
-		goto drop_skb;
-
-	if (dev->type != ARPHRD_IEEE802154)
-		goto drop_skb;
-
-	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
-		goto drop_skb;
-
-	/* check that it's our buffer */
-	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
-		/* Pull off the 1-byte of 6lowpan header. */
-		skb_pull(skb, 1);
-		return lowpan_give_skb_to_devices(skb, NULL);
-	} else {
-		switch (skb->data[0] & 0xe0) {
-		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
-			ret = iphc_decompress(skb, &hdr);
-			if (ret < 0)
-				goto drop_skb;
-
-			return lowpan_give_skb_to_devices(skb, NULL);
-		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
-			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
-				return lowpan_give_skb_to_devices(skb, NULL);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
-			}
-		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
-			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
-			if (ret == 1) {
-				ret = iphc_decompress(skb, &hdr);
-				if (ret < 0)
-					goto drop_skb;
-
-				return lowpan_give_skb_to_devices(skb, NULL);
-			} else if (ret == -1) {
-				return NET_RX_DROP;
-			} else {
-				return NET_RX_SUCCESS;
-			}
-		default:
-			break;
-		}
-	}
-
-drop_skb:
-	kfree_skb(skb);
-drop:
-	return NET_RX_DROP;
-}
-
-static struct packet_type lowpan_packet_type = {
-	.type = htons(ETH_P_IEEE802154),
-	.func = lowpan_rcv,
-};
-
 static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[])
 {
@@ -607,7 +444,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	ret = register_netdevice(dev);
 	if (ret >= 0) {
 		if (!lowpan_open_count)
-			dev_add_pack(&lowpan_packet_type);
+			lowpan_rx_init();
 		lowpan_open_count++;
 	}
 
@@ -624,7 +461,7 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
 
 	lowpan_open_count--;
 	if (!lowpan_open_count)
-		dev_remove_pack(&lowpan_packet_type);
+		lowpan_rx_exit();
 
 	mutex_lock(&lowpan_dev_info(dev)->dev_list_mtx);
 	list_for_each_entry_safe(entry, tmp, &lowpan_devices, list) {
diff --git a/net/ieee802154/6lowpan/Makefile b/net/ieee802154/6lowpan/Makefile
index 936959b..8e83971 100644
--- a/net/ieee802154/6lowpan/Makefile
+++ b/net/ieee802154/6lowpan/Makefile
@@ -1,3 +1,3 @@
 obj-y += ieee802154_6lowpan.o
 
-ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
+ieee802154_6lowpan-y := 6lowpan_rtnl.o rx.o reassembly.o
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
new file mode 100644
index 0000000..4be1d28
--- /dev/null
+++ b/net/ieee802154/6lowpan/rx.c
@@ -0,0 +1,171 @@
+/* This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/if_arp.h>
+
+#include <net/6lowpan.h>
+#include <net/ieee802154_netdev.h>
+
+#include "6lowpan_i.h"
+
+static int lowpan_give_skb_to_devices(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	struct lowpan_dev_record *entry;
+	struct sk_buff *skb_cp;
+	int stat = NET_RX_SUCCESS;
+
+	skb->protocol = htons(ETH_P_IPV6);
+	skb->pkt_type = PACKET_HOST;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &lowpan_devices, list)
+		if (lowpan_dev_info(entry->ldev)->real_dev == skb->dev) {
+			skb_cp = skb_copy(skb, GFP_ATOMIC);
+			if (!skb_cp) {
+				kfree_skb(skb);
+				rcu_read_unlock();
+				return NET_RX_DROP;
+			}
+
+			skb_cp->dev = entry->ldev;
+			stat = netif_rx(skb_cp);
+			if (stat == NET_RX_DROP)
+				break;
+		}
+	rcu_read_unlock();
+
+	consume_skb(skb);
+
+	return stat;
+}
+
+static int
+iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
+{
+	u8 iphc0, iphc1;
+	struct ieee802154_addr_sa sa, da;
+	void *sap, *dap;
+
+	raw_dump_table(__func__, "raw skb data dump", skb->data, skb->len);
+	/* at least two bytes will be used for the encoding */
+	if (skb->len < 2)
+		return -EINVAL;
+
+	if (lowpan_fetch_skb_u8(skb, &iphc0))
+		return -EINVAL;
+
+	if (lowpan_fetch_skb_u8(skb, &iphc1))
+		return -EINVAL;
+
+	ieee802154_addr_to_sa(&sa, &hdr->source);
+	ieee802154_addr_to_sa(&da, &hdr->dest);
+
+	if (sa.addr_type == IEEE802154_ADDR_SHORT)
+		sap = &sa.short_addr;
+	else
+		sap = &sa.hwaddr;
+
+	if (da.addr_type == IEEE802154_ADDR_SHORT)
+		dap = &da.short_addr;
+	else
+		dap = &da.hwaddr;
+
+	return lowpan_header_decompress(skb, skb->dev, sap, sa.addr_type,
+					IEEE802154_ADDR_LEN, dap, da.addr_type,
+					IEEE802154_ADDR_LEN, iphc0, iphc1);
+}
+
+static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
+		      struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct ieee802154_hdr hdr;
+	int ret;
+
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		goto drop;
+
+	if (!netif_running(dev))
+		goto drop_skb;
+
+	if (skb->pkt_type == PACKET_OTHERHOST)
+		goto drop_skb;
+
+	if (dev->type != ARPHRD_IEEE802154)
+		goto drop_skb;
+
+	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
+		goto drop_skb;
+
+	/* check that it's our buffer */
+	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
+		/* Pull off the 1-byte of 6lowpan header. */
+		skb_pull(skb, 1);
+		return lowpan_give_skb_to_devices(skb, NULL);
+	} else {
+		switch (skb->data[0] & 0xe0) {
+		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
+			ret = iphc_decompress(skb, &hdr);
+			if (ret < 0)
+				goto drop_skb;
+
+			return lowpan_give_skb_to_devices(skb, NULL);
+		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
+			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
+			if (ret == 1) {
+				ret = iphc_decompress(skb, &hdr);
+				if (ret < 0)
+					goto drop_skb;
+
+				return lowpan_give_skb_to_devices(skb, NULL);
+			} else if (ret == -1) {
+				return NET_RX_DROP;
+			} else {
+				return NET_RX_SUCCESS;
+			}
+		case LOWPAN_DISPATCH_FRAGN:	/* next fragments headers */
+			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
+			if (ret == 1) {
+				ret = iphc_decompress(skb, &hdr);
+				if (ret < 0)
+					goto drop_skb;
+
+				return lowpan_give_skb_to_devices(skb, NULL);
+			} else if (ret == -1) {
+				return NET_RX_DROP;
+			} else {
+				return NET_RX_SUCCESS;
+			}
+		default:
+			break;
+		}
+	}
+
+drop_skb:
+	kfree_skb(skb);
+drop:
+	return NET_RX_DROP;
+}
+
+static struct packet_type lowpan_packet_type = {
+	.type = htons(ETH_P_IEEE802154),
+	.func = lowpan_rcv,
+};
+
+void lowpan_rx_init(void)
+{
+	dev_add_pack(&lowpan_packet_type);
+}
+
+void lowpan_rx_exit(void)
+{
+	dev_remove_pack(&lowpan_packet_type);
+}
-- 
2.2.0

