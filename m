Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:44730 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbbBXQSB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 11:18:01 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv4 bluetooth-next 0/2] at86rf230: add support for xtal trim register
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 24 Feb 2015 08:17:53 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <EF479A57-17F1-423B-82B2-53C5A26148C4@holtmann.org>
References: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de, Werner Almesberger <werner@almesberger.net>, Thomas Stilwell <stilwellt@openlabs.co>

Hi Alex,

> I want to clarify how xtal_trim value is calculated now.
> 
> First of all the xtal_mode set to 0x5 will require a 16 Mhz clock signal at
> pin 26. I don't have such at86rf2xx board which can do that, so I don't want
> to support it right now.
> 
> IMPORTANT:
> The xtal_mode for external frequency differs per at86rf2xx transceiver. For
> at86rf230/at86rf231 it's 0x4. For at86rf233 it's 0x5. (Thanks Werner
> Almesberger who pointed this out). That doesn't matter right now, because we
> don't change the "normal" mode.
> 
> 
> The xtal_trim is only necesarry for external crystal, when xtal_mode == 0xF.
> The xtal_trim value is calculated by:
> 
> CL = capacitor of used crystal
> CX = connected capacitors at xtal pins
> CPAR = in all at86rf2xx datasheets this is a constant value 3 pF,
>       but this is different on each board setup. You need to fine
>       tuning this value via CTRIM.
> CTRIM = variable capacitor setting. Resolution is 0.3 pF range is
>        0 pF upto 4.5 pF.
> 
> CL = 0.5 * (CX + CTRIM + CPAR)
> 
> 
> Examples:
> 
> On atben [0]:
> 
> CL = 8 pF
> CX = 12 pF
> CPAR = 3 pF (We assume the magic constant from datasheet)
> CTRIM = 0.9 pF
> 
> (12+0.9+3)/2 = 7.95 which is nearly at 8 pF
> 
> openlabs [1]:
> 
> CL = 16 pF
> CX = 22 pF
> CPAR = 3 pF (We assume the magic constant from datasheet)
> CTRIM = 4.5 pF
> 
> (22+4.5+3)/2 = 14.75 which is the nearest value to 16 pF
> 
> For more information it's the section "Integrated Oscillator Setup" inside
> the at86rf2xx datasheets. (In my case 8111C–MCU Wireless–09/09).
> 
> For a better calculation of the CPAR value, Werner Almesberger developed some
> diagnostic tool [2], which I don't tried out yet.

don't you want to put this kind of information either in the commit message of the patch or actually as comment in the source code. If you keep it in the cover letter, then this will not be part of the source tree in any form or shape.

Regards

Marcel

