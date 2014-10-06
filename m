Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33712 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaJFJBs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 05:01:48 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so5854423wgh.21
        for <linux-wpan@vger.kernel.org>; Mon, 06 Oct 2014 02:01:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-next 3/3] ieee802154: 6lowpan: fix sign of errno return val
Date: Mon,  6 Oct 2014 11:00:52 +0200
Message-Id: <1412586052-27299-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch fix ERR_PTR(-rc) to ERR_PTR(rc). The variable rc is already a
negative errno value.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 8631206..45c3977 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -233,7 +233,7 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 				     &master_hdr->source, size);
 		if (rc < 0) {
 			kfree_skb(frag);
-			return ERR_PTR(-rc);
+			return ERR_PTR(rc);
 		}
 	} else {
 		frag = ERR_PTR(-ENOMEM);
-- 
2.1.2

