Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35927 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbbDMJqo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Apr 2015 05:46:44 -0400
Received: by wgsk9 with SMTP id k9so74559469wgs.3
        for <linux-wpan@vger.kernel.org>; Mon, 13 Apr 2015 02:46:43 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next] mac802154: fix ieee802154_register_hw error handling
Date: Mon, 13 Apr 2015 11:46:32 +0200
Message-Id: <1428918392-19840-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Currently if ieee802154_if_add failed, we don't unregister the wpan phy
which was registered before. This patch adds a correct error handling
for unregister the wpan phy when ieee802154_if_add failed.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 - fix typo 's/registrated/registered/' in commit msg

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

