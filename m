Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37981 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907AbbIDJRv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Sep 2015 05:17:51 -0400
Received: by wiclk2 with SMTP id lk2so11140523wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 04 Sep 2015 02:17:50 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 1/3] website: update rzusbstick firmware
Date: Fri,  4 Sep 2015 11:17:09 +0200
Message-Id: <1441358231-22349-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 907af61..9a4794f 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -47,7 +47,7 @@ Supported Hardware
 |cc2520      |yes              |cc2520     | SPI | http://de.aliexpress.com/item/CC2520-wireless-module-ZIGBEE-wireless-sensor-networking-module-with-SMA-external-antenna/1921436550.html[aliexpress]
 |cc2531      |no               |           | USB | http://de.aliexpress.com/item/free-shipping-FOR-ZigBee-CC2531-USB-dongle-protocol-analysis-port-capture-wireless-keyboard-and-mouse/32270975591.html[aliexpress]
  |mrf24j40   |yes              |mrf24j40   | SPI |  http://de.aliexpress.com/item/MRF24J40MA-I-RM-MRF24J40MA-I-MRF24J40MA-MRF24J40-MICROC-QFN-Import-original/32223258627.html[aliexpress]
-|RZUSBstick  |no, WIP          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
+|RZUSBstick  |experimental, http://wpan.cakelab.org/firmwares/rzusb.bin[WIP]          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
 |Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]
 |=============================================================
 
-- 
2.5.1

