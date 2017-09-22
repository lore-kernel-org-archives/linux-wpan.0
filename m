Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54879 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdIVMO0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:26 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 10/14] ieee802154: ca8210: use __func__ macro for debug messages
Date: Fri, 22 Sep 2017 14:14:01 +0200
Message-Id: <20170922121405.31789-11-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Instead of having the function name hard-coded (it might change and we
forgot to update them in the debug output) we can use __func__ instead
and also shorter the line so we do not need to break it.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/ca8210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 66829055aa8b..26e04c9176a4 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -924,7 +924,7 @@ static int ca8210_spi_transfer(
 	priv = spi_get_drvdata(spi);
 	reinit_completion(&priv->spi_transfer_complete);
 
-	dev_dbg(&spi->dev, "ca8210_spi_transfer called\n");
+	dev_dbg(&spi->dev, "%s called\n", __func__);
 
 	cas_ctl = kmalloc(sizeof(*cas_ctl), GFP_ATOMIC);
 	if (!cas_ctl)
@@ -1898,7 +1898,7 @@ static int ca8210_net_rx(struct ieee802154_hw *hw, u8 *command, size_t len)
 	unsigned long flags;
 	u8 status;
 
-	dev_dbg(&priv->spi->dev, "ca8210_net_rx(), CmdID = %d\n", command[0]);
+	dev_dbg(&priv->spi->dev, "%s: CmdID = %d\n", __func__, command[0]);
 
 	if (command[0] == SPI_MCPS_DATA_INDICATION) {
 		/* Received data */
@@ -1948,7 +1948,7 @@ static int ca8210_skb_tx(
 	struct secspec secspec;
 	unsigned int mac_len;
 
-	dev_dbg(&priv->spi->dev, "ca8210_skb_tx() called\n");
+	dev_dbg(&priv->spi->dev, "%s called\n", __func__);
 
 	/* Get addressing info from skb - ieee802154 layer creates a full
 	 * packet
@@ -2051,7 +2051,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct ca8210_priv *priv = hw->priv;
 	int status;
 
-	dev_dbg(&priv->spi->dev, "calling ca8210_xmit_async()\n");
+	dev_dbg(&priv->spi->dev, "calling %s\n", __func__);
 
 	priv->tx_skb = skb;
 	priv->async_tx_pending = true;
-- 
2.13.5

