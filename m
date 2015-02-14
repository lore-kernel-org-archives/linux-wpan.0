Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34579 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbbBNW6D (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Feb 2015 17:58:03 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so19263661wiv.2
        for <linux-wpan@vger.kernel.org>; Sat, 14 Feb 2015 14:58:01 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: assign wait_for_completion_timeout to appropriately typed var
Date: Sat, 14 Feb 2015 23:57:48 +0100
Message-Id: <1423954668-21406-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Nicholas Mc Guire <hofrat@osadl.org>, Alexander Aring <alex.aring@gmail.com>

From: Nicholas Mc Guire <hofrat@osadl.org>

return type of wait_for_completion_timeout is unsigned long not int.
As rc is used here only for wait_for_completion_timeout the type is simply
changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7b051ea..cbfc8c5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -689,7 +689,7 @@ at86rf230_sync_state_change_complete(void *context)
 static int
 at86rf230_sync_state_change(struct at86rf230_local *lp, unsigned int state)
 {
-	int rc;
+	unsigned long rc;
 
 	at86rf230_async_state_change(lp, &lp->state, state,
 				     at86rf230_sync_state_change_complete,
-- 
2.3.0

