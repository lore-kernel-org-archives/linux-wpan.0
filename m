Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48017 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429AbcEWTXD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 23 May 2016 15:23:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC 05/12] ndisc: get rid off dev parameter in ndisc_opt_addr_data
Date: Mon, 23 May 2016 21:22:01 +0200
Message-Id: <1464031328-17524-6-git-send-email-aar@pengutronix.de>
In-Reply-To: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
References: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

This patch removes the net_device parameter from ndisc_opt_addr_data
function. This can be useful for calling such functionality which
doesn't depends on dev parameter. For current existing functionality
which depends on dev parameter, we introduce ndisc_dev_opt_addr_data to have
an easy replacement for the ndisc_opt_addr_data function.

Cc: David S. Miller <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: James Morris <jmorris@namei.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Patrick McHardy <kaber@trash.net>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/ndisc.h | 12 +++++++++---
 net/ipv6/ndisc.c    | 14 ++++++++------
 net/ipv6/route.c    |  4 ++--
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index dbc8d01..7fa74b0 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -139,16 +139,22 @@ static inline int ndisc_dev_opt_addr_space(const struct net_device *dev)
 }
 
 static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
-				      struct net_device *dev)
+				      unsigned char addr_len, int prepad)
 {
 	u8 *lladdr = (u8 *)(p + 1);
 	int lladdrlen = p->nd_opt_len << 3;
-	int prepad = ndisc_addr_option_pad(dev->type);
-	if (lladdrlen != ndisc_opt_addr_space(dev->addr_len, prepad))
+	if (lladdrlen != ndisc_opt_addr_space(addr_len, prepad))
 		return NULL;
 	return lladdr + prepad;
 }
 
+static inline u8 *ndisc_dev_opt_addr_data(struct nd_opt_hdr *p,
+					  const struct net_device *dev)
+{
+	return ndisc_opt_addr_data(p, dev->addr_len,
+				   ndisc_addr_option_pad(dev->type));
+}
+
 static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, __u32 *hash_rnd)
 {
 	const u32 *p32 = pkey;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 2241f06..d6f28d5 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -744,7 +744,8 @@ static void ndisc_recv_ns(struct sk_buff *skb)
 	}
 
 	if (ndopts.nd_opts_src_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr, dev);
+		lladdr = ndisc_dev_opt_addr_data(ndopts.nd_opts_src_lladdr,
+						 dev);
 		if (!lladdr) {
 			ND_PRINTK(2, warn,
 				  "NS: invalid link-layer address length\n");
@@ -916,7 +917,8 @@ static void ndisc_recv_na(struct sk_buff *skb)
 		return;
 	}
 	if (ndopts.nd_opts_tgt_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev);
+		lladdr = ndisc_dev_opt_addr_data(ndopts.nd_opts_tgt_lladdr,
+						 dev);
 		if (!lladdr) {
 			ND_PRINTK(2, warn,
 				  "NA: invalid link-layer address length\n");
@@ -1023,8 +1025,8 @@ static void ndisc_recv_rs(struct sk_buff *skb)
 	}
 
 	if (ndopts.nd_opts_src_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
-					     skb->dev);
+		lladdr = ndisc_dev_opt_addr_data(ndopts.nd_opts_src_lladdr,
+						 skb->dev);
 		if (!lladdr)
 			goto out;
 	}
@@ -1321,8 +1323,8 @@ skip_linkparms:
 	if (neigh) {
 		u8 *lladdr = NULL;
 		if (ndopts.nd_opts_src_lladdr) {
-			lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
-						     skb->dev);
+			lladdr = ndisc_dev_opt_addr_data(ndopts.nd_opts_src_lladdr,
+							 skb->dev);
 			if (!lladdr) {
 				ND_PRINTK(2, warn,
 					  "RA: invalid link-layer address length\n");
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 969913d..d662cd8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2207,8 +2207,8 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	lladdr = NULL;
 	if (ndopts.nd_opts_tgt_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr,
-					     skb->dev);
+		lladdr = ndisc_dev_opt_addr_data(ndopts.nd_opts_tgt_lladdr,
+						 skb->dev);
 		if (!lladdr) {
 			net_dbg_ratelimited("rt6_redirect: invalid link-layer address length\n");
 			return;
-- 
2.8.2

