Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:37769 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbDGTSO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 15:18:14 -0400
Date: Tue, 7 Apr 2015 21:17:40 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: hardware recommendation
Message-ID: <20150407191740.GA8588@bogon.m.sigxcpu.org>
References: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
 <20150323075818.GA4069@omega>
 <4E57CCC9-A879-457C-9471-9A83BA417CE5@cisco.com>
 <CAFUtXGzGeMmbSNtbP2xdjr6uitzFwPZCb3Yo-GV2+2gV3uz6+w@mail.gmail.com>
 <978F3708-BC58-46E5-AED3-3C4CE1C4BBD3@cisco.com>
 <20150407185917.GF16415@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150407185917.GF16415@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, "Ralph Droms (rdroms)" <rdroms@cisco.com>, Maciej Wasilak <wasilak@gmail.com>

Hi,
On Tue, Apr 07, 2015 at 08:59:20PM +0200, Alexander Aring wrote:
> Hi Ralph,
> 
> On Tue, Apr 07, 2015 at 06:12:49PM +0000, Ralph Droms (rdroms) wrote:
> > 
> > > On Mar 26, 2015, at 2:44 AM 3/26/15, Maciej Wasilak <wasilak@gmail.com> wrote:
> > > 
> > > Dear Ralph,
> > > 
> > > I confirm it's possible to use USB and Ethernet on RaspberryPi with bluetooth-next. You have to enable kernel options:
> > > 
> > > CONFIG_USB_DWC2_HOST
> > > CONFIG_USB_DWC2_PLATFORM 
> > 
> > Are there any other changes to a clone of bluetooth-next I need to make to build a Raspberry Pi kernel?  I tried naively building bluetooth-next with an updated, known good .config but the resulting kernel doesn't seem to be operational.
> > 
> 
> A lastest "known to work config" can be found at [0].
> 
> But you need to boot with device tree, then it depends on plus model or
> not, see [1] or [2]. You need to tell your bootloader where the device
> tree file is found. Also the device tree file is usually a binary
> format, you need to convert the dts file with dtc to some dtb file.

I recently went through this using device tree. Had to minimally patch
device tree due to using "Raspberry Pi 802.15.4 radio" from Openlabs and
it worked fine after tweaking defconfig a tiny bit to enable
6LoWPAN. Notes are here:

    https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

The current tree I'm using is at:

    https://github.com/agx/linux-wpan-next/tree/rpi-6lowpan

It's basically bluetooth-next as of
baf880a96859cca79208122e555e7efeabd16e4d + the device tree and defconfig
changes. Ethernet works fine here too.

Cheers,
 -- Guido
