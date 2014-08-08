Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:53780 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbaHHGZD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 02:25:03 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so5168731wes.38
        for <linux-wpan@vger.kernel.org>; Thu, 07 Aug 2014 23:25:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri,  8 Aug 2014 08:24:39 +0200
Message-Id: <1407479079-5114-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next] 6lowpan_rtnl: fix correct return of errno value
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 0acd273..b6ec3b1 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -238,7 +238,7 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 			return ERR_PTR(-rc);
 		}
 	} else {
-		frag = ERR_PTR(ENOMEM);
+		frag = ERR_PTR(-ENOMEM);
 	}
 
 	return frag;
-- 
2.0.3

