Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8026463E;
	Tue,  1 Jul 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356459; cv=none; b=c96nigViOJ5dUytnFy+QB6BqgOKRAFHbKT9GlWKVE1VgYM822erVtgA7NfxYokHPVEPNnvF83fv3B2GdANZsx2NV4SONbBuoxRE2FdOtBlHtaafrWMG05P+AEPiy8As+OTxcL44+rWh/zHRx2kmevPqmFdvdYFCAGxEZEaqFDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356459; c=relaxed/simple;
	bh=aLp0OTQCW+cGVNmp1xaqhe81qVdtYj7yQtXstHlUy3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MRD0j1KKBSFZEk1h48hDhVQreWxx226Anmtu/jMQE/Wh5bnGLRDcwTnrijts06oyS3nz4VJ6T9KO0HkGnd8Nbrc8aIytvGnSJXlzbgNITOzTKTaJa4YL/5sRfN8+EgQ0T8LwQRn7JTxuaZfKsjE2uFvGsxr0GUTNJE9t/X5REAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bWZxf0Hfkz2TSwt;
	Tue,  1 Jul 2025 15:52:22 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id EDED6140276;
	Tue,  1 Jul 2025 15:54:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Jul
 2025 15:54:05 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <alex.aring@gmail.com>,
	<dsahern@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>
Subject: [PATCH net-next v2] net: replace ND_PRINTK with dynamic debug
Date: Tue, 1 Jul 2025 16:11:14 +0800
Message-ID: <20250701081114.1378895-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)

ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
Changes in v2:
Use dynamic debug instead of sysctl.
---
 include/net/ndisc.h |   9 ---
 net/6lowpan/ndisc.c |  16 ++---
 net/ipv6/ndisc.c    | 157 +++++++++++++++++---------------------------
 3 files changed, 67 insertions(+), 115 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 3c88d5bc5eed..d38783a2ce57 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -60,15 +60,6 @@ enum {
 
 #include <net/neighbour.h>
 
-/* Set to 3 to get tracing... */
-#define ND_DEBUG 1
-
-#define ND_PRINTK(val, level, fmt, ...)				\
-do {								\
-	if (val <= ND_DEBUG)					\
-		net_##level##_ratelimited(fmt, ##__VA_ARGS__);	\
-} while (0)
-
 struct ctl_table;
 struct inet6_dev;
 struct net_device;
diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index c40b98f7743c..868d28583c0a 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -20,9 +20,8 @@ static int lowpan_ndisc_parse_802154_options(const struct net_device *dev,
 	switch (nd_opt->nd_opt_len) {
 	case NDISC_802154_SHORT_ADDR_LENGTH:
 		if (ndopts->nd_802154_opt_array[nd_opt->nd_opt_type])
-			ND_PRINTK(2, warn,
-				  "%s: duplicated short addr ND6 option found: type=%d\n",
-				  __func__, nd_opt->nd_opt_type);
+			net_dbg_ratelimited("%s: duplicated short addr ND6 option found: type=%d\n",
+					    __func__, nd_opt->nd_opt_type);
 		else
 			ndopts->nd_802154_opt_array[nd_opt->nd_opt_type] = nd_opt;
 		return 1;
@@ -63,8 +62,7 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
 			lladdr_short = __ndisc_opt_addr_data(ndopts->nd_802154_opts_src_lladdr,
 							     IEEE802154_SHORT_ADDR_LEN, 0);
 			if (!lladdr_short) {
-				ND_PRINTK(2, warn,
-					  "NA: invalid short link-layer address length\n");
+				net_dbg_ratelimited("NA: invalid short link-layer address length\n");
 				return;
 			}
 		}
@@ -75,8 +73,7 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
 			lladdr_short = __ndisc_opt_addr_data(ndopts->nd_802154_opts_tgt_lladdr,
 							     IEEE802154_SHORT_ADDR_LEN, 0);
 			if (!lladdr_short) {
-				ND_PRINTK(2, warn,
-					  "NA: invalid short link-layer address length\n");
+				net_dbg_ratelimited("NA: invalid short link-layer address length\n");
 				return;
 			}
 		}
@@ -209,9 +206,8 @@ static void lowpan_ndisc_prefix_rcv_add_addr(struct net *net,
 						   sllao, tokenized, valid_lft,
 						   prefered_lft);
 		if (err)
-			ND_PRINTK(2, warn,
-				  "RA: could not add a short address based address for prefix: %pI6c\n",
-				  &pinfo->prefix);
+			net_dbg_ratelimited("RA: could not add a short address based address for prefix: %pI6c\n",
+					    &pinfo->prefix);
 	}
 }
 #endif
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ecb5c4b8518f..591f0e084658 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -243,9 +243,8 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 		case ND_OPT_NONCE:
 		case ND_OPT_REDIRECT_HDR:
 			if (ndopts->nd_opt_array[nd_opt->nd_opt_type]) {
-				ND_PRINTK(2, warn,
-					  "%s: duplicated ND6 option found: type=%d\n",
-					  __func__, nd_opt->nd_opt_type);
+				net_dbg_ratelimited("%s: duplicated ND6 option found: type=%d\n",
+						    __func__, nd_opt->nd_opt_type);
 			} else {
 				ndopts->nd_opt_array[nd_opt->nd_opt_type] = nd_opt;
 			}
