Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37191 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2Uf6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:58 -0400
Received: by mail-wi0-f170.google.com with SMTP id q5so2540939wiv.1
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/17] mac802154: rx: remove unnecessary parameter
Date: Wed, 29 Oct 2014 21:34:35 +0100
Message-Id: <1414614884-20243-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes a not used parameter in ieee802154_deliver_skb.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 2aa80bd..51a55d9 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -29,7 +29,7 @@
 
 #include "ieee802154_i.h"
 
-static int ieee802154_deliver_skb(struct net_device *dev, struct sk_buff *skb)
+static int ieee802154_deliver_skb(struct sk_buff *skb)
 {
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	skb->protocol = htons(ETH_P_IEEE802154);
@@ -103,7 +103,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 	switch (mac_cb(skb)->type) {
 	case IEEE802154_FC_TYPE_DATA:
-		return ieee802154_deliver_skb(sdata->dev, skb);
+		return ieee802154_deliver_skb(skb);
 	default:
 		pr_warn("ieee802154: bad frame received (type = %d)\n",
 			mac_cb(skb)->type);
-- 
2.1.2

