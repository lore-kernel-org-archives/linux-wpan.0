Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45403 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaJBK3p (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 06:29:45 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so3436174wiv.11
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 03:29:44 -0700 (PDT)
Date: Thu, 2 Oct 2014 12:29:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Linux WPAN sources for ZigBee porting
Message-ID: <20141002102941.GC19732@omega>
References: <CAAdqeRSU=irjdpERicLhZ=cT_cBBfsDEXWeVr7V4z0=OgB2xYw@mail.gmail.com>
 <20141002084013.GA18438@omega>
 <CAAdqeRQu3-uYVHP-OE7eT839btnf8VmuaEuTr9kx3M_pRMXTWg@mail.gmail.com>
 <20141002102717.GB19732@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141002102717.GB19732@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Evgeniy Eksarevsky <eexarevsky@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

On Thu, Oct 02, 2014 at 12:27:17PM +0200, Alexander Aring wrote:
> Hi,
> 
> > >
> > >> Just now I am trying to define which MAC features required by ZigBee exist
> > >> and which are missing.
> > >
> > > many.
> > 
> > I know... For now it looks like not using Linux wpan is simpler than use it.
> > 
> 
> correct.
> 
> > >
> > >>
> > >> Which WPAN sources I need to look into?
> > >> Is it official Linux kernel?
> > >> Is it in https://github.com/linux-wpan/linux-wpan-next ?
> > >
> > > Yes it is.
> > >
> > > master: things which should be mainline.
> > > testing: patches for integrating process.
> > 
> > ok, thanks.
> > 
> > >
> > >> Which branch?
> > >>
> > >> Is serial protocol v.2 already implemented?
> > >
> > > No, also v1 isn't mainline.
> > 
> > Yes, I already found a patch for v1.
> > What i definitely need from the serial protocol is ability to do indirect send.
> > 
> 
> indirect send?
> 
> > >
> > >> What do you think about its modification if it will be necessary for
> > >> ZigBee? It will be, for sure...
> > >>
> > >
> > > mac802.15.4 isn't in an useable state. I am currently try to change it
> > > look in the rework branch.
> > 
> > wpan_rework_rfc?
> > 
> 
> Yes, but it's not in a mainline state. I disabled for integrating
> process the 802.15.4 address family. For ZigBee userspace stuff you need
> definitely af802154. I could give you the advice to make everything on
> 802.15.4 RAW sockets. DGRAM sockets are only for data frames and the userspace
> API will be changed eventually.
> 

Okay, netlink interface will definitely be changed in future. Sorry.

- Alex
