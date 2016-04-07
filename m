Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51117 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757370AbcDGSyi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 14:54:38 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 17/21] ndisc: add addr_len parameter to ndisc_fill_addr_option
Date: Thu,  7 Apr 2016 20:54:18 +0200
Message-Id: <1460055262-4330-18-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
References: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch makes the address length as argument for the
ndisc_fill_addr_option function. This is necessary to handle addresses
which don't use dev->addr_len as address length.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ipv6/ndisc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 4e91d5e..176c7c4 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -150,11 +150,11 @@ struct neigh_table nd_tbl = {
 };
 EXPORT_SYMBOL_GPL(nd_tbl);
 
-static void ndisc_fill_addr_option(struct sk_buff *skb, int type, void *data)
+static void ndisc_fill_addr_option(struct sk_buff *skb, int type, void *data,
+				   int data_len)
 {
 	int pad   = ndisc_addr_option_pad(skb->dev->type);
-	int data_len = skb->dev->addr_len;
-	int space = ndisc_opt_addr_space(skb->dev, skb->dev->addr_len);
+	int space = ndisc_opt_addr_space(skb->dev, data_len);
 	u8 *opt = skb_put(skb, space);
 
 	opt[0] = type;
@@ -528,7 +528,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 
 	if (inc_opt)
 		ndisc_fill_addr_option(skb, ND_OPT_TARGET_LL_ADDR,
-				       dev->dev_addr);
+				       dev->dev_addr, dev->addr_len);
 
 
 	ndisc_send_skb(skb, daddr, src_addr);
@@ -590,7 +590,7 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
 
 	if (inc_opt)
 		ndisc_fill_addr_option(skb, ND_OPT_SOURCE_LL_ADDR,
-				       dev->dev_addr);
+				       dev->dev_addr, dev->addr_len);
 
 	ndisc_send_skb(skb, daddr, saddr);
 }
@@ -641,7 +641,7 @@ void ndisc_send_rs(struct net_device *dev, const struct in6_addr *saddr,
 
 	if (send_sllao)
 		ndisc_fill_addr_option(skb, ND_OPT_SOURCE_LL_ADDR,
-				       dev->dev_addr);
+				       dev->dev_addr, dev->addr_len);
 
 	ndisc_send_skb(skb, daddr, saddr);
 }
@@ -1597,7 +1597,8 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	 */
 
 	if (ha)
-		ndisc_fill_addr_option(buff, ND_OPT_TARGET_LL_ADDR, ha);
+		ndisc_fill_addr_option(buff, ND_OPT_TARGET_LL_ADDR, ha,
+				       dev->addr_len);
 
 	/*
 	 *	build redirect option and copy skb over to the new packet.
-- 
2.8.0

