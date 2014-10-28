Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33815 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaJ1RWN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:13 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so1041184lbi.17
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 16/17] mac802154: cleanup open count handling
Date: Tue, 28 Oct 2014 18:21:31 +0100
Message-Id: <1414516892-4107-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the open_count variable increment in open and close
calls of netdev.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 1c0274e..c0bf5f9 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -166,19 +166,19 @@ static int mac802154_slave_open(struct net_device *dev)
 
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (local->open_count++ == 0) {
+	if (!local->open_count) {
 		res = drv_start(local);
 		WARN_ON(res);
 		if (res)
 			goto err;
 	}
 
+	local->open_count++;
 	netif_start_queue(dev);
 	return 0;
 err:
 	/* might already be clear but that doesn't matter */
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
-	sdata->local->open_count--;
 
 	return res;
 }
@@ -252,10 +252,11 @@ static int mac802154_slave_close(struct net_device *dev)
 	ASSERT_RTNL();
 
 	netif_stop_queue(dev);
+	local->open_count--;
 
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
-	if (!--local->open_count)
+	if (!local->open_count)
 		drv_stop(local);
 
 	return 0;
-- 
2.1.2

