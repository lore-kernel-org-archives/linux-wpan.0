Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50383 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbaIPEv2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 00:51:28 -0400
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: mrf24j40: use pr_* / dev_*
Date: Tue, 16 Sep 2014 10:18:42 +0530
Message-Id: <1410842922-10564-4-git-send-email-varkab@cdac.in>
In-Reply-To: <1410842922-10564-1-git-send-email-varkab@cdac.in>
References: <1410842922-10564-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>

This patch replace printk() with dev_* if dev is available
or replace with pr_*

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/mrf24j40.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 2c617e3..80b6adf 100644
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
@@ -482,12 +482,10 @@ static int mrf24j40_filter(struct ieee802154_dev *dev,
 		for (i = 0; i < 8; i++)
 			write_short_reg(devrec, REG_EADR0 + i, addr[i]);
 
-#ifdef DEBUG
-		printk(KERN_DEBUG "Set long addr to: ");
+		pr_debug("Set long addr to: ");
 		for (i = 0; i < 8; i++)
-			printk("%02hhx ", addr[7 - i]);
-		printk(KERN_DEBUG "\n");
-#endif
+			pr_debug("%02hhx ", addr[7 - i]);
+		pr_debug("\n");
 	}
 
 	if (changed & IEEE802515_AFILT_PANID_CHANGED) {
@@ -702,7 +700,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 	int ret = -ENOMEM;
 	struct mrf24j40 *devrec;
 
-	printk(KERN_INFO "mrf24j40: probe(). IRQ: %d\n", spi->irq);
+	dev_info(&spi->dev, "probe(). IRQ: %d\n", spi->irq);
 
 	devrec = devm_kzalloc(&spi->dev, sizeof(struct mrf24j40), GFP_KERNEL);
 	if (!devrec)
-- 
1.7.9.5

