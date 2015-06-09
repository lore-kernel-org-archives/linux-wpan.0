Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:58582 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbbFIImv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 04:42:51 -0400
Date: Tue, 9 Jun 2015 10:42:17 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: RPi model B - bluetooth-next kernel, shutdown always reboots the
 RPi
Message-ID: <20150609084217.GA5456@bogon.m.sigxcpu.org>
References: <20150604063416.GA3045@probook-6560b>
 <20150604074123.GC13133@omega>
 <20150604093315.GB3045@probook-6560b>
 <20150605090541.GA16437@bogon.m.sigxcpu.org>
 <20150608122931.GA3863@arazu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150608122931.GA3863@arazu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

On Mon, Jun 08, 2015 at 02:29:31PM +0200, Christoffer Holmstedt wrote:
> On Fri, Jun 05, 2015 at 11:05:41AM +0200, Guido Günther wrote:
> > On Thu, Jun 04, 2015 at 11:33:16AM +0200, Christoffer Holmstedt wrote:
> > > On Thu, Jun 04, 2015 at 09:41:26AM +0200, Alexander Aring wrote:
> > > > On Thu, Jun 04, 2015 at 08:34:16AM +0200, Christoffer Holmstedt wrote:
> > > > > I know some of you are using the RPi as well so I start by asking here, perhaps
> > > > > linux-rpi-kernel list is the next step. When I run "shutdown -h 0" the RPi
> > > > 
> > > > Maybe try "halt"? "halt" should shutdown your RPi, means unmounting
> > > > filesystems etc. and stops there (without rebooting) Then it should be
> > > > safe to pull the plug.
> > > > 
> > > > To poweroff the RPi, the RPi can't do that, it only can reboot itself
> > > > which is solved by some watchdog timeout, I suppose. Maybe there exists
> > > > self-builded solutions somewhere on RPi sites to shutdown the RPi
> > > > somehow (means poweroff).
> > > > 
> > > > - Alex
> > > 
> > > "shutdown -h 0", halt, poweroff all end up with the same result. Rebooting
> > > U-Boot and eventually starting Raspbian.
> > > 
> > > Yea, I probably have to look deeper into some RPi sources and find out how it
> > > works in the 3.18.y series.
> > 
> > This might not help much but I'm seeing the same behaviour here but did
> > not get around to look into this.
> > Cheers,
> >  -- Guido
> 
> That is helpful, at least I know I'm not alone. Can you specify which version
> of U-Boot you are using (or are you using another boot loader)?
> Alexander isn't using U-Boot so maybe it is something there that is
> problematic (I'm using a really old version of U-Boot).

I'm using

    v2015.04-rc4-45-g21866c3

as of commit 21866c34a1b4098a8868c9250daf01baf84c2397.
Cheers,
 -- Guido
