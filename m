Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:42696 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbcAYONR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Jan 2016 09:13:17 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-misc] web: add supported adf7242 transceiver in table
Date: Mon, 25 Jan 2016 15:05:29 +0100
Message-Id: <1453730729-5396-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Keep alphabetical order of the list.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 website/index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/website/index.txt b/website/index.txt
index e476d8a..3ac44b6 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -37,6 +37,7 @@ Supported Hardware
 [cols="3,4,2,^2,12",options="header"]
 |=============================================================
 |Transceiver |Supported        |Driver     | Bus |Where to buy
+|adf7242     |yes | adf7242 | SPI or PMOD | http://www.analog.com/en/products/rf-microwave/integrated-transceivers-transmitters-receivers/low-power-rf-transceivers/adf7242.html#product-samplebuy[Analog]
 |at86rf212   |yes              |at86rf230  | SPI | http://de.aliexpress.com/item/Wireless-transceiver-module-zigbee-module-belt-at86rf212-mcu-chip-780m-module/1757611944.html[aliexpress]
 |at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
 |at86rf230   |no               |at86rf230? | SPI |
-- 
2.5.0

