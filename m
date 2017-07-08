Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36195 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbdGHSG7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 8 Jul 2017 14:06:59 -0400
Received: by mail-wr0-f169.google.com with SMTP id c11so86720560wrc.3
        for <linux-wpan@vger.kernel.org>; Sat, 08 Jul 2017 11:06:58 -0700 (PDT)
Date: Sat, 8 Jul 2017 20:06:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Message-ID: <20170708180631.l7lddi475pmua33o@omega>
References: <06812919-6657-de81-25c5-63444c1527b9@hm.edu>
 <20170707110011.pwz272ppmwwu2wzh@omega>
 <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan@vger.kernel.org

Hi,

please keep mailinglist in cc.

On Sat, Jul 08, 2017 at 11:39:22AM +0200, Balz wrote:
> Hi Alex,
> 
> Thank you very mutch for you fast replay,
> 
> I've combined the openlabs DeviceTree fragment for rpi with the SPI-Dev
> Overlay from elinux:
> 
> /dts-v1/;
> 
> /plugin/;
> 
> / {
> 
> compatible = "ti,beaglebone", "ti,beaglebone-black";
> 
> /* identification */
> 
> part-number = "spi0pinmux";
> 
> fragment@0 {
> 
> target = <&am33xx_pinmux>;
> 
> __overlay__ {
> 
> spi0_pins_s0: spi0_pins_s0 {
> 
> pinctrl-single,pins = <
> 
> 0x150 0x30/* spi0_sclk, INPUT_PULLUP | MODE0 */
> 
> 0x154 0x30/* spi0_d0, INPUT_PULLUP | MODE0 */
> 
> 0x158 0x10/* spi0_d1, OUTPUT_PULLUP | MODE0 */
> 
> 0x15c 0x10/* spi0_cs0, OUTPUT_PULLUP | MODE0 */
> 
> /* 0x044 0x17PWM - RESET*/
> 
> /* 0x1ac 0x27IRQ*/
> 
> /* 0x1a4 0x27SLP-Trigger*/
> 

why is this commented?

> > ;
> 
> };
> 
> };
> 
> };
> 
> fragment@1 {
> 
> target = <&spi0>;
> 
> __overlay__ {
> 
> #address-cells = <1>;
> 
> #size-cells = <0>;
> 
> status = "okay";
> 
> pinctrl-names = "default";
> 
> pinctrl-0 = <&spi0_pins_s0>;
> 
> spidev@0 {
> 
> spi-max-frequency = <24000000>;
> 
> reg = <0>;
> 
> compatible = "linux,spidev";
> 
> };
>

remove the spidev entry. This is for userspace /dev/spi0 device and the
bus is already used by at86rf230. OR you use different chipselects and
you have two devices on one spi bus. (Then it makes sense, but one of
them should be reg = <1>; then. If it makes sense - I don't know, I
think this is just for making board config more readable. Linux will
ignore reg <1>. Or maybe not?)

Also I don't know what happens with the multiple max freq stuff.

> at86rf233@0 {
> 
> compatible = "atmel,at86rf233";
> 
> reg = <0>;
> 
> interrupts = <14 4>;
> 
> interrupt-parent = <&gpio0>;
> 
> reset-gpio = <&gpio1 17 1>;
> 
> sleep-gpio = <&gpio3 19 1>;
> 
> spi-max-frequency = <3000000>;
> 
> xtal-trim = /bits/ 8 <0x0F>;
> 
> };
> 
> };
> 
> };
> 
> };
> 

I googled for my valid spi configuration. _IMPORTANT_ i don't know if I
used the same SPI interface which you used. See [0].

> The Registers a configured as:
> 
> cat /sys/kernel/debug/regmap/spi1.0/registers
> 
> 01: 16
> 02: 16
> 03: 00
> 04: 20
> 05: 00
> 06: 20
> 07: ff
> 08: 1a
> 09: 00
> 0a: 00
> 0b: 00
> 0c: a0

RX_SAFE_MODE is 1 here, good.

> 0d: 00
> 0e: 08
> 10: 44
> 11: 00
> 12: ff
> 15: 00
> 17: 02
> 18: 00
> 1a: 57
> 1b: 2a
> 1c: 0b
> 1d: 01
> 1e: 1f
> 1f: 00
> 20: ff
> 21: ff
> 22: ff
> 23: ff
> 24: 00
> 25: 00
> 26: 00
> 27: 00
> 28: 00
> 29: 00
> 2a: 00
> 2b: 00
> 2c: 38
> 2d: 74
> 2e: 57
> 2f: 53
> 
> uname -a prints :
> Linux beaglebone 4.4.54-ti-r93
> 
> i've set the irq trigger to Mode 1 rising edge :
> interrupts = <14 1>;
> 
> and increased the Clock frequency to 7 MHZ but the result is the same.
> 
> Unfortunately i'm not able sniff reliable 7Mhz.
> 

7 is to high, try 4.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01597.html
