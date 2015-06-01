Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35459 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbFAH2d (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 03:28:33 -0400
Received: by wicmx19 with SMTP id mx19so66402816wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 00:28:32 -0700 (PDT)
Date: Mon, 1 Jun 2015 09:28:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: At86rf212B(driver at86rf230), Ralink MT7228, cs1 always high
Message-ID: <20150601072823.GA734@omega>
References: <CAPpUg6Pa7xOOScRSf5qvBEJqEdBp_=e5J_Ozbmd10CgbnCgjcA@mail.gmail.com>
 <20150531123430.GC1476@omega>
 <CAPpUg6MTo5ifze9JxqCk1u9Y7OVXsZQNO9y0ZezkHMvJvhY1Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6MTo5ifze9JxqCk1u9Y7OVXsZQNO9y0ZezkHMvJvhY1Zg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Mon, Jun 01, 2015 at 09:00:30AM +0200, Baptiste Clenet wrote:
> Sorry, it was Ralink MT7628.
> I boot via device tree yes and the dts is configured to use AT86RF212B
> with chip select 1 :
> 
> palmbus@10000000 {
>   spi@b00 {
>       status = "okay";
> 
>       m25p80@0 {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         compatible = "en25q64";
>         reg = <0 0>;
>         ...
>       };
> 
>       at86rf212@0 {
>           compatible = "atmel,at86rf212";
>           reg = <1>;

this normally represents the chip select, I don't know if this is just
eye candy or it's _really_ evaluated.

>           interrupts = <15 4>;
>           interrupt-parent = <&intc>;
>           reset-gpio = <&gpio0 16 1>;
>           sleep-gpio = <&gpio0 17 1>;
>           spi-max-frequency = <1000000>;
>       };
>   };
> };
> 
> 
> This didn't work so I had a look a the spi driver spi-mt7621.c and I
> saw that the driver wasn't implemented FOR two chip selects. This is
> why I change the function "static void mt7621_spi_set_cs();" (last
> message)
> 
> Does it make sense?
> 

I think it could make sense, depends what the hardware designer for Ralink
MT7628 did there.

First you need to figure out "who" make your chip select. I mean with
this question, if your SPI controller do the chip select or is it
software triggered by GPIO.

I don't know the spi subsystem much if the lastest one is ever supported
or you need to implement yourself (if possible). I think the spi subsystem
supports that, but I never setup such configuration.

If it's triggered by GPIO (this smells like the spi-mt7621.c function),
you need to care that the cs is handled by software correctly and now I
think that this can have 100 issues why it's not working currently in
your setup.

I think this is more a spi specific question and you should ask on:

http://vger.kernel.org/vger-lists.html#linux-spi

or get commercial support. Sorry, but I can't really help your with a
generic spi question and your issue smells like "reading zeros" on the
bus only.

- Alex
