Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46658 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758816AbcCVNPq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:46 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 18/19] ndisc: add support for short address option
Date: Tue, 22 Mar 2016 14:15:14 +0100
Message-Id: <1458652515-7862-19-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch will add 802.15.4 6lowpan handling when parsing NS and NA
messages. The 802.15.4 6lowpan neighbour has a parivate data room for
storing an optional address which is available via link layer address
option fields.

This option field will currently always be written if a neighbour was
returned by neighbour lookup functionality.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ipv6/ndisc.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 5c96ec6..6d9768e 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -235,6 +235,52 @@ static void ndisc_802154_parse_addr_options(struct ndisc_options *ndopts,
 		break;
 	}
 }
+
+static void ndisc_802154_neigh_update(struct neighbour *n, void *priv)
+{
+	struct lowpan_802154_neigh *neigh = lowpan_802154_neigh(neighbour_priv(n));
+
+	write_lock_bh(&n->lock);
+	if (priv)
+		ieee802154_be16_to_le16(&neigh->short_addr, priv);
+	else
+		neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	write_unlock_bh(&n->lock);
+}
+
+static inline int ndisc_802154_short_addr_space(struct net_device *dev)
+{
+	struct wpan_dev *wpan_dev;
+	int addr_space = 0;
+
+	if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154)) {
+		wpan_dev = lowpan_802154_dev(dev)->wdev->ieee802154_ptr;
+
+		if (ieee802154_is_valid_src_short_addr(wpan_dev->short_addr))
+			addr_space = ndisc_opt_addr_space(dev, IEEE802154_SHORT_ADDR_LEN);
+	}
+
+	return addr_space;
+}
+
+static inline void ndisc_802154_short_addr_option(struct net_device *dev,
+						  struct sk_buff *skb,
+						  int type)
+{
+	struct wpan_dev *wpan_dev;
+	__be16 short_addr;
+
+	if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154)) {
+		wpan_dev = lowpan_802154_dev(dev)->wdev->ieee802154_ptr;
+
+		if (ieee802154_is_valid_src_short_addr(wpan_dev->short_addr)) {
+			ieee802154_le16_to_be16(&short_addr,
+						&wpan_dev->short_addr);
+			ndisc_fill_addr_option(skb, type, &short_addr,
+					       IEEE802154_SHORT_ADDR_LEN);
+		}
+	}
+}
 #endif
 
 struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
@@ -550,8 +596,12 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 
 	if (!dev->addr_len)
 		inc_opt = 0;
-	if (inc_opt)
+	if (inc_opt) {
 		optlen += ndisc_opt_addr_space(dev, dev->addr_len);
+#ifdef CONFIG_IEEE802154_6LOWPAN
+		optlen += ndisc_802154_short_addr_space(dev);
+#endif
+	}
 
 	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
 	if (!skb)
@@ -568,9 +618,14 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		.target = *solicited_addr,
 	};
 
-	if (inc_opt)
+	if (inc_opt) {
 		ndisc_fill_addr_option(skb, ND_OPT_TARGET_LL_ADDR,
 				       dev->dev_addr, dev->addr_len);
+#ifdef CONFIG_IEEE802154_6LOWPAN
+		ndisc_802154_short_addr_option(dev, skb,
+					       ND_OPT_TARGET_LL_ADDR);
+#endif
+	}
 
 
 	ndisc_send_skb(skb, daddr, src_addr);
@@ -615,8 +670,12 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
 
 	if (ipv6_addr_any(saddr))
 		inc_opt = false;
-	if (inc_opt)
+	if (inc_opt) {
 		optlen += ndisc_opt_addr_space(dev, dev->addr_len);
+#ifdef CONFIG_IEEE802154_6LOWPAN
+		optlen += ndisc_802154_short_addr_space(dev);
+#endif
+	}
 
 	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
 	if (!skb)
@@ -630,9 +689,14 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
 		.target = *solicit,
 	};
 
-	if (inc_opt)
+	if (inc_opt) {
 		ndisc_fill_addr_option(skb, ND_OPT_SOURCE_LL_ADDR,
 				       dev->dev_addr, dev->addr_len);
+#ifdef CONFIG_IEEE802154_6LOWPAN
+		ndisc_802154_short_addr_option(dev, skb,
+					       ND_OPT_SOURCE_LL_ADDR);
+#endif
+	}
 
 	ndisc_send_skb(skb, daddr, saddr);
 }
