Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57433 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932769AbcFOTVJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 15 Jun 2016 15:21:09 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv4 net-next 05/12] ndisc: add __ndisc_opt_addr_data function
Date: Wed, 15 Jun 2016 21:20:20 +0200
Message-Id: <20160615192027.4064-6-aar@pengutronix.de>
In-Reply-To: <20160615192027.4064-1-aar@pengutronix.de>
References: <20160615192027.4064-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

This patch adds __ndisc_opt_addr_data as low-level function for
ndisc_opt_addr_data which doesn't depend on net_device parameter.

Cc: David S. Miller <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: James Morris <jmorris@namei.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Patrick McHardy <kaber@trash.net>
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/ndisc.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 4cee826..c8962ad 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -138,17 +138,23 @@ static inline int ndisc_opt_addr_space(struct net_device *dev)
 				      ndisc_addr_option_pad(dev->type));
 }
 
-static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
-				      struct net_device *dev)
+static inline u8 *__ndisc_opt_addr_data(struct nd_opt_hdr *p,
+					unsigned char addr_len, int prepad)
 {
 	u8 *lladdr = (u8 *)(p + 1);
 	int lladdrlen = p->nd_opt_len << 3;
-	int prepad = ndisc_addr_option_pad(dev->type);
-	if (lladdrlen != ndisc_opt_addr_space(dev))
+	if (lladdrlen != __ndisc_opt_addr_space(addr_len, prepad))
 		return NULL;
 	return lladdr + prepad;
 }
 
+static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
+				      struct net_device *dev)
+{
+	return __ndisc_opt_addr_data(p, dev->addr_len,
+				     ndisc_addr_option_pad(dev->type));
+}
+
 static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, __u32 *hash_rnd)
 {
 	const u32 *p32 = pkey;
-- 
2.8.3

