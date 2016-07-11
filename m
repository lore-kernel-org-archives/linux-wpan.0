Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48900 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752193AbcGKTvR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:17 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 03/20] ieee802154: 6lowpan: remove headroom check
Date: Mon, 11 Jul 2016 21:50:27 +0200
Message-Id: <20160711195044.25343-4-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

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
2.9.0

