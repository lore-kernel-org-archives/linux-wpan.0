Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:55889 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaLQW5l (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 17:57:41 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so17373833wib.16
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 14:57:40 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 1/2] website: add digikey at86rf233 transceiver
Date: Wed, 17 Dec 2014 23:57:33 +0100
Message-Id: <1418857054-5447-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Reported-by: Andrey Yurovsky <andrey@snupi.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 9e4c36f..682ac8b 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -31,7 +31,7 @@ Supported Hardware
 |Transceiver |Supported        |Driver     | Bus |Where to buy
 |at86rf230   |no               |at86rf230? | SPI |
 |at86rf231   |yes              |at86rf230  | SPI | http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
-|at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
+|at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs], http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATREB233-XPRO[digikey]
 |at86rf212   |yes              |at86rf230  | SPI |
 |cc2520      |yes              |cc2520     | SPI |
 |atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
-- 
2.1.3

