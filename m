Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47979 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758448AbcCVNPm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:42 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 05/19] 6lowpan: change naming for lowpan private data
Date: Tue, 22 Mar 2016 14:15:01 +0100
Message-Id: <1458652515-7862-6-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch changes the naming for interface private data for lowpan
intefaces. The current private data scheme is:

-------------------------------------------------
|    6LoWPAN Generic   |    LinkLayer 6LoWPAN   |
-------------------------------------------------

the current naming schemes are:

- 6LoWPAN Generic:
  - lowpan_priv
- LinkLayer 6LoWPAN:
  - BTLE
    - lowpan_dev
  - 802.15.4:
    - lowpan_dev_info

the new naming scheme with this patch will be:

- 6LoWPAN Generic:
  - lowpan_dev
- LinkLayer 6LoWPAN:
  - BTLE
    - lowpan_802154_dev
  - 802.15.4:
    - lowpan_btle_dev

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h              |  6 +--
 net/6lowpan/core.c                 |  8 ++--
 net/6lowpan/debugfs.c              | 22 +++++-----
 net/6lowpan/iphc.c                 | 38 +++++++++---------
 net/6lowpan/nhc_udp.c              |  2 +-
 net/bluetooth/6lowpan.c            | 82 ++++++++++++++++++++------------------
 net/ieee802154/6lowpan/6lowpan_i.h |  6 +--
 net/ieee802154/6lowpan/core.c      |  6 +--
 net/ieee802154/6lowpan/tx.c        | 14 +++----
 9 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index da3a77d..f204664 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -93,7 +93,7 @@ static inline bool lowpan_is_iphc(u8 dispatch)
 }
 
 #define LOWPAN_PRIV_SIZE(llpriv_size)	\
-	(sizeof(struct lowpan_priv) + llpriv_size)
+	(sizeof(struct lowpan_dev) + llpriv_size)
 
 enum lowpan_lltypes {
 	LOWPAN_LLTYPE_BTLE,
@@ -129,7 +129,7 @@ lowpan_iphc_ctx_is_compression(const struct lowpan_iphc_ctx *ctx)
 	return test_bit(LOWPAN_IPHC_CTX_FLAG_COMPRESSION, &ctx->flags);
 }
 
