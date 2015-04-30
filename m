Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34304 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbD3PqK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 11:46:10 -0400
Received: by wgso17 with SMTP id o17so67148241wgs.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Apr 2015 08:46:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/13] mac802154: fix ieee802154_register_hw error handling
Date: Thu, 30 Apr 2015 17:44:53 +0200
Message-Id: <1430408704-21815-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
References: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

Currently if ieee802154_if_add failed, we don't unregister the wpan phy
which was registered before. This patch adds a correct error handling
for unregister the wpan phy when ieee802154_if_add failed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 8500378..beece7b 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -166,13 +166,15 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 	if (IS_ERR(dev)) {
 		rtnl_unlock();
 		rc = PTR_ERR(dev);
-		goto out_wq;
+		goto out_phy;
 	}
 
 	rtnl_unlock();
 
 	return 0;
 
+out_phy:
+	wpan_phy_unregister(local->phy);
 out_wq:
 	destroy_workqueue(local->workqueue);
 out:
-- 
2.3.6