@@ -275,11 +274,8 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 			 * to accommodate future extension to the
 			 * protocol.
 			 */
-			ND_PRINTK(2, notice,
-				  "%s: ignored unsupported option; type=%d, len=%d\n",
-				  __func__,
-				  nd_opt->nd_opt_type,
-				  nd_opt->nd_opt_len);
+			net_dbg_ratelimited("%s: ignored unsupported option; type=%d, len=%d\n",
+					    __func__, nd_opt->nd_opt_type, nd_opt->nd_opt_len);
 		}
 next_opt:
 		opt_len -= l;
@@ -751,9 +747,8 @@ static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb)
 	probes -= NEIGH_VAR(neigh->parms, UCAST_PROBES);
 	if (probes < 0) {
 		if (!(READ_ONCE(neigh->nud_state) & NUD_VALID)) {
-			ND_PRINTK(1, dbg,
-				  "%s: trying to ucast probe in NUD_INVALID: %pI6\n",
-				  __func__, target);
+			net_warn_ratelimited("%s: trying to ucast probe in NUD_INVALID: %pI6\n",
+					     __func__, target);
 		}
 		ndisc_send_ns(dev, target, target, saddr, 0);
 	} else if ((probes -= NEIGH_VAR(neigh->parms, APP_PROBES)) < 0) {
@@ -811,7 +806,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 
 	if (ipv6_addr_is_multicast(&msg->target)) {
-		ND_PRINTK(2, warn, "NS: multicast target address\n");
+		net_dbg_ratelimited("NS: multicast target address\n");
 		return reason;
 	}
 
@@ -820,7 +815,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	 * DAD has to be destined for solicited node multicast address.
 	 */
 	if (dad && !ipv6_addr_is_solict_mult(daddr)) {
-		ND_PRINTK(2, warn, "NS: bad DAD packet (wrong destination)\n");
+		net_dbg_ratelimited("NS: bad DAD packet (wrong destination)\n");
 		return reason;
 	}
 
@@ -830,8 +825,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	if (ndopts.nd_opts_src_lladdr) {
 		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr, dev);
 		if (!lladdr) {
-			ND_PRINTK(2, warn,
-				  "NS: invalid link-layer address length\n");
+			net_dbg_ratelimited("NS: invalid link-layer address length\n");
 			return reason;
 		}
 
@@ -841,8 +835,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 		 *	in the message.
 		 */
 		if (dad) {
-			ND_PRINTK(2, warn,
-				  "NS: bad DAD packet (link-layer address option)\n");
+			net_dbg_ratelimited("NS: bad DAD packet (link-layer address option)\n");
 			return reason;
 		}
 	}
@@ -859,10 +852,8 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 				if (nonce != 0 && ifp->dad_nonce == nonce) {
 					u8 *np = (u8 *)&nonce;
 					/* Matching nonce if looped back */
-					ND_PRINTK(2, notice,
-						  "%s: IPv6 DAD loopback for address %pI6c nonce %pM ignored\n",
-						  ifp->idev->dev->name,
-						  &ifp->addr, np);
+					net_dbg_ratelimited("%s: IPv6 DAD loopback for address %pI6c nonce %pM ignored\n",
+							    ifp->idev->dev->name, &ifp->addr, np);
 					goto out;
 				}
 				/*
@@ -1013,13 +1004,13 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 
 	if (ipv6_addr_is_multicast(&msg->target)) {
-		ND_PRINTK(2, warn, "NA: target address is multicast\n");
+		net_dbg_ratelimited("NA: target address is multicast\n");
 		return reason;
 	}
 
 	if (ipv6_addr_is_multicast(daddr) &&
 	    msg->icmph.icmp6_solicited) {
-		ND_PRINTK(2, warn, "NA: solicited NA is multicasted\n");
+		net_dbg_ratelimited("NA: solicited NA is multicasted\n");
 		return reason;
 	}
 
@@ -1038,8 +1029,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	if (ndopts.nd_opts_tgt_lladdr) {
 		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev);
 		if (!lladdr) {
-			ND_PRINTK(2, warn,
-				  "NA: invalid link-layer address length\n");
+			net_dbg_ratelimited("NA: invalid link-layer address length\n");
 			return reason;
 		}
 	}
@@ -1060,9 +1050,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		   unsolicited advertisement.
 		 */
 		if (skb->pkt_type != PACKET_LOOPBACK)
