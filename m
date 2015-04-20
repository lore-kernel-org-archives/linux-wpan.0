Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail102.csoft.net ([96.47.74.245]:49514 "EHLO mail102.csoft.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbbDTSJY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 20 Apr 2015 14:09:24 -0400
Message-ID: <55353FC0.5050909@fid4.com>
Date: Mon, 20 Apr 2015 14:04:48 -0400
From: "Michael C. Cambria" <mcc@fid4.com>
MIME-Version: 1.0
Subject: Re: at86rf233 on BeagleBone Black
References: <551EDFCA.3070905@fid4.com> <20150403191320.GD773@omega> <20150414150656.GB2179@omega> <553024C3.2020207@fid4.com> <55307D66.7020606@gmail.com> <55310A85.5080601@fid4.com> <20150417221913.GA3338@omega>
In-Reply-To: <20150417221913.GA3338@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org



On 04/17/2015 06:19 PM, Alexander Aring wrote:
> On Fri, Apr 17, 2015 at 09:28:37AM -0400, Michael C. Cambria wrote:
> ....
>> With those changes the "arguments longer than property" message does go
>> away.  I now get this probe error:
>>
>>
>> [    9.815400] of_get_named_gpiod_flags: parsed 'reset-gpio' property of
>> node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
>> [    9.815437] of_get_named_gpiod_flags: parsed 'sleep-gpio' property of
>> node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
>> [   10.287193] at86rf230 spi1.0: Non-Atmel dev found (MAN_ID 00 00)
>> [   10.971416] at86rf230: probe of spi1.0 failed with error -22
>>
> Meanwhile I got private repsonse that somebody have a working openlabs
> module on a beaglebone, so it's _really_ possible! :-)

Thanks for all the help.  My BBB now works with the openlabs radio.  I 
had P9_28 & P9_30 in the the wrong holes (blush).

I still have those two messages at modprobe time, but the radio is probed.

[   11.346020] of_get_named_gpiod_flags: parsed 'reset-gpio' property of 
node '/ocp/spi@481a0000/at86rf233@0[0]' - status (0)
[   11.346056] of_get_named_gpiod_flags: parsed 'sleep-gpio' property of 
node '/ocp/spi@481a0000/at86rf233@0[0]' - status (0)
[   11.349282] at86rf230 spi1.0: Detected at86rf233 chip version 1

I'll test e..g ping6 to another BBB and Pi ASAP.

Here is what I appended to the existing am335x-boneblack.dts file:

&am33xx_pinmux {
         spi1_pins: pinmux_spi1_pins {
                 pinctrl-single,pins = <
                         0x190 (PIN_INPUT_PULLDOWN | MUX_MODE3) /* 
mcasp0_aclkx.spi1_sclk */
                         0x194 (PIN_INPUT | MUX_MODE3) /* 
mcasp0_fsx.spi1_d0 */
                         0x198 (PIN_OUTPUT_PULLDOWN | MUX_MODE3) /* 
mcasp0_axr0.spi1_d1 */
                         0x19c (PIN_OUTPUT_PULLUP | MUX_MODE3) /* 
mcasp0_ahclkr.spi1_cs0 */
                         0x1a4 (PIN_INPUT | MUX_MODE7)  /* IRQ: 
mcasp0_fsr.gpio3_19 */
                         0x1ac (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* 
SLP_TR: mcasp0_ahclkx.gpio3_21 */
                         0x044 (PIN_OUTPUT_PULLUP | MUX_MODE7) /* RESET: 
gpmc_a1.gpio1_17 */
                 >;
         };
};


&spi1 {
         status = "okay";
         pinctrl-names = "default";
         pinctrl-0 = <&spi1_pins>;
         at86rf233@0 {
                 compatible = "atmel,at86rf233";
                 spi-max-frequency = <500000>;
                 reg = <0>;
                 interrupts = <19 4>;
                 interrupt-parent = <&gpio3>;
                 reset-gpio = <&gpio1 17 1>;
                 sleep-gpio = <&gpio3 21 1>;
                 xtal-trim = /bits/ 8 <0xF>;
         };
};

I'll post the J1 to BBB P9 pin mapping ASAP as well.


