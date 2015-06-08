Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47012 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752798AbbFHM3o (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Jun 2015 08:29:44 -0400
Date: Mon, 8 Jun 2015 14:29:31 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: RPi model B - bluetooth-next kernel, shutdown always reboots the
 RPi
Message-ID: <20150608122931.GA3863@arazu>
References: <20150604063416.GA3045@probook-6560b>
 <20150604074123.GC13133@omega>
 <20150604093315.GB3045@probook-6560b>
 <20150605090541.GA16437@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150605090541.GA16437@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

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
>  -- Guido

That is helpful, at least I know I'm not alone. Can you specify which version
of U-Boot you are using (or are you using another boot loader)?
Alexander isn't using U-Boot so maybe it is something there that is
problematic (I'm using a really old version of U-Boot).

btw. I'm experiencing the exact same behaviour now on my new
Broadwell based laptop...the plot thickens ;)

Regards
-- 
Christoffer Holmstedt
