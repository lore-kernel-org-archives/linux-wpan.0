Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48621 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbEVHyt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 03:54:49 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-misc] website: Update status of atusb driver which is now mainline.
Date: Fri, 22 May 2015 09:54:42 +0200
Message-Id: <1432281282-7707-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 7cede5d..d8ccbb7 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -42,7 +42,7 @@ Supported Hardware
 |at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
 |cc2520      |yes              |cc2520     | SPI |
 |cc2420      |no               |           | SPI | http://de.aliexpress.com/store/product/ZIGBEE-networking-technology-Wi-Fi-CC2420-wireless-transceiver-modules-including-antenna/1383438_2036388706.html[aliexpress]
-|atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
+|atusb       |yes              |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |RZUSBstick  |no, WIP          |atusb      | USB |
 |=============================================================
 
-- 
2.1.0

