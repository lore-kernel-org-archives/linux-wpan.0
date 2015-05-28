Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34537 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbbE1Gve (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 02:51:34 -0400
Received: by pdbki1 with SMTP id ki1so35084124pdb.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 23:51:34 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 2/3] cc2520: update initial transmit power value
Date: Thu, 28 May 2015 12:20:59 +0530
Message-Id: <1432795860-16462-2-git-send-email-varkab@cdac.in>
In-Reply-To: <1432795860-16462-1-git-send-email-varkab@cdac.in>
References: <1432795860-16462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

CC2520 has the default 0dBm transmit power level  on reset.
This patch update initial value of transmit power with 0dBm value.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index a20e6d4..94347d4 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -708,6 +708,8 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->phy->supported.tx_powers = cc2520_powers;
 	priv->hw->phy->supported.tx_powers_size = ARRAY_SIZE(cc2520_powers);
 
+	priv->hw->phy->transmit_power = priv->hw->phy->supported.tx_powers[4];
+
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
 	if (ret)
-- 
1.7.9.5

