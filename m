Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45476 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756148AbcBSI7S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 19 Feb 2016 03:59:18 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 5/5] mrf24j40: add writeable missing reg
Date: Fri, 19 Feb 2016 09:59:14 +0100
Message-Id: <1455872354-26032-5-git-send-email-aar@pengutronix.de>
In-Reply-To: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
References: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Alan Ott <alan@signal11.us>

This patch adds a missing reg for writeable stuff for regmap.

Cc: Alan Ott <alan@signal11.us>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 drivers/net/ieee802154/mrf24j40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 4cdf516..764a2bd 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -310,6 +310,7 @@ mrf24j40_short_reg_writeable(struct device *dev, unsigned int reg)
 	case REG_TRISGPIO:
 	case REG_GPIO:
 	case REG_RFCTL:
+	case REG_SECCR2:
 	case REG_SLPACK:
 	case REG_BBREG0:
 	case REG_BBREG1:
-- 
2.7.1

