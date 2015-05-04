Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36024 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbEDS0T (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 14:26:19 -0400
Received: by wizk4 with SMTP id k4so131680424wiz.1
        for <linux-wpan@vger.kernel.org>; Mon, 04 May 2015 11:26:17 -0700 (PDT)
Date: Mon, 4 May 2015 20:26:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: corrupted data on bcm2835 spi controller
Message-ID: <20150504182613.GC2385@omega.Speedport_W_921V_1_37_000>
References: <20150504165720.GB2385@omega.Speedport_W_921V_1_37_000>
 <124B99F4-221A-41EA-89BF-13D201E81104@martin.sperl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <124B99F4-221A-41EA-89BF-13D201E81104@martin.sperl.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-wpan@vger.kernel.org, agx@sigxcpu.org, swarren@wwwdotorg.org, lee@kernel.org, linux-rpi-kernel@lists.infradead.org

On Mon, May 04, 2015 at 07:30:06PM +0200, Martin Sperl wrote:
> 
> > On 04.05.2015, at 18:57, Alexander Aring <alex.aring@gmail.com> wrote:
> > 
> > My last test shows many corrupted data and I bisected this issue on
> > commit 210b49231af6a3ede5de3c90850dbf1134a855c2 ("spi: bcm2835: clock
> > divider can be a multiple of 2").
> > 
> > After reverting this commit by running:
> > 
> > git revert 210b49231af6a3ede5de3c90850dbf1134a855c2
> > 
> > there is no corrupted data anymore.
> > 
> > 
> > My spi device-tree entry for the at86rf230 driver is the following:
> > 
> > &spi {
> >        status = "okay";
> >        at86rf233@0 {
> >                compatible = "atmel,at86rf233";
> >                spi-max-frequency = <7500000>;
> >                reg = <0>;
> >                interrupts = <23 4>;
> >                interrupt-parent = <&gpio>;
> >                reset-gpio = <&gpio 24 1>;
> >                sleep-gpio = <&gpio 25 1>;
> >                xtal-trim = /bits/ 8 <0x0F>;
> >        };
> > };
> 
> Does it show when you set spi-max-frequency to 6MHz, 5MHz or to 4MHz?
> 

with 6 Mhz it works fine.

> Note that without that patch you are actually running at 3.91MHz
> spi-bus speed (clock divider of 64) with this patch you run at 
> 7.35 MHz (clock divider of 34).
> 
> Datasheet for the chip shows that 7.5MHz is the max for spi clock,
> maybe  the device is having issues at this high frequency already.
> 

yes, that should be the issue.

> One more question: is the wireless reception worse or are there
> issues talking to the chip itself (spi errors in dmesg).
> 

The wireless connection was worse, there was no spi errors which was
reported by dmesg.

> Maybe with the higher SPI-clock frequencies more high-frequent
> noise is produced due to the PCB-layout which negatively impacts 
> wireless reception/transmission.
> 

Yes seems so, I will report that.

Thanks.

- Alex
