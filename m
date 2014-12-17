Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:63524 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaLQW5m (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 17:57:42 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so50114wgh.32
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 14:57:41 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 2/2] website: add digikey at86rf212b transceiver
Date: Wed, 17 Dec 2014 23:57:34 +0100
Message-Id: <1418857054-5447-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418857054-5447-1-git-send-email-alex.aring@gmail.com>
References: <1418857054-5447-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Reported-by: Andrey Yurovsky <andrey@snupi.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/website/index.txt b/website/index.txt
index 682ac8b..4ccb218 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -33,6 +33,7 @@ Supported Hardware
 |at86rf231   |yes              |at86rf230  | SPI | http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs], http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATREB233-XPRO[digikey]
 |at86rf212   |yes              |at86rf230  | SPI |
+|at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
 |cc2520      |yes              |cc2520     | SPI |
 |atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |=============================================================
-- 
2.1.3

