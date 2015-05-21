Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33227 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbbEUPjS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 11:39:18 -0400
Received: by wicmx19 with SMTP id mx19so16855673wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 21 May 2015 08:39:17 -0700 (PDT)
Date: Thu, 21 May 2015 17:39:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH atubs-fw 0/4] ATUSB firmware changes towards a 0.2 release
Message-ID: <20150521153910.GB901@omega>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
 <555C8A77.3070203@datenfreihafen.org>
 <555DEE4E.4020307@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <555DEE4E.4020307@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, werner@almesberger.net

On Thu, May 21, 2015 at 04:40:14PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 20/05/15 15:21, Stefan Schmidt wrote:
> >Hello.
> >
> >On 20/05/15 15:18, Stefan Schmidt wrote:
> >>Hello.
> >>
> >>Nothing to be appliad to the kernel but rather the atusb firmware repo. Just
> >>sending it here as it is releated to the mainline driver and the device users
> >>are reading here.
> >>
> >>These are the four patches I consider we need to have a working 0.2 release.
> >>The revert might be only needed for my qemu setup with USB passthrough, but
> >>without it I'm not able to get the device to show up in qemu. Thoughts
> >>appreciated.
> >>
> >>Using RX_AACK_ON sounds like a good idea as we loose nothing but work also work
> >>well with nodes using ARET.
> >>
> >>Bumping to version 0.2 and adding the need magic to add a valid DFU suffix to
> >>the firmware file. I will followup with a mail attaching the binary I'm using
> >>right now and I consider the final 0.2 if everyone agrees with these patches.
> >>
> >Binary firmware image attached. Alexander, if you could give that a test
> >it would be appreciated.
> >
> >Everyone else with a atusb please test as well if you have the time.
> 
> The pending patches have been pushed and I tagged the atusb firmware 0.2
> release in git:
> http://projects.qi-hardware.com/index.php/p/ben-wpan/source/changes/v0.2-atusb-fw/
> 
> The firmware binary should be available from the website soon. If you are
> eager you can get it here:
> http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/web/releases/atusb-0.2.dfu
> 
> If anyone has patches for the firmware pending or upcoming please CC me. I
> should be able help reviewing, testing and pushing them.
> 

Maybe send patches to be maintainer of atusb driver? I could review
also some firmware things when it's related to talk the with the
at86rf231 transceiver.

- Alex
