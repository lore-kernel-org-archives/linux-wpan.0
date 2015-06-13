Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35184 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbFMUQD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 13 Jun 2015 16:16:03 -0400
Received: by wiga1 with SMTP id a1so42795951wig.0
        for <linux-wpan@vger.kernel.org>; Sat, 13 Jun 2015 13:16:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/4] mac802154: iface: fix hrtimer cancel on ifdown
Date: Sat, 13 Jun 2015 22:15:51 +0200
Message-Id: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The interframe spacing timer is a per phy definition and is part of a
ieee802154_local structure. If we have possible multiple interfaces
ifdown one interface then the timer should not be cancled. First if the
last interface is down and the receive handling is stopped we should be
sure that the interframe spacing timer isn't run anymore.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index e3d77b0..d804337 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -302,15 +302,15 @@ static int mac802154_slave_close(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	hrtimer_cancel(&local->ifs_timer);
-
 	netif_stop_queue(dev);
 	local->open_count--;
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (!local->open_count)
+	if (!local->open_count) {
+		hrtimer_cancel(&local->ifs_timer);
 		drv_stop(local);
+	}
 
 	return 0;
 }
-- 
2.4.1

