Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36609 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbbDGS7Y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 14:59:24 -0400
Received: by wizk4 with SMTP id k4so28817308wiz.1
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 11:59:23 -0700 (PDT)
Date: Tue, 7 Apr 2015 20:59:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: hardware recommendation
Message-ID: <20150407185917.GF16415@omega>
References: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
 <20150323075818.GA4069@omega>
 <4E57CCC9-A879-457C-9471-9A83BA417CE5@cisco.com>
 <CAFUtXGzGeMmbSNtbP2xdjr6uitzFwPZCb3Yo-GV2+2gV3uz6+w@mail.gmail.com>
 <978F3708-BC58-46E5-AED3-3C4CE1C4BBD3@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <978F3708-BC58-46E5-AED3-3C4CE1C4BBD3@cisco.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Ralph Droms (rdroms)" <rdroms@cisco.com>
Cc: Maciej Wasilak <wasilak@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Ralph,

On Tue, Apr 07, 2015 at 06:12:49PM +0000, Ralph Droms (rdroms) wrote:
> 
> > On Mar 26, 2015, at 2:44 AM 3/26/15, Maciej Wasilak <wasilak@gmail.com> wrote:
> > 
> > Dear Ralph,
> > 
> > I confirm it's possible to use USB and Ethernet on RaspberryPi with bluetooth-next. You have to enable kernel options:
> > 
> > CONFIG_USB_DWC2_HOST
> > CONFIG_USB_DWC2_PLATFORM 
> 
> Are there any other changes to a clone of bluetooth-next I need to make to build a Raspberry Pi kernel?  I tried naively building bluetooth-next with an updated, known good .config but the resulting kernel doesn't seem to be operational.
> 

A lastest "known to work config" can be found at [0].

But you need to boot with device tree, then it depends on plus model or
not, see [1] or [2]. You need to tell your bootloader where the device
tree file is found. Also the device tree file is usually a binary
format, you need to convert the dts file with dtc to some dtb file.



Or do you mean mainline networking support? This doesn't work on my side, too.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/arch/arm/configs/bcm2835_defconfig
[1] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
[2] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/arch/arm/boot/dts/bcm2835-rpi-b.dts
