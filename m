Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34741 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbE2F3B (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:29:01 -0400
Received: by pabru16 with SMTP id ru16so43220669pab.1
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:29:00 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 5/5] cc2520: update current channel
Date: Fri, 29 May 2015 10:56:58 +0530
Message-Id: <1432877218-12537-6-git-send-email-varkab@cdac.in>
In-Reply-To: <1432877218-12537-1-git-send-email-varkab@cdac.in>
References: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: bradjc5@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch updates the current channel to 11. This is the default
value on reset.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 2384c28..8141353 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -762,6 +762,8 @@ static int cc2520_register(struct cc2520_private *priv)
 		priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[0];
 	}
 
+	priv->hw->phy->current_channel = 11;
+
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
 	if (ret)
-- 
1.7.9.5