-			ND_PRINTK(1, warn,
-				  "NA: %pM advertised our address %pI6c on %s!\n",
-				  eth_hdr(skb)->h_source, &ifp->addr, ifp->idev->dev->name);
+			net_warn_ratelimited("NA: %pM advertised our address %pI6c on %s!\n",
+					     eth_hdr(skb)->h_source, &ifp->addr,
+					     ifp->idev->dev->name);
 		in6_ifa_put(ifp);
 		return reason;
 	}
@@ -1149,7 +1139,7 @@ static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 	if (!idev) {
-		ND_PRINTK(1, err, "RS: can't find in6 device\n");
+		net_err_ratelimited("RS: can't find in6 device\n");
 		return reason;
 	}
 
@@ -1257,11 +1247,9 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	optlen = (skb_tail_pointer(skb) - skb_transport_header(skb)) -
 		sizeof(struct ra_msg);
 
-	ND_PRINTK(2, info,
-		  "RA: %s, dev: %s\n",
-		  __func__, skb->dev->name);
+	net_dbg_ratelimited("RA: %s, dev: %s\n", __func__, skb->dev->name);
 	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL)) {
-		ND_PRINTK(2, warn, "RA: source address is not link-local\n");
+		net_dbg_ratelimited("RA: source address is not link-local\n");
 		return reason;
 	}
 	if (optlen < 0)
@@ -1269,15 +1257,14 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	if (skb->ndisc_nodetype == NDISC_NODETYPE_HOST) {
-		ND_PRINTK(2, warn, "RA: from host or unauthorized router\n");
+		net_dbg_ratelimited("RA: from host or unauthorized router\n");
 		return reason;
 	}
 #endif
 
 	in6_dev = __in6_dev_get(skb->dev);
 	if (!in6_dev) {
-		ND_PRINTK(0, err, "RA: can't find inet6 device for %s\n",
-			  skb->dev->name);
+		net_err_ratelimited("RA: can't find inet6 device for %s\n", skb->dev->name);
 		return reason;
 	}
 
@@ -1285,18 +1272,16 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
 
 	if (!ipv6_accept_ra(in6_dev)) {
-		ND_PRINTK(2, info,
-			  "RA: %s, did not accept ra for dev: %s\n",
-			  __func__, skb->dev->name);
+		net_dbg_ratelimited("RA: %s, did not accept ra for dev: %s\n", __func__,
+				    skb->dev->name);
 		goto skip_linkparms;
 	}
 
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype == NDISC_NODETYPE_NODEFAULT) {
-		ND_PRINTK(2, info,
-			  "RA: %s, nodetype is NODEFAULT, dev: %s\n",
-			  __func__, skb->dev->name);
+		net_dbg_ratelimited("RA: %s, nodetype is NODEFAULT, dev: %s\n", __func__,
+				    skb->dev->name);
 		goto skip_linkparms;
 	}
 #endif
@@ -1325,18 +1310,16 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		send_ifinfo_notify = true;
 
 	if (!READ_ONCE(in6_dev->cnf.accept_ra_defrtr)) {
-		ND_PRINTK(2, info,
-			  "RA: %s, defrtr is false for dev: %s\n",
-			  __func__, skb->dev->name);
+		net_dbg_ratelimited("RA: %s, defrtr is false for dev: %s\n", __func__,
+				    skb->dev->name);
 		goto skip_defrtr;
 	}
 
 	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
 	if (lifetime != 0 &&
 	    lifetime < READ_ONCE(in6_dev->cnf.accept_ra_min_lft)) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
+		net_dbg_ratelimited("RA: router lifetime (%ds) is too short: %s\n", lifetime,
+				    skb->dev->name);
 		goto skip_defrtr;
 	}
 
@@ -1346,9 +1329,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	net = dev_net(in6_dev->dev);
 	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(net, &ipv6_hdr(skb)->saddr, in6_dev->dev, 0)) {
-		ND_PRINTK(2, info,
-			  "RA from local address detected on dev: %s: default router ignored\n",
-			  skb->dev->name);
+		net_dbg_ratelimited("RA from local address detected on dev: %s: default router ignored\n",
+				    skb->dev->name);
 		goto skip_defrtr;
 	}
 
