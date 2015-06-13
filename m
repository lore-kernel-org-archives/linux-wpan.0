Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38494 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbFMUQD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 13 Jun 2015 16:16:03 -0400
Received: by wibdq8 with SMTP id dq8so43024084wib.1
        for <linux-wpan@vger.kernel.org>; Sat, 13 Jun 2015 13:16:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/4] mac802154: iface: flush workqueue before stop
Date: Sat, 13 Jun 2015 22:15:52 +0200
Message-Id: <1434226554-1450-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
References: <1434226554-1450-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch flushs the workqueue which is currently used for xmit_sync
callback before calling stop driver-ops. Flush the queue will ensure all
pending tx frames are transmitted.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index d804337..692731d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -308,6 +308,7 @@ static int mac802154_slave_close(struct net_device *dev)
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	if (!local->open_count) {
+		flush_workqueue(local->workqueue);
 		hrtimer_cancel(&local->ifs_timer);
 		drv_stop(local);
 	}
-- 
2.4.1

