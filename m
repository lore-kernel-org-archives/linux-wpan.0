Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38829 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbbLNVaw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Dec 2015 16:30:52 -0500
Received: by wmpp66 with SMTP id p66so79070171wmp.1
        for <linux-wpan@vger.kernel.org>; Mon, 14 Dec 2015 13:30:50 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] adf7242: remove multiple returns
Date: Mon, 14 Dec 2015 22:30:44 +0100
Message-Id: <1450128644-9659-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>

This patch removes an unnecessary return inside the adf7242 driver.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/adf7242.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 89154c0..738b373 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1114,8 +1114,6 @@ static int adf7242_debugfs_init(struct adf7242_local *lp)
 					    lp->debugfs_root,
 					    adf7242_stats_show);
 	return PTR_ERR_OR_ZERO(stats);
-
-	return 0;
 }
 
 static const s32 adf7242_powers[] = {
-- 
2.6.1

