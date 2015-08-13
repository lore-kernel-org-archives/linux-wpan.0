Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34612 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbHMMX1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Aug 2015 08:23:27 -0400
Received: by wicne3 with SMTP id ne3so256991521wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 13 Aug 2015 05:23:26 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 07/21] mrf24j40: add random extended addr generation
Date: Thu, 13 Aug 2015 14:22:34 +0200
Message-Id: <1439468568-22288-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

The mrf24j40 has no source to get a permanent extended address. This
patch will add a random generated permanent extended address source.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 4051310..e92b29a 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -722,6 +722,7 @@ err_ret:
 
 static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 {
+	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
 	devrec->hw->phy->current_channel = 11;
 }
 
-- 
2.5.0

