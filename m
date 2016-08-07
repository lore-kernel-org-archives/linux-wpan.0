Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33685 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047AbcHGOdF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:05 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 14/19] 6lowpan: iphc: override l2 packet information
Date: Sun,  7 Aug 2016 16:30:51 +0200
Message-Id: <20160807143056.3116-15-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

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
2.9.2

