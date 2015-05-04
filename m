Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from 212-186-180-163.dynamic.surfer.at ([212.186.180.163]:48518 "EHLO
	cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbEDRaI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 13:30:08 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: corrupted data on bcm2835 spi controller
From: Martin Sperl <kernel@martin.sperl.org>
In-Reply-To: <20150504165720.GB2385@omega.Speedport_W_921V_1_37_000>
Date: Mon, 4 May 2015 19:30:06 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <124B99F4-221A-41EA-89BF-13D201E81104@martin.sperl.org>
References: <20150504165720.GB2385@omega.Speedport_W_921V_1_37_000>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, agx@sigxcpu.org, swarren@wwwdotorg.org, lee@kernel.org, linux-rpi-kernel@lists.infradead.org


> On 04.05.2015, at 18:57, Alexander Aring <alex.aring@gmail.com> wrote:
> 
> My last test shows many corrupted data and I bisected this issue on
> commit 210b49231af6a3ede5de3c90850dbf1134a855c2 ("spi: bcm2835: clock
> divider can be a multiple of 2").
> 
> After reverting this commit by running:
> 
> git revert 210b49231af6a3ede5de3c90850dbf1134a855c2
> 
> there is no corrupted data anymore.
> 
> 
> My spi device-tree entry for the at86rf230 driver is the following:
> 
> &spi {
>        status = "okay";
>        at86rf233@0 {
>                compatible = "atmel,at86rf233";
>                spi-max-frequency = <7500000>;
>                reg = <0>;
>                interrupts = <23 4>;
>                interrupt-parent = <&gpio>;
>                reset-gpio = <&gpio 24 1>;
>                sleep-gpio = <&gpio 25 1>;
>                xtal-trim = /bits/ 8 <0x0F>;
>        };
> };

Does it show when you set spi-max-frequency to 6MHz, 5MHz or to 4MHz?

Note that without that patch you are actually running at 3.91MHz
spi-bus speed (clock divider of 64) with this patch you run at 
7.35 MHz (clock divider of 34).

Datasheet for the chip shows that 7.5MHz is the max for spi clock,
maybe  the device is having issues at this high frequency already.

One more question: is the wireless reception worse or are there
issues talking to the chip itself (spi errors in dmesg).

Maybe with the higher SPI-clock frequencies more high-frequent
noise is produced due to the PCB-layout which negatively impacts 
wireless reception/transmission.






