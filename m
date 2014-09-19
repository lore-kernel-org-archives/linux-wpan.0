Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57360 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbaISEsh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 00:48:37 -0400
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next v2 3/3] mrf24j40: use pr_* / dev_* instead of printk()
Date: Fri, 19 Sep 2014 10:15:10 +0530
Message-Id: <1411101911-12462-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1411101911-12462-1-git-send-email-varkab@cdac.in>
References: <1411101911-12462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>

Replace printk() with dev_*() pr_*()

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/mrf24j40.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 2c617e3..c7f638c 100644
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
@@ -481,12 +481,11 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 		memcpy(addr, &filt->ieee_addr, 8);
 		for (i = 0; i < 8; i++)
 			write_short_reg(devrec, REG_EADR0 + i, addr[i]);
-
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
 
@@ -702,7 +701,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 	int ret = -ENOMEM;
 	struct mrf24j40 *devrec;
 
-	printk(KERN_INFO "mrf24j40: probe(). IRQ: %d\n", spi->irq);
+	dev_info(&spi->dev, "probe(). IRQ: %d\n", spi->irq);
 
 	devrec = devm_kzalloc(&spi->dev, sizeof(struct mrf24j40), GFP_KERNEL);
 	if (!devrec)
-- 
1.7.9.5

