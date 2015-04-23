Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail102.csoft.net ([96.47.74.245]:59857 "EHLO mail102.csoft.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965013AbbDWNsq (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 23 Apr 2015 09:48:46 -0400
Message-ID: <5538F7E7.9020308@fid4.com>
Date: Thu, 23 Apr 2015 09:47:19 -0400
From: "Michael C. Cambria" <mcc@fid4.com>
MIME-Version: 1.0
Subject: Re: at86rf233 on BeagleBone Black
References: <551EDFCA.3070905@fid4.com> <20150403191320.GD773@omega> <20150414150656.GB2179@omega> <553024C3.2020207@fid4.com> <55307D66.7020606@gmail.com> <55310A85.5080601@fid4.com> <20150417221913.GA3338@omega> <55353FC0.5050909@fid4.com> <20150423093739.GA8178@omega>
In-Reply-To: <20150423093739.GA8178@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org



On 04/23/2015 05:37 AM, Alexander Aring wrote:
> On Mon, Apr 20, 2015 at 02:04:48PM -0400, Michael C. Cambria wrote:
> ....
>> &spi1 {
>>          status = "okay";
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&spi1_pins>;
>>          at86rf233@0 {
>>                  compatible = "atmel,at86rf233";
>>                  spi-max-frequency = <500000>;
> now I detect this here. Why such low clock? You should use a 7.5 Mhz
> clock here not 500 Khz. I had some troubles with such a low clock and
> fragmentation handling.
>
> Means:
>
> change it to "spi-max-frequency = <7500000>;"
>
> - Alex

The openlabs blog post [0] used 500 Khz:

&spi {
     status = "okay";
     at86rf233@0 {
         compatible = "atmel,at86rf233";
         reg = <0>;
         interrupts = <23 1>;
         interrupt-parent = <&gpio>;
         reset-gpio = <&gpio 24 1>;
         sleep-tpio = <&gpio 25 1>;
         spi-max-frequency = <500000>;
     };
};

I've fixed both the Pi and BBB dts to use 7.5 Mhz as suggested.
I will also change "interrupts = <23 1>': to <23 4> on the Pi to get rid 
of the dmesg warning at next reboot.

"[    7.810095] at86rf230 spi32766.0: Using edge triggered irq's are not 
recommended!"

Right now, I'm using the Pi to route over at86rf233 to the BBB to a 
local LAN off the BBB.


[0] http://openlabs.co/blog/archives/1-6LoWPAN-kernel-on-a-Raspberry-Pi


