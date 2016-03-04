Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35794 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758587AbcCDIfm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2016 03:35:42 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so24033095wml.0
        for <linux-wpan@vger.kernel.org>; Fri, 04 Mar 2016 00:35:41 -0800 (PST)
Date: Fri, 4 Mar 2016 09:35:33 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4G support?
Message-ID: <20160304083528.GA1525@omega>
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega>
 <28981.1457015214@obiwan.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28981.1457015214@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

Hi,

On Thu, Mar 03, 2016 at 09:26:54AM -0500, Michael Richardson wrote:
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > You want to run 6LoWPAN on it, current the 802.15.4 calculates a lot of
>     > stuff with the IEEE802154_MTU define, in most cases when using
>     > fragmentation.
> 
>     > It seems you don't need fragmentation in your case, because you reach
>     > the 1280 minimum MTU for IPv6. The condition at [4] should be always
>     > true then.
> 
> I believe that they do, as 15.4g PHYs can communicate with 15.4 PHYs, and
> so the fragment on/off/MTU decision will need to be added to the neighbour
> cache.
> 

Okay, this really scares me now. You say that the these "SUN PHY's" use
the same modulation/band/preamble and can probaly talk with all other
PHY's.

That's for me something like a ethernet jumbo frame will talk with
another ethernet network which doesn't support jumbo frames.

(Don't know how they handle the situation then).

It scares me, because we have still the situation that we can't tell
much the L2-layer for special things from the neighbor cache. E.g. the
still important functionality to support short address handling. I
currently try to solve this and will try to take care for such possible
future handling.

>     > Another question would be: You can run 6LoWPAN on it, but nobody
>     > specifies to run 6LoWPAN on such "SUN PHY's". I actually don't see
>     > that. Everything is specified with 127 MTU.
> 
>     > I don't want to tell you cannot run 6LoWPAN on it, but does somebody
>     > need to specify 6LoWPAN for 802.15.4g at first?
> 
> WiSun alliance did that, I think.
> 

ok. Then the above situation about handling with "SUN PHYs" and all
other PHYs need to be specified there, or?

And another question is: Is that an open standard?

Can it be that there exits a closed 6lowpan standard somehow for a specific
link-layer? Okay, they probaly use IPHC and fragmentation handling of
6LoWPAN but all other parts can be closed then.

First try with google I didn't find anything.

- Alex
