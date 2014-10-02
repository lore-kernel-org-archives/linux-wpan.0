Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13604 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbaJBKMs (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 2 Oct 2014 06:12:48 -0400
Message-ID: <1412244764.13121.19.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type
 PACKET_OTHERHOST
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 02 Oct 2014 13:12:44 +0300
In-Reply-To: <20141002095841.GF3850@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
	 <20141002092804.GC3850@omega> <542D1C80.9050807@xsilon.com>
	 <1412242985.13121.11.camel@jrissane-mobl.ger.corp.intel.com>
	 <20141002095430.GE3850@omega> <20141002095841.GF3850@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, varkabhadram@gmail.com, marcel@holtmann.org

Hi Alex,

On to, 2014-10-02 at 11:58 +0200, Alexander Aring wrote:
> On Thu, Oct 02, 2014 at 11:54:30AM +0200, Alexander Aring wrote:
> > Jukka,
> > 
> > On Thu, Oct 02, 2014 at 12:43:05PM +0300, Jukka Rissanen wrote:
> > > Hi Simon,
> > > 
> > > On to, 2014-10-02 at 10:36 +0100, Simon Vincent wrote:
> > > > I will add this patch when I rebase on bluetooth-next.
> > > 
> > > and thanks for doing that.
> > > 
> > 
> > I see now, that the bluetooth layer never sets this value. I don't know
> > how bluetooth deal with that. But you need to set PACKET_HOST if packet
> > belongs to you, OTHERHOST if packets belongs not to you, or
> > PACKET_BROADCAST if packet belongs to you, but is a broadcast.
> > 
> > Also for PACKET_MULTICAST, if bluetooth support MULTICAST frames.
> > 
> > 
> > I think you need handling for this in bluetooth 6lowpan layer.
> > 
> 
> and this should be fixed before Simon's patches. I add Marcel here in
> cc, maybe he can bring some new information if bluetooth ever set's the
> pkt_type in sk_buff.
> 
> Point is IPv6 needs this information and we should set it to a valid value.
> ... and this is not always set PACKET_HOST, IPv6 also check on PACKET_BROADCAST.

Hmm, bluetooth 6lowpan is a bit different from ieee802154 as the
bluetooth link is a point-to-point one and typically only uses link
local addresses so normally every packet is really meant for that host.

I will investigate this a bit more, so perhaps it is best if Simon does
not change the pkt_type field after all. Everything seems to work just
fine with unicast and multicast packets at the moment (when pkt_type ==
PACKET_HOST).


Cheers,
Jukka


