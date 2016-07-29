Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51074 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbcG2PWH (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 29 Jul 2016 11:22:07 -0400
Date: Fri, 29 Jul 2016 11:22:04 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: Looking for boards with an 802.15.4 chip
Message-ID: <20160729152203.GD181121@redhat.com>
References: <20160728174051.GB75405@redhat.com>
 <10331.1469740794@obiwan.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10331.1469740794@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: aar@pengutronix.de, linux-wpan@vger.kernel.org, linville@redhat.com

On Thu, Jul 28, 2016 at 05:19:54PM -0400, Michael Richardson wrote:
> 
> Don Zickus <dzickus@redhat.com> wrote:
>     > I was wondering what boards/chips folks like yourself use to develop/test
>     > the 802.15.4 work?  I noticed the website  http://wpan.cakelab.org/
>     > mentions
> 
> It depends a lot on what you want to do, what pieces you want to hack on,
> and what devices you want to interoperate with.

Pretty simple.  Just want to see how well the technology works.  With all
the industry's talk about IoT, we are just trying to set up in our lab
various technologies that customers may ask us about.  And we want to see
how well it works with our products. :-)

> 
> The at86rf233 is popular and easily obtainable and Alex is doing lots of work
> to support it.  Get the openlabs device.  It seems that we might be able
> to support 6tisch on this device if we try hard enough, but for the moment
> you are restricted to 1 channel and aloha-only time slots.

Ok, thanks for the suggestion!

> 
> Many people are using openmote's connected via USB or via daughter card
> to an RPI.   The openmote does the 6tisch stuff, but "bridges" (but/wrong
> term, but have yet to find a better one) the raw 6lowpan packets over USB
> using a custom encapsulation.  (I'd like to change it to ppp actually)

Interesting so it would be 6lowpan over usb serial?

> 
>     > I assume the SPI bus is easily found on a rPI-like board.  Is it
>     > difficult to hook one of them up to an x86 desktop?
> 
> Yes, it's a bit painful since few desktops have easily accessible GPIO
> pins that you can turn into a SPI bus.  You can add one with a FTDI USB
> interface easily, but given the cost of an RPI... hard to argue.

Hehe.  Good point.

Thanks for the feedback!  I will probably buy some stuff and start playing
with it.

Cheers,
Don
