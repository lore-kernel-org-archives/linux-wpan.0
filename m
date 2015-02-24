Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:44742 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbBXQuZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Feb 2015 11:50:25 -0500
Received: by wggx12 with SMTP id x12so6539980wgg.11
        for <linux-wpan@vger.kernel.org>; Tue, 24 Feb 2015 08:50:24 -0800 (PST)
Date: Tue, 24 Feb 2015 17:50:17 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv4 bluetooth-next 0/2] at86rf230: add support for xtal
 trim register
Message-ID: <20150224165013.GA24422@omega>
References: <1424793301-29931-1-git-send-email-alex.aring@gmail.com>
 <EF479A57-17F1-423B-82B2-53C5A26148C4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EF479A57-17F1-423B-82B2-53C5A26148C4@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de, Werner Almesberger <werner@almesberger.net>, Thomas Stilwell <stilwellt@openlabs.co>

Hi Marcel,

On Tue, Feb 24, 2015 at 08:17:53AM -0800, Marcel Holtmann wrote:
> Hi Alex,
> 
> > I want to clarify how xtal_trim value is calculated now.
> > 
> > First of all the xtal_mode set to 0x5 will require a 16 Mhz clock signal at
> > pin 26. I don't have such at86rf2xx board which can do that, so I don't want
> > to support it right now.
> > 
> > IMPORTANT:
> > The xtal_mode for external frequency differs per at86rf2xx transceiver. For
> > at86rf230/at86rf231 it's 0x4. For at86rf233 it's 0x5. (Thanks Werner
> > Almesberger who pointed this out). That doesn't matter right now, because we
> > don't change the "normal" mode.
> > 
> > 
> > The xtal_trim is only necesarry for external crystal, when xtal_mode == 0xF.
> > The xtal_trim value is calculated by:
> > 
> > CL = capacitor of used crystal
> > CX = connected capacitors at xtal pins
> > CPAR = in all at86rf2xx datasheets this is a constant value 3 pF,
> >       but this is different on each board setup. You need to fine
> >       tuning this value via CTRIM.
> > CTRIM = variable capacitor setting. Resolution is 0.3 pF range is
> >        0 pF upto 4.5 pF.
> > 
> > CL = 0.5 * (CX + CTRIM + CPAR)
> > 
> > 
> > Examples:
> > 
> > On atben [0]:
> > 
> > CL = 8 pF
> > CX = 12 pF
> > CPAR = 3 pF (We assume the magic constant from datasheet)
> > CTRIM = 0.9 pF
> > 
> > (12+0.9+3)/2 = 7.95 which is nearly at 8 pF
> > 
> > openlabs [1]:
> > 
> > CL = 16 pF
> > CX = 22 pF
> > CPAR = 3 pF (We assume the magic constant from datasheet)
> > CTRIM = 4.5 pF
> > 
> > (22+4.5+3)/2 = 14.75 which is the nearest value to 16 pF
> > 
> > For more information it's the section "Integrated Oscillator Setup" inside
> > the at86rf2xx datasheets. (In my case 8111C–MCU Wireless–09/09).
> > 
> > For a better calculation of the CPAR value, Werner Almesberger developed some
> > diagnostic tool [2], which I don't tried out yet.
> 
> don't you want to put this kind of information either in the commit message of the patch or actually as comment in the source code. If you keep it in the cover letter, then this will not be part of the source tree in any form or shape.
> 

ok.

- Alex
