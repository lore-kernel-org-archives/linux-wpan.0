Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34535 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaLQENs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Dec 2014 23:13:48 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so13279849pdi.7
        for <linux-wpan@vger.kernel.org>; Tue, 16 Dec 2014 20:13:47 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-misc] website: add cc2520 support entry
Date: Wed, 17 Dec 2014 09:39:35 +0530
Message-Id: <1418789375-5450-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 website/index.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/website/index.txt b/website/index.txt
index a7ab4bb..9e4c36f 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -33,6 +33,7 @@ Supported Hardware
 |at86rf231   |yes              |at86rf230  | SPI | http://downloads.qi-hardware.com/people/werner/wpan/web/[atben] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |at86rf233   |yes              |at86rf230  | SPI | http://openlabs.co/store/Raspberry-Pi-802.15.4-radio[openlabs]
 |at86rf212   |yes              |at86rf230  | SPI |
+|cc2520      |yes              |cc2520     | SPI |
 |atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
 |=============================================================
 
-- 
1.7.9.5

