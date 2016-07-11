Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33001 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580AbcGKTvV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:21 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 15/20] 6lowpan: iphc: override l2 packet information
Date: Mon, 11 Jul 2016 21:50:39 +0200
Message-Id: <20160711195044.25343-16-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

The skb->pkt_type need to be set by L2, but on 6LoWPAN there exists L2
e.g. BTLE which doesn't has multicast addressing. If it's a multicast or
not is detected by IPHC headers multicast bit. The IPv6 layer will
evaluate this pkt_type, so we force set this type while uncompressing.
Should be okay for 802.15.4 as well.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 79f1fa2..fb5f6fa 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -666,6 +666,8 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 
 	switch (iphc1 & (LOWPAN_IPHC_M | LOWPAN_IPHC_DAC)) {
 	case LOWPAN_IPHC_M | LOWPAN_IPHC_DAC:
+		skb->pkt_type = PACKET_BROADCAST;
+
 		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
 		if (!ci) {
@@ -681,11 +683,15 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 		break;
 	case LOWPAN_IPHC_M:
+		skb->pkt_type = PACKET_BROADCAST;
+
 		/* multicast */
 		err = lowpan_uncompress_multicast_daddr(skb, &hdr.daddr,
 							iphc1 & LOWPAN_IPHC_DAM_MASK);
 		break;
 	case LOWPAN_IPHC_DAC:
+		skb->pkt_type = PACKET_HOST;
+
 		spin_lock_bh(&lowpan_dev(dev)->ctx.lock);
 		ci = lowpan_iphc_ctx_get_by_id(dev, LOWPAN_IPHC_CID_DCI(cid));
 		if (!ci) {
@@ -701,6 +707,8 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		spin_unlock_bh(&lowpan_dev(dev)->ctx.lock);
 		break;
 	default:
+		skb->pkt_type = PACKET_HOST;
+
 		err = lowpan_iphc_uncompress_addr(skb, dev, &hdr.daddr,
 						  iphc1 & LOWPAN_IPHC_DAM_MASK,
 						  daddr);
-- 
2.9.0

