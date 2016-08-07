Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39923 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745AbcHGOdC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 01/19] ieee802154: 6lowpan: remove headroom check
Date: Sun,  7 Aug 2016 16:30:38 +0200
Message-Id: <20160807143056.3116-2-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch removes unnessary headroom check. We will check that value
while register net device that we have such headroom for placing address
information at the headroom of skb.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ieee802154/6lowpan/tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index dbb476d..a7a1b12 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -26,7 +26,6 @@ struct lowpan_addr_info {
 static inline struct
 lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
 {
-	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
 	return (struct lowpan_addr_info *)(skb->data -
 			sizeof(struct lowpan_addr_info));
 }
-- 
2.9.2