@@ -760,6 +824,9 @@ static void ndisc_recv_ns(struct sk_buff *skb)
 	int dad = ipv6_addr_any(saddr);
 	bool inc;
 	int is_router = -1;
+#ifdef CONFIG_IEEE802154_6LOWPAN
+	u8 *lladdr_short = NULL;
+#endif
 
 	if (skb->len < sizeof(struct nd_msg)) {
 		ND_PRINTK(2, warn, "NS: packet too short\n");
@@ -806,6 +873,30 @@ static void ndisc_recv_ns(struct sk_buff *skb)
 		}
 	}
 
+#ifdef CONFIG_IEEE802154_6LOWPAN
+	if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154) &&
+	    ndopts.nd_802154_opts_src_lladdr) {
+		lladdr_short = ndisc_opt_addr_data(ndopts.nd_802154_opts_src_lladdr,
+						   dev, IEEE802154_SHORT_ADDR_LEN);
+		if (!lladdr_short) {
+			ND_PRINTK(2, warn,
+				  "NS: invalid short link-layer address length\n");
+			return;
+		}
+
+		/* RFC2461 7.1.1:
+		 *	If the IP source address is the unspecified address,
+		 *	there MUST NOT be source link-layer address option
+		 *	in the message.
+		 */
+		if (dad) {
+			ND_PRINTK(2, warn,
+				  "NS: bad DAD packet (short link-layer address option)\n");
+			return;
+		}
+	}
+#endif
+
 	inc = ipv6_addr_is_multicast(daddr);
 
 	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
@@ -898,10 +989,15 @@ have_ifp:
 	 */
 	neigh = __neigh_lookup(&nd_tbl, saddr, dev,
 			       !inc || lladdr || !dev->addr_len);
-	if (neigh)
+	if (neigh) {
 		neigh_update(neigh, lladdr, NUD_STALE,
 			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
 			     NEIGH_UPDATE_F_OVERRIDE);
+#ifdef CONFIG_IEEE802154_6LOWPAN
+		if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
+			ndisc_802154_neigh_update(neigh, lladdr_short);
+#endif
+	}
 	if (neigh || !dev->header_ops) {
 		ndisc_send_na(dev, saddr, &msg->target, !!is_router,
 			      true, (ifp != NULL && inc), inc);
@@ -929,6 +1025,9 @@ static void ndisc_recv_na(struct sk_buff *skb)
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	struct inet6_ifaddr *ifp;
 	struct neighbour *neigh;
+#ifdef CONFIG_IEEE802154_6LOWPAN
+	u8 *lladdr_short = NULL;
+#endif
 
 	if (skb->len < sizeof(struct nd_msg)) {
 		ND_PRINTK(2, warn, "NA: packet too short\n");
@@ -967,6 +1066,18 @@ static void ndisc_recv_na(struct sk_buff *skb)
 			return;
 		}
 	}
+#ifdef CONFIG_IEEE802154_6LOWPAN
+	if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154) &&
+	    ndopts.nd_802154_opts_tgt_lladdr) {
+		lladdr_short = ndisc_opt_addr_data(ndopts.nd_802154_opts_tgt_lladdr,
+						   dev, IEEE802154_SHORT_ADDR_LEN);
+		if (!lladdr_short) {
+			ND_PRINTK(2, warn,
+				  "NA: invalid short link-layer address length\n");
+			return;
+		}
+	}
+#endif
 	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
 	if (ifp) {
 		if (skb->pkt_type != PACKET_LOOPBACK
@@ -1018,6 +1129,11 @@ static void ndisc_recv_na(struct sk_buff *skb)
 			     NEIGH_UPDATE_F_OVERRIDE_ISROUTER|
 			     (msg->icmph.icmp6_router ? NEIGH_UPDATE_F_ISROUTER : 0));
 
+#ifdef CONFIG_IEEE802154_6LOWPAN
+		if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
+			ndisc_802154_neigh_update(neigh, lladdr_short);
+#endif
+
 		if ((old_flags & ~neigh->flags) & NTF_ROUTER) {
 			/*
 			 * Change: router to host
-- 
2.7.4

