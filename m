Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35854 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbJCEoI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Oct 2015 00:44:08 -0400
Received: by pablk4 with SMTP id lk4so123211562pab.3
        for <linux-wpan@vger.kernel.org>; Fri, 02 Oct 2015 21:44:07 -0700 (PDT)
From: =?UTF-8?q?J=CE=B5an=20Sacren?= <sakiwit@gmail.com>
Subject: [PATCH bluetooth-next] nl802154: fix rtnl_unlock() being missing
Date: Fri,  2 Oct 2015 22:46:52 -0600
Message-Id: <1443847612-8933-1-git-send-email-sakiwit@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

From: Jean Sacren <sakiwit@gmail.com>

In nl802154_prepare_wpan_dev_dump(), rtnl_unlock() was missing if it
returns 0. If we insert rtnl_unlock() mechanically, we will have
unbearable code duplication. Fix this bug by unifying exit paths.

Following the new exit path, clean up now the obsolete goto statement.

Fixes: a26c5fd7622d ("nl802154: add support for security layer")
Signed-off-by: Jean Sacren <sakiwit@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 1e9e86508441..0074f13ea4ca 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -253,7 +253,7 @@ nl802154_prepare_wpan_dev_dump(struct sk_buff *skb,
 			       struct cfg802154_registered_device **rdev,
 			       struct wpan_dev **wpan_dev)
 {
-	int err;
+	int err = 0;
 
 	rtnl_lock();
 
@@ -293,13 +293,10 @@ nl802154_prepare_wpan_dev_dump(struct sk_buff *skb,
 			}
 		}
 
-		if (!*wpan_dev) {
+		if (!*wpan_dev)
 			err = -ENODEV;
-			goto out_unlock;
-		}
 	}
 
-	return 0;
  out_unlock:
 	rtnl_unlock();
 	return err;
