Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33583 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbbDNPHD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Apr 2015 11:07:03 -0400
Received: by wgin8 with SMTP id n8so15388774wgi.0
        for <linux-wpan@vger.kernel.org>; Tue, 14 Apr 2015 08:07:01 -0700 (PDT)
Date: Tue, 14 Apr 2015 17:06:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150414150656.GB2179@omega>
References: <551EDFCA.3070905@fid4.com>
 <20150403191320.GD773@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150403191320.GD773@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Apr 03, 2015 at 09:13:20PM +0200, Alexander Aring wrote:
> On Fri, Apr 03, 2015 at 02:45:30PM -0400, Michael C. Cambria wrote:
> > 
> > Hi Alex,
> > 
> > Do you happen to have the pin mapping & device tree overlay needed for the
> > Openlabs at86rf233 [0] to run on BeagleBone Black (BBB)?
> > 
> > I only have a few Pi's but do have a few spare BBB I could use. I'd rather
> > not experiment an ruin either the BBB or at86rf233 if this information is
> > known.
> > 
> 
> What I can give you are my dts entries for the BeagleBone (white),
> pinout should be the same:
> 
> &am33xx_pinmux {
> 	spi1_pins: pinmux_spi1_pins {
> 		pinctrl-single,pins = <
> 			0x190 0x33      /* mcasp0_aclkx.spi1_sclk, INPUT_PULLUP | MODE3 (special mode input for clock) */
> 			0x194 0x33      /* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
> 			0x198 0x13      /* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
> 			0x19c 0x13      /* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
> 			0x1a4 0x2f      /* mcasp0_fsr.gpio3_19, INPUT, PULL DISABLED | MODE7 */
> 		>;
> 	};
> };
> 

since somebody noticed me about several pinmux issues on this setup. I
will update them now with:

&am33xx_pinmux {
        spi1_pins: pinmux_spi1_pins {
                pinctrl-single,pins = <
                        0x190 (PIN_INPUT_PULLDOWN | MUX_MODE3) /* mcasp0_aclkx.spi1_sclk */
                        0x194 (PIN_INPUT | MUX_MODE3) /* mcasp0_fsx.spi1_d0 */
                        0x198 (PIN_OUTPUT_PULLDOWN | MUX_MODE3) /* mcasp0_axr0.spi1_d1 */
                        0x19c (PIN_OUTPUT_PULLUP | MUX_MODE3) /* mcasp0_ahclkr.spi1_cs0 */
                        0x1a4 (PIN_INPUT | MUX_MODE7)  /* IRQ: mcasp0_fsr.gpio3_19 */
                        0x1ac (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* SLP_TR: mcasp0_ahclkx.gpio3_21 */
                        0x044 (PIN_OUTPUT_PULLUP | MUX_MODE7) /* RESET: gpmc_a1.gpio1_17 */
                >;            
        };                    
};

This is what [0] describes at page 11, I hope. Can somebody report if it
was successful to get openlabs with bb/bbw working?

- Alex

[0] http://www.atmel.com/images/atmel-8351-mcu_wireless-at86rf233_datasheet.pdf (1.3.2 Pull-up and Pull-down Configuration)
