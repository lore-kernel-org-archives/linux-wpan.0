Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:39673 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbbCHIRj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 8 Mar 2015 04:17:39 -0400
Received: by wiwl15 with SMTP id l15so12911431wiw.4
        for <linux-wpan@vger.kernel.org>; Sun, 08 Mar 2015 00:17:38 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 0/2] ieee802154: add usual way to get extended address via device tree
Date: Sun,  8 Mar 2015 09:17:21 +0100
Message-Id: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch introduce an usual way to getting extended address from device tree.
I added the properties "extended-address" and "local-extended-address". The
ethernet framework has "mac-address", "local-mac-address" and "address", where
"address" is according the comment an obsolete property.

An example how you could add a extended address would be:

&spi1 {
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&spi1_pins>;
	at86rf231@0 {
		compatible = "atmel,at86rf231";
		spi-max-frequency = <7500000>;
		reg = <0>;
		interrupts = <19 4>;
		interrupt-parent = <&gpio3>;
		xtal-trim = /bits/ 8 <0x03>;
		extended-address = [ DE AD BE EF CA FE FA CE ];
	};
};

This is actually a RFC only. I want to be sure that we can use this naming
convention and I need also add a cc in Patch 1/1 ("of: net: add support for
extended address") to the device tree mailinglist, then wait for an acked-by
and marcel can apply it on bluetooth-next and we have it mainline.

- Alex

Alexander Aring (2):
  of: net: add support for extended address
  at86rf230: add support for dt or pdata extended addr

 drivers/net/ieee802154/at86rf230.c | 15 ++++++++++++---
 drivers/of/of_net.c                | 34 ++++++++++++++++++++++++++++++++++
 include/linux/of_net.h             |  6 ++++++
 include/linux/spi/at86rf230.h      |  1 +
 4 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.3.0

