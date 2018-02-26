Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34770 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeBZJvg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Feb 2018 04:51:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so16148122wmd.1
        for <linux-wpan@vger.kernel.org>; Mon, 26 Feb 2018 01:51:35 -0800 (PST)
Received: from xue-ThinkPad-T470s.kelle.grp (p578b164d.dip0.t-ipconnect.de. [87.139.22.77])
        by smtp.gmail.com with ESMTPSA id g7sm6482431edf.4.2018.02.26.01.51.33
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 01:51:34 -0800 (PST)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCH] website: Add NXP mcr20a to the suppoted hardware
Date: Mon, 26 Feb 2018 10:51:29 +0100
Message-Id: <1519638689-5134-1-git-send-email-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

add NXP mcr20a to the suppoted hardware list.

Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
---
 website/index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/website/index.txt b/website/index.txt
index 6d9fe88..d631371 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -47,6 +47,7 @@ Supported Hardware
 |cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
 |cc2520      |yes              |cc2520     | SPI | http://de.aliexpress.com/item/CC2520-wireless-module-ZIGBEE-wireless-sensor-networking-module-with-SMA-external-antenna/1921436550.html[aliexpress]
 |cc2531      |no               |           | USB | http://de.aliexpress.com/item/free-shipping-FOR-ZigBee-CC2531-USB-dongle-protocol-analysis-port-capture-wireless-keyboard-and-mouse/32270975591.html[aliexpress]
+|mcr20a      |yes              |mcr20a	   | SPI | https://www.nxp.com/products/wireless-connectivity/thread/2.4-ghz-802.15.4-wireless-transceiver:MCR20A[NXP]
  |mrf24j40   |yes              |mrf24j40   | SPI |  http://de.aliexpress.com/item/MRF24J40MA-I-RM-MRF24J40MA-I-MRF24J40MA-MRF24J40-MICROC-QFN-Import-original/32223258627.html[aliexpress]
 |RZUSBstick  |experimental, http://wpan.cakelab.org/firmwares/rzusb.bin[WIP]          |atusb      | USB | http://www.element14.com/community/docs/DOC-67532/l/avr-rz-usb-stick-module[element14]
 |Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]
-- 
2.7.4

