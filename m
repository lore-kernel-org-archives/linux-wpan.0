Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail102.csoft.net ([96.47.74.245]:20087 "EHLO mail102.csoft.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbbDQN2x (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 17 Apr 2015 09:28:53 -0400
Message-ID: <55310A85.5080601@fid4.com>
Date: Fri, 17 Apr 2015 09:28:37 -0400
From: "Michael C. Cambria" <mcc@fid4.com>
MIME-Version: 1.0
Subject: Re: at86rf233 on BeagleBone Black
References: <551EDFCA.3070905@fid4.com> <20150403191320.GD773@omega> <20150414150656.GB2179@omega> <553024C3.2020207@fid4.com> <55307D66.7020606@gmail.com>
In-Reply-To: <55307D66.7020606@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>



On 04/16/2015 11:26 PM, Varka Bhadram wrote:
> On 04/17/2015 02:38 AM, Michael C. Cambria wrote:
>>
>> On 04/14/2015 11:06 AM, Alexander Aring wrote:
>>> Hi,
>> [deleted]
>>
>>> since somebody noticed me about several pinmux issues on this setup. I
>>> will update them now with:
>>>
>>> &am33xx_pinmux {
>>>           spi1_pins: pinmux_spi1_pins {
>>>                   pinctrl-single,pins = <
>>>                           0x190 (PIN_INPUT_PULLDOWN | MUX_MODE3) /*
>>> mcasp0_aclkx.spi1_sclk */
>>>                           0x194 (PIN_INPUT | MUX_MODE3) /*
>>> mcasp0_fsx.spi1_d0 */
>>>                           0x198 (PIN_OUTPUT_PULLDOWN | MUX_MODE3) /*
>>> mcasp0_axr0.spi1_d1 */
>>>                           0x19c (PIN_OUTPUT_PULLUP | MUX_MODE3) /*
>>> mcasp0_ahclkr.spi1_cs0 */
>>>                           0x1a4 (PIN_INPUT | MUX_MODE7)  /* IRQ:
>>> mcasp0_fsr.gpio3_19 */
>>>                           0x1ac (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /*
>>> SLP_TR: mcasp0_ahclkx.gpio3_21 */
>>>                           0x044 (PIN_OUTPUT_PULLUP | MUX_MODE7) /*
>>> RESET: gpmc_a1.gpio1_17 */
>>>                   >;
>>>           };
>>> };
>>>
>>> This is what [0] describes at page 11, I hope. Can somebody report if it
>>> was successful to get openlabs with bb/bbw working?
>>>
>>> - Alex
>>>
>>> [0]
>>> http://www.atmel.com/images/atmel-8351-mcu_wireless-at86rf233_datasheet.pdf
>>> (1.3.2 Pull-up and Pull-down Configuration)
>> On BBB, I'm using:
>>
>> &am33xx_pinmux {
>>          spi1_pins: pinmux_spi1_pins {
>>                  pinctrl-single,pins = <
>>                          0x190 (PIN_INPUT_PULLDOWN | MUX_MODE3) /*
>> mcasp0_aclkx.spi1_sclk */
>>                          0x194 (PIN_INPUT | MUX_MODE3) /*
>> mcasp0_fsx.spi1_d0 */
>>                          0x198 (PIN_OUTPUT_PULLDOWN | MUX_MODE3) /*
>> mcasp0_axr0.spi1_d1 */
>>                          0x19c (PIN_OUTPUT_PULLUP | MUX_MODE3) /*
>> mcasp0_ahclkr.spi1_cs0 */
>>                          0x1a4 (PIN_INPUT | MUX_MODE7)  /* IRQ:
>> mcasp0_fsr.gpio3_19 */
>>                          0x1ac (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /*
>> SLP_TR: mcasp0_ahclkx.gpio3_21 */
>>                          0x044 (PIN_OUTPUT_PULLUP | MUX_MODE7) /*
>> RESET: gpmc_a1.gpio1_17 */
>>                  >;
>>          };
>> };
>>
>>
>> &spi1 {
>>          status = "okay";
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&spi1_pins>;
>>          at86rf231@0 {
>>                  compatible = "atmel,at86rf231";
>>                  spi-max-frequency = <7500000>;
>>                  reg = <0>;
>>                  interrupts = <19 4>;
>>                  interrupt-parent = <&gpio3>;
>>                  reset-gpio = <&gpio1 17>;
> Here you are missing the initial state of the reset gpio pin status.
>
> It has to be something like this:
> 	
> 		reset-gpio = <&gpio1 17 1>;
>
>>                  sleep-gpio = <&gpio3 31>;
> Same here also...
>
> 		sleep-gpio = <&gpio3 31 1>;
>
>>                  xtal-trim = /bits/ 8 <0xF>;
>>          };
>> };
>>
>>
>> At probe time, I get
>>
>> [    8.203574] /ocp/spi@481a0000/at86rf231@0: arguments longer than
>> property
>> [    8.210963] of_get_named_gpiod_flags: can't parse 'reset-gpio'
>> property of node '/ocp/spi@481a0000/at86rf231@0[0]'
>> [    8.210992] /ocp/spi@481a0000/at86rf231@0: arguments longer than
>> property
>> [    8.218231] of_get_named_gpiod_flags: can't parse 'sleep-gpio'
>> property of node '/ocp/spi@481a0000/at86rf231@0[0]'
>> [    9.830628] using random self ethernet address
>>
>>
>> Using e.g. "gpio1_17" doesn't compile, nor do other guesses.  What
>> syntax is expected for reset-gpio and sleep-gpio?
>>
>> My kernel id bluetooth-next pulled Monday,
>>
>> Linux beaglebone 4.0.0-rc7-244798-gf86c0e3 #1 SMP Wed Apr 15 10:34:12
>> EDT 2015 armv7l GNU/Linux
>>

With those changes the "arguments longer than property" message does go 
away.  I now get this probe error:


[    9.815400] of_get_named_gpiod_flags: parsed 'reset-gpio' property of 
node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
[    9.815437] of_get_named_gpiod_flags: parsed 'sleep-gpio' property of 
node '/ocp/spi@481a0000/at86rf231@0[0]' - stat)
[   10.287193] at86rf230 spi1.0: Non-Atmel dev found (MAN_ID 00 00)
[   10.971416] at86rf230: probe of spi1.0 failed with error -22



