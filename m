Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59412 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbaKLCh6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:58 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so13027533wgg.17
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:57 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/18] at86rf230: remove invalid backoff exponent check
Date: Wed, 12 Nov 2014 03:37:00 +0100
Message-Id: <1415759825-8309-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the invalid backoff exponent check from driver layer.
This is already handled by nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f9e3bce..05d4f8f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1167,7 +1167,7 @@ at86rf230_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
 	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
-	if (min_be > max_be || max_be > 8 || retries > 5)
+	if (retries > 5)
 		return -EINVAL;
 
 	rc = at86rf230_write_subreg(lp, SR_MIN_BE, min_be);
-- 
2.1.3

