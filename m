Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.51.6]:15481 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757861AbdEWSd4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 23 May 2017 14:33:56 -0400
Received: from cm1.websitewelcome.com (unknown [192.185.0.102])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id DC026400EF017
        for <linux-wpan@vger.kernel.org>; Tue, 23 May 2017 13:11:49 -0500 (CDT)
Date: Tue, 23 May 2017 13:11:47 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] net: ieee802154: fix potential null pointer dereference
Message-ID: <20170523181147.GA32714@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Null check at line 918: if (!spi) {, implies spi might be NULL.
Function spi_get_drvdata() dereference pointer spi.
Move pointer priv assignment after the null check.

Addresses-Coverity-ID: 1408888
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/net/ieee802154/ca8210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 25fd3b0..ccaf20d 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -912,7 +912,7 @@ static int ca8210_spi_transfer(
 )
 {
 	int i, status = 0;
-	struct ca8210_priv *priv = spi_get_drvdata(spi);
+	struct ca8210_priv *priv;
 	struct cas_control *cas_ctl;
 
 	if (!spi) {
@@ -923,6 +923,7 @@ static int ca8210_spi_transfer(
 		return -ENODEV;
 	}
 
+	priv = spi_get_drvdata(spi);
 	reinit_completion(&priv->spi_transfer_complete);
 
 	dev_dbg(&spi->dev, "ca8210_spi_transfer called\n");
-- 
2.5.0

