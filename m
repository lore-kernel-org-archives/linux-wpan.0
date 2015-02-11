Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40359 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbbBKOdr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 09:33:47 -0500
Received: by mail-wi0-f169.google.com with SMTP id em10so756587wid.0
        for <linux-wpan@vger.kernel.org>; Wed, 11 Feb 2015 06:33:46 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: add aliexpress cc2420
Date: Wed, 11 Feb 2015 15:33:40 +0100
Message-Id: <1423665220-21113-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/website/index.txt b/website/index.txt
index 7331534..3eb455b 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -38,6 +38,7 @@ Supported Hardware
 |at86rf212   |yes              |at86rf230  | SPI |
 |at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
 |cc2520      |yes              |cc2520     | SPI |
+|cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
 |atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |RZUSBstick  |no, WIP          |atusb      | USB |
 |=============================================================
-- 
2.3.0

