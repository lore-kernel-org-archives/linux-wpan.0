Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35933 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbDCTgr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Apr 2015 15:36:47 -0400
Received: by wgra20 with SMTP id a20so117910294wgr.3
        for <linux-wpan@vger.kernel.org>; Fri, 03 Apr 2015 12:36:46 -0700 (PDT)
Date: Fri, 3 Apr 2015 21:36:44 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: at86rf233 on BeagleBone Black
Message-ID: <20150403193643.GF773@omega>
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

I forgot something.

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

You should also declare your pinmux for your reset output pin here.
The first magic values you will get from the am33xx datasheet, If I
remember correctly that are some offset addresses.

But I am sure there exists also a lot of example outside in the www.

> 		>;
> 	};
> };
> 

- Alex
