Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53357 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbaLJL4S (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Dec 2014 06:56:18 -0500
Message-ID: <1418212574.32209.78.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCHv3 bluetooth-next 3/3] 6lowpan: nhc: add other known
 rfc6282 compressions
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 10 Dec 2014 13:56:14 +0200
In-Reply-To: <1418202242.32209.65.camel@jrissane-mobl.ger.corp.intel.com>
References: <1418053838-8692-1-git-send-email-alex.aring@gmail.com>
	 <1418053838-8692-4-git-send-email-alex.aring@gmail.com>
	 <1418124496.32209.47.camel@jrissane-mobl.ger.corp.intel.com>
	 <20141209115250.GA32681@omega>
	 <1418133949.32209.58.camel@jrissane-mobl.ger.corp.intel.com>
	 <20141209184250.GB32681@omega>
	 <1418202242.32209.65.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <mtownsend1973@gmail.com>

On ke, 2014-12-10 at 11:04 +0200, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ti, 2014-12-09 at 19:42 +0100, Alexander Aring wrote:
> > Hi Jukka,
> > 
> > On Tue, Dec 09, 2014 at 04:05:49PM +0200, Jukka Rissanen wrote:
> > > Hi Alex,
> > > 
> > > On ti, 2014-12-09 at 12:52 +0100, Alexander Aring wrote:
> > > > Hi Jukka,
> > > > 
> > > > On Tue, Dec 09, 2014 at 01:28:16PM +0200, Jukka Rissanen wrote:
> > > > > Hi Alex,
> > > > > 
> > > > > the module unloading caused some issues in the receiving end.
> > > > > 
> > > > > I tried this:
> > > > > * setup bluetooth 6lowpan connection
> > > > > * transfer some UDP data
> > > > > * unload the nhc_rfc6282_udp module (in one peer only, the other still
> > > > > had udp nhc module loaded)
> > > > > * try to send more data
> > > > > 
> > > > > This caused kernel crash in peer that had udp module unloaded:
> > > > > 
> > > > > 
> > > > 
> > > > mhh, okay. I don't know why this happens also the log gave me not much
> > > > information, but thanks anyway.
> > > > 
> > > > Maybe this is a global issue with bluetooth 6LoWPAN error handling.
> > > > 
> > > > Can you simple do something like this:
> > > > 
> > > > diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> > > > index 32ffec6..2228dce 100644
> > > > --- a/net/6lowpan/iphc.c
> > > > +++ b/net/6lowpan/iphc.c
> > > > @@ -425,6 +425,8 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
> > > >                         return -EINVAL;
> > > >         }
> > > >  
> > > > +       return -EINVAL;
> > > > +
> > > >         /* UDP data uncompression */
> > > >         if (iphc0 & LOWPAN_IPHC_NH_C) {
> > > >                 struct udphdr uh;
> > > > 
> > > > 
> > > > based on current bluetooth-next/master without the NHC framework.
> > > > 
> > > > This should be working, maybe you never hit any error while calling
> > > > lowpan_header_decompress function. It's simple testing the error
> > > > handling not more.
> > > 
> > > Hmm, I get the same crash here also without this patchset. So something
> > > goes wrong if <0 code is returned.
> > > 
> > 
> > Okay, do you already working on it?
> 
> Yes, I will investigate this.

Found the problem, in bt 6lowpan the skb that was freed was still used
by network stack. I will send a patch for this soon.

> 
> > 
> > > > 
> > > > Do this please on one node, the other node should send some 6LoWPAN IPHC
> > > > packets to check if the error handling working there.
> > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > Another issue is that I see that skb->dev isn't set before calling
> > > > lowpan_header_decompress. Because inside your log is a "NULL":
> > > > 
> > > > (NULL net_device): received unknown nhc id which was not found.
> > > > 
> > > > Can you change that? That skb->dev is set to before calling
> > > > lowpan_header_decompress.
> > > 
> > > I am setting the skb->dev after the call to lowpan_header_decompress().
> > > And anyway the skb->dev is only used when printing the err.
> > > Actually should we replace the skb->dev in lowpan_header_decompress()
> > > with plain dev as that is given to the function as a parameter. 
> > > 
> > 
> > Ok, how we introduce this now? You wanna add this do the patch series for
> > fixing the above issue, or should I add it to my patch series for
> > introduce nhc framework?
> 
> I am fine with either. If you have time, please go ahead and send a
> patch or I can do it also after figuring what is causing the crash.

After second though, can you do the change as actually what I had in
mind was to change the

      netdev_warn(skb->dev, ...)
to
      netdev_warn(dev, ...)

and that code is part of patch 2 of your patchset.

Another thing I noticed is that we need to rate limit the output as now
it might be that the warning is printed for every udp packet which is
way too much.


Cheers,
Jukka


