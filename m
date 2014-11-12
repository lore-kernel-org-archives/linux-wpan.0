Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:54708 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbaKLCiA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:38:00 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so12855750wgh.6
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:59 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/18] at86rf230: remove invalid max csma backoffs check
Date: Wed, 12 Nov 2014 03:37:02 +0100
Message-Id: <1415759825-8309-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the invalid check on max csma backoffs in driver
layer. This is already handled by nl802154 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 05d4f8f..aea00d3 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1167,9 +1167,6 @@ at86rf230_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
 	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
-	if (retries > 5)
-		return -EINVAL;
-
 	rc = at86rf230_write_subreg(lp, SR_MIN_BE, min_be);
 	if (rc)
 		return rc;
-- 
2.1.3

