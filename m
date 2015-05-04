Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35368 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbEDQ52 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 12:57:28 -0400
Received: by wgyo15 with SMTP id o15so156638681wgy.2
        for <linux-wpan@vger.kernel.org>; Mon, 04 May 2015 09:57:27 -0700 (PDT)
Date: Mon, 4 May 2015 18:57:24 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: corrupted data on bcm2835 spi controller
Message-ID: <20150504165720.GB2385@omega.Speedport_W_921V_1_37_000>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: kernel@martin.sperl.org
Cc: linux-wpan@vger.kernel.org, agx@sigxcpu.org, swarren@wwwdotorg.org, lee@kernel.org, linux-rpi-kernel@lists.infradead.org

Hi,

I have an openlabs 802.15.4 transceiver [0] connected to a RPi and there
are several users inside linux-wpan community which use these transceivers
on a RPi.


My last test shows many corrupted data and I bisected this issue on
commit 210b49231af6a3ede5de3c90850dbf1134a855c2 ("spi: bcm2835: clock
divider can be a multiple of 2").

After reverting this commit by running:

git revert 210b49231af6a3ede5de3c90850dbf1134a855c2

there is no corrupted data anymore.


My spi device-tree entry for the at86rf230 driver is the following:

&spi {
        status = "okay";
        at86rf233@0 {
                compatible = "atmel,at86rf233";
                spi-max-frequency = <7500000>;
                reg = <0>;
                interrupts = <23 4>;
                interrupt-parent = <&gpio>;
                reset-gpio = <&gpio 24 1>;
                sleep-gpio = <&gpio 25 1>;
                xtal-trim = /bits/ 8 <0x0F>;
        };
};


I have no other equipment at my home to check the exact spi clock or
something else, what I can say is after reverting this commit I don't
have any corrupted data anymore and eveything working fine.


To all linux-wpan at86rf233 users on a RPi:
Can you confirm these issue with the bcm2835 controller? Then we could
maybe more debug this issue.


- Alex

[0] http://openlabs.co/store/Raspberry-Pi-802.15.4-radio
