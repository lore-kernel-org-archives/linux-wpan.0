Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45478 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbaKLChy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:54 -0500
Received: by mail-wg0-f43.google.com with SMTP id y10so13170552wgg.16
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:53 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/18] ieee820154: remove valid page and channel checks
Date: Wed, 12 Nov 2014 03:36:56 +0100
Message-Id: <1415759825-8309-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes validation of page and channel while setting from
driver layer. This is already handled by nl802154 and mac802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 14 +-------------
 drivers/net/ieee802154/fakelb.c    |  3 ---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index ebcbeb3..f9e3bce 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1047,23 +1047,11 @@ at86rf230_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
-	if (page > 31 ||
-	    !(lp->hw->phy->channels_supported[page] & BIT(channel))) {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	rc = lp->data->set_channel(lp, page, channel);
-	if (rc < 0)
-		return rc;
-
 	/* Wait for PLL */
 	usleep_range(lp->data->t_channel_switch,
 		     lp->data->t_channel_switch + 10);
-	hw->phy->current_channel = channel;
-	hw->phy->current_page = page;
-
-	return 0;
+	return rc;
 }
 
 static int
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 6e62286..96947d7 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -58,9 +58,6 @@ fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	pr_debug("set channel to %d\n", channel);
 
-	hw->phy->current_page = page;
-	hw->phy->current_channel = channel;
-
 	return 0;
 }
 
-- 
2.1.3

