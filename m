Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54508 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbbFEOYD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 10:24:03 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-misc] website: Update supported hardware table
Date: Fri,  5 Jun 2015 16:23:54 +0200
Message-Id: <1433514234-16526-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Sort in lexical order, add some more where to buy links and add entries for
cc2531, mrf24j40 and XBee.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 website/index.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/website/index.txt b/website/index.txt
index d8ccbb7..19d1e70 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -35,15 +35,18 @@ Supported Hardware
 [cols="3,4,2,^2,12",options="header"]
 |=============================================================
 |Transceiver |Supported        |Driver     | Bus |Where to buy
+|at86rf212   |yes              |at86rf230  | SPI | http://de.aliexpress.com/item/Wireless-transceiver-module-zigbee-module-belt-at86rf212-mcu-chip-780m-module/1757611944.html[aliexpress]
+|at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
 |at86rf230   |no               |at86rf230? | SPI |
 |at86rf231   |yes              |at86rf230  | SPI | http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs], http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATREB233-XPRO[digikey]
-|at86rf212   |yes              |at86rf230  | SPI |
-|at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
-|cc2520      |yes              |cc2520     | SPI |
-|cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
 |atusb       |yes              |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
-|RZUSBstick  |no, WIP          |atusb      | USB |
+|cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
+|cc2520      |yes              |cc2520     | SPI | http://de.aliexpress.com/item/CC2520-wireless-module-ZIGBEE-wireless-sensor-networking-module-with-SMA-external-antenna/1921436550.html[aliexpress]
+|cc2531      |no               |           | USB | http://de.aliexpress.com/item/free-shipping-FOR-ZigBee-CC2531-USB-dongle-protocol-analysis-port-capture-wireless-keyboard-and-mouse/32270975591.html[aliexpress]
+ |mrf24j40   |yes              |mrf24j40   | SPI |  http://de.aliexpress.com/item/MRF24J40MA-I-RM-MRF24J40MA-I-MRF24J40MA-MRF24J40-MICROC-QFN-Import-original/32223258627.html[aliexpress]
+|RZUSBstick  |no, WIP          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
+|Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]
 |=============================================================
 
 How-To's
-- 
2.1.0

