Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35544 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbEQTqI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:46:08 -0400
Received: by wgfl8 with SMTP id l8so13367303wgf.2
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:46:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 31/34] fakelb: add virtual phy reset defaults
Date: Sun, 17 May 2015 21:45:07 +0200
Message-Id: <1431891910-32231-32-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

This patch adds reset defaults for the fakelb phy. I used the channel 13
and page 0 which is the same default like at86rf233.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index c60837e..d693a53 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -173,6 +173,11 @@ static int fakelb_add_one(struct device *dev)
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->supported.channels[6] |= 0x3ffc00;
 
+	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
+	/* fake phy channel 13 as default */
+	hw->phy->current_channel = 13;
+	phy->channel = hw->phy->current_channel;
+
 	hw->parent = dev;
 
 	err = ieee802154_register_hw(hw);
-- 
2.3.7

