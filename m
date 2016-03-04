Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:45885 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235AbcCDPw7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 10:52:59 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: 802.15.4G support?
In-Reply-To: <20160304083528.GA1525@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com> <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24415.1457106776.1@obiwan.sandelman.ca>
Date: Fri, 04 Mar 2016 10:52:56 -0500
Message-ID: <24416.1457106776@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

Alexander Aring <alex.aring@gmail.com> wrote:
    > On Thu, Mar 03, 2016 at 09:26:54AM -0500, Michael Richardson wrote:
    >> Alexander Aring <alex.aring@gmail.com> wrote: > You want to run
    >> 6LoWPAN on it, current the 802.15.4 calculates a lot of > stuff with
    >> the IEEE802154_MTU define, in most cases when using > fragmentation.
    >>
    >> > It seems you don't need fragmentation in your case, because you
    >> reach > the 1280 minimum MTU for IPv6. The condition at [4] should be
    >> always > true then.
    >>
    >> I believe that they do, as 15.4g PHYs can communicate with 15.4 PHYs,
    >> and so the fragment on/off/MTU decision will need to be added to the
    >> neighbour cache.


    > Okay, this really scares me now. You say that the these "SUN PHY's" use
    > the same modulation/band/preamble and can probaly talk with all other
    > PHY's.

Yes, that's my belief.
Maybe they don't use the same modulation when they send bigger frames, but
they can speak to 15.4-noletter,/15.4e.
(Note: 802.15.4-2015 includes all of e, and I think, all of the g work too,
making it harder to know which is which when speaking)

    > That's for me something like a ethernet jumbo frame will talk with
    > another ethernet network which doesn't support jumbo frames.

No, that's not the case.
Both Ethernet and 802.15.4 can not send "jumbo" frames to non-jumbo nodes, it
just won't work.   They have to send smaller frames.
The ARP and ND process has a way to say what the MTU is.
But, in the 802.15.4 case, the affect is not on the L3 MTU, but the L2 MTU.

    > It scares me, because we have still the situation that we can't tell
    > much the L2-layer for special things from the neighbor cache. E.g. the
    > still important functionality to support short address handling. I
    > currently try to solve this and will try to take care for such possible
    > future handling.

Yes -- exactly, this is more L2 info needed in the neighbour cache.

    >> > Another question would be: You can run 6LoWPAN on it, but nobody >
    >> specifies to run 6LoWPAN on such "SUN PHY's". I actually don't see >
    >> that. Everything is specified with 127 MTU.
    >>
    >> > I don't want to tell you cannot run 6LoWPAN on it, but does somebody
    >> > need to specify 6LoWPAN for 802.15.4g at first?
    >>
    >> WiSun alliance did that, I think.
    >>

    > ok. Then the above situation about handling with "SUN PHYs" and all
    > other PHYs need to be specified there, or?

    > And another question is: Is that an open standard?

https://www.wi-sun.org/ seems relatively open, it's just 802.15.4g, I think.
And https://datatracker.ietf.org/doc/draft-ietf-roll-applicability-ami/
is mostly about 4g.

    > Can it be that there exits a closed 6lowpan standard somehow for a
    > specific link-layer? Okay, they probaly use IPHC and fragmentation
    > handling of 6LoWPAN but all other parts can be closed then.



--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [

