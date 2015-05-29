Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33701 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbbE2F2t (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:28:49 -0400
Received: by padbw4 with SMTP id bw4so43109049pad.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:28:49 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 2/5] cc2520: fix CC2591 handling
Date: Fri, 29 May 2015 10:56:55 +0530
Message-Id: <1432877218-12537-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1432877218-12537-1-git-send-email-varkab@cdac.in>
References: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: bradjc5@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch changes tha way of handling of cc2591-cc2520 combination
by moving amplified variable from platform data to private data.
This will be useful in other sections like tx power support.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Cc: Brad Campbell <bradjc5@gmail.com>
---
 drivers/net/ieee802154/cc2520.c |   10 ++++++++--
 include/linux/spi/cc2520.h      |    1 -
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index ea280d4..0d93537 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -196,6 +196,7 @@ struct cc2520_private {
 	u8 *buf;			/* SPI TX/Rx data buffer */
 	struct mutex buffer_mutex;	/* SPI buffer mutex */
 	bool is_tx;			/* Flag for sync b/w Tx and Rx */
+	bool amplified;			/* Flag for CC2591 */
 	int fifo_pin;			/* FIFO GPIO pin number */
 	struct work_struct fifop_irqwork;/* Workqueue for FIFOP */
 	spinlock_t lock;		/* Lock for is_tx*/
@@ -738,7 +739,9 @@ static int cc2520_get_platform_data(struct spi_device *spi,
 	pdata->vreg = of_get_named_gpio(np, "vreg-gpio", 0);
 	pdata->reset = of_get_named_gpio(np, "reset-gpio", 0);
 
-	pdata->amplified = of_property_read_bool(np, "amplified");
+	/* CC2591 front end for CC2520 */
+	if (of_property_read_bool(np, "amplified"))
+		priv->amplified = true;
 
 	return 0;
 }
@@ -781,7 +784,7 @@ static int cc2520_hw_init(struct cc2520_private *priv)
 	 * amplifier. See section 8 page 17 of TI application note AN065.
 	 * http://www.ti.com/lit/an/swra229a/swra229a.pdf
 	 */
-	if (pdata.amplified) {
+	if (priv->amplified) {
 		ret = cc2520_write_register(priv, CC2520_AGCCTRL1, 0x16);
 		if (ret)
 			goto err_ret;
@@ -896,6 +899,9 @@ static int cc2520_probe(struct spi_device *spi)
 	spin_lock_init(&priv->lock);
 	init_completion(&priv->tx_complete);
 
+	/* Assumption that CC2591 is not connected */
+	priv->amplified = false;
+
 	/* Request all the gpio's */
 	if (!gpio_is_valid(pdata.fifo)) {
 		dev_err(&spi->dev, "fifo gpio is not valid\n");
diff --git a/include/linux/spi/cc2520.h b/include/linux/spi/cc2520.h
index e741e8b..85b8ee6 100644
--- a/include/linux/spi/cc2520.h
+++ b/include/linux/spi/cc2520.h
@@ -21,7 +21,6 @@ struct cc2520_platform_data {
 	int sfd;
 	int reset;
 	int vreg;
-	bool amplified;
 };
 
 #endif
-- 
1.7.9.5