-struct lowpan_priv {
+struct lowpan_dev {
 	enum lowpan_lltypes lltype;
 	struct dentry *iface_debugfs;
 	struct lowpan_iphc_ctx_table ctx;
@@ -139,7 +139,7 @@ struct lowpan_priv {
 };
 
 static inline
-struct lowpan_priv *lowpan_priv(const struct net_device *dev)
+struct lowpan_dev *lowpan_dev(const struct net_device *dev)
 {
 	return netdev_priv(dev);
 }
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 34e44c0..7a240b3 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -27,11 +27,11 @@ int lowpan_register_netdevice(struct net_device *dev,
 	dev->mtu = IPV6_MIN_MTU;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
-	lowpan_priv(dev)->lltype = lltype;
+	lowpan_dev(dev)->lltype = lltype;
 
-	spin_lock_init(&lowpan_priv(dev)->ctx.lock);
+	spin_lock_init(&lowpan_dev(dev)->ctx.lock);
 	for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
-		lowpan_priv(dev)->ctx.table[i].id = i;
+		lowpan_dev(dev)->ctx.table[i].id = i;
 
 	ret = register_netdevice(dev);
 	if (ret < 0)
@@ -85,7 +85,7 @@ static int lowpan_event(struct notifier_block *unused,
 	case NETDEV_DOWN:
 		for (i = 0; i < LOWPAN_IPHC_CTX_TABLE_SIZE; i++)
 			clear_bit(LOWPAN_IPHC_CTX_FLAG_ACTIVE,
-				  &lowpan_priv(dev)->ctx.table[i].flags);
+				  &lowpan_dev(dev)->ctx.table[i].flags);
 		break;
 	default:
 		return NOTIFY_DONE;
diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 0793a81..acbaa3d 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -172,7 +172,7 @@ static const struct file_operations lowpan_ctx_pfx_fops = {
 static int lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 				       struct dentry *ctx, u8 id)
 {
-	struct lowpan_priv *lpriv = lowpan_priv(dev);
+	struct lowpan_dev *ldev = lowpan_dev(dev);
 	struct dentry *dentry, *root;
 	char buf[32];
 
@@ -185,25 +185,25 @@ static int lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 		return -EINVAL;
 
 	dentry = debugfs_create_file("active", 0644, root,
-				     &lpriv->ctx.table[id],
+				     &ldev->ctx.table[id],
 				     &lowpan_ctx_flag_active_fops);
 	if (!dentry)
 		return -EINVAL;
 
 	dentry = debugfs_create_file("compression", 0644, root,
-				     &lpriv->ctx.table[id],
+				     &ldev->ctx.table[id],
 				     &lowpan_ctx_flag_c_fops);
 	if (!dentry)
 		return -EINVAL;
 
 	dentry = debugfs_create_file("prefix", 0644, root,
-				     &lpriv->ctx.table[id],
+				     &ldev->ctx.table[id],
 				     &lowpan_ctx_pfx_fops);
 	if (!dentry)
 		return -EINVAL;
 
 	dentry = debugfs_create_file("prefix_len", 0644, root,
-				     &lpriv->ctx.table[id],
+				     &ldev->ctx.table[id],
 				     &lowpan_ctx_plen_fops);
 	if (!dentry)
 		return -EINVAL;
@@ -247,21 +247,21 @@ static const struct file_operations lowpan_context_fops = {
 
 int lowpan_dev_debugfs_init(struct net_device *dev)
 {
-	struct lowpan_priv *lpriv = lowpan_priv(dev);
+	struct lowpan_dev *ldev = lowpan_dev(dev);
 	struct dentry *contexts, *dentry;
 	int ret, i;
 
 	/* creating the root */
-	lpriv->iface_debugfs = debugfs_create_dir(dev->name, lowpan_debugfs);
-	if (!lpriv->iface_debugfs)
+	ldev->iface_debugfs = debugfs_create_dir(dev->name, lowpan_debugfs);
+	if (!ldev->iface_debugfs)
 		goto fail;
 
-	contexts = debugfs_create_dir("contexts", lpriv->iface_debugfs);
+	contexts = debugfs_create_dir("contexts", ldev->iface_debugfs);
 	if (!contexts)
 		goto remove_root;
 
 	dentry = debugfs_create_file("show", 0644, contexts,
-				     &lowpan_priv(dev)->ctx,
+				     &lowpan_dev(dev)->ctx,
 				     &lowpan_context_fops);
 	if (!dentry)
 		goto remove_root;
@@ -282,7 +282,7 @@ fail:
 
 void lowpan_dev_debugfs_exit(struct net_device *dev)
 {
-	debugfs_remove_recursive(lowpan_priv(dev)->iface_debugfs);
+	debugfs_remove_recursive(lowpan_dev(dev)->iface_debugfs);
 }
 
 int __init lowpan_debugfs_init(void)
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 99bb22a..798d5b2 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -202,7 +202,7 @@ static inline void iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 static struct lowpan_iphc_ctx *
 lowpan_iphc_ctx_get_by_id(const struct net_device *dev, u8 id)
 {
-	struct lowpan_iphc_ctx *ret = &lowpan_priv(dev)->ctx.table[id];
+	struct lowpan_iphc_ctx *ret = &lowpan_dev(dev)->ctx.table[id];
 
 	if (!lowpan_iphc_ctx_is_active(ret))
 		return NULL;
@@ -214,7 +214,7 @@ static struct lowpan_iphc_ctx *
 lowpan_iphc_ctx_get_by_addr(const struct net_device *dev,
 			    const struct in6_addr *addr)
 {
-	struct lowpan_iphc_ctx *table = lowpan_priv(dev)->ctx.table;
+	struct lowpan_iphc_ctx *table = lowpan_dev(dev)->ctx.table;
 	struct lowpan_iphc_ctx *ret = NULL;
 	struct in6_addr addr_pfx;
 	u8 addr_plen;
@@ -258,7 +258,7 @@ static struct lowpan_iphc_ctx *
 lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
 				  const struct in6_addr *addr)
 {
-	struct lowpan_iphc_ctx *table = lowpan_priv(dev)->ctx.table;
+	struct lowpan_iphc_ctx *table = lowpan_dev(dev)->ctx.table;
 	struct lowpan_iphc_ctx *ret = NULL;
 	struct in6_addr addr_mcast, network_pfx = {};
 	int i;
@@ -327,7 +327,7 @@ static int uncompress_addr(struct sk_buff *skb, const struct net_device *dev,
 	case LOWPAN_IPHC_SAM_11:
 	case LOWPAN_IPHC_DAM_11:
 		fail = false;
-		switch (lowpan_priv(dev)->lltype) {
+		switch (lowpan_dev(dev)->lltype) {
 		case LOWPAN_LLTYPE_IEEE802154:
 			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
@@ -388,7 +388,7 @@ static int uncompress_ctx_addr(struct sk_buff *skb,
 	case LOWPAN_IPHC_SAM_11:
 	case LOWPAN_IPHC_DAM_11:
 		fail = false;
-		switch (lowpan_priv(dev)->lltype) {
+		switch (lowpan_dev(dev)->lltype) {
 		case LOWPAN_LLTYPE_IEEE802154:
 			iphc_uncompress_802154_lladdr(ipaddr, lladdr);
 			break;
@@ -652,17 +652,17 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 	}
 
 	if (iphc1 & LOWPAN_IPHC_SAC) {
-		spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_SCI(cid));
 		if (!ci) {
-			spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+			spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 			return -EINVAL;
 		}
 
 		pr_debug("SAC bit is set. Handle context based source address.\n");
 		err = uncompress_ctx_addr(skb, dev, ci, &hdr.saddr,
 					  iphc1 & LOWPAN_IPHC_SAM_MASK, saddr);
-		spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 	} else {
 		/* Source address uncompression */
 		pr_debug("source address stateless compression\n");
@@ -676,10 +676,10 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 
 	switch (iphc1 & (LOWPAN_IPHC_M | LOWPAN_IPHC_DAC)) {
 	case LOWPAN_IPHC_M | LOWPAN_IPHC_DAC:
-		spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
 		if (!ci) {
-			spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+			spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 			return -EINVAL;
 		}
 
@@ -688,7 +688,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		err = lowpan_uncompress_multicast_ctx_daddr(skb, ci,
 							    &hdr.daddr,
 							    iphc1 & LOWPAN_IPHC_DAM_MASK);
-		spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 		break;
 	case LOWPAN_IPHC_M:
 		/* multicast */
@@ -696,10 +696,10 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 							iphc1 & LOWPAN_IPHC_DAM_MASK);
 		break;
 	case LOWPAN_IPHC_DAC:
-		spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
 		if (!ci) {
-			spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+			spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 			return -EINVAL;
 		}
 
@@ -707,7 +707,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		pr_debug("DAC bit is set. Handle context based destination address.\n");
 		err = uncompress_ctx_addr(skb, dev, ci, &hdr.daddr,
 					  iphc1 & LOWPAN_IPHC_DAM_MASK, daddr);
-		spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 		break;
 	default:
 		err = uncompress_addr(skb, dev, &hdr.daddr,
@@ -731,7 +731,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 			return err;
 	}
 
-	switch (lowpan_priv(dev)->lltype) {
+	switch (lowpan_dev(dev)->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_802154_cb(skb)->d_size)
 			hdr.payload_len = htons(lowpan_802154_cb(skb)->d_size -
@@ -1028,7 +1028,7 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		       skb->data, skb->len);
 
 	ipv6_daddr_type = ipv6_addr_type(&hdr->daddr);
-	spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+	spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 	if (ipv6_daddr_type & IPV6_ADDR_MULTICAST)
 		dci = lowpan_iphc_ctx_get_by_mcast_addr(dev, &hdr->daddr);
 	else
@@ -1037,15 +1037,15 @@ int lowpan_header_compress(struct sk_buff *skb, const struct net_device *dev,
 		memcpy(&dci_entry, dci, sizeof(*dci));
 		cid |= dci->id;
 	}
-	spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+	spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 
-	spin_lock_bh(&lowpan_priv(dev)->ctx.lock);
+	spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 	sci = lowpan_iphc_ctx_get_by_addr(dev, &hdr->saddr);
 	if (sci) {
 		memcpy(&sci_entry, sci, sizeof(*sci));
 		cid |= (sci->id << 4);
 	}
-	spin_unlock_bh(&lowpan_priv(dev)->ctx.lock);
+	spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 
 	/* if cid is zero it will be compressed */
 	if (cid) {
diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
index 69537a2..225d919 100644
--- a/net/6lowpan/nhc_udp.c
+++ b/net/6lowpan/nhc_udp.c
@@ -91,7 +91,7 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
 	 * here, we obtain the hint from the remaining size of the
 	 * frame
 	 */
-	switch (lowpan_priv(skb->dev)->lltype) {
+	switch (lowpan_dev(skb->dev)->lltype) {
 	case LOWPAN_LLTYPE_IEEE802154:
 		if (lowpan_802154_cb(skb)->d_size)
 			uh.len = htons(lowpan_802154_cb(skb)->d_size -
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 8a4cc2f..38e82dd 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -68,7 +68,7 @@ struct lowpan_peer {
 	struct in6_addr peer_addr;
 };
 
-struct lowpan_dev {
+struct lowpan_btle_dev {
 	struct list_head list;
 
 	struct hci_dev *hdev;
@@ -80,18 +80,21 @@ struct lowpan_dev {
 	struct delayed_work notify_peers;
 };
 
-static inline struct lowpan_dev *lowpan_dev(const struct net_device *netdev)
+static inline struct lowpan_btle_dev *
+lowpan_btle_dev(const struct net_device *netdev)
 {
-	return (struct lowpan_dev *)lowpan_priv(netdev)->priv;
+	return (struct lowpan_btle_dev *)lowpan_dev(netdev)->priv;
 }
 
-static inline void peer_add(struct lowpan_dev *dev, struct lowpan_peer *peer)
+static inline void peer_add(struct lowpan_btle_dev *dev,
+			    struct lowpan_peer *peer)
 {
 	list_add_rcu(&peer->list, &dev->peers);
 	atomic_inc(&dev->peer_count);
 }
 
-static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
+static inline bool peer_del(struct lowpan_btle_dev *dev,
+			    struct lowpan_peer *peer)
 {
 	list_del_rcu(&peer->list);
 	kfree_rcu(peer, rcu);
@@ -106,7 +109,7 @@ static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
 	return false;
 }
 
-static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_dev *dev,
+static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_btle_dev *dev,
 						 bdaddr_t *ba, __u8 type)
 {
 	struct lowpan_peer *peer;
@@ -134,8 +137,8 @@ static inline struct lowpan_peer *peer_lookup_ba(struct lowpan_dev *dev,
 	return NULL;
 }
 
-static inline struct lowpan_peer *__peer_lookup_chan(struct lowpan_dev *dev,
-						     struct l2cap_chan *chan)
+static inline struct lowpan_peer *
+__peer_lookup_chan(struct lowpan_btle_dev *dev, struct l2cap_chan *chan)
 {
 	struct lowpan_peer *peer;
 
@@ -147,8 +150,8 @@ static inline struct lowpan_peer *__peer_lookup_chan(struct lowpan_dev *dev,
 	return NULL;
 }
 
-static inline struct lowpan_peer *__peer_lookup_conn(struct lowpan_dev *dev,
-						     struct l2cap_conn *conn)
+static inline struct lowpan_peer *
+__peer_lookup_conn(struct lowpan_btle_dev *dev, struct l2cap_conn *conn)
 {
 	struct lowpan_peer *peer;
 
@@ -160,7 +163,7 @@ static inline struct lowpan_peer *__peer_lookup_conn(struct lowpan_dev *dev,
 	return NULL;
 }
 
-static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_dev *dev,
+static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 						  struct in6_addr *daddr,
 						  struct sk_buff *skb)
 {
@@ -220,7 +223,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_dev *dev,
 
 static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn)
 {
-	struct lowpan_dev *entry;
+	struct lowpan_btle_dev *entry;
 	struct lowpan_peer *peer = NULL;
 
 	rcu_read_lock();
@@ -236,10 +239,10 @@ static struct lowpan_peer *lookup_peer(struct l2cap_conn *conn)
 	return peer;
 }
 
-static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
+static struct lowpan_btle_dev *lookup_dev(struct l2cap_conn *conn)
 {
-	struct lowpan_dev *entry;
-	struct lowpan_dev *dev = NULL;
+	struct lowpan_btle_dev *entry;
+	struct lowpan_btle_dev *dev = NULL;
 
 	rcu_read_lock();
 
@@ -270,10 +273,10 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 			   struct l2cap_chan *chan)
 {
 	const u8 *saddr, *daddr;
-	struct lowpan_dev *dev;
+	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
 
-	dev = lowpan_dev(netdev);
+	dev = lowpan_btle_dev(netdev);
 
 	rcu_read_lock();
 	peer = __peer_lookup_chan(dev, chan);
@@ -375,7 +378,7 @@ drop:
 /* Packet from BT LE device */
 static int chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct lowpan_dev *dev;
+	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
 	int err;
 
@@ -431,13 +434,13 @@ static int setup_header(struct sk_buff *skb, struct net_device *netdev,
 			bdaddr_t *peer_addr, u8 *peer_addr_type)
 {
 	struct in6_addr ipv6_daddr;
-	struct lowpan_dev *dev;
+	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
 	bdaddr_t addr, *any = BDADDR_ANY;
 	u8 *daddr = any->b;
 	int err, status = 0;
 
-	dev = lowpan_dev(netdev);
+	dev = lowpan_btle_dev(netdev);
 
 	memcpy(&ipv6_daddr, &lowpan_cb(skb)->addr, sizeof(ipv6_daddr));
 
@@ -543,19 +546,19 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct sk_buff *local_skb;
-	struct lowpan_dev *entry;
+	struct lowpan_btle_dev *entry;
 	int err = 0;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
 		struct lowpan_peer *pentry;
-		struct lowpan_dev *dev;
+		struct lowpan_btle_dev *dev;
 
 		if (entry->netdev != netdev)
 			continue;
 
-		dev = lowpan_dev(entry->netdev);
+		dev = lowpan_btle_dev(entry->netdev);
 
 		list_for_each_entry_rcu(pentry, &dev->peers, list) {
 			int ret;
@@ -723,8 +726,8 @@ static void ifdown(struct net_device *netdev)
 
 static void do_notify_peers(struct work_struct *work)
 {
-	struct lowpan_dev *dev = container_of(work, struct lowpan_dev,
-					      notify_peers.work);
+	struct lowpan_btle_dev *dev = container_of(work, struct lowpan_btle_dev,
+						   notify_peers.work);
 
 	netdev_notify_peers(dev->netdev); /* send neighbour adv at startup */
 }
@@ -766,7 +769,7 @@ static void set_ip_addr_bits(u8 addr_type, u8 *addr)
 }
 
 static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
-					struct lowpan_dev *dev)
+					struct lowpan_btle_dev *dev)
 {
 	struct lowpan_peer *peer;
 
@@ -803,12 +806,12 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	return peer->chan;
 }
 
-static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
+static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 {
 	struct net_device *netdev;
 	int err = 0;
 
-	netdev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_dev)),
+	netdev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_btle_dev)),
 			      IFACE_NAME_TEMPLATE, NET_NAME_UNKNOWN,
 			      netdev_setup);
 	if (!netdev)
@@ -820,7 +823,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
 	SET_NETDEV_DEVTYPE(netdev, &bt_type);
 
-	*dev = lowpan_dev(netdev);
+	*dev = lowpan_btle_dev(netdev);
 	(*dev)->netdev = netdev;
 	(*dev)->hdev = chan->conn->hcon->hdev;
 	INIT_LIST_HEAD(&(*dev)->peers);
@@ -853,7 +856,7 @@ out:
 
 static inline void chan_ready_cb(struct l2cap_chan *chan)
 {
-	struct lowpan_dev *dev;
+	struct lowpan_btle_dev *dev;
 
 	dev = lookup_dev(chan->conn);
 
@@ -890,8 +893,9 @@ static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
 
 static void delete_netdev(struct work_struct *work)
 {
-	struct lowpan_dev *entry = container_of(work, struct lowpan_dev,
-						delete_netdev);
+	struct lowpan_btle_dev *entry = container_of(work,
+						     struct lowpan_btle_dev,
+						     delete_netdev);
 
 	lowpan_unregister_netdev(entry->netdev);
 
@@ -900,8 +904,8 @@ static void delete_netdev(struct work_struct *work)
 
 static void chan_close_cb(struct l2cap_chan *chan)
 {
-	struct lowpan_dev *entry;
-	struct lowpan_dev *dev = NULL;
+	struct lowpan_btle_dev *entry;
+	struct lowpan_btle_dev *dev = NULL;
 	struct lowpan_peer *peer;
 	int err = -ENOENT;
 	bool last = false, remove = true;
@@ -921,7 +925,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
-		dev = lowpan_dev(entry->netdev);
+		dev = lowpan_btle_dev(entry->netdev);
 		peer = __peer_lookup_chan(dev, chan);
 		if (peer) {
 			last = peer_del(dev, peer);
@@ -1131,7 +1135,7 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 
 static void disconnect_all_peers(void)
 {
-	struct lowpan_dev *entry;
+	struct lowpan_btle_dev *entry;
 	struct lowpan_peer *peer, *tmp_peer, *new_peer;
 	struct list_head peers;
 
@@ -1291,7 +1295,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 
 static int lowpan_control_show(struct seq_file *f, void *ptr)
 {
-	struct lowpan_dev *entry;
+	struct lowpan_btle_dev *entry;
 	struct lowpan_peer *peer;
 
 	spin_lock(&devices_lock);
@@ -1322,7 +1326,7 @@ static const struct file_operations lowpan_control_fops = {
 
 static void disconnect_devices(void)
 {
-	struct lowpan_dev *entry, *tmp, *new_dev;
+	struct lowpan_btle_dev *entry, *tmp, *new_dev;
 	struct list_head devices;
 
 	INIT_LIST_HEAD(&devices);
@@ -1360,7 +1364,7 @@ static int device_event(struct notifier_block *unused,
 			unsigned long event, void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-	struct lowpan_dev *entry;
+	struct lowpan_btle_dev *entry;
 
 	if (netdev->type != ARPHRD_6LOWPAN)
 		return NOTIFY_DONE;
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index b4092a9..b02b74d 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -48,15 +48,15 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
 }
 
 /* private device info */
-struct lowpan_dev_info {
+struct lowpan_802154_dev {
 	struct net_device	*wdev; /* wpan device ptr */
 	u16			fragment_tag;
 };
 
 static inline struct
-lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
+lowpan_802154_dev *lowpan_802154_dev(const struct net_device *dev)
 {
-	return (struct lowpan_dev_info *)lowpan_priv(dev)->priv;
+	return (struct lowpan_802154_dev *)lowpan_dev(dev)->priv;
 }
 
 int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 0023c90..dd085db 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -148,7 +148,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 		return -EBUSY;
 	}
 
-	lowpan_dev_info(ldev)->wdev = wdev;
+	lowpan_802154_dev(ldev)->wdev = wdev;
 	/* Set the lowpan hardware address to the wpan hardware address. */
 	memcpy(ldev->dev_addr, wdev->dev_addr, IEEE802154_ADDR_LEN);
 	/* We need headroom for possible wpan_dev_hard_header call and tailroom
@@ -173,7 +173,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 
 static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
 {
-	struct net_device *wdev = lowpan_dev_info(ldev)->wdev;
+	struct net_device *wdev = lowpan_802154_dev(ldev)->wdev;
 
 	ASSERT_RTNL();
 
@@ -184,7 +184,7 @@ static void lowpan_dellink(struct net_device *ldev, struct list_head *head)
 
 static struct rtnl_link_ops lowpan_link_ops __read_mostly = {
 	.kind		= "lowpan",
-	.priv_size	= LOWPAN_PRIV_SIZE(sizeof(struct lowpan_dev_info)),
+	.priv_size	= LOWPAN_PRIV_SIZE(sizeof(struct lowpan_802154_dev)),
 	.setup		= lowpan_setup,
 	.newlink	= lowpan_newlink,
 	.dellink	= lowpan_dellink,
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index d4353fa..e459afd 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -84,7 +84,7 @@ static struct sk_buff*
 lowpan_alloc_frag(struct sk_buff *skb, int size,
 		  const struct ieee802154_hdr *master_hdr, bool frag1)
 {
-	struct net_device *wdev = lowpan_dev_info(skb->dev)->wdev;
+	struct net_device *wdev = lowpan_802154_dev(skb->dev)->wdev;
 	struct sk_buff *frag;
 	int rc;
 
@@ -148,8 +148,8 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct net_device *ldev,
 	int frag_cap, frag_len, payload_cap, rc;
 	int skb_unprocessed, skb_offset;
 
-	frag_tag = htons(lowpan_dev_info(ldev)->fragment_tag);
-	lowpan_dev_info(ldev)->fragment_tag++;
+	frag_tag = htons(lowpan_802154_dev(ldev)->fragment_tag);
+	lowpan_802154_dev(ldev)->fragment_tag++;
 
 	frag_hdr[0] = LOWPAN_DISPATCH_FRAG1 | ((dgram_size >> 8) & 0x07);
 	frag_hdr[1] = dgram_size & 0xff;
@@ -208,7 +208,7 @@ err:
 static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 			 u16 *dgram_size, u16 *dgram_offset)
 {
-	struct wpan_dev *wpan_dev = lowpan_dev_info(ldev)->wdev->ieee802154_ptr;
+	struct wpan_dev *wpan_dev = lowpan_802154_dev(ldev)->wdev->ieee802154_ptr;
 	struct ieee802154_addr sa, da;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
 	struct lowpan_addr_info info;
@@ -248,8 +248,8 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 		cb->ackreq = wpan_dev->ackreq;
 	}
 
-	return wpan_dev_hard_header(skb, lowpan_dev_info(ldev)->wdev, &da, &sa,
-				    0);
+	return wpan_dev_hard_header(skb, lowpan_802154_dev(ldev)->wdev, &da,
+				    &sa, 0);
 }
 
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
@@ -283,7 +283,7 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 	max_single = ieee802154_max_payload(&wpan_hdr);
 
 	if (skb_tail_pointer(skb) - skb_network_header(skb) <= max_single) {
-		skb->dev = lowpan_dev_info(ldev)->wdev;
+		skb->dev = lowpan_802154_dev(ldev)->wdev;
 		ldev->stats.tx_packets++;
 		ldev->stats.tx_bytes += dgram_size;
 		return dev_queue_xmit(skb);
-- 
2.7.4