@@ -1366,9 +1348,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 					 rt->fib6_nh->fib_nh_dev, NULL,
 					  &ipv6_hdr(skb)->saddr);
 		if (!neigh) {
-			ND_PRINTK(0, err,
-				  "RA: %s got default router without neighbour\n",
-				  __func__);
+			net_err_ratelimited("RA: %s got default router without neighbour\n",
+					    __func__);
 			fib6_info_release(rt);
 			return reason;
 		}
@@ -1381,10 +1362,10 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		rt = NULL;
 	}
 
-	ND_PRINTK(3, info, "RA: rt: %p  lifetime: %d, metric: %d, for dev: %s\n",
-		  rt, lifetime, defrtr_usr_metric, skb->dev->name);
+	net_dbg_ratelimited("RA: rt: %p  lifetime: %d, metric: %d, for dev: %s\n", rt, lifetime,
+			    defrtr_usr_metric, skb->dev->name);
 	if (!rt && lifetime) {
-		ND_PRINTK(3, info, "RA: adding default router\n");
+		net_dbg_ratelimited("RA: adding default router\n");
 
 		if (neigh)
 			neigh_release(neigh);
@@ -1393,9 +1374,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 					 skb->dev, pref, defrtr_usr_metric,
 					 lifetime);
 		if (!rt) {
-			ND_PRINTK(0, err,
-				  "RA: %s failed to add default route\n",
-				  __func__);
+			net_err_ratelimited("RA: %s failed to add default route\n", __func__);
 			return reason;
 		}
 
@@ -1403,9 +1382,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 					 rt->fib6_nh->fib_nh_dev, NULL,
 					  &ipv6_hdr(skb)->saddr);
 		if (!neigh) {
-			ND_PRINTK(0, err,
-				  "RA: %s got default router without neighbour\n",
-				  __func__);
+			net_err_ratelimited("RA: %s got default router without neighbour\n",
+					    __func__);
 			fib6_info_release(rt);
 			return reason;
 		}
@@ -1436,7 +1414,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 			fib6_metric_set(rt, RTAX_HOPLIMIT,
 					ra_msg->icmph.icmp6_hop_limit);
 		} else {
-			ND_PRINTK(2, warn, "RA: Got route advertisement with lower hop_limit than minimum\n");
+			net_dbg_ratelimited("RA: Got route advertisement with lower hop_limit than minimum\n");
 		}
 	}
 
@@ -1492,8 +1470,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 			lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
 						     skb->dev);
 			if (!lladdr) {
-				ND_PRINTK(2, warn,
-					  "RA: invalid link-layer address length\n");
+				net_dbg_ratelimited("RA: invalid link-layer address length\n");
 				goto out;
 			}
 		}
@@ -1507,9 +1484,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 
 	if (!ipv6_accept_ra(in6_dev)) {
-		ND_PRINTK(2, info,
-			  "RA: %s, accept_ra is false for dev: %s\n",
-			  __func__, skb->dev->name);
+		net_dbg_ratelimited("RA: %s, accept_ra is false for dev: %s\n", __func__,
+				    skb->dev->name);
 		goto out;
 	}
 
@@ -1517,9 +1493,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
 			  in6_dev->dev, 0)) {
-		ND_PRINTK(2, info,
-			  "RA from local address detected on dev: %s: router info ignored.\n",
-			  skb->dev->name);
+		net_dbg_ratelimited("RA from local address detected on dev: %s: router info ignored.\n",
+				    skb->dev->name);
 		goto skip_routeinfo;
 	}
 
@@ -1555,9 +1530,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific ndopts from interior routers */
 	if (skb->ndisc_nodetype == NDISC_NODETYPE_NODEFAULT) {
-		ND_PRINTK(2, info,
-			  "RA: %s, nodetype is NODEFAULT (interior routes), dev: %s\n",
-			  __func__, skb->dev->name);
+		net_dbg_ratelimited("RA: %s, nodetype is NODEFAULT (interior routes), dev: %s\n",
+				    __func__, skb->dev->name);
 		goto out;
 	}
 #endif
