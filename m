Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33522 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbbGAMAA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jul 2015 08:00:00 -0400
Received: by laar3 with SMTP id r3so39174701laa.0
        for <linux-wpan@vger.kernel.org>; Wed, 01 Jul 2015 04:59:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
References: <CAPpUg6ODFfRpaM9EtL0YY4iHNbgOtgZ4QLVzGpSYkC-zRGY+7w@mail.gmail.com>
	<20150626080338.GB959@omega>
	<CAPpUg6PQZ8aYabugqr1jL=yfE1HmWinCzy1JN4LCv1QXbfw6dQ@mail.gmail.com>
	<CAPpUg6O61HyVEiTXD7r-14dVp-G3thy_YSG06PSUDooDEPHEFw@mail.gmail.com>
	<20150629080937.GA1674@omega>
	<55910C2F.3070601@gmail.com>
	<CAPpUg6Nb0TXj7Xm0WTv+T4K-3BV-VJjsQcCJabd3txg7JHv-pQ@mail.gmail.com>
	<CAPpUg6NUwAGo402HgJkwcDTyT3HPBAAnSEW7V63zUyv5PHSJ8A@mail.gmail.com>
	<20150629220929.GB1165@omega>
	<CAPpUg6N5SAY3fOio7zGnsOPkYytgx5gRgfULO5=6Tz+fcN-9PA@mail.gmail.com>
	<20150701082130.GA1834@omega>
	<CAPpUg6P7ffx8yhcN7Oqjw6uK7-z1mBGNeHXJaBycbkbjYUSK=g@mail.gmail.com>
	<CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
Date: Wed, 1 Jul 2015 13:59:58 +0200
Message-ID: <CAPpUg6OiRu2XWb_xMXDVzuSLYP7=JeD1ULcksCh=WjprxxCbKA@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

2015-07-01 11:45 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> 2015-07-01 11:22 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>>
>> 2015-07-01 10:21 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> > Hi,
>> >
>> > On Tue, Jun 30, 2015 at 11:12:36AM +0200, Baptiste Clenet wrote:
>> > ....
>> >>
>> >> root@OpenWrt:/# dmesg | grep at86rf230
>> >> [   94.820000] at86rf230 spi32766.1: Detected at86rf212 chip version 3
>> >> [   94.830000] at86rf230 spi32766.1: unexcept state change from 0x00
>> >> to 0x08. Actual state: 0x00
>> >>
>> >> It detects the chip but yes definitely, there is problem to read the state.
>> >> Will check the pins
>> >>
>> >
>> > if you have debugfs support and mounted it, then you could dump all
>> > register settings by doing something similar like:
>> >
>> > cat /sys/kernel/debug/regmap/spi1.0/registers
>> >
>> > result would be some $REGISTER <-> $VALUE mapping.
>> >
>> > Note:
>> >
>> > One interface of the 802.15.4 phy should be up for this development method,
>> > because the transceiver isn't in sleep mode then.
>> >
>> > - Alex
>>
>> The mapping:
>>
>> root@OpenWrt:/# cat /sys/kernel/debug/regmap/spi32766.1/registers
>> 01: 16
>> 02: f6
>> 03: 10
>> 04: 20
>> 05: 60
>> 06: 80
>> 07: 2c
>> 08: 25
>> 09: 77
>> 0a: 17
>> 0b: a7
>> 0c: a4
>> 0d: 01
>> 0e: 08
>> 10: 44
>> 11: a2
>> 12: f0
>> 15: 00
>> 17: 00
>> 18: 50
>> 1a: 47
>> 1b: 54
>> 1c: 07
>> 1d: 03
>> 1e: 1f
>> 1f: 00
>> 20: ff
>> 21: ff
>> 22: ef
>> 23: be
>> 24: 05
>> 25: 45
>> 26: 92
>> 27: 92
>> 28: 1e
>> 29: 52
>> 2a: e4
>> 2b: d0
>> 2c: 38
>> 2d: 98
>> 2e: 42
>> 2f: 53
>>
>>
>> --
>> Baptiste
>
>
>
> I can set a different channel and see the difference in the regmap,
> I'm definitely able to communicate with the transceiver.
> I'm not sure about my interrupt pin definition in my dts. That might
> be the problem.
>
> in palmbus
>     spi
>       at86rf212@0 {
>           compatible = "atmel,at86rf212";
>           reg = <1>;
>           interrupt-parent = <&gpio0>;
>           interrupts = <15 1>;
>           reset-gpio = <&gpio0 16 1>;
>           sleep-gpio = <&gpio0 17 1>;
>           spi-max-frequency = <1000000>;
>       };
>
>
> and gpio
> gpio@600 {
>        #address-cells = <1>;
>        #size-cells = <0>;
>        interrupt-parent = <&intc>;
>        interrupts = <6>;
>
>        compatible = "mtk,mt7628-gpio", "mtk,mt7621-gpio";
>        reg = <0x600 0x100>;
>
>        gpio0: bank@0 {
>             reg = <0>;
>             ...
>
>
> I define pin 15 as the interrupt pin here but how can I check it while
> OpenWRT is running?
>
> Good luck for your exam through :-)
> --
> Baptiste

I'm wondering how regmap works. the at86rf230 write and read functions
call regmap functions. I suppose regmap communicates with spi?

Are values displayed by 'cat
/sys/kernel/debug/regmap/spi32766.1/registers' read from the
transceiver? (updated every time) or is it in the flash of my board
and change one by one when it is required?

When I change the channel, it obviously changes the regmap but how may
I check that at86rf230 channel is really edited? (calling spi
function)


-- 
Baptiste
