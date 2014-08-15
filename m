Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43279 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbaHOKaH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:07 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so650804wiv.7
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:47 +0200
Message-Id: <1408098592-13412-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 07/12] mac802154: tx: fix error handling on xmit
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

If error occur we should call kfree_skb instead of dev_kfree_skb or
consume_skb.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 5dc32dd..cae6fb5 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -54,8 +54,12 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	int res;
 
 	res = drv_xmit(local, skb);
-	if (res)
+	if (res) {
 		pr_debug("transmission failed\n");
+		ieee802154_wake_queue(&local->hw);
+		kfree_skb(skb);
+		return;
+	}
 
 	/* Restart the netif queue on each sub_if_data object. */
 	ieee802154_xmit_complete(&local->hw, skb);
-- 
2.0.3

