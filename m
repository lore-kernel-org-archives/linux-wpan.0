Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34394 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbbG3I5N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 04:57:13 -0400
Received: by wibud3 with SMTP id ud3so12153019wib.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Jul 2015 01:57:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv3 bluetooth-next 5/6] at86rf230: remove max_frame_retries -1 check
Date: Thu, 30 Jul 2015 10:55:41 +0200
Message-Id: <1438246542-17633-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
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
2.5.0

