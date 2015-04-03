Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37612 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbDCTN0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Apr 2015 15:13:26 -0400
Received: by wiaa2 with SMTP id a2so148253105wia.0
        for <linux-wpan@vger.kernel.org>; Fri, 03 Apr 2015 12:13:24 -0700 (PDT)
Date: Fri, 3 Apr 2015 21:13:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150403191320.GD773@omega>
References: <551EDFCA.3070905@fid4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <551EDFCA.3070905@fid4.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Apr 03, 2015 at 02:45:30PM -0400, Michael C. Cambria wrote:
> 
> Hi Alex,
> 
> Do you happen to have the pin mapping & device tree overlay needed for the
> Openlabs at86rf233 [0] to run on BeagleBone Black (BBB)?
> 
> I only have a few Pi's but do have a few spare BBB I could use. I'd rather
> not experiment an ruin either the BBB or at86rf233 if this information is
> known.
> 

What I can give you are my dts entries for the BeagleBone (white),
pinout should be the same:

&am33xx_pinmux {
	spi1_pins: pinmux_spi1_pins {
		pinctrl-single,pins = <
			0x190 0x33      /* mcasp0_aclkx.spi1_sclk, INPUT_PULLUP | MODE3 (special mode input for clock) */
			0x194 0x33      /* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
			0x198 0x13      /* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
			0x19c 0x13      /* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
			0x1a4 0x2f      /* mcasp0_fsr.gpio3_19, INPUT, PULL DISABLED | MODE7 */
		>;
	};
};

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
		reset-gpio = $YOUR_GPIO
		xtal-trim = /bits/ 8 <0xF>;
	};
};

I also changed the "xtal-trim" value. Now it's fit with the openlabs
transceivers.

So you can see how my transceiver (I use the atben which have no reset pin)
is connected to my BeagleBone. Check [0] to get pins for interrupt and
reset pin.

I did the reset pin optional, please don't do that... normally then we
need to run a reset of phy settings if the at86rf233 have no reset pin
which is much unlikely (Okay, the atben have no reset pins...). I did
not implement such a PHY reset handling yet. So please use some free gpio.
This means you need to replace _maybe_ the interrupts and
interrupt-parent property. What you really need to change is the
$YOUR_GPIO property to something like [0] (fast googling which use the
dt naming stuff).

I mean something like:

reset-gpio = <&gpio3 21 1>;

depends on you adaptation from openlabs at86rf233 to a BBB.

- Alex

[0] http://blog.savoirfairelinux.com/wp-content/uploads/2013/11/beaglebone_pins-table.png
[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/gpio/gpio.txt
