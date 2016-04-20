Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50091 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753578AbcDTIUL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 Apr 2016 04:20:11 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 04/10] ndisc: add addr_len parameter to ndisc_opt_addr_space
Date: Wed, 20 Apr 2016 10:19:36 +0200
Message-Id: <1461140382-4784-5-git-send-email-aar@pengutronix.de>
In-Reply-To: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

This patch makes the address length as argument for the
ndisc_opt_addr_space function. This is necessary to handle addresses
which don't use dev->addr_len as address length.

Cc: David S. Miller <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: James Morris <jmorris@namei.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Patrick McHardy <kaber@trash.net>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/ndisc.h |  8 ++++----
 net/ipv6/ndisc.c    | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 2d8edaa..ef43e88 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -127,10 +127,10 @@ static inline int ndisc_addr_option_pad(unsigned short type)
 	}
 }
 
-static inline int ndisc_opt_addr_space(struct net_device *dev)
+static inline int ndisc_opt_addr_space(struct net_device *dev,
+				       unsigned char addr_len)
 {
-	return NDISC_OPT_SPACE(dev->addr_len +
-			       ndisc_addr_option_pad(dev->type));
+	return NDISC_OPT_SPACE(addr_len + ndisc_addr_option_pad(dev->type));
 }
 
 static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
@@ -139,7 +139,7 @@ static inline u8 *ndisc_opt_addr_data(struct nd_opt_hdr *p,
 	u8 *lladdr = (u8 *)(p + 1);
 	int lladdrlen = p->nd_opt_len << 3;
 	int prepad = ndisc_addr_option_pad(dev->type);
-	if (lladdrlen != ndisc_opt_addr_space(dev))
+	if (lladdrlen != ndisc_opt_addr_space(dev, dev->addr_len))
 		return NULL;
 	return lladdr + prepad;
 }
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index c245895..69e20e3 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -154,7 +154,7 @@ static void ndisc_fill_addr_option(struct sk_buff *skb, int type, void *data)
 {
 	int pad   = ndisc_addr_option_pad(skb->dev->type);
 	int data_len = skb->dev->addr_len;
-	int space = ndisc_opt_addr_space(skb->dev);
+	int space = ndisc_opt_addr_space(skb->dev, skb->dev->addr_len);
 	u8 *opt = skb_put(skb, space);
 
 	opt[0] = type;
@@ -509,7 +509,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 	if (!dev->addr_len)
 		inc_opt = 0;
 	if (inc_opt)
-		optlen += ndisc_opt_addr_space(dev);
+		optlen += ndisc_opt_addr_space(dev, dev->addr_len);
 
 	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
 	if (!skb)
@@ -574,7 +574,7 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
 	if (ipv6_addr_any(saddr))
 		inc_opt = false;
 	if (inc_opt)
-		optlen += ndisc_opt_addr_space(dev);
+		optlen += ndisc_opt_addr_space(dev, dev->addr_len);
 
 	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
 	if (!skb)
@@ -626,7 +626,7 @@ void ndisc_send_rs(struct net_device *dev, const struct in6_addr *saddr,
 	}
 #endif
 	if (send_sllao)
-		optlen += ndisc_opt_addr_space(dev);
+		optlen += ndisc_opt_addr_space(dev, dev->addr_len);
 
 	skb = ndisc_alloc_skb(dev, sizeof(*msg) + optlen);
 	if (!skb)
@@ -1563,7 +1563,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 			memcpy(ha_buf, neigh->ha, dev->addr_len);
 			read_unlock_bh(&neigh->lock);
 			ha = ha_buf;
-			optlen += ndisc_opt_addr_space(dev);
+			optlen += ndisc_opt_addr_space(dev, dev->addr_len);
 		} else
 			read_unlock_bh(&neigh->lock);
 
-- 
2.8.0

