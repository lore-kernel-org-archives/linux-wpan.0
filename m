Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33198 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbbEQTp6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:58 -0400
Received: by wgjc11 with SMTP id c11so3906725wgj.0
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 22/34] fakelb: creating two virtual phys per default
Date: Sun, 17 May 2015 21:44:58 +0200
Message-Id: <1431891910-32231-23-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch change the default virtual wpan phys of fakelb driver from
one to two. To have one virtual phy makes no sense, because it need at
least two virtual phy's to speak to each other.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 230f7da..cc1c7df 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -27,7 +27,7 @@
 #include <net/mac802154.h>
 #include <net/cfg802154.h>
 
-static int numlbs = 1;
+static int numlbs = 2;
 
 struct fakelb_dev_priv {
 	struct ieee802154_hw *hw;
-- 
2.3.7

