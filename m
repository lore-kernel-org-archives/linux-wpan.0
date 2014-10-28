Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35425 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbaJ1RWK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:10 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so1022330lab.41
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/17] mac802154: add synchronization handling
Date: Tue, 28 Oct 2014 18:21:27 +0100
Message-Id: <1414516892-4107-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds synchronization handling in start and stop driver ops
calls. This patch is mostly grab from mac80211 which was introduced by
commit ea77f12f2cc0f31168f2e0259e65a22202ac4dc2 ("mac80211: remove
tasklet enable/disable"). This is to be sure that we don't run into same
issues.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/driver-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index bb3ee03..4b820cf 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -30,6 +30,7 @@ static inline int drv_start(struct ieee802154_local *local)
 	might_sleep();
 
 	local->started = true;
+	smp_mb();
 
 	return local->ops->start(&local->hw);
 }
@@ -40,6 +41,12 @@ static inline void drv_stop(struct ieee802154_local *local)
 
 	local->ops->stop(&local->hw);
 
+	/* sync away all work on the tasklet before clearing started */
+	tasklet_disable(&local->tasklet);
+	tasklet_enable(&local->tasklet);
+
+	barrier();
+
 	local->started = false;
 }
 
-- 
2.1.2

