Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:55193 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbaKLCiD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:38:03 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so13043021wgh.14
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:38:01 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 17/18] at86rf230: remove invalid max frame retries check
Date: Wed, 12 Nov 2014 03:37:04 +0100
Message-Id: <1415759825-8309-18-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the invalid max frame retries check from driver
layer. This is already handled by nl802154 framework. Also the IEEE
802.15.4 standard doesn't allow a frame retries setting above 7. This
seems to be valid for the at86rf230 transceiver but the chip running out
of spec then. We only allow settings according 802.15.4 right now.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index aea00d3..31d62f9 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1184,9 +1184,6 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 	struct at86rf230_local *lp = hw->priv;
 	int rc = 0;
 
-	if (retries < -1 || retries > 15)
-		return -EINVAL;
-
 	lp->tx_aret = retries >= 0;
 	lp->max_frame_retries = retries;
 
-- 
2.1.3

