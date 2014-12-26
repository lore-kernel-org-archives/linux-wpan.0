Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:60133 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLZEsK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Dec 2014 23:48:10 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so12472372pac.8
        for <linux-wpan@vger.kernel.org>; Thu, 25 Dec 2014 20:48:10 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 3/3] cc2520: fix zero perm_extended_addr address
Date: Fri, 26 Dec 2014 10:13:40 +0530
Message-Id: <1419569020-5410-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1419569020-5410-1-git-send-email-varkab@cdac.in>
References: <1419569020-5410-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

It will remove the bug of havine zero perm_extended_addr address.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/cc2520.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 8344260..29bf329 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -651,6 +651,7 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->parent = &priv->spi->dev;
 	priv->hw->extra_tx_headroom = 0;
 	priv->hw->vif_data_size = sizeof(*priv);
+	ieee802154_random_extended_addr(&priv->hw->phy->perm_extended_addr);
 
 	/* We do support only 2.4 Ghz */
 	priv->hw->phy->channels_supported[0] = 0x7FFF800;
-- 
1.7.9.5

