Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36834 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbbE1Gvi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 02:51:38 -0400
Received: by paza2 with SMTP id a2so16572988paz.3
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 23:51:37 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 3/3] cc2520: update current channel
Date: Thu, 28 May 2015 12:21:00 +0530
Message-Id: <1432795860-16462-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1432795860-16462-1-git-send-email-varkab@cdac.in>
References: <1432795860-16462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

This patch updates the current channel to 11. This is the default
value on reset.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 94347d4..2bc8e86 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -709,6 +709,7 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_powers);
 
 	priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[4];
+	priv->hw->phy->current_channel = 11;
 
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
-- 
1.7.9.5

