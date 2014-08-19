Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:40525 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbaHSJDQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 05:03:16 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth 2/5] ieee802154: 6lowpan_rtnl: fix correct errno value
Date: Tue, 19 Aug 2014 11:03:00 +0200
Message-Id: <1408438983-13892-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
References: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch correct the return value of lowpan_alloc_frag if an error
occur. Errno numbers should always be negative.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 016b77e..71fa7d4 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -246,7 +246,7 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
 			return ERR_PTR(-rc);
 		}
 	} else {
-		frag = ERR_PTR(ENOMEM);
+		frag = ERR_PTR(-ENOMEM);
 	}
 
 	return frag;
-- 
2.0.3

