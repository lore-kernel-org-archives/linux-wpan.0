Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:37813 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaJBKWJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 06:22:09 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so2670338wgh.34
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 03:22:08 -0700 (PDT)
Date: Thu, 2 Oct 2014 12:22:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
Message-ID: <20141002102200.GA19732@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <20141002092804.GC3850@omega>
 <542D1C80.9050807@xsilon.com>
 <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
 <20141002095430.GE3850@omega>
 <20141002095841.GF3850@omega>
 <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com, marcel@holtmann.org

Hi Jukka,

On Thu, Oct 02, 2014 at 01:12:44PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On to, 2014-10-02 at 11:58 +0200, Alexander Aring wrote:
> > On Thu, Oct 02, 2014 at 11:54:30AM +0200, Alexander Aring wrote:
> > > Jukka,
> > > 
> > > On Thu, Oct 02, 2014 at 12:43:05PM +0300, Jukka Rissanen wrote:
> > > > Hi Simon,
> > > > 
> > > > On to, 2014-10-02 at 10:36 +0100, Simon Vincent wrote:
> > > > > I will add this patch when I rebase on bluetooth-next.
> > > > 
> > > > and thanks for doing that.
> > > > 
> > > 
> > > I see now, that the bluetooth layer never sets this value. I don't know
> > > how bluetooth deal with that. But you need to set PACKET_HOST if packet
> > > belongs to you, OTHERHOST if packets belongs not to you, or
> > > PACKET_BROADCAST if packet belongs to you, but is a broadcast.
> > > 
> > > Also for PACKET_MULTICAST, if bluetooth support MULTICAST frames.
> > > 
> > > 
> > > I think you need handling for this in bluetooth 6lowpan layer.
> > > 
> > 
> > and this should be fixed before Simon's patches. I add Marcel here in
> > cc, maybe he can bring some new information if bluetooth ever set's the
> > pkt_type in sk_buff.
> > 
> > Point is IPv6 needs this information and we should set it to a valid value.
> > ... and this is not always set PACKET_HOST, IPv6 also check on PACKET_BROADCAST.
> 
> Hmm, bluetooth 6lowpan is a bit different from ieee802154 as the
> bluetooth link is a point-to-point one and typically only uses link
> local addresses so normally every packet is really meant for that host.
> 
> I will investigate this a bit more, so perhaps it is best if Simon does
> not change the pkt_type field after all. Everything seems to work just
> fine with unicast and multicast packets at the moment (when pkt_type ==
> PACKET_HOST).
> 

Okay, then maybe bluetooth 6lowpan need to set it to PACKET_HOST always.

Another idea would be:
We could also set PACKET_BROADCAST if the IPv6 address is a
multicast/broadcast addresss.

But it looks wrong, the PACKET_FOO values should be set by mac layer only.


What I deteced is at [0]. There it checks if the "mac frame" was
broadcast or multicast. I don't know when this occurs, I need to check
this but it seems to be broken, when we always set the PACKET_HOST.



Simon had issues with routing when IPv6 Layer gets a skb with PACKET_HOST and
it was PACKET_OTHERHOSTS before.


Simon:

Maybe only send patch:

[PATCH linux-wpan 3/3] ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan

this should fix your routing problems, but issue with [0] still exists.

- Alex

[0] http://lxr.free-electrons.com/source/net/ipv6/mcast.c#L1413
