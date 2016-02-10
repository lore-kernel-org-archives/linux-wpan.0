Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.snt.utwente.nl ([130.89.149.33]:42958 "EHLO
	mx1.snt.utwente.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbcBJKuH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Feb 2016 05:50:07 -0500
Received: from bergzand.student.utwente.nl ([130.89.160.191])
	by mx1.snt.utwente.nl with esmtp (Exim 4.84)
	(envelope-from <hydrazine@bergzand.net>)
	id 1aTSLT-0000hb-KJ
	for linux-wpan@vger.kernel.org; Wed, 10 Feb 2016 11:50:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.bergzand.net (Postfix) with ESMTP id 17178594D7
	for <linux-wpan@vger.kernel.org>; Wed, 10 Feb 2016 11:50:38 +0100 (CET)
From: Koen Zandberg <koen@bergzand.net>
Subject: [PATCHv2 bluetooth-next] mac802154: Fixes kernel oops when unloading a radio driver
Date: Wed, 10 Feb 2016 11:49:38 +0100
Message-Id: <1455101378-2225-1-git-send-email-koen@bergzand.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Koen Zandberg <koen@bergzand.net>

Destroying the workqueue before unregistering the net device caused a
kernel oops

Signed-off-by: Koen Zandberg <koen@bergzand.net>
---
 net/mac802154/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index e8cab5b..87da85a 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -218,7 +218,6 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	tasklet_kill(&local->tasklet);
 	flush_workqueue(local->workqueue);
-	destroy_workqueue(local->workqueue);
 
 	rtnl_lock();
 
@@ -226,6 +225,7 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 
 	rtnl_unlock();
 
+	destroy_workqueue(local->workqueue);
 	wpan_phy_unregister(local->phy);
 }
 EXPORT_SYMBOL(ieee802154_unregister_hw);
-- 
2.4.10

