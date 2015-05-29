Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36540 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbE2F25 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:28:57 -0400
Received: by pacux9 with SMTP id ux9so1596205pac.3
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:28:56 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 4/5] cc2520: update initial transmit power value
Date: Fri, 29 May 2015 10:56:57 +0530
Message-Id: <1432877218-12537-5-git-send-email-varkab@cdac.in>
In-Reply-To: <1432877218-12537-1-git-send-email-varkab@cdac.in>
References: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: bradjc5@gmail.com, Varka Bhadram <varkab@cdac.in>

CC2520 has the default 0dBm transmit power level  on reset.
This patch update initial value of transmit power with 0dBm value.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Cc: Brad Campbell <bradjc5@gmail.com>
---
 drivers/net/ieee802154/cc2520.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 36a4f31..2384c28 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -755,9 +755,11 @@ static int cc2520_register(struct cc2520_private *priv)
 	if (!priv->amplified) {
 		priv->hw->phy->supported.tx_powers = cc2520_powers;
 		priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_powers);
+		priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[4];
 	} else {
 		priv->hw->phy->supported.tx_powers = cc2520_cc2591_powers;
 		priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_cc2591_powers);
+		priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[0];
 	}
 
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
-- 
1.7.9.5

