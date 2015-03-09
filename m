Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:44496 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbCIM4Y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 08:56:24 -0400
Received: by wivr20 with SMTP id r20so20105585wiv.3
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 05:56:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] at86rf230: fix volatile regmap registers
Date: Mon,  9 Mar 2015 13:56:12 +0100
Message-Id: <1425905772-28560-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
References: <1425905772-28560-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

These registers are also changed by transceiver and should be volatile
for right accessing via regmap debugfs.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 3b81c62..51b88fd 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -421,6 +421,8 @@ at86rf230_reg_volatile(struct device *dev, unsigned int reg)
 	case RG_PHY_ED_LEVEL:
 	case RG_IRQ_STATUS:
 	case RG_VREG_CTRL:
+	case RG_PLL_CF:
+	case RG_PLL_DCU:
 		return true;
 	default:
 		return false;
-- 
2.3.0

