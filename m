Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:57511 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNrD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:03 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so9285946lam.28
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:47:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:30 +0200
Message-Id: <1407937595-16415-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 07/12] mac802154: rx: use netif_receive_skb
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

To use netif_receive_skb or netif_rx_ni depends on context. We have a
tasklet which is the same like mac80211 and we should use the same
net rx delivery function netif_receive_skb.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 394601a..7c3af47 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -36,7 +36,7 @@
 
 static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
 {
-	return netif_rx_ni(skb);
+	return netif_receive_skb(skb);
 }
 
 static int
-- 
2.0.3

