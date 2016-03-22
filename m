Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44472 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758874AbcCVNPq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:46 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 17/19] ndisc: add short address to ndisc opts parsing
Date: Tue, 22 Mar 2016 14:15:13 +0100
Message-Id: <1458652515-7862-18-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch adds support for parsing the short address in case of
source/target link-layer address option. The short address is inidcated
by length option field equal to 1, otherwise the extended address will
be handled like the normal length option fields.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/ndisc.h |  9 ++++++++-
 net/ipv6/ndisc.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++------
 net/ipv6/route.c    |  2 +-
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index aac868e..495750e 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -93,6 +93,9 @@ struct nd_opt_hdr {
 /* ND options */
 struct ndisc_options {
 	struct nd_opt_hdr *nd_opt_array[__ND_OPT_ARRAY_MAX];
+#ifdef CONFIG_IEEE802154_6LOWPAN
+	struct nd_opt_hdr *nd_802154_opt_array[__ND_OPT_ARRAY_MAX];
+#endif
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	struct nd_opt_hdr *nd_opts_ri;
 	struct nd_opt_hdr *nd_opts_ri_end;
@@ -108,9 +111,13 @@ struct ndisc_options {
 #define nd_opts_rh		nd_opt_array[ND_OPT_REDIRECT_HDR]
 #define nd_opts_mtu		nd_opt_array[ND_OPT_MTU]
 
+#define nd_802154_opts_src_lladdr	nd_802154_opt_array[ND_OPT_SOURCE_LL_ADDR]
+#define nd_802154_opts_tgt_lladdr	nd_802154_opt_array[ND_OPT_TARGET_LL_ADDR]
+
 #define NDISC_OPT_SPACE(len) (((len)+2+7)&~7)
 
-struct ndisc_options *ndisc_parse_options(u8 *opt, int opt_len,
+struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
+					  u8 *opt, int opt_len,
 					  struct ndisc_options *ndopts);
 
 /*
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 176c7c4..5c96ec6 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -60,6 +60,7 @@
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 #include <net/icmp.h>
+#include <net/6lowpan.h>
 
 #include <net/netlink.h>
 #include <linux/rtnetlink.h>
@@ -202,7 +203,42 @@ static struct nd_opt_hdr *ndisc_next_useropt(struct nd_opt_hdr *cur,
 	return cur <= end && ndisc_is_useropt(cur) ? cur : NULL;
 }
 
-struct ndisc_options *ndisc_parse_options(u8 *opt, int opt_len,
+#ifdef CONFIG_IEEE802154_6LOWPAN
+
+#define NDISC_802154_EXTENDED_ADDR_LENGTH	2
+#define NDISC_802154_SHORT_ADDR_LENGTH		1
+
+static void ndisc_802154_parse_addr_options(struct ndisc_options *ndopts,
+					    struct nd_opt_hdr *nd_opt)
+{
+	switch (nd_opt->nd_opt_len) {
+	case NDISC_802154_EXTENDED_ADDR_LENGTH:
+		if (ndopts->nd_opt_array[nd_opt->nd_opt_type])
+			ND_PRINTK(2, warn,
+				  "%s: duplicated extended addr ND6 option found: type=%d\n",
+				  __func__, nd_opt->nd_opt_type);
+		else
+			ndopts->nd_opt_array[nd_opt->nd_opt_type] = nd_opt;
+		break;
+	case NDISC_802154_SHORT_ADDR_LENGTH:
+		if (ndopts->nd_802154_opt_array[nd_opt->nd_opt_type])
+			ND_PRINTK(2, warn,
+				  "%s: duplicated short addr ND6 option found: type=%d\n",
+				  __func__, nd_opt->nd_opt_type);
+		else
+			ndopts->nd_802154_opt_array[nd_opt->nd_opt_type] = nd_opt;
+		break;
+	default:
+		ND_PRINTK(2, warn,
+			  "%s: invalid length detected: type=%d\n",
+			  __func__, nd_opt->nd_opt_type);
+		break;
+	}
+}
+#endif
+
+struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
+					  u8 *opt, int opt_len,
 					  struct ndisc_options *ndopts)
 {
 	struct nd_opt_hdr *nd_opt = (struct nd_opt_hdr *)opt;
@@ -220,6 +256,12 @@ struct ndisc_options *ndisc_parse_options(u8 *opt, int opt_len,
 		switch (nd_opt->nd_opt_type) {
 		case ND_OPT_SOURCE_LL_ADDR:
 		case ND_OPT_TARGET_LL_ADDR:
+#ifdef CONFIG_IEEE802154_6LOWPAN
+			if (lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154)) {
+				ndisc_802154_parse_addr_options(ndopts, nd_opt);
+				break;
+			}
+#endif
 		case ND_OPT_MTU:
 		case ND_OPT_REDIRECT_HDR:
 			if (ndopts->nd_opt_array[nd_opt->nd_opt_type]) {
@@ -738,7 +780,7 @@ static void ndisc_recv_ns(struct sk_buff *skb)
 		return;
 	}
 
-	if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
+	if (!ndisc_parse_options(dev, msg->opt, ndoptlen, &ndopts)) {
 		ND_PRINTK(2, warn, "NS: invalid ND options\n");
 		return;
 	}
@@ -912,7 +954,7 @@ static void ndisc_recv_na(struct sk_buff *skb)
 	    idev->cnf.drop_unsolicited_na)
 		return;
 
-	if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
+	if (!ndisc_parse_options(dev, msg->opt, ndoptlen, &ndopts)) {
 		ND_PRINTK(2, warn, "NS: invalid ND option\n");
 		return;
 	}
@@ -1019,7 +1061,7 @@ static void ndisc_recv_rs(struct sk_buff *skb)
 		goto out;
 
 	/* Parse ND options */
-	if (!ndisc_parse_options(rs_msg->opt, ndoptlen, &ndopts)) {
+	if (!ndisc_parse_options(skb->dev, rs_msg->opt, ndoptlen, &ndopts)) {
 		ND_PRINTK(2, notice, "NS: invalid ND option, ignored\n");
 		goto out;
 	}
@@ -1137,7 +1179,7 @@ static void ndisc_router_discovery(struct sk_buff *skb)
 		return;
 	}
 
-	if (!ndisc_parse_options(opt, optlen, &ndopts)) {
+	if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts)) {
 		ND_PRINTK(2, warn, "RA: invalid ND options\n");
 		return;
 	}
@@ -1462,7 +1504,7 @@ static void ndisc_redirect_rcv(struct sk_buff *skb)
 		return;
 	}
 
-	if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts))
+	if (!ndisc_parse_options(skb->dev, msg->opt, ndoptlen, &ndopts))
 		return;
 
 	if (!ndopts.nd_opts_rh) {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index cc180b3..5fa276d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2149,7 +2149,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	 *	first-hop router for the specified ICMP Destination Address.
 	 */
 
-	if (!ndisc_parse_options(msg->opt, optlen, &ndopts)) {
+	if (!ndisc_parse_options(skb->dev, msg->opt, optlen, &ndopts)) {
 		net_dbg_ratelimited("rt6_redirect: invalid ND options\n");
 		return;
 	}
-- 
2.7.4

