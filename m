Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61074 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaJZIhf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:35 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so4354486lbd.29
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:33 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 09/15] mac802154: tx: don't allow if down while sync tx
Date: Sun, 26 Oct 2014 09:37:09 +0100
Message-Id: <1414312635-19396-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch holds rtnl lock while sync xmit inside of workqueue.
Otherwise we could down the interface while worker xmit handling.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 1a4f6d9..4439041 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -21,6 +21,7 @@
 #include <linux/if_arp.h>
 #include <linux/crc-ccitt.h>
 
+#include <net/rtnetlink.h>
 #include <net/ieee802154_netdev.h>
 #include <net/mac802154.h>
 #include <net/cfg802154.h>
@@ -50,16 +51,28 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct sk_buff *skb = cb->skb;
 	int res;
 
+	rtnl_lock();
+
+	/* check if ifdown occurred while schedule */
+	if (!netif_running(skb->dev))
+		goto err_tx;
+
 	res = local->ops->xmit_sync(&local->hw, skb);
-	if (res) {
-		pr_debug("transmission failed\n");
-		/* Restart the netif queue on each sub_if_data object. */
-		ieee802154_wake_queue(&local->hw);
-		kfree_skb(skb);
-	} else {
-		/* Restart the netif queue on each sub_if_data object. */
-		ieee802154_xmit_complete(&local->hw, skb);
-	}
+	if (res)
+		goto err_tx;
+
+	ieee802154_xmit_complete(&local->hw, skb);
+
+	rtnl_unlock();
+
+	return;
+
+err_tx:
+	/* Restart the netif queue on each sub_if_data object. */
+	ieee802154_wake_queue(&local->hw);
+	rtnl_unlock();
+	kfree_skb(skb);
+	pr_debug("transmission failed\n");
 }
 
 static netdev_tx_t
-- 
2.1.2

