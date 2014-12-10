Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57386 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbaLJMFG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Dec 2014 07:05:06 -0500
Date: Wed, 10 Dec 2014 13:04:56 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 3/3] 6lowpan: nhc: add other known
 rfc6282 compressions
Message-ID: <20141210120453.GA24018@omega>
References: <1418053838-8692-1-git-send-email-alex.aring@gmail.com>
 <1418053838-8692-4-git-send-email-alex.aring@gmail.com>
 <1418124496.32209.47.camel@jrissane-mobl.ger.corp.intel.com>
 <20141209115250.GA32681@omega>
 <1418133949.32209.58.camel@jrissane-mobl.ger.corp.intel.com>
 <20141209184250.GB32681@omega>
 <1418202242.32209.65.camel@jrissane-mobl.ger.corp.intel.com>
 <1418212574.32209.78.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1418212574.32209.78.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <mtownsend1973@gmail.com>

Hi Jukka,

On Wed, Dec 10, 2014 at 01:56:14PM +0200, Jukka Rissanen wrote:
> 
> Found the problem, in bt 6lowpan the skb that was freed was still used
> by network stack. I will send a patch for this soon.
> 

ok.

> > 
> > > 
> > > > > 
> > > > > Do this please on one node, the other node should send some 6LoWPAN IPHC
> > > > > packets to check if the error handling working there.
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > Another issue is that I see that skb->dev isn't set before calling
> > > > > lowpan_header_decompress. Because inside your log is a "NULL":
> > > > > 
> > > > > (NULL net_device): received unknown nhc id which was not found.
> > > > > 
> > > > > Can you change that? That skb->dev is set to before calling
> > > > > lowpan_header_decompress.
> > > > 
> > > > I am setting the skb->dev after the call to lowpan_header_decompress().
> > > > And anyway the skb->dev is only used when printing the err.
> > > > Actually should we replace the skb->dev in lowpan_header_decompress()
> > > > with plain dev as that is given to the function as a parameter. 
> > > > 
> > > 
> > > Ok, how we introduce this now? You wanna add this do the patch series for
> > > fixing the above issue, or should I add it to my patch series for
> > > introduce nhc framework?
> > 
> > I am fine with either. If you have time, please go ahead and send a
> > patch or I can do it also after figuring what is causing the crash.
> 
> After second though, can you do the change as actually what I had in
> mind was to change the
> 
>       netdev_warn(skb->dev, ...)
> to
>       netdev_warn(dev, ...)
> 
> and that code is part of patch 2 of your patchset.
> 
> Another thing I noticed is that we need to rate limit the output as now
> it might be that the warning is printed for every udp packet which is
> way too much.
> 

ok. Or maybe simple remove the output, or make it only visable on
debugging. I don't really know what's the best notice for use that the
packet was dropping because invalid/unsupported packets.

I will do it to ratelimit and add patches for the netdev_warn(dev, ...)
thing. Currently I am working a little bit on the 802154 branch again.

I will start this work when you are done with the above fix.

- Alex
