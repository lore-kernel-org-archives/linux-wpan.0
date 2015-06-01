Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34610 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbbFAHAc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 03:00:32 -0400
Received: by lbcmx3 with SMTP id mx3so78359957lbc.1
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 00:00:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150531123430.GC1476@omega>
References: <CAPpUg6Pa7xOOScRSf5qvBEJqEdBp_=e5J_Ozbmd10CgbnCgjcA@mail.gmail.com>
	<20150531123430.GC1476@omega>
Date: Mon, 1 Jun 2015 09:00:30 +0200
Message-ID: <CAPpUg6MTo5ifze9JxqCk1u9Y7OVXsZQNO9y0ZezkHMvJvhY1Zg@mail.gmail.com>
Subject: Re: At86rf212B(driver at86rf230), Ralink MT7228, cs1 always high
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Sorry, it was Ralink MT7628.
I boot via device tree yes and the dts is configured to use AT86RF212B
with chip select 1 :

palmbus@10000000 {
  spi@b00 {
      status = "okay";

      m25p80@0 {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "en25q64";
        reg = <0 0>;
        ...
      };

      at86rf212@0 {
          compatible = "atmel,at86rf212";
          reg = <1>;
          interrupts = <15 4>;
          interrupt-parent = <&intc>;
          reset-gpio = <&gpio0 16 1>;
          sleep-gpio = <&gpio0 17 1>;
          spi-max-frequency = <1000000>;
      };
  };
};


This didn't work so I had a look a the spi driver spi-mt7621.c and I
saw that the driver wasn't implemented FOR two chip selects. This is
why I change the function "static void mt7621_spi_set_cs();" (last
message)

Does it make sense?

2015-05-31 14:34 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Fri, May 29, 2015 at 11:28:48AM +0200, Baptiste Clenet wrote:
>> Hi,
>>
>> I'm working on the board Ralink MT7228 with an Atmel AT86RF212B by SPI.
>> I've configured the transceiver to be on cs1. I plugged cs from the
>> transceiver to pin 6 of MT7228.
>> I've edited spi-mt7621.c to allow two slave on SPI master as follow:
>>
>
> sorry, I have no idea what you mean and did there. To make the
> chipselect right I suppose this part of spi subsystem, you don't need
> (if you don't doing hacks) to touch anything at driver layer. What you
> need is to tell the spi subsystem the right configuration so the spi
> controller can do the right thing.
>
> I also tried to google "Ralink MT7228" without luck.
>
> Do you boot via device tree or the old way?
>
> - Alex
