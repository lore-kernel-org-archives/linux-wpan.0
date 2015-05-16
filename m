Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37501 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbbEPP1B (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:01 -0400
Received: by wibt6 with SMTP id t6so23971716wib.0
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 01/13] fakelb: creating two virtual phys per default
Date: Sat, 16 May 2015 17:26:05 +0200
Message-Id: <1431789977-31393-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch change the default virtual wpan phys of fakelb driver from
one to two. To have one virtual phy makes no sense, because it need at
least two virtual phy's to speak to each other.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index baa8d36..0fe42b0 100644
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

