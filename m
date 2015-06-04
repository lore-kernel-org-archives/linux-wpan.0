Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46369 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045AbbFDJdT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 05:33:19 -0400
Date: Thu, 4 Jun 2015 11:33:16 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: RPi model B - bluetooth-next kernel, shutdown always reboots the
 RPi
Message-ID: <20150604093315.GB3045@probook-6560b>
References: <20150604063416.GA3045@probook-6560b>
 <20150604074123.GC13133@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150604074123.GC13133@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 09:41:26AM +0200, Alexander Aring wrote:
> On Thu, Jun 04, 2015 at 08:34:16AM +0200, Christoffer Holmstedt wrote:
> > I know some of you are using the RPi as well so I start by asking here, perhaps
> > linux-rpi-kernel list is the next step. When I run "shutdown -h 0" the RPi
> 
> Maybe try "halt"? "halt" should shutdown your RPi, means unmounting
> filesystems etc. and stops there (without rebooting) Then it should be
> safe to pull the plug.
> 
> To poweroff the RPi, the RPi can't do that, it only can reboot itself
> which is solved by some watchdog timeout, I suppose. Maybe there exists
> self-builded solutions somewhere on RPi sites to shutdown the RPi
> somehow (means poweroff).
> 
> - Alex

"shutdown -h 0", halt, poweroff all end up with the same result. Rebooting
U-Boot and eventually starting Raspbian.

Yea, I probably have to look deeper into some RPi sources and find out how it
works in the 3.18.y series.

-- 
Christoffer Holmstedt
