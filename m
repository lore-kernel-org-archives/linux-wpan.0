Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36785 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbbDMJJg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Apr 2015 05:09:36 -0400
Received: by wizk4 with SMTP id k4so63965980wiz.1
        for <linux-wpan@vger.kernel.org>; Mon, 13 Apr 2015 02:09:35 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: fix ieee802154_register_hw error handling
Date: Mon, 13 Apr 2015 11:08:59 +0200
Message-Id: <1428916139-18593-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Currently if ieee802154_if_add failed, we don't unregister the wpan phy
which was registrated before. This patch adds a correct error handling
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
2.3.5

