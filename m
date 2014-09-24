Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63627 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbaIXKWI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 06:22:08 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/4] mrf24j40: use pr_* / dev_* instead of printk()
Date: Wed, 24 Sep 2014 12:21:32 +0200
Message-Id: <1411554093-14976-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkabhadram@gmail.com>, Varka Bhadram <varkab@cdac.in>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkabhadram@gmail.com>

Replace printk() with dev_*() pr_*().

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Acked-by: Alan Ott <alan@signal11.us>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/mrf24j40.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 2c617e3..07e0b88 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -323,8 +323,8 @@ static int mrf24j40_read_rx_buf(struct mrf24j40 *devrec,
 #ifdef DEBUG
 	print_hex_dump(KERN_DEBUG, "mrf24j40 rx: ",
 		DUMP_PREFIX_OFFSET, 16, 1, data, *len, 0);
-	printk(KERN_DEBUG "mrf24j40 rx: lqi: %02hhx rssi: %02hhx\n",
-		lqi_rssi[0], lqi_rssi[1]);
+	pr_debug("mrf24j40 rx: lqi: %02hhx rssi: %02hhx\n",
+		 lqi_rssi[0], lqi_rssi[1]);
 #endif
 
 out:
@@ -385,7 +385,7 @@ err:
 static int mrf24j40_ed(struct ieee802154_dev *dev, u8 *level)
 {
 	/* TODO: */
-	printk(KERN_WARNING "mrf24j40: ed not implemented\n");
+	pr_warn("mrf24j40: ed not implemented\n");
 	*level = 0;
 	return 0;
 }
@@ -483,10 +483,10 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 			write_short_reg(devrec, REG_EADR0 + i, addr[i]);
 
 #ifdef DEBUG
-		printk(KERN_DEBUG "Set long addr to: ");
+		pr_debug("Set long addr to: ");
 		for (i = 0; i < 8; i++)
-			printk("%02hhx ", addr[7 - i]);
-		printk(KERN_DEBUG "\n");
+			pr_debug("%02hhx ", addr[7 - i]);
+		pr_debug("\n");
 #endif
 	}
 
@@ -702,7 +702,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 	int ret = -ENOMEM;
 	struct mrf24j40 *devrec;
 
-	printk(KERN_INFO "mrf24j40: probe(). IRQ: %d\n", spi->irq);
+	dev_info(&spi->dev, "probe(). IRQ: %d\n", spi->irq);
 
 	devrec = devm_kzalloc(&spi->dev, sizeof(struct mrf24j40), GFP_KERNEL);
 	if (!devrec)
-- 
2.1.0

