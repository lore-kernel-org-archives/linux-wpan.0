Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34155 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbHELDD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Aug 2015 07:03:03 -0400
Received: by wibcd8 with SMTP id cd8so18530515wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 05 Aug 2015 04:03:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv4 bluetooth-next 5/6] at86rf230: remove frame_retries -1 check
Date: Wed,  5 Aug 2015 13:03:21 +0200
Message-Id: <1438772602-9877-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438772602-9877-1-git-send-email-alex.aring@gmail.com>
References: <1438772602-9877-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Since we remove the frame_retries "-1" option from mac802154 stack
we don't need to check on such option as parameter.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 06f7eaa..48b45c5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1270,12 +1270,8 @@ static int
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

