Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37885 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760138AbcCDQiD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 11:38:03 -0500
Received: by mail-wm0-f44.google.com with SMTP id p65so35975536wmp.0
        for <linux-wpan@vger.kernel.org>; Fri, 04 Mar 2016 08:38:02 -0800 (PST)
Date: Fri, 4 Mar 2016 17:37:55 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4G support?
Message-ID: <20160304163749.GA21798@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega>
 <28981.1457015214@obiwan.sandelman.ca>
 <20160304083528.GA1525@omega>
 <24416.1457106776@obiwan.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24416.1457106776@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

On Fri, Mar 04, 2016 at 10:52:56AM -0500, Michael Richardson wrote:
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > On Thu, Mar 03, 2016 at 09:26:54AM -0500, Michael Richardson wrote:
>     >> Alexander Aring <alex.aring@gmail.com> wrote: > You want to run
>     >> 6LoWPAN on it, current the 802.15.4 calculates a lot of > stuff with
>     >> the IEEE802154_MTU define, in most cases when using > fragmentation.
>     >>
>     >> > It seems you don't need fragmentation in your case, because you
>     >> reach > the 1280 minimum MTU for IPv6. The condition at [4] should be
>     >> always > true then.
>     >>
>     >> I believe that they do, as 15.4g PHYs can communicate with 15.4 PHYs,
>     >> and so the fragment on/off/MTU decision will need to be added to the
>     >> neighbour cache.
> 
> 
>     > Okay, this really scares me now. You say that the these "SUN PHY's" use
>     > the same modulation/band/preamble and can probaly talk with all other
>     > PHY's.
> 
> Yes, that's my belief.
> Maybe they don't use the same modulation when they send bigger frames, but
> they can speak to 15.4-noletter,/15.4e.
> (Note: 802.15.4-2015 includes all of e, and I think, all of the g work too,
> making it harder to know which is which when speaking)
> 

ok.

>     > That's for me something like a ethernet jumbo frame will talk with
>     > another ethernet network which doesn't support jumbo frames.
> 
> No, that's not the case.
> Both Ethernet and 802.15.4 can not send "jumbo" frames to non-jumbo nodes, it
> just won't work.   They have to send smaller frames.
> The ARP and ND process has a way to say what the MTU is.
> But, in the 802.15.4 case, the affect is not on the L3 MTU, but the L2 MTU.
> 

ok.

>     > It scares me, because we have still the situation that we can't tell
>     > much the L2-layer for special things from the neighbor cache. E.g. the
>     > still important functionality to support short address handling. I
>     > currently try to solve this and will try to take care for such possible
>     > future handling.
> 
> Yes -- exactly, this is more L2 info needed in the neighbour cache.
> 

Yes, sir. :-)

>     >> > Another question would be: You can run 6LoWPAN on it, but nobody >
>     >> specifies to run 6LoWPAN on such "SUN PHY's". I actually don't see >
>     >> that. Everything is specified with 127 MTU.
>     >>
>     >> > I don't want to tell you cannot run 6LoWPAN on it, but does somebody
>     >> > need to specify 6LoWPAN for 802.15.4g at first?
>     >>
>     >> WiSun alliance did that, I think.
>     >>
> 
>     > ok. Then the above situation about handling with "SUN PHYs" and all
>     > other PHYs need to be specified there, or?
> 
>     > And another question is: Is that an open standard?
> 
> https://www.wi-sun.org/ seems relatively open, it's just 802.15.4g, I think.
> And https://datatracker.ietf.org/doc/draft-ietf-roll-applicability-ami/
> is mostly about 4g.
> 

Okay. I think at first normal 127-bytes frames need to be send. After if
you are sure that your "neighbor" uses a "SUN Phy" then you need to
change the MTU (during runtime) for this special neighbor so a different
handling can be done.

Depends if you really want such handling as default behaviour.

Something like that, but I am not sure how it really would working and
don't know how the "indentification it's a SUN Phy or not will work",
the MAC frame format has some extensions with "capabilities" maybe
somehow while parsing mac frame in L2 which indicates the transmitted
node as a "SUN Phy".

Maybe there exists also a L3 mechanism to indicate a "SUN Phy", e.g.
an Option-Field. (I would more like such handling than that the L2 header
indicates it somehow). I suppose the right website to lookup such thing
is [0], but didn't find anything related to that.

(about fragmentation handling for 4g):
The [1] say something about that fragmentation/reassembly is not
necessary when using 2048 frames. :-)

- Alex

[0] https://www.iana.org/assignments/icmpv6-parameters/icmpv6-parameters.xml#icmpv6-parameters-5
[1] https://tools.ietf.org/html/draft-ietf-roll-applicability-ami-11#section-7.2.2
