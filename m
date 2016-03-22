Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41274 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758927AbcCVNPp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:45 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 15/19] ndisc: add addr_len parameter to ndisc_opt_addr_data
Date: Tue, 22 Mar 2016 14:15:11 +0100
Message-Id: <1458652515-7862-16-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch makes the address length as argument for the
ndisc_opt_addr_data function. This is necessary to handle addresses
which don't use dev->addr_len as address length.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/ndisc.h |  5 +++--
 net/ipv6/ndisc.c    | 11 +++++++----
 net/ipv6/route.c    |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index ef43e88..aac868e 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -134,12 +134,13 @@ static inline int ndisc_opt_addr_space(struct net_device *dev,
 }
 
 static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
-				      struct net_device *dev)
+				      struct net_device *dev,
+				      unsigned char addr_len)
 {
 	u8 *lladdr = (u8 *)(p + 1);
 	int lladdrlen = p->nd_opt_len << 3;
 	int prepad = ndisc_addr_option_pad(dev->type);
-	if (lladdrlen != ndisc_opt_addr_space(dev, dev->addr_len))
+	if (lladdrlen != ndisc_opt_addr_space(dev, addr_len))
 		return NULL;
 	return lladdr + prepad;
 }
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 69e20e3..4e91d5e 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -744,7 +744,8 @@ static void ndisc_recv_ns(struct sk_buff *skb)
 	}
 
 	if (ndopts.nd_opts_src_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr, dev);
+		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr, dev,
+					     dev->addr_len);
 		if (!lladdr) {
 			ND_PRINTK(2, warn,
 				  "NS: invalid link-layer address length\n");
@@ -916,7 +917,8 @@ static void ndisc_recv_na(struct sk_buff *skb)
 		return;
 	}
 	if (ndopts.nd_opts_tgt_lladdr) {
-		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev);
+		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr, dev,
+					     dev->addr_len);
 		if (!lladdr) {
 			ND_PRINTK(2, warn,
 				  "NA: invalid link-layer address length\n");
@@ -1024,7 +1026,7 @@ static void ndisc_recv_rs(struct sk_buff *skb)
 
 	if (ndopts.nd_opts_src_lladdr) {
 		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
-					     skb->dev);
+					     skb->dev, skb->dev->addr_len);
 		if (!lladdr)
 			goto out;
 	}
@@ -1322,7 +1324,8 @@ skip_linkparms:
 		u8 *lladdr = NULL;
 		if (ndopts.nd_opts_src_lladdr) {
 			lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr,
-						     skb->dev);
+						     skb->dev,
+						     skb->dev->addr_len);
 			if (!lladdr) {
 				ND_PRINTK(2, warn,
 					  "RA: invalid link-layer address length\n");
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ed44663..cc180b3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2157,7 +2157,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	lladdr = NULL;
 	if (ndopts.nd_opts_tgt_lladdr) {
 		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_tgt_lladdr,
-					     skb->dev);
+					     skb->dev, skb->dev->addr_len);
 		if (!lladdr) {
 			net_dbg_ratelimited("rt6_redirect: invalid link-layer address length\n");
 			return;
-- 
2.7.4

