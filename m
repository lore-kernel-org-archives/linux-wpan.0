Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:60896 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757373AbaLJOdi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Dec 2014 09:33:38 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so3785671wgh.20
        for <linux-wpan@vger.kernel.org>; Wed, 10 Dec 2014 06:33:37 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/4] at86rf230: add reset state cca handling
Date: Wed, 10 Dec 2014 15:33:14 +0100
Message-Id: <1418221994-17976-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
References: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds the default cca setting after device reset for at86rf230
driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1ac46ba..0626e7d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1441,6 +1441,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
 			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
 
+	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
+
 	switch (part) {
 	case 2:
 		chip = "at86rf230";
-- 
2.1.3

