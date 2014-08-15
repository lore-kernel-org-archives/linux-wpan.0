Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:42925 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbaHOKaG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:06 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so635263wib.17
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:04 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:46 +0200
Message-Id: <1408098592-13412-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 06/12] mac802154: tx: add drv_xmit to driver-ops
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a new helper for calling the xmit callback from
ieee802154_ops.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/driver-ops.h | 6 ++++++
 net/mac802154/tx.c         | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index edaf75f..00298d6 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -5,6 +5,12 @@
 
 #include "ieee802154_i.h"
 
+static inline int
+drv_xmit(struct ieee802154_local *local, struct sk_buff *skb)
+{
+	return local->ops->xmit(&local->hw, skb);
+}
+
 static inline int drv_start(struct ieee802154_local *local)
 {
 	might_sleep();
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index c748080..5dc32dd 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -30,6 +30,7 @@
 #include <net/wpan-phy.h>
 
 #include "ieee802154_i.h"
+#include "driver-ops.h"
 
 /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
  * packets through the workqueue.
@@ -52,7 +53,7 @@ static void mac802154_xmit_worker(struct work_struct *work)
 	struct sk_buff *skb = cb->skb;
 	int res;
 
-	res = local->ops->xmit(&cb->local->hw, skb);
+	res = drv_xmit(local, skb);
 	if (res)
 		pr_debug("transmission failed\n");
 
-- 
2.0.3

