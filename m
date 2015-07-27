Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37459 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbG0NGS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 09:06:18 -0400
Received: by wibud3 with SMTP id ud3so114990725wib.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 06:06:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 5/6] at86rf230: remove max_frame_retries -1 check
Date: Mon, 27 Jul 2015 15:06:18 +0200
Message-Id: <1438002379-17294-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438002379-17294-1-git-send-email-alex.aring@gmail.com>
References: <1438002379-17294-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Since we remove the max_frame_retries "-1" option from mac802154 stack
we don't need to check on such option as parameter.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 8b9557f..0bb52b2 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1268,12 +1268,8 @@ static int
 at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 {
 	struct at86rf230_local *lp = hw->priv;
-	int rc = 0;
 
-	if (retries >= 0)
-		rc = at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
-
-	return rc;
+	return at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
 }
 
 static int
-- 
2.4.6

