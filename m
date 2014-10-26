Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:55141 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaJZIhg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:36 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so4293692lbv.21
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 10/15] mac802154: tx: use netdev print helpers
Date: Sun, 26 Oct 2014 09:37:10 +0100
Message-Id: <1414312635-19396-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replace the pr_foo printout function to netdev_foo printout
function. Inside the xmit handling, the interface is already known.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 4439041..d39c7d9 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -72,7 +72,7 @@ err_tx:
 	ieee802154_wake_queue(&local->hw);
 	rtnl_unlock();
 	kfree_skb(skb);
-	pr_debug("transmission failed\n");
+	netdev_dbg(skb->dev, "transmission failed\n");
 }
 
 static netdev_tx_t
@@ -137,7 +137,7 @@ netdev_tx_t mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
 	if (rc) {
-		pr_warn("encryption failed: %i\n", rc);
+		netdev_warn(dev, "encryption failed: %i\n", rc);
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
 	}
-- 
2.1.2

