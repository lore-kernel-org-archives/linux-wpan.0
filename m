Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34704 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030220AbbE2QZJ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 29 May 2015 12:25:09 -0400
Message-ID: <556892E0.6050605@osg.samsung.com>
Date: Fri, 29 May 2015 18:25:04 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: for all openlabs tranceiver users
References: <20150504183515.GD2385@omega.Speedport_W_921V_1_37_000>
In-Reply-To: <20150504183515.GD2385@omega.Speedport_W_921V_1_37_000>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: stilwellt@openlabs.co

Hello.

On 04/05/15 20:35, Alexander Aring wrote:
> Hi,
>
> maybe you read the other mail about the RPi and openlabs transceiver
> module.
>
> at86rf233 datasheet says 7.5 Mhz is the highest clock, but since the RPi
> clock can run at 7.35 Mhz I expierence issues with the openlabs transceiver.
>
> Set the max spi clock to 6 Mhz solved this issue. Please update the
> device tree according to that value.
>
> I tested two different transceivers with the same issue at 7.35 Mhz spi
> clock.
>

Based on this I wanted to update my dts for the RPi B+ with openlabs shield.

 From the collected wisdom I now have this:

&spi {
     status = "okay";
     at86rf233@0 {
         compatible = "atmel,at86rf233";
         spi-max-frequency = <6000000>;
         reg = <0>;
         interrupts = <23 4>;
         interrupt-parent = <&gpio>;
         reset-gpio = <&gpio 24 1>;
         sleep-tpio = <&gpio 25 1>;
         xtal-trim = /bits/ 8 <0x0F>;
     };
};

o SPI speed capped at 6 MHz due to problem on the Pi (funny note, I had 
it running at 0.5 MHz so far :))
o interrupts changed to <23 4> from <23 1> (edge to lvel trigger change) 
to avoid the deadlock situation
o Xtal-trim set to 0x0F which should be +4.5 pF and the right value for 
the openlabs shield

Anything else I missed?

regards
Stefan Schmidt