@@ -1586,7 +1560,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		}
 
 		if (mtu < IPV6_MIN_MTU || mtu > skb->dev->mtu) {
-			ND_PRINTK(2, warn, "RA: invalid mtu: %d\n", mtu);
+			net_dbg_ratelimited("RA: invalid mtu: %d\n", mtu);
 		} else if (READ_ONCE(in6_dev->cnf.mtu6) != mtu) {
 			WRITE_ONCE(in6_dev->cnf.mtu6, mtu);
 			fib6_metric_set(rt, RTAX_MTU, mtu);
@@ -1605,7 +1579,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 
 	if (ndopts.nd_opts_tgt_lladdr || ndopts.nd_opts_rh) {
-		ND_PRINTK(2, warn, "RA: invalid RA options\n");
+		net_dbg_ratelimited("RA: invalid RA options\n");
 	}
 out:
 	/* Send a notify if RA changed managed/otherconf flags or
@@ -1633,15 +1607,13 @@ static enum skb_drop_reason ndisc_redirect_rcv(struct sk_buff *skb)
 	switch (skb->ndisc_nodetype) {
 	case NDISC_NODETYPE_HOST:
 	case NDISC_NODETYPE_NODEFAULT:
-		ND_PRINTK(2, warn,
-			  "Redirect: from host or unauthorized router\n");
+		net_dbg_ratelimited("Redirect: from host or unauthorized router\n");
 		return reason;
 	}
 #endif
 
 	if (!(ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL)) {
-		ND_PRINTK(2, warn,
-			  "Redirect: source address is not link-local\n");
+		net_dbg_ratelimited("Redirect: source address is not link-local\n");
 		return reason;
 	}
 
@@ -1702,15 +1674,13 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	}
 
 	if (ipv6_get_lladdr(dev, &saddr_buf, IFA_F_TENTATIVE)) {
-		ND_PRINTK(2, warn, "Redirect: no link-local address on %s\n",
-			  dev->name);
+		net_dbg_ratelimited("Redirect: no link-local address on %s\n", dev->name);
 		return;
 	}
 
 	if (!ipv6_addr_equal(&ipv6_hdr(skb)->daddr, target) &&
 	    ipv6_addr_type(target) != (IPV6_ADDR_UNICAST|IPV6_ADDR_LINKLOCAL)) {
-		ND_PRINTK(2, warn,
-			  "Redirect: target address is not link-local unicast\n");
+		net_dbg_ratelimited("Redirect: target address is not link-local unicast\n");
 		return;
 	}
 
@@ -1729,8 +1699,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	rt = dst_rt6_info(dst);
 
 	if (rt->rt6i_flags & RTF_GATEWAY) {
-		ND_PRINTK(2, warn,
-			  "Redirect: destination is not a neighbour\n");
+		net_dbg_ratelimited("Redirect: destination is not a neighbour\n");
 		goto release;
 	}
 
@@ -1743,8 +1712,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	if (dev->addr_len) {
 		struct neighbour *neigh = dst_neigh_lookup(skb_dst(skb), target);
 		if (!neigh) {
-			ND_PRINTK(2, warn,
-				  "Redirect: no neigh for target address\n");
+			net_dbg_ratelimited("Redirect: no neigh for target address\n");
 			goto release;
 		}
 
@@ -1845,14 +1813,12 @@ enum skb_drop_reason ndisc_rcv(struct sk_buff *skb)
 	__skb_push(skb, skb->data - skb_transport_header(skb));
 
 	if (ipv6_hdr(skb)->hop_limit != 255) {
-		ND_PRINTK(2, warn, "NDISC: invalid hop-limit: %d\n",
-			  ipv6_hdr(skb)->hop_limit);
+		net_dbg_ratelimited("NDISC: invalid hop-limit: %d\n", ipv6_hdr(skb)->hop_limit);
 		return SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT;
 	}
 
 	if (msg->icmph.icmp6_code != 0) {
-		ND_PRINTK(2, warn, "NDISC: invalid ICMPv6 code: %d\n",
-			  msg->icmph.icmp6_code);
+		net_dbg_ratelimited("NDISC: invalid ICMPv6 code: %d\n", msg->icmph.icmp6_code);
 		return SKB_DROP_REASON_IPV6_NDISC_BAD_CODE;
 	}
 
@@ -2003,9 +1969,8 @@ static int __net_init ndisc_net_init(struct net *net)
 	err = inet_ctl_sock_create(&sk, PF_INET6,
 				   SOCK_RAW, IPPROTO_ICMPV6, net);
 	if (err < 0) {
-		ND_PRINTK(0, err,
-			  "NDISC: Failed to initialize the control socket (err %d)\n",
-			  err);
+		net_err_ratelimited("NDISC: Failed to initialize the control socket (err %d)\n",
+				    err);
 		return err;
 	}
 
-- 
2.34.1

