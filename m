Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38829 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbIUJZE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:04 -0400
Received: by wiclk2 with SMTP id lk2so102417909wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/22] mrf24j40: add random extended addr generation
Date: Mon, 21 Sep 2015 11:24:28 +0200
Message-Id: <1442827483-27975-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

The mrf24j40 has no source to get a permanent extended address. This
patch will add a random generated permanent extended address source.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 7c224cd..80b3c6e 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -722,6 +722,7 @@ err_ret:
 
 static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
 {
+	ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
 	devrec->hw->phy->current_channel = 11;
 }
 
-- 
2.5.2

