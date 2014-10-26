Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34911 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaJZIhc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:37:32 -0400
Received: by mail-lb0-f180.google.com with SMTP id z12so900753lbi.11
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:37:31 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 07/15] mac802154: tx: fix error handling while xmit
Date: Sun, 26 Oct 2014 09:37:07 +0100
Message-Id: <1414312635-19396-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
References: <1414312635-19396-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

In case of an error we should call kfree_skb instead of consume_skb which
is called by ieee802154_xmit_complete function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 8e2f429..23139ca 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -51,11 +51,15 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	int res;
 
 	res = local->ops->xmit(&local->hw, skb);
-	if (res)
+	if (res) {
 		pr_debug("transmission failed\n");
-
-	/* Restart the netif queue on each sub_if_data object. */
-	ieee802154_xmit_complete(&local->hw, skb);
+		/* Restart the netif queue on each sub_if_data object. */
+		ieee802154_wake_queue(&local->hw);
+		kfree_skb(skb);
+	} else {
+		/* Restart the netif queue on each sub_if_data object. */
+		ieee802154_xmit_complete(&local->hw, skb);
+	}
 }
 
 static netdev_tx_t
-- 
2.1.2

