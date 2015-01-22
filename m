Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61119 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbbAVV2t (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jan 2015 16:28:49 -0500
Received: by mail-wg0-f41.google.com with SMTP id a1so4180927wgh.0
        for <linux-wpan@vger.kernel.org>; Thu, 22 Jan 2015 13:28:48 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 2/2] website: add RZUSBstick information
Date: Thu, 22 Jan 2015 22:28:22 +0100
Message-Id: <1421962102-20901-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1421962102-20901-1-git-send-email-alex.aring@gmail.com>
References: <1421962102-20901-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds information for RZUSBstick stick, that somebody already
working on this to porting the atusb firmware to this stick.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/website/index.txt b/website/index.txt
index 2b4c367..ef9c778 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -39,6 +39,7 @@ Supported Hardware
 |at86rf212b  |yes              |at86rf230  | SPI | http://www.digikey.com/product-search/en?x=0&y=0&lang=en&site=us&keywords=ATZB-212B-XPRO[digikey]
 |cc2520      |yes              |cc2520     | SPI |
 |atusb       |not mainline yet |atusb      | USB | http://downloads.qi-hardware.com/people/werner/wpan/web/[atusb] Out of stock. Mailto linux-wpan and Werner to produce maybe new ones. Or contact http://en.qi-hardware.com/wiki/Main_Page[qi-hardware].
+|RZUSBstick  |no, WIP          |atusb      | USB |
 |=============================================================
 
 How-To's
-- 
2.2.2

