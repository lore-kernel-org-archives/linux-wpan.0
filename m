Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.snt.utwente.nl ([130.89.149.33]:42871 "EHLO
	mx1.snt.utwente.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757932AbcBBV0S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Feb 2016 16:26:18 -0500
Received: from bergzand.student.utwente.nl ([130.89.160.191])
	by mx1.snt.utwente.nl with esmtp (Exim 4.72)
	(envelope-from <hydrazine@bergzand.net>)
	id 1aQiSk-000133-OX
	for linux-wpan@vger.kernel.org; Tue, 02 Feb 2016 22:26:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.bergzand.net (Postfix) with ESMTP id 3F7F058CC6
	for <linux-wpan@vger.kernel.org>; Tue,  2 Feb 2016 22:26:43 +0100 (CET)
From: Koen Zandberg <koen@bergzand.net>
Subject: [PATCH bluetooth-next] Fixes kernel oops when unloading the radio module
Date: Tue,  2 Feb 2016 22:26:04 +0100
Message-Id: <1454448364-22417-1-git-send-email-koen@bergzand.net>
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

