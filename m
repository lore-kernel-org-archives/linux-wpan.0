Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38736 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbABOt6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Jan 2015 09:49:58 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so27827222wid.15
        for <linux-wpan@vger.kernel.org>; Fri, 02 Jan 2015 06:49:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: fix kbuild test robot warning
Date: Fri,  2 Jan 2015 15:49:41 +0100
Message-Id: <1420210181-9228-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixs the following kbuild test robot warning:

coccinelle warnings: (new ones prefixed by >>)

>> net/mac802154/cfg.c:53:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
To return net_device here is for supporting still the deprecated functionality.
When we remove the old netlink interface we will change the return type to int.

 net/mac802154/cfg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 7d31da5..5d9f68c 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -51,10 +51,7 @@ ieee802154_add_iface(struct wpan_phy *phy, const char *name,
 	struct net_device *err;
 
 	err = ieee802154_if_add(local, name, type, extended_addr);
-	if (IS_ERR(err))
-		return PTR_ERR(err);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(err);
 }
 
 static int
-- 
2.2.1

