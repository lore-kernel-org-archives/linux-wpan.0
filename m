Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33669 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbbFEJMv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 05:12:51 -0400
Received: by wgez8 with SMTP id z8so51806754wge.0
        for <linux-wpan@vger.kernel.org>; Fri, 05 Jun 2015 02:12:50 -0700 (PDT)
Date: Fri, 5 Jun 2015 11:12:43 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: RPi model B - bluetooth-next kernel, shutdown always reboots the
 RPi
Message-ID: <20150605091239.GA30035@omega>
References: <20150604063416.GA3045@probook-6560b>
 <20150604074123.GC13133@omega>
 <20150604093315.GB3045@probook-6560b>
 <20150605090541.GA16437@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150605090541.GA16437@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Christoffer Holmstedt <christoffer@christofferholmstedt.se>, linux-wpan@vger.kernel.org

On Fri, Jun 05, 2015 at 11:05:41AM +0200, Guido Günther wrote:
> On Thu, Jun 04, 2015 at 11:33:16AM +0200, Christoffer Holmstedt wrote:
> > On Thu, Jun 04, 2015 at 09:41:26AM +0200, Alexander Aring wrote:
> > > On Thu, Jun 04, 2015 at 08:34:16AM +0200, Christoffer Holmstedt wrote:
> > > > I know some of you are using the RPi as well so I start by asking here, perhaps
> > > > linux-rpi-kernel list is the next step. When I run "shutdown -h 0" the RPi
> > > 
> > > Maybe try "halt"? "halt" should shutdown your RPi, means unmounting
> > > filesystems etc. and stops there (without rebooting) Then it should be
> > > safe to pull the plug.
> > > 
> > > To poweroff the RPi, the RPi can't do that, it only can reboot itself
> > > which is solved by some watchdog timeout, I suppose. Maybe there exists
> > > self-builded solutions somewhere on RPi sites to shutdown the RPi
> > > somehow (means poweroff).
> > > 
> > > - Alex
> > 
> > "shutdown -h 0", halt, poweroff all end up with the same result. Rebooting
> > U-Boot and eventually starting Raspbian.
> > 
> > Yea, I probably have to look deeper into some RPi sources and find out how it
> > works in the 3.18.y series.
> 
> This might not help much but I'm seeing the same behaviour here but did
> not get around to look into this.
> Cheers,

I am using barebox [0] as bootloader and not seeing this issue. When I
type "halt" several messages are shown and ends with:

[  127.095945] reboot: System halted

no reboot.

- Alex

[0] http://barebox.org/
