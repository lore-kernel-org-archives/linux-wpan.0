Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37313 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbIBMWE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:04 -0400
Received: by wicfx3 with SMTP id fx3so17115227wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/16] ieee802154: 6lowpan: change dev vars to wdev and ldev
Date: Wed,  2 Sep 2015 14:21:16 +0200
Message-Id: <1441196491-25013-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Inside the IEEE 802.15.4 6LoWPAN subsystem we use two interfaces which
are wpan and lowpan interfaces. Instead of using always the variable
name "dev" for both we rename the "dev" variable to wdev which means the
wpan net_device and ldev which means a lowpan net_device. This avoids
confusing and always looking back to see which net_device is meant by
the variable name "dev".

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/6lowpan_i.h  |  2 +-
 net/ieee802154/6lowpan/core.c       | 89 ++++++++++++++++++-------------------
 net/ieee802154/6lowpan/reassembly.c | 14 +++---
 net/ieee802154/6lowpan/rx.c         | 22 ++++-----
 net/ieee802154/6lowpan/tx.c         | 39 ++++++++--------
 5 files changed, 82 insertions(+), 84 deletions(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index ea339fa..9aa7b62 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -40,7 +40,7 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
 
 /* private device info */
 struct lowpan_dev_info {
-	struct net_device	*real_dev; /* real WPAN device ptr */
+	struct net_device	*wdev; /* wpan device ptr */
 	u16			fragment_tag;
 };
 
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 953b1c4..b0f0460 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -61,7 +61,7 @@ static struct header_ops lowpan_header_ops = {
 static struct lock_class_key lowpan_tx_busylock;
 static struct lock_class_key lowpan_netdev_xmit_lock_key;
 
-static void lowpan_set_lockdep_class_one(struct net_device *dev,
+static void lowpan_set_lockdep_class_one(struct net_device *ldev,
 					 struct netdev_queue *txq,
 					 void *_unused)
 {
@@ -69,10 +69,10 @@ static void lowpan_set_lockdep_class_one(struct net_device *dev,
 			  &lowpan_netdev_xmit_lock_key);
 }
 
-static int lowpan_dev_init(struct net_device *dev)
+static int lowpan_dev_init(struct net_device *ldev)
 {
-	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-	dev->qdisc_tx_busylock = &lowpan_tx_busylock;
+	netdev_for_each_tx_queue(ldev, lowpan_set_lockdep_class_one, NULL);
+	ldev->qdisc_tx_busylock = &lowpan_tx_busylock;
 	return 0;
 }
 
@@ -81,23 +81,23 @@ static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_start_xmit		= lowpan_xmit,
 };
 
-static void lowpan_setup(struct net_device *dev)
+static void lowpan_setup(struct net_device *ldev)
 {
-	dev->addr_len		= IEEE802154_ADDR_LEN;
-	memset(dev->broadcast, 0xff, IEEE802154_ADDR_LEN);
-	dev->type		= ARPHRD_6LOWPAN;
+	ldev->addr_len		= IEEE802154_ADDR_LEN;
+	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
+	ldev->type		= ARPHRD_6LOWPAN;
 	/* Frame Control + Sequence Number + Address fields + Security Header */
-	dev->hard_header_len	= 2 + 1 + 20 + 14;
-	dev->needed_tailroom	= 2; /* FCS */
-	dev->mtu		= IPV6_MIN_MTU;
-	dev->priv_flags		|= IFF_NO_QUEUE;
-	dev->flags		= IFF_BROADCAST | IFF_MULTICAST;
-	dev->watchdog_timeo	= 0;
-
-	dev->netdev_ops		= &lowpan_netdev_ops;
-	dev->header_ops		= &lowpan_header_ops;
-	dev->destructor		= free_netdev;
-	dev->features		|= NETIF_F_NETNS_LOCAL;
+	ldev->hard_header_len	= 2 + 1 + 20 + 14;
+	ldev->needed_tailroom	= 2; /* FCS */
+	ldev->mtu		= IPV6_MIN_MTU;
+	ldev->priv_flags	|= IFF_NO_QUEUE;
+	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
+	ldev->watchdog_timeo	= 0;
+
+	ldev->netdev_ops	= &lowpan_netdev_ops;
+	ldev->header_ops	= &lowpan_header_ops;
+	ldev->destructor	= free_netdev;
+	ldev->features		|= NETIF_F_NETNS_LOCAL;
 }
 
 static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
@@ -109,10 +109,10 @@ static int lowpan_validate(struct nlattr *tb[], struct nlattr *data[])
 	return 0;
 }
 
-static int lowpan_newlink(struct net *src_net, struct net_device *dev,
+static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 			  struct nlattr *tb[], struct nlattr *data[])
 {
-	struct net_device *real_dev;
+	struct net_device *wdev;
 	int ret;
 
 	ASSERT_RTNL();
@@ -120,35 +120,35 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	pr_debug("adding new link\n");
 
 	if (!tb[IFLA_LINK] ||
-	    !net_eq(dev_net(dev), &init_net))
+	    !net_eq(dev_net(ldev), &init_net))
 		return -EINVAL;
-	/* find and hold real wpan device */
-	real_dev = dev_get_by_index(dev_net(dev), nla_get_u32(tb[IFLA_LINK]));
-	if (!real_dev)
+	/* find and hold wpan device */
+	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	if (!wdev)
 		return -ENODEV;
-	if (real_dev->type != ARPHRD_IEEE802154) {
-		dev_put(real_dev);
+	if (wdev->type != ARPHRD_IEEE802154) {
+		dev_put(wdev);
 		return -EINVAL;
 	}
 
-	if (real_dev->ieee802154_ptr->lowpan_dev) {
-		dev_put(real_dev);
+	if (wdev->ieee802154_ptr->lowpan_dev) {
+		dev_put(wdev);
 		return -EBUSY;
 	}
 
-	lowpan_dev_info(dev)->real_dev = real_dev;
+	lowpan_dev_info(ldev)->wdev = wdev;
 	/* Set the lowpan hardware address to the wpan hardware address. */
-	memcpy(dev->dev_addr, real_dev->dev_addr, IEEE802154_ADDR_LEN);
+	memcpy(ldev->dev_addr, wdev->dev_addr, IEEE802154_ADDR_LEN);
 
-	lowpan_netdev_setup(dev, LOWPAN_LLTYPE_IEEE802154);
+	lowpan_netdev_setup(ldev, LOWPAN_LLTYPE_IEEE802154);
 
-	ret = register_netdevice(dev);
+	ret = register_netdevice(ldev);
 	if (ret < 0) {
-		dev_put(real_dev);
+		dev_put(wdev);
 		return ret;
 	}
 
-	real_dev->ieee802154_ptr->lowpan_dev = dev;
+	wdev->ieee802154_ptr->lowpan_dev = ldev;
 	if (!open_count)
 		lowpan_rx_init();
 
@@ -157,10 +157,9 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	return 0;
 }
 
-static void lowpan_dellink(struct net_device *dev, struct list_head *head)
+static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
 {
-	struct lowpan_dev_info *lowpan_dev = lowpan_dev_info(dev);
-	struct net_device *real_dev = lowpan_dev->real_dev;
+	struct net_device *wdev = lowpan_dev_info(ldev)->wdev;
 
 	ASSERT_RTNL();
 
@@ -169,9 +168,9 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
 	if (!open_count)
 		lowpan_rx_exit();
 
-	real_dev->ieee802154_ptr->lowpan_dev = NULL;
-	unregister_netdevice(dev);
-	dev_put(real_dev);
+	wdev->ieee802154_ptr->lowpan_dev = NULL;
+	unregister_netdevice(ldev);
+	dev_put(wdev);
 }
 
 static struct rtnl_link_ops lowpan_link_ops __read_mostly = {
@@ -196,9 +195,9 @@ static inline void lowpan_netlink_fini(void)
 static int lowpan_device_event(struct notifier_block *unused,
 			       unsigned long event, void *ptr)
 {
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct net_device *wdev = netdev_notifier_info_to_dev(ptr);
 
-	if (dev->type != ARPHRD_IEEE802154)
+	if (wdev->type != ARPHRD_IEEE802154)
 		goto out;
 
 	switch (event) {
@@ -207,8 +206,8 @@ static int lowpan_device_event(struct notifier_block *unused,
 		 * also delete possible lowpan interfaces which belongs
 		 * to the wpan interface.
 		 */
-		if (dev->ieee802154_ptr && dev->ieee802154_ptr->lowpan_dev)
-			lowpan_dellink(dev->ieee802154_ptr->lowpan_dev, NULL);
+		if (wdev->ieee802154_ptr && wdev->ieee802154_ptr->lowpan_dev)
+			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
 		break;
 	default:
 		break;
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 214d44a..60d6df7 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -46,7 +46,7 @@ static struct lowpan_frag_info *lowpan_cb(struct sk_buff *skb)
 static struct inet_frags lowpan_frags;
 
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
-			     struct sk_buff *prev, struct net_device *dev);
+			     struct sk_buff *prev, struct net_device *ldev);
 
 static unsigned int lowpan_hash_frag(u16 tag, u16 d_size,
 				     const struct ieee802154_addr *saddr,
@@ -141,7 +141,7 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 			     struct sk_buff *skb, const u8 frag_type)
 {
 	struct sk_buff *prev, *next;
-	struct net_device *dev;
+	struct net_device *ldev;
 	int end, offset;
 
 	if (fq->q.flags & INET_FRAG_COMPLETE)
@@ -195,8 +195,8 @@ found:
 	else
 		fq->q.fragments = skb;
 
-	dev = skb->dev;
-	if (dev)
+	ldev = skb->dev;
+	if (ldev)
 		skb->dev = NULL;
 
 	fq->q.stamp = skb->tstamp;
@@ -215,7 +215,7 @@ found:
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		res = lowpan_frag_reasm(fq, prev, dev);
+		res = lowpan_frag_reasm(fq, prev, ldev);
 		skb->_skb_refdst = orefdst;
 		return res;
 	}
@@ -235,7 +235,7 @@ err:
  *	the last and the first frames arrived and all the bits are here.
  */
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq, struct sk_buff *prev,
-			     struct net_device *dev)
+			     struct net_device *ldev)
 {
 	struct sk_buff *fp, *head = fq->q.fragments;
 	int sum_truesize;
@@ -313,7 +313,7 @@ static int lowpan_frag_reasm(struct lowpan_frag_queue *fq, struct sk_buff *prev,
 	sub_frag_mem_limit(fq->q.net, sum_truesize);
 
 	head->next = NULL;
-	head->dev = dev;
+	head->dev = ldev;
 	head->tstamp = fq->q.stamp;
 
 	fq->q.fragments = NULL;
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 12e1020..b1442f3 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -16,9 +16,9 @@
 #include "6lowpan_i.h"
 
 static int lowpan_give_skb_to_device(struct sk_buff *skb,
-				     struct net_device *dev)
+				     struct net_device *wdev)
 {
-	skb->dev = dev->ieee802154_ptr->lowpan_dev;
+	skb->dev = wdev->ieee802154_ptr->lowpan_dev;
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->pkt_type = PACKET_HOST;
 
@@ -61,21 +61,21 @@ iphc_decompress(struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 					IEEE802154_ADDR_LEN, iphc0, iphc1);
 }
 
-static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
-		      struct packet_type *pt, struct net_device *orig_dev)
+static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
+		      struct packet_type *pt, struct net_device *orig_wdev)
 {
 	struct ieee802154_hdr hdr;
 	int ret;
 
-	if (dev->type != ARPHRD_IEEE802154 ||
-	    !dev->ieee802154_ptr->lowpan_dev)
+	if (wdev->type != ARPHRD_IEEE802154 ||
+	    !wdev->ieee802154_ptr->lowpan_dev)
 		goto drop;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
 		goto drop;
 
-	if (!netif_running(dev))
+	if (!netif_running(wdev))
 		goto drop_skb;
 
 	if (skb->pkt_type == PACKET_OTHERHOST)
@@ -88,7 +88,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
 		/* Pull off the 1-byte of 6lowpan header. */
 		skb_pull(skb, 1);
-		return lowpan_give_skb_to_device(skb, dev);
+		return lowpan_give_skb_to_device(skb, wdev);
 	} else {
 		switch (skb->data[0] & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
@@ -96,7 +96,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 			if (ret < 0)
 				goto drop_skb;
 
-			return lowpan_give_skb_to_device(skb, dev);
+			return lowpan_give_skb_to_device(skb, wdev);
 		case LOWPAN_DISPATCH_FRAG1:	/* first fragment header */
 			ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
 			if (ret == 1) {
@@ -104,7 +104,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 				if (ret < 0)
 					goto drop_skb;
 
-				return lowpan_give_skb_to_device(skb, dev);
+				return lowpan_give_skb_to_device(skb, wdev);
 			} else if (ret == -1) {
 				return NET_RX_DROP;
 			} else {
@@ -117,7 +117,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 				if (ret < 0)
 					goto drop_skb;
 
-				return lowpan_give_skb_to_device(skb, dev);
+				return lowpan_give_skb_to_device(skb, wdev);
 			} else if (ret == -1) {
 				return NET_RX_DROP;
 			} else {
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index f6263fc..9a2147e 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -36,7 +36,7 @@ lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
 			sizeof(struct lowpan_addr_info));
 }
 
-int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
+int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 			 unsigned short type, const void *_daddr,
 			 const void *_saddr, unsigned int len)
 {
@@ -51,7 +51,7 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 		return 0;
 
 	if (!saddr)
-		saddr = dev->dev_addr;
+		saddr = ldev->dev_addr;
 
 	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
 	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
@@ -73,22 +73,21 @@ static struct sk_buff*
 lowpan_alloc_frag(struct sk_buff *skb, int size,
 		  const struct ieee802154_hdr *master_hdr)
 {
-	struct net_device *real_dev = lowpan_dev_info(skb->dev)->real_dev;
+	struct net_device *wdev = lowpan_dev_info(skb->dev)->wdev;
 	struct sk_buff *frag;
 	int rc;
 
-	frag = alloc_skb(real_dev->hard_header_len +
-			 real_dev->needed_tailroom + size,
+	frag = alloc_skb(wdev->hard_header_len + wdev->needed_tailroom + size,
 			 GFP_ATOMIC);
 
 	if (likely(frag)) {
-		frag->dev = real_dev;
+		frag->dev = wdev;
 		frag->priority = skb->priority;
-		skb_reserve(frag, real_dev->hard_header_len);
+		skb_reserve(frag, wdev->hard_header_len);
 		skb_reset_network_header(frag);
 		*mac_cb(frag) = *mac_cb(skb);
 
-		rc = dev_hard_header(frag, real_dev, 0, &master_hdr->dest,
+		rc = dev_hard_header(frag, wdev, 0, &master_hdr->dest,
 				     &master_hdr->source, size);
 		if (rc < 0) {
 			kfree_skb(frag);
@@ -123,7 +122,7 @@ lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 }
 
 static int
-lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *dev,
+lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
 		       const struct ieee802154_hdr *wpan_hdr)
 {
 	u16 dgram_size, dgram_offset;
@@ -134,8 +133,8 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *dev,
 
 	dgram_size = lowpan_uncompress_size(skb, &dgram_offset) -
 		     skb->mac_len;
-	frag_tag = htons(lowpan_dev_info(dev)->fragment_tag);
-	lowpan_dev_info(dev)->fragment_tag++;
+	frag_tag = htons(lowpan_dev_info(ldev)->fragment_tag);
+	lowpan_dev_info(ldev)->fragment_tag++;
 
 	frag_hdr[0] = LOWPAN_DISPATCH_FRAG1 | ((dgram_size >> 8) & 0x07);
 	frag_hdr[1] = dgram_size & 0xff;
@@ -188,9 +187,9 @@ err:
 	return rc;
 }
 
-static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
+static int lowpan_header(struct sk_buff *skb, struct net_device *ldev)
 {
-	struct wpan_dev *wpan_dev = lowpan_dev_info(dev)->real_dev->ieee802154_ptr;
+	struct wpan_dev *wpan_dev = lowpan_dev_info(ldev)->wdev->ieee802154_ptr;
 	struct ieee802154_addr sa, da;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
 	struct lowpan_addr_info info;
@@ -202,7 +201,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 	daddr = &info.daddr.u.extended_addr;
 	saddr = &info.saddr.u.extended_addr;
 
-	lowpan_header_compress(skb, dev, ETH_P_IPV6, daddr, saddr, skb->len);
+	lowpan_header_compress(skb, ldev, ETH_P_IPV6, daddr, saddr, skb->len);
 
 	cb->type = IEEE802154_FC_TYPE_DATA;
 
@@ -227,11 +226,11 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 		cb->ackreq = wpan_dev->ackreq;
 	}
 
-	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
-			ETH_P_IPV6, (void *)&da, (void *)&sa, 0);
+	return dev_hard_header(skb, lowpan_dev_info(ldev)->wdev, ETH_P_IPV6,
+			       (void *)&da, (void *)&sa, 0);
 }
 
-netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 {
 	struct ieee802154_hdr wpan_hdr;
 	int max_single, ret;
@@ -245,7 +244,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!skb)
 		return NET_XMIT_DROP;
 
-	ret = lowpan_header(skb, dev);
+	ret = lowpan_header(skb, ldev);
 	if (ret < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
@@ -259,13 +258,13 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	max_single = ieee802154_max_payload(&wpan_hdr);
 
 	if (skb_tail_pointer(skb) - skb_network_header(skb) <= max_single) {
-		skb->dev = lowpan_dev_info(dev)->real_dev;
+		skb->dev = lowpan_dev_info(ldev)->wdev;
 		return dev_queue_xmit(skb);
 	} else {
 		netdev_tx_t rc;
 
 		pr_debug("frame is too big, fragmentation is needed\n");
-		rc = lowpan_xmit_fragmented(skb, dev, &wpan_hdr);
+		rc = lowpan_xmit_fragmented(skb, ldev, &wpan_hdr);
 
 		return rc < 0 ? NET_XMIT_DROP : rc;
 	}
-- 
2.5.1

