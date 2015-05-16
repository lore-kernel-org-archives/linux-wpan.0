Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32853 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbEPP1L (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:11 -0400
Received: by wicmx19 with SMTP id mx19so59054866wic.0
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:27:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 10/13] fakelb: add virtual phy reset defaults
Date: Sat, 16 May 2015 17:26:14 +0200
Message-Id: <1431789977-31393-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
References: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

This patch adds reset defaults for the fakelb phy. I used the channel 13
and page 0 which is the same default like at86rf233.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index e435d7b..8b3f65c 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -173,6 +173,11 @@ static int fakelb_add_one(struct device *dev)
 	/* 950 MHz GFSK 802.15.4d-2009 */
 	hw->phy->channels_supported[6] |= 0x3ffc00;
 
+	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
+	/* fake phy channel 13 as default */
+	hw->phy->current_channel = 13;
+	phy->channel = hw->phy->current_channel;
+
 	hw->parent = dev;
 
 	err = ieee802154_register_hw(hw);
-- 
2.3.7

