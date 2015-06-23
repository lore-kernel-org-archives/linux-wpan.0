Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34605 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbFWGLl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 02:11:41 -0400
Received: by pabvl15 with SMTP id vl15so48174pab.1
        for <linux-wpan@vger.kernel.org>; Mon, 22 Jun 2015 23:11:40 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: use WARN_ON() macro
Date: Tue, 23 Jun 2015 11:41:03 +0530
Message-Id: <1435039863-27225-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch will generate the warning if the required driver ops
were not defined. Also it removes unnecessary debug message.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/mac802154/main.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 356b346..4caf04b 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -58,11 +58,9 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	struct ieee802154_local *local;
 	size_t priv_size;
 
-	if (!ops || !(ops->xmit_async || ops->xmit_sync) || !ops->ed ||
-	    !ops->start || !ops->stop || !ops->set_channel) {
-		pr_err("undefined IEEE802.15.4 device operations\n");
+	if (WARN_ON(!ops || !(ops->xmit_async || ops->xmit_sync) || !ops->ed ||
+		    !ops->start || !ops->stop || !ops->set_channel))
 		return NULL;
-	}
 
 	/* Ensure 32-byte alignment of our private data and hw private data.
 	 * We use the wpan_phy priv data for both our ieee802154_local and for
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
