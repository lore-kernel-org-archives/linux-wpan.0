Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37211 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbaKBDTM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:12 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so3958345wib.1
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/16] at86rf230: fix page parameter constraints
Date: Sun,  2 Nov 2014 04:18:32 +0100
Message-Id: <1414898327-20759-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Since commit e37d2ec82a222f1819e7793a27bc052999a379fb ("mac802154: ops:
declare channel and page as u8") the page parameter can't be below zero.
This patch fix a kbuild test robot warning. Furthermore this check
should be removed and handled by netlink 802.15.4 interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9ad2d43..624080d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1047,7 +1047,7 @@ at86rf230_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
-	if (page < 0 || page > 31 ||
+	if (page > 31 ||
 	    !(lp->hw->phy->channels_supported[page] & BIT(channel))) {
 		WARN_ON(1);
 		return -EINVAL;
-- 
2.1.3

