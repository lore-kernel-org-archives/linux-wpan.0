Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53955 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbbE2DWP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 23:22:15 -0400
Date: Fri, 29 May 2015 06:22:13 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH,RFC bluetooth-next 1/2] ieee802154: Fix generation of
 random EUI-64 addresses.
Message-ID: <20150529032213.GM11340@wantstofly.org>
References: <20150528123832.GD11340@wantstofly.org>
 <20150528131714.GD716@omega>
 <20150528133948.GF11340@wantstofly.org>
 <20150528144249.GF716@omega>
 <20150528145351.GG716@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150528145351.GG716@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, May 28, 2015 at 04:53:51PM +0200, Alexander Aring wrote:

> Grml, I think I am getting too much confuses right now.

:-)


> > > Also compare your [0] with this document:
> > > 
> > > 	http://standards.ieee.org/develop/regauth/tut/eui48.pdf
> > > 
> > > And note how neither the EUI-48 nor the EUI-64 PDFs talk about group
> > > addresses -- this is because an EUI-{48,64} contains an OUI, and the
> > > OUI contains the scope/group bits, and so the documents explaining
> > > the EUI-{48,64} format are not the right place to discuss those bits,
> > > although they exist both in EUI-48 and in EUI-64 addresses.
> > > 
> > > Just the fact that 802.15.4 spec doesn't talk about multicast doesn't
> > > suddenly redefine the EUI-64 group bit as just another unicast address
> > > bit, in my humble opinion, but this is what Linux is currently doing.
> > >
> > 
> > The 802.15.4 spec doesn't also say any words about that the "extended
> > address" is an EUI-64 address. 6LoWPAN RFC says it should handled like a
> > EUI-64 [1]. General question is "Is the extended-address in 802.15.4
> > really meaning an EUI-64 address?". Sorry for this newbie question, but
> > this is what I am asking myself now.
> > 
> > What I see is that the extended-addr is described as "The 64-bit (IEEE)
> > address assigned to the device." Which says to me it's an EUI-64, or?
> > 
> > But then this means 0x00..00 and 0xff..ff are also valid, but IPv6 can't
> > deal with the 0x00..00.
> 
> forget this sentence. I mean this is true when extended_addr != EUI-64
> but I don't think that's true.

Right, OK, makes sense.


> > > From a hardware point of view, multicast packets should never be
> > > ACKed, so there is no need for the hardware to be aware of the active
> > > multicast addresses on this interface per se.  (We could theoretically
> > > pass the multicast address list for the interface to the hardware to
> > > allow doing frame filtering in hardware, but this does not affect
> > > operational correctness.)
> > 
> > So then we should also add a check of this bit at [0]? Then set the
> > ackreq bit to 0 if the bit is set?
> > 
> > > Whether we should be using EUI-64 group addresses on the "wire" for
> > > 802.15.4 for multicast (IPv6) traffic is another question, but using
> > > EUI-64 group addresses as station addresses just because the link
> > > layer doesn't define multicast functionality is wrong from my point
> > > of view.
> > 
> > When this address is invalid and the MAC layer doesn't use this bit.
> > Then we need to care that we drop all frames with the source address
> > with this bit. I also don't see that any transceiver with address
> > filtering enabled will drop this frame (okay they also don't filter 0x00..00
> > and 0xff...ff) frames.
> 
> I mean here how we should react globally about source address which have
> this bit set? When it's source address then we should drop it and
> destination address? I don't know. :-)

I don't think we can get away with changing our behavior to start being
strict about the source address group bit. :(
