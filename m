Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34726 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbDQV4F (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Apr 2015 17:56:05 -0400
Received: by widjs5 with SMTP id js5so42751271wid.1
        for <linux-wpan@vger.kernel.org>; Fri, 17 Apr 2015 14:56:03 -0700 (PDT)
Date: Fri, 17 Apr 2015 23:56:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [joao.p.taveira@gmail.com: Re: [Roll] Looking for Linux
 implementation of RPL for interop testing]
Message-ID: <20150417215600.GB847@omega>
References: <20150417214036.GA847@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150417214036.GA847@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: joao.p.taveira@gmail.com

Hi,

now I will comment some things about the mail here in linux-wpan.

On Fri, Apr 17, 2015 at 11:40:36PM +0200, Alexander Aring wrote:
...
> 
> Still on MRHOF, I contact linux-zigbee/linux-wpan group to get some
> information about roadmap about MAC802154 and I was told that it was too
> soon to know what and how things would be. I think there was a merge from
> linux zigbee to linux-wpan, but in the meanwhile, it was agreed between
> linux groups to merge wpan with bluetooth.
> 

There was no linux-wpan before, we renamed from zigbee to wpan because
we _can't_ name it zigbee, see [0]. This was the first important thing
which was needed to change after now maintainership.

To send everything into bluebooth-next this is just because Marcel
(bluebooth maintainer) was very friendly and offered to apply everything
which is for linux-wpan into bluebooth-next. This behaviour should be
changed if the stack implementation is in a more useable state.

Since there exist a BTLE 6LoWPAN draft, the BTLE 6LoWPAN and 802.15.4
6LoWPAN implementation shared the IPHC format.

> As last resort on ETX and MRHOF on linux and to see it working, I just
> tried to use nd6 timers as indication on link quality on linux side.
> Basically, when some neighbour moved to state REACHABLE would count as a
> good packet delivered. When a neighbour moved to state FAILED would count
> as several non-acked packets. Assuming that nodes wouldn't send too many
> packets, neighbours would move frequently to IDLE state. On each packet
> exchange this would make state to move to REACHABLE and count as good
> packet. Using RPL linux as root, this metric would be more or less
> acceptable but I didn't like the idea of different metrics. Anyway, I was
> able to get correct behaviour from MRHOF from linux nodes (even with a
> strange metric).
> 
> Since 4thQ 2014, I had no time available to work on this. I think I already
> know how to get ETX working. I'll see linux-wpan/linux-bluebooth current
> status and I hope to continue what I was doing back then.
> 

cool. Since there exists also BTLE 6LoWPAN a RPL implementation is good
to have for both subsystems (bt/802.15.4).

> About the blog which talks about tests to RPL Linux implementation, I just
> want to say that I wasn't contact about it before the post.
> 

I would say, you need to do your things mainline. Maybe simple write a
mail to netdev@vger.kernel.org and talk about your plans for implement
your stuff, I think you will 100% get some response to that. Then send
patches to netdev so we have your RPL implementation mainline. To get
stuff mainline is the most important thing. If you need help to getting
patches stuff mainline, I can offer you my help if you want.

- Alex

[0] https://docs.zigbee.org/zigbee-docs/dcn/05-3739.pdf
